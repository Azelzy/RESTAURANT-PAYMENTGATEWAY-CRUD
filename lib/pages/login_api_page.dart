import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_api_controller.dart';

class LoginApiPage extends StatelessWidget {
  const LoginApiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginApiController controller = Get.find<LoginApiController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Section
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: const Icon(
                      Icons.cloud,
                      size: 60,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Title
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: const Text(
                      "API LOGIN",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Text(
                      "SILAKAN MASUK KE AKUN ANDA",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[600],
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Username Field
                  _buildInputField(
                    controller: controller.usernameController,
                    label: "USERNAME",
                    icon: Icons.person,
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  _buildInputField(
                    controller: controller.passwordController,
                    label: "PASSWORD",
                    icon: Icons.lock,
                    isPassword: true,
                  ),

                  const SizedBox(height: 32),

                  // Login Button
                  Obx(
                    () => Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: controller.isLoading.value
                            ? Colors.grey[400]
                            : Colors.black,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: TextButton.icon(
                        icon: controller.isLoading.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.login, color: Colors.white),
                        label: Text(
                          controller.isLoading.value ? "LOADING..." : "MASUK",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.loginApi,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "ATAU",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey[600],
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Google Sign In Button
                  Obx(
                    () => Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: controller.isGoogleLoading.value
                            ? Colors.grey[400]
                            : Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: TextButton.icon(
                        icon: controller.isGoogleLoading.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2,
                                ),
                              )
                            : Image.asset(
                                'assets/images/google_logo.png',
                                width: 24,
                                height: 24,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.g_mobiledata,
                                    color: Colors.black,
                                    size: 28,
                                  );
                                },
                              ),
                        label: Text(
                          controller.isGoogleLoading.value
                              ? "LOADING..."
                              : "MASUK DENGAN GOOGLE",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: controller.isGoogleLoading.value
                            ? null
                            : controller.loginWithGoogle,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Demo Credentials Info
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "API CREDENTIALS",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey[600],
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Username: admin123\nPassword: admin123",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[700],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 1.0,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: Icon(icon, color: Colors.black),
        ),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}