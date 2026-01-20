import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FootballResponsiveController extends GetxController {
  var isMobile = true.obs;
  var gridCrossAxisCount = 1.obs;

  void updateLayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
    
    if (constraints.maxWidth < 600) {
      gridCrossAxisCount.value = 1;
    } else if (constraints.maxWidth < 1200) {
      gridCrossAxisCount.value = 2;
    } else {
      gridCrossAxisCount.value = 3;
    }
  }
}