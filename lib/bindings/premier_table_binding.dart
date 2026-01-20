import 'package:get/get.dart';
import 'package:laihan01/controllers/premier_table_contoller.dart';

class PremierTableBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<PremierTableContoller>(() => PremierTableContoller());
  }
}
