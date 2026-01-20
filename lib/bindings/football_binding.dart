import 'package:get/get.dart';
import 'package:laihan01/controllers/football_controller.dart';

class FootballBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FootballController>(() => FootballController());
  }
}