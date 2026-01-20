import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/football_model.dart';

class FootballEditController extends GetxController {
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final numberController = TextEditingController();
  final imageController = TextEditingController();

  late int index;
  late Player player;
  late bool isNewPlayer;
  @override
  void onClose() {
    nameController.dispose();
    positionController.dispose();
    numberController.dispose();
    imageController.dispose();
    super.onClose();
  }

  void initializeFields(Player player) {
    nameController.text = player.name;
    positionController.text = player.position;
    numberController.text = player.number == 0 ? '' : player.number.toString();
    imageController.text = player.imageUrl;
  }

  Player getPlayer() {
    return Player(
      name: nameController.text.trim(),
      position: positionController.text.trim(),
      number: int.tryParse(numberController.text.trim()) ?? 0,
      imageUrl: imageController.text.trim(),
    );
  }

  void clearFields() {
    nameController.clear();
    positionController.clear();
    numberController.clear();
    imageController.clear();
  }
}
