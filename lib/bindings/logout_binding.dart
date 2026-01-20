import 'package:get/get.dart';
import 'package:laihan01/controllers/logout_controller.dart';

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogoutController>(() => LogoutController());
    
  }
}