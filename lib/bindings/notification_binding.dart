import 'package:get/get.dart';
import 'package:laihan01/services/notification_service.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationService(), permanent: true);
  }
}
