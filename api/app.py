from flask import Flask, request, jsonify
import os
import subprocess
import cv2
import numpy as np
from PIL import Image
from tensorflow.keras.models import load_model
from facenet_pytorch import MTCNN
import tempfile

app = Flask(__name__)

app.config['MAX_CONTENT_LENGTH'] = 200 * 1024 * 1024  # 50MB

model = load_model("v2_chiled_model.h5")
IMG_SIZE = (299, 299)

mtcnn = MTCNN(margin=30, select_largest=True, post_process=False, device='cpu')

def extract_frames(video_path, output_dir):
    os.makedirs(output_dir, exist_ok=True)
    command = [
        #r"C:\Users\bahaa\AppData\Local\Microsoft\WinGet\Links\ffmpeg.exe", "-i", video_path,
        "ffmpeg", "-i", video_path,
        "-vf", "fps=1/1",
        "-vframes", "15",
        "-qscale:v", "2",
        os.path.join(output_dir, "%04d.jpg")
    ]
    subprocess.run(command, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def process_image(frame_path):
    try:
        frame = cv2.imread(frame_path)
        if frame is None:
            return None

        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        img_pil = Image.fromarray(frame_rgb)

        face = mtcnn(img_pil)
        if face is not None:
            face_img = face.permute(1, 2, 0).int().numpy().astype(np.uint8)
            face_img = cv2.resize(face_img, IMG_SIZE)
            return face_img
        return None
    except Exception as e:
        print(f"Error processing frame {frame_path}: {e}")
        return None

@app.route('/predict', methods=['POST'])
def predict_video():
    if 'video' not in request.files:
        return jsonify({'error': 'No video file provided'}), 400

    video_file = request.files['video']
    with tempfile.NamedTemporaryFile(delete=False, suffix=".mp4") as tmp:
        video_file.save(tmp.name)
        temp_video_path = tmp.name

    temp_frames_dir = tempfile.mkdtemp()

    extract_frames(temp_video_path, temp_frames_dir)

    faces = []
    for frame_file in sorted(os.listdir(temp_frames_dir)):
        frame_path = os.path.join(temp_frames_dir, frame_file)
        face = process_image(frame_path)
        if face is not None:
            faces.append(face)

   # os.remove(temp_video_path)

    if not faces:
        return jsonify({"result": "No face is revealed in the video."})

    faces_array = np.array(faces) / 255.0
    predictions = model.predict(faces_array)

    if predictions.shape[1] == 2:
        fake_scores = predictions[:, 1]
    else:
        return jsonify({"error": "Model doesn't produce 2-class predictions."})

    avg_score = np.mean(fake_scores)
    label = "Real" if avg_score > 0.5 else "Fake"
    confidence = avg_score if avg_score > 0.5 else 1 - avg_score

    return jsonify({
        "result": label,
        "confidence": round(confidence * 100, 2)
    })

if __name__ == '__main__':
    app.run( debug=True)
    
