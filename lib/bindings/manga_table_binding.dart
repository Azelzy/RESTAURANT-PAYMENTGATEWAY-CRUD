import 'package:get/get.dart';
import '../controllers/manga_table_controller.dart';

class MangaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MangaController>(() => MangaController());
  }
}
