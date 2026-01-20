import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/football_model.dart';
import '../routes/routes.dart';
import '../widget/NavDrawer.dart';
import 'mobile/footballpage_mobile.dart';
import '../controllers/football_controller.dart';
import '../controllers/football_responsive_controller.dart';
import 'widescreen/footballpage_widescreen.dart';

class Footballpage extends StatelessWidget {
  Footballpage({super.key}) {
    Get.put(FootballResponsiveController());
  }

  FootballController get footballController => Get.find<FootballController>();
  FootballResponsiveController get responsiveController =>
      Get.find<FootballResponsiveController>();

  void _addNewPlayer() {
    final newPlayer = Player(name: "", position: "", number: 0, imageUrl: "");
    Get.toNamed(
      AppRoutes.footballedit,
      arguments: {
        'index': footballController.players.length,
        'player': newPlayer,
        'isNewPlayer': true,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "LISTS PEMAINS",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: Colors.black, height: 2),
        ),
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.rectangle,
        ),
        child: IconButton(
          onPressed: _addNewPlayer,
          icon: const Icon(Icons.add, color: Colors.white, size: 24),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          responsiveController.updateLayout(constraints);
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => responsiveController.isMobile.value
                  ? const FootballMobile()
                  : const FootballWidescreen(),
            ),
          );
        },
      ),
    );
  }
}
