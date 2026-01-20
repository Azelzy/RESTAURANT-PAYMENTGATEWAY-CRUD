import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_nav_controller.dart';
import '../controllers/calculator_controller.dart';
import '../controllers/football_controller.dart';
import '../controllers/contact_controller.dart';
import '../controllers/login_api_controller.dart';
import 'calculator_page.dart';
import 'football_page.dart';
import 'profile_page.dart';
import 'contact_page.dart';

class BottomNavPage extends StatelessWidget {
  BottomNavPage({super.key}) {
    // Register controllers if not already registered
    if (!Get.isRegistered<CalculatorController>()) {
      Get.put(CalculatorController());
    }
    if (!Get.isRegistered<FootballController>()) {
      Get.put(FootballController());
    }
    if (!Get.isRegistered<ContactController>()) {
      Get.put(ContactController());
    }
    if (!Get.isRegistered<LoginApiController>()) {
      Get.put(LoginApiController());
    }
  }

  final controller = Get.find<BottomNavController>();
  final List<Widget> pages = [
    const CalculatorPage(),
    Footballpage(),
    const ContactPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[100],
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black, width: 2)),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTabIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey[600],
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 9,
              letterSpacing: 0.5,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 9,
              letterSpacing: 0.5,
            ),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: controller.currentIndex.value == 0
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Icon(
                    Icons.calculate,
                    size: 16,
                    color: controller.currentIndex.value == 0
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                label: "CALCULATOR",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: controller.currentIndex.value == 1
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Icon(
                    Icons.sports_soccer,
                    size: 16,
                    color: controller.currentIndex.value == 1
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                label: "PEMAIN",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: controller.currentIndex.value == 2
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Icon(
                    Icons.contacts,
                    size: 16,
                    color: controller.currentIndex.value == 2
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                label: "CONTACT",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: controller.currentIndex.value == 3
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 16,
                    color: controller.currentIndex.value == 3
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                label: "PROFILE",
              ),
            ],
          ),
        ),
      ),
    );
  }
}