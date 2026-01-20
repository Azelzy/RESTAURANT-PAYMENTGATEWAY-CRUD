import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:laihan01/models/login_model.dart';
import 'package:laihan01/networks/client_network.dart';
import 'package:laihan01/routes/routes.dart';
import 'package:laihan01/helper/shared_pref_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginApiController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  var isLoading = false.obs;
  var isGoogleLoading = false.obs;
  
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User data observables
  var userEmail = ''.obs;
  var userName = ''.obs;
  var userPhotoUrl = ''.obs;
  var loginType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Load user data from SharedPreferences
  Future<void> loadUserData() async {
    userEmail.value = await SharedPrefHelper.getEmail() ?? '';
    userName.value = await SharedPrefHelper.getUsername() ?? '';
    userPhotoUrl.value = await SharedPrefHelper.getPhotoUrl() ?? '';
    loginType.value = await SharedPrefHelper.getLoginType() ?? '';
    
    print('\n========== USER DATA LOADED ==========');
    print('Email: ${userEmail.value}');
    print('Username: ${userName.value}');
    print('Photo URL: ${userPhotoUrl.value}');
    print('Login Type: ${loginType.value}');
    print('======================================\n');
  }

  /// Login with API
  void loginApi() async {
    print('\n========================================');
    print('🚀 LOGIN API STARTED');
    print('========================================');
    
    // Validasi input
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      print('❌ Validation Failed: Username atau password kosong');
      Get.snackbar(
        "ERROR",
        "Username dan password tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(63, 112, 111, 111),
        colorText: Colors.black,
      );
      return;
    }

    print('✅ Validation Passed');
    print('📝 Username: ${usernameController.text}');
    print('📝 Password: ${passwordController.text}');
    
    isLoading.value = true;

    try {
      // Prepare request data
      final requestData = {
        'username': usernameController.text,
        'password': passwordController.text,
      };

      print('\n----------------------------------------');
      print('📤 REQUEST DETAILS:');
      print('----------------------------------------');
      print('URL: ${ClientNetwork.login}');
      print('Method: POST');
      print('Body Parameters:');
      requestData.forEach((key, value) {
        print('  - $key: $value');
      });
      print('----------------------------------------\n');

      // Hit API
      print('⏳ Sending request to server...');
      final response = await http.post(
        Uri.parse(ClientNetwork.login),
        body: requestData,
      );

      print('\n----------------------------------------');
      print('📥 RESPONSE DETAILS:');
      print('----------------------------------------');
      print('Status Code: ${response.statusCode}');
      print('Status Message: ${response.reasonPhrase}');
      print('Response Headers: ${response.headers}');
      print('Response Body: ${response.body}');
      print('Response Length: ${response.body.length} characters');
      print('----------------------------------------\n');

      // Parse response
      if (response.statusCode == 200) {
        print('✅ Status Code 200 - OK');
        
        try {
          final LoginModel loginModel = loginModelFromJson(response.body);
          
          print('\n----------------------------------------');
          print('📦 PARSED MODEL:');
          print('----------------------------------------');
          print('Status: ${loginModel.status}');
          print('Message: ${loginModel.message}');
          print('Token: ${loginModel.token}');
          print('Token Length: ${loginModel.token.length} characters');
          print('----------------------------------------\n');

          if (loginModel.status) {
            print('✅ Login Status: SUCCESS');
            
            // Simpan data menggunakan SharedPrefHelper
            await SharedPrefHelper.saveLoginData(
              loginModel.token,
              usernameController.text,
            );

            // Update observables
            userName.value = usernameController.text;
            loginType.value = 'api';

            print('💾 Login data saved to SharedPreferences');

            Get.snackbar(
              "BERHASIL",
              loginModel.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green[100],
              colorText: Colors.black,
            );

            isLoading.value = false;
            
            print('🔄 Navigating to: ${AppRoutes.bottomNav}');
            print('========================================');
            print('✅ LOGIN API COMPLETED SUCCESSFULLY');
            print('========================================\n');
            
            // Navigate ke halaman utama
            Get.offAllNamed(AppRoutes.bottomNav);
          } else {
            print('❌ Login Status: FAILED');
            print('📝 Reason: ${loginModel.message}');
            
            isLoading.value = false;
            Get.snackbar(
              "ERROR",
              loginModel.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red[100],
              colorText: Colors.black,
            );
            
            print('========================================');
            print('❌ LOGIN API FAILED');
            print('========================================\n');
          }
        } catch (parseError) {
          isLoading.value = false;
          print('\n❌ JSON PARSE ERROR:');
          print('Error: ${parseError.toString()}');
          print('Raw Response: ${response.body}');
          
          Get.snackbar(
            "ERROR",
            "Error parsing response: ${parseError.toString()}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red[100],
            colorText: Colors.black,
          );
          
          print('========================================');
          print('❌ LOGIN API FAILED - PARSE ERROR');
          print('========================================\n');
        }
      } else {
        print('❌ Status Code: ${response.statusCode} - ${response.reasonPhrase}');
        isLoading.value = false;
        
        Get.snackbar(
          "ERROR",
          "Server error: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.black,
        );
        
        print('========================================');
        print('❌ LOGIN API FAILED - SERVER ERROR');
        print('========================================\n');
      }
    } catch (e) {
      isLoading.value = false;
      
      print('\n❌❌❌ EXCEPTION OCCURRED ❌❌❌');
      print('Error Type: ${e.runtimeType}');
      print('Error Message: ${e.toString()}');
      print('Stack Trace:');
      print(StackTrace.current);
      
      Get.snackbar(
        "ERROR",
        "Terjadi kesalahan: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black,
      );
      
      print('========================================');
      print('❌ LOGIN API FAILED - EXCEPTION');
      print('========================================\n');
    }
  }

  /// Login with Google
  Future<void> loginWithGoogle() async {
    print('\n========================================');
    print('🚀 GOOGLE SIGN IN STARTED');
    print('========================================');
    
    isGoogleLoading.value = true;

    try {
      // Trigger Google Sign In
      print('⏳ Opening Google Sign In dialog...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        print('❌ Google Sign In cancelled by user');
        isGoogleLoading.value = false;
        return;
      }

      print('✅ Google account selected: ${googleUser.email}');

      // Get authentication details
      print('⏳ Getting authentication details...');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      print('✅ Access Token: ${googleAuth.accessToken?.substring(0, 20)}...');
      print('✅ ID Token: ${googleAuth.idToken?.substring(0, 20)}...');

      // Create credential for Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      print('⏳ Signing in to Firebase...');
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print('\n----------------------------------------');
        print('📦 USER DATA:');
        print('----------------------------------------');
        print('Email: ${user.email}');
        print('Display Name: ${user.displayName}');
        print('Photo URL: ${user.photoURL}');
        print('UID: ${user.uid}');
        print('----------------------------------------\n');

        // Simpan data menggunakan SharedPrefHelper
        await SharedPrefHelper.saveGoogleLoginData(
          email: user.email ?? '',
          username: user.displayName ?? 'User',
          photoUrl: user.photoURL,
          token: await user.getIdToken(),
        );

        // Update observables
        userEmail.value = user.email ?? '';
        userName.value = user.displayName ?? 'User';
        userPhotoUrl.value = user.photoURL ?? '';
        loginType.value = 'google';

        print('💾 Google login data saved to SharedPreferences');

        Get.snackbar(
          "BERHASIL",
          "Login dengan Google berhasil!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[100],
          colorText: Colors.black,
        );

        isGoogleLoading.value = false;
        
        print('🔄 Navigating to: ${AppRoutes.bottomNav}');
        print('========================================');
        print('✅ GOOGLE SIGN IN COMPLETED SUCCESSFULLY');
        print('========================================\n');
        
        // Navigate ke halaman utama
        Get.offAllNamed(AppRoutes.bottomNav);
      } else {
        print('❌ Firebase user is null');
        throw Exception('Failed to get user data from Firebase');
      }
    } catch (e) {
      isGoogleLoading.value = false;
      
      print('\n❌❌❌ GOOGLE SIGN IN EXCEPTION ❌❌❌');
      print('Error Type: ${e.runtimeType}');
      print('Error Message: ${e.toString()}');
      
      Get.snackbar(
        "ERROR",
        "Google Sign In gagal: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black,
      );
      
      print('========================================');
      print('❌ GOOGLE SIGN IN FAILED');
      print('========================================\n');
    }
  }
}