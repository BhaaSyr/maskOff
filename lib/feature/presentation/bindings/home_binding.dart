import 'package:get/get.dart';
import 'package:testvid/feature/controllers/auth/auth_controller.dart';
import 'package:testvid/feature/controllers/home_controller.dart';
import 'package:testvid/feature/controllers/profile/profile_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Lazily initialize the VideoController when HomeView is accessed
    Get.lazyPut<VideoController>(() => VideoController());

    // Check if AuthController is already registered, if not, put it
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController(), permanent: true);
    }

    // Initialize ProfileController
    Get.put<ProfileController>(ProfileController());
  }
}
