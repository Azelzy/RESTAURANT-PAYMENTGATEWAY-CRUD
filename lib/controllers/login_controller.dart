import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laihan01/routes/routes.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  //save username ke shared preferences
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  var isLoading = false.obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "ERROR", 
        "Username dan password tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(63, 112, 111, 111),
        colorText: Colors.black,
      );
      return;
    }

    isLoading.value = true;

    if (usernameController.text.toString() == "admin" &&
        passwordController.text.toString() == "admin") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("username", usernameController.text.toString());
      
      Get.snackbar(
        "BERHASIL", 
        "Login berhasil!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(63, 112, 111, 111),
        colorText: Colors.black,
      );
      
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.bottomNav);
    } else {
      isLoading.value = false;
      Get.snackbar(
        "ERROR", 
        "Username atau password salah",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(63, 112, 111, 111),
        colorText: Colors.black,
      );
    }
  }
}