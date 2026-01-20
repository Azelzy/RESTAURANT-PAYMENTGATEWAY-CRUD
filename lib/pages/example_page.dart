import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/example_controller.dart';
import 'package:laihan01/pages/mobile/example_mobile.dart';
import 'package:laihan01/pages/widescreen/example_widescreen.dart';

class ExamplePage extends StatelessWidget {
  ExamplePage({super.key});
  //nanti inject di binding
  final ExampleController controller = Get.put(ExampleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // detection width screen
          controller.updateLayout(constraints);
          //transforming loadpage
          return Obx(
            () => controller.isMobile.value
                ? const ExampleMobile()
                : const ExampleWidescreen(),
          );
        },
      ),
    );
  }
}