import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Lazily initialize the VideoController when HomeView is accessed
    Get.lazyPut<VideoController>(() => VideoController());
  }
}
