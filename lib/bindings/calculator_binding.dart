import 'package:get/get.dart';
import 'package:laihan01/controllers/calculator_controller.dart';

class CalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalculatorController>(() => CalculatorController());
  }
}