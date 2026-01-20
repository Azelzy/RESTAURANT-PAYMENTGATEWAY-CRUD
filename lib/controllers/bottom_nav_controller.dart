import 'package:get/get.dart';
import 'package:laihan01/helper/shared_pref_helper.dart';
import 'package:laihan01/routes/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;
  var isLoggingOut = false.obs;
  
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void changeTabIndex(int index) {
    if (index >= 0 && index <= 3) {
      currentIndex.value = index;
    }
  }

  String get currentPageTitle {
    switch (currentIndex.value) {
      case 0:
        return 'CALCULATORS';
      case 1:
        return 'PEMAINS';
      case 2:
        return 'CONTACTS';
      case 3:
        return 'PROFILS';
      default:
        return '';
    }
  }

  void logout() {
    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.black, width: 3),
        ),
        title: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: const Text(
            'KONFIRMASI LOGOUT',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              fontSize: 14,
            ),
          ),
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari aplikasi?',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                'BATAL',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextButton(
              onPressed: () async {
                Get.back(); // Close dialog
                await _performLogout();
              },
              child: const Text(
                'LOGOUT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _performLogout() async {
    print('\n========================================');
    print('🚪 LOGOUT STARTED');
    print('========================================');
    
    isLoggingOut.value = true;

    try {
      // Get login type
      final loginType = await SharedPrefHelper.getLoginType();
      print('📝 Login Type: $loginType');

      // Logout from Google if logged in with Google
      if (loginType == 'google') {
        print('⏳ Signing out from Google...');
        await _googleSignIn.signOut();
        print('✅ Google sign out successful');
        
        print('⏳ Signing out from Firebase...');
        await _auth.signOut();
        print('✅ Firebase sign out successful');
      }

      // Clear all login data from SharedPreferences
      print('⏳ Clearing SharedPreferences...');
      await SharedPrefHelper.clearLoginData();
      print('✅ SharedPreferences cleared');

      // Debug: Print all data
      await SharedPrefHelper.printAll();

      isLoggingOut.value = false;

      print('🔄 Navigating to: ${AppRoutes.loginApi}');
      print('========================================');
      print('✅ LOGOUT COMPLETED SUCCESSFULLY');
      print('========================================\n');

      // Navigate to login page
      Get.offAllNamed(AppRoutes.loginApi);
    } catch (e) {
      isLoggingOut.value = false;
      
      print('\n❌❌❌ LOGOUT EXCEPTION ❌❌❌');
      print('Error Type: ${e.runtimeType}');
      print('Error Message: ${e.toString()}');
      
      Get.snackbar(
        "ERROR",
        "Logout gagal: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      
      print('========================================');
      print('❌ LOGOUT FAILED');
      print('========================================\n');
    }
  }
}