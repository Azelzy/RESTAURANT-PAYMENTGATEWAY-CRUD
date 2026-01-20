import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_nav_controller.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavController>();
    
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            height: 180,
            color: Colors.black,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "BURGIR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "NAVIGATION MENU",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          
          // Navigation Items - Scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildNavItem(
                    icon: Icons.calculate,
                    title: "CALCULATOR",
                    onTap: () {
                      controller.changeTabIndex(0);
                      Get.back();
                    },
                  ),
                  const Divider(height: 1, color: Colors.black),
                  _buildNavItem(
                    icon: Icons.sports_soccer,
                    title: "FOOTBALL",
                    onTap: () {
                      controller.changeTabIndex(1);
                      Get.back();
                    },
                  ),
                  const Divider(height: 1, color: Colors.black),
                  _buildNavItem(
                    icon: Icons.table_chart,
                    title: "PREMIER LEAGUE TABLE",
                    onTap: () {
                      Get.back();
                      Get.toNamed('/premierTable');
                    },
                  ),
                  const Divider(height: 1, color: Colors.black),
                  _buildNavItem(
                    icon: Icons.contacts,
                    title: "CONTACT",
                    onTap: () {
                      controller.changeTabIndex(2);
                      Get.back();
                    },
                  ),
                  const Divider(height: 1, color: Colors.black),
                  _buildNavItem(
                    icon: Icons.person,
                    title: "PROFILE",
                    onTap: () {
                      controller.changeTabIndex(3);
                      Get.back();
                    },
                  ),
                  const Divider(height: 2, color: Colors.black),
                ],
              ),
            ),
          ),
          
          // Logout Button - Fixed at bottom
          Container(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: controller.isLoggingOut.value 
                      ? Colors.grey[400] 
                      : Colors.red,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: TextButton.icon(
                  icon: controller.isLoggingOut.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.logout, color: Colors.white, size: 20),
                  label: Text(
                    controller.isLoggingOut.value ? "LOGGING OUT..." : "LOGOUT",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      fontSize: 12,
                    ),
                  ),
                  onPressed: controller.isLoggingOut.value 
                      ? null 
                      : () {
                          Get.back();
                          controller.logout();
                        },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Icon(icon, color: Colors.black, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800, 
                  letterSpacing: 1,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}