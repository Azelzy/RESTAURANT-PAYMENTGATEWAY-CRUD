import 'package:get/get.dart';
import 'package:laihan01/routes/routes.dart';
import 'package:laihan01/helper/shared_pref_helper.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  checkLogin() async {
    print('\n========================================');
    print('🔍 CHECKING LOGIN STATUS');
    print('========================================');
    
    // Simulate splash screen delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Cek apakah user sudah login (ada token)
    final isLoggedIn = await SharedPrefHelper.isLoggedIn();
    final token = await SharedPrefHelper.getToken();
    final username = await SharedPrefHelper.getUsername();
    
    print('Is Logged In: $isLoggedIn');
    print('Token: ${token ?? "null"}');
    print('Username: ${username ?? "null"}');
    
    if (isLoggedIn && token != null) {
      print('✅ User is logged in, navigating to BottomNav');
      print('========================================\n');
      Get.offAllNamed(AppRoutes.bottomNav);
    } else {
      print('❌ User not logged in, navigating to LoginApi');
      print('========================================\n');
      Get.offAllNamed(AppRoutes.loginApi);
    }
  }
}