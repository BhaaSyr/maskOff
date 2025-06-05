import 'package:get/get.dart';
import '../controllers/result_controller.dart';
import '../domain/usecases/analyze_video_usecase.dart';
import '../domain/repositories/deepfake_repository.dart';
import '../data/repositories/deepfake_repository_impl.dart';
import '../data/datasources/remote/deepfake_remote_data_source.dart';

class ResultBinding implements Bindings {
  @override
  void dependencies() {
    // Register the remote data source
    Get.lazyPut<DeepfakeRemoteDataSource>(
      () => DeepfakeRemoteDataSourceImpl(),
    );

    // Register the repository implementation
    Get.lazyPut<DeepfakeRepository>(
      () => DeepfakeRepositoryImpl(
        remoteDataSource: Get.find<DeepfakeRemoteDataSource>(),
      ),
    );

    // Register the use case
    Get.lazyPut<AnalyzeVideoUseCase>(
      () => AnalyzeVideoUseCase(
        repository: Get.find<DeepfakeRepository>(),
      ),
    );

    // Register the controller
    Get.lazyPut<ResultController>(
      () => ResultController(
        analyzeVideoUseCase: Get.find<AnalyzeVideoUseCase>(),
      ),
    );
  }
}
