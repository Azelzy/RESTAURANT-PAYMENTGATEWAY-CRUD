import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../routes/routes.dart';
import '../helper/shared_pref_helper.dart';

class LogoutController extends GetxController {
  var isLoggingOut = false.obs;

  Future<void> performLogout() async {
    // Show confirmation dialog
    bool? shouldLogout = await _showLogoutConfirmation();
    
    if (shouldLogout == true) {
      isLoggingOut.value = true;
      
      try {
        print('\n========================================');
        print('🚪 LOGOUT STARTED');
        print('========================================');
        
        // Print data sebelum dihapus
        print('\n📋 Data before logout:');
        await SharedPrefHelper.printAll();
        
        // Clear shared preferences (token + username)
        await SharedPrefHelper.clearLoginData();
        
        print('✅ Token removed');
        print('✅ Username removed');
        
        // Print data setelah dihapus
        print('\n📋 Data after logout:');
        await SharedPrefHelper.printAll();
        
        // Show success message
        Get.snackbar(
          "LOGOUT BERHASIL",
          "Anda telah keluar dari aplikasi",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey[300],
          colorText: Colors.black,
          icon: const Icon(Icons.check_circle, color: Colors.green),
          duration: const Duration(seconds: 2),
        );
        
        print('========================================');
        print('✅ LOGOUT COMPLETED');
        print('========================================\n');
        
        // Navigate to login page and clear all previous routes
        await Future.delayed(const Duration(milliseconds: 500));
        Get.offAllNamed(AppRoutes.loginApi);
      } catch (e) {
        print('❌ Logout Error: $e');
        
        Get.snackbar(
          "ERROR",
          "Terjadi kesalahan saat logout",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.black,
          icon: const Icon(Icons.error, color: Colors.red),
        );
      } finally {
        isLoggingOut.value = false;
      }
    }
  }

  Future<bool?> _showLogoutConfirmation() async {
    return await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: const BorderSide(color: Colors.black, width: 3),
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
              onPressed: () => Get.back(result: false),
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
              onPressed: () => Get.back(result: true),
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
}