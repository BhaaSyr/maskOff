// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:testvid/feature/controllers/theme_controller.dart';
// import 'package:video_trimmer/video_trimmer.dart';

// class VideoTrimmerWidget extends StatefulWidget {
//   final File videoFile;
//   final Function(File) onTrimComplete;

//   const VideoTrimmerWidget({
//     Key? key,
//     required this.videoFile,
//     required this.onTrimComplete,
//   }) : super(key: key);

//   @override
//   _VideoTrimmerWidgetState createState() => _VideoTrimmerWidgetState();
// }

// class _VideoTrimmerWidgetState extends State<VideoTrimmerWidget>
//     with TickerProviderStateMixin {
//   final Trimmer _trimmer = Trimmer();
//   double _startValue = 0.0;
//   double _endValue = 0.0;
//   bool _isPlaying = false;
//   bool _progressVisibility = false;
//   late AnimationController _fadeController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//   final ThemeController themeController = Get.find<ThemeController>();

//   Duration? _videoDuration;
//   Duration? _trimmedDuration;

//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//     _loadVideo();
//   }

//   void _initializeAnimations() {
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _slideController = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
//     );

//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(
//         CurvedAnimation(parent: _slideController, curve: Curves.elasticOut));

//     _fadeController.forward();
//     _slideController.forward();
//   }

//   void _loadVideo() async {
//     await _trimmer.loadVideo(videoFile: widget.videoFile);
//     if (_trimmer.videoPlayerController != null) {
//       setState(() {
//         _videoDuration = _trimmer.videoPlayerController!.value.duration;
//         _trimmedDuration = _videoDuration;
//       });
//     }
//   }

//   void _updateTrimmedDuration() {
//     if (_videoDuration != null) {
//       final startMs = (_startValue * _videoDuration!.inMilliseconds).round();
//       final endMs = (_endValue * _videoDuration!.inMilliseconds).round();
//       setState(() {
//         _trimmedDuration = Duration(milliseconds: endMs - startMs);
//       });
//     }
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$twoDigitMinutes:$twoDigitSeconds";
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _slideController.dispose();
//     _trimmer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = themeController.isDarkMode;

//     return Scaffold(
//       backgroundColor:
//           isDark ? const Color(0xFF0A0A0F) : const Color(0xFFF8F9FA),
//       body: SafeArea(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: Column(
//             children: [
//               // Enhanced Header
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: isDark
//                         ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
//                         : [Colors.white, const Color(0xFFF8F9FA)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
//                       blurRadius: 20,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     // Animated icon container
//                     TweenAnimationBuilder<double>(
//                       tween: Tween<double>(begin: 0.0, end: 1.0),
//                       duration: const Duration(milliseconds: 600),
//                       builder: (context, value, child) {
//                         return Transform.scale(
//                           scale: value,
//                           child: Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color:
//                                       const Color(0xFF667EEA).withOpacity(0.3),
//                                   blurRadius: 8,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: const Icon(
//                               Icons.video_camera_back_rounded,
//                               color: Colors.white,
//                               size: 24,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Video Düzenleyici',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700,
//                               color: isDark
//                                   ? Colors.white
//                                   : const Color(0xFF1A1A2E),
//                               letterSpacing: -0.5,
//                             ),
//                           ),
//                           if (_videoDuration != null)
//                             Text(
//                               'Süre: ${_formatDuration(_videoDuration!)}',
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: isDark
//                                     ? Colors.white60
//                                     : Colors.grey.shade600,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                     // Close button with animation
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () => Get.back(),
//                         borderRadius: BorderRadius.circular(10),
//                         child: Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: isDark
//                                 ? Colors.white.withOpacity(0.1)
//                                 : Colors.grey.shade100,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Icon(
//                             Icons.close_rounded,
//                             color:
//                                 isDark ? Colors.white70 : Colors.grey.shade700,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: SlideTransition(
//                     position: _slideAnimation,
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 20),

//                         // Enhanced Video Preview
//                         Container(
//                           height: 280,
//                           margin: const EdgeInsets.symmetric(horizontal: 20),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.black,
//                                 Colors.black.withOpacity(0.9),
//                               ],
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.3),
//                                 blurRadius: 20,
//                                 offset: const Offset(0, 8),
//                               ),
//                               BoxShadow(
//                                 color: const Color(0xFF667EEA).withOpacity(0.1),
//                                 blurRadius: 40,
//                                 offset: const Offset(0, 16),
//                               ),
//                             ],
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Stack(
//                               children: [
//                                 VideoViewer(trimmer: _trimmer),
//                                 // Gradient overlay
//                                 Positioned(
//                                   bottom: 0,
//                                   left: 0,
//                                   right: 0,
//                                   child: Container(
//                                     height: 60,
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Colors.transparent,
//                                           Colors.black.withOpacity(0.7),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 24),

//                         // Trim Duration Info
//                         if (_trimmedDuration != null)
//                           Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 20),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 12),
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: isDark
//                                     ? [
//                                         const Color(0xFF667EEA)
//                                             .withOpacity(0.1),
//                                         const Color(0xFF764BA2).withOpacity(0.1)
//                                       ]
//                                     : [
//                                         const Color(0xFF667EEA)
//                                             .withOpacity(0.05),
//                                         const Color(0xFF764BA2)
//                                             .withOpacity(0.05)
//                                       ],
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                 color: const Color(0xFF667EEA).withOpacity(0.3),
//                                 width: 1,
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.access_time_rounded,
//                                   size: 16,
//                                   color: const Color(0xFF667EEA),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   'Kırpılan Süre: ${_formatDuration(_trimmedDuration!)}',
//                                   style: TextStyle(
//                                     color: isDark
//                                         ? Colors.white
//                                         : const Color(0xFF1A1A2E),
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                         const SizedBox(height: 20),

//                         // Enhanced Trim Controls
//                         Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 20),
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: isDark
//                                   ? [
//                                       const Color(0xFF1A1A2E),
//                                       const Color(0xFF16213E)
//                                     ]
//                                   : [Colors.white, const Color(0xFFF8F9FA)],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black
//                                     .withOpacity(isDark ? 0.3 : 0.08),
//                                 blurRadius: 20,
//                                 offset: const Offset(0, 8),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.content_cut_rounded,
//                                     color: const Color(0xFF667EEA),
//                                     size: 20,
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     'Video Kırpma',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: isDark
//                                           ? Colors.white
//                                           : const Color(0xFF1A1A2E),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 20),

//                               // Trim Viewer with enhanced styling
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: isDark
//                                         ? Colors.white.withOpacity(0.1)
//                                         : Colors.grey.shade200,
//                                   ),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: TrimViewer(
//                                     trimmer: _trimmer,
//                                     viewerHeight: 60,
//                                     viewerWidth:
//                                         MediaQuery.of(context).size.width - 80,
//                                     maxVideoLength: const Duration(minutes: 10),
//                                     onChangeStart: (value) {
//                                       _startValue = value;
//                                       _updateTrimmedDuration();
//                                     },
//                                     onChangeEnd: (value) {
//                                       _endValue = value;
//                                       _updateTrimmedDuration();
//                                     },
//                                     onChangePlaybackState: (value) =>
//                                         setState(() => _isPlaying = value),
//                                   ),
//                                 ),
//                               ),

//                               const SizedBox(height: 24),

//                               // Enhanced Control Buttons
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: _buildControlButton(
//                                       onPressed: () async {
//                                         bool playing = _isPlaying;
//                                         setState(() => _isPlaying = !playing);
//                                         if (playing) {
//                                           _trimmer.videoPlayerController
//                                               ?.pause();
//                                         } else {
//                                           _trimmer.videoPlayerController
//                                               ?.play();
//                                         }
//                                       },
//                                       icon: _isPlaying
//                                           ? Icons.pause_rounded
//                                           : Icons.play_arrow_rounded,
//                                       label: _isPlaying ? 'Duraklat' : 'Oynat',
//                                       isPrimary: false,
//                                       isDark: isDark,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Expanded(
//                                     child: _buildControlButton(
//                                       onPressed: _progressVisibility
//                                           ? null
//                                           : () async {
//                                               setState(() =>
//                                                   _progressVisibility = true);
//                                               await _trimmer.saveTrimmedVideo(
//                                                 startValue: _startValue,
//                                                 endValue: _endValue,
//                                                 onSave: (String? path) {
//                                                   setState(() =>
//                                                       _progressVisibility =
//                                                           false);
//                                                   if (path != null) {
//                                                     widget.onTrimComplete(
//                                                         File(path));
//                                                     Get.back();
//                                                   }
//                                                 },
//                                               );
//                                             },
//                                       icon: _progressVisibility
//                                           ? null
//                                           : Icons.save_rounded,
//                                       label: _progressVisibility
//                                           ? 'Kaydediliyor...'
//                                           : 'Kaydet',
//                                       isPrimary: true,
//                                       isDark: isDark,
//                                       isLoading: _progressVisibility,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               // Enhanced Progress Indicator
//               if (_progressVisibility)
//                 Container(
//                   margin: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 4,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(2),
//                           gradient: const LinearGradient(
//                             colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
//                           ),
//                         ),
//                         child: const LinearProgressIndicator(
//                           backgroundColor: Colors.transparent,
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(Colors.white),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         'Video işleniyor, lütfen bekleyin...',
//                         style: TextStyle(
//                           color: themeController.isDarkMode
//                               ? Colors.white70
//                               : Colors.grey.shade600,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildControlButton({
//     required VoidCallback? onPressed,
//     IconData? icon,
//     required String label,
//     required bool isPrimary,
//     required bool isDark,
//     bool isLoading = false,
//   }) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isPrimary
//               ? const Color(0xFF667EEA)
//               : isDark
//                   ? Colors.white.withOpacity(0.1)
//                   : Colors.grey.shade100,
//           foregroundColor: isPrimary
//               ? Colors.white
//               : isDark
//                   ? Colors.white
//                   : const Color(0xFF667EEA),
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: isPrimary ? 4 : 0,
//           shadowColor:
//               isPrimary ? const Color(0xFF667EEA).withOpacity(0.3) : null,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (isLoading)
//               const SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                 ),
//               )
//             else if (icon != null)
//               Icon(icon, size: 20),
//             if (!isLoading && icon != null) const SizedBox(width: 8),
//             Text(
//               label,
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
