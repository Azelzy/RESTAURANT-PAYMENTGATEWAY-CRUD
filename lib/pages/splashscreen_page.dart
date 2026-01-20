import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splashscreen_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashscreenPage extends StatelessWidget {
  SplashscreenPage({super.key});

  final SplashscreenController controller = Get.find<SplashscreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Container
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 4),
                ),
                child: const Icon(
                  Icons.calculate,
                  size: 80,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 40),

              // App Title
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
                  "LAIHAN01",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Text(
                  "CALCULATOR & FOOTBALL MANAGER",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700],
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Loading Animation
              Container(
                child: LoadingAnimationWidget.threeArchedCircle(
                      color: const Color.fromARGB(255, 143, 143, 143),
                size: 50,
                    ),
                  ),

              const SizedBox(height: 16),

              Text(
                "LOADING...",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey[600],
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
