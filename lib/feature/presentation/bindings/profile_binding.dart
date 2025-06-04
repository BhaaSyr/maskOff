import 'package:get/get.dart';
import 'package:testvid/feature/controllers/profile&history/profile_and_history_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
