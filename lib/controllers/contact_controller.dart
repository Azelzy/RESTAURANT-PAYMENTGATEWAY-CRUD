import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/database_helper.dart';

class ContactController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final names = <String>[].obs;
  final ids = <int>[].obs;
  final _dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    fetchNames();
  }

  Future<void> fetchNames() async {
    final data = await _dbHelper.getNames();
    names.value = data.map((e) => e['name'] as String).toList();
    ids.value = data.map((e) => e['id'] as int).toList();
  }

  Future<void> addName() async {
    final text = nameController.text.trim();
    if (text.isEmpty) {
      Get.snackbar(
        "ERROR",
        "PLEASE ENTER A NAME",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    await _dbHelper.insertName(text);
    nameController.clear();
    fetchNames();
    Get.snackbar(
      "SUCCESS",
      "CONTACT ADDED: ${text.toUpperCase()}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(63, 112, 111, 111),
      colorText: Colors.black,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> updateName(int index, String newName) async {
    if (newName.isEmpty) {
      Get.snackbar(
        "ERROR",
        "NAME CANNOT BE EMPTY",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    
    final id = ids[index];
    await _dbHelper.updateName(id, newName);
    fetchNames();
    
    Get.snackbar(
      "UPDATED",
      "CONTACT UPDATED: ${newName.toUpperCase()}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(63, 112, 111, 111),
      colorText: Colors.black,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> deleteName(int index) async {
    final name = names[index];
    final id = ids[index];
    
    await _dbHelper.deleteName(id);
    fetchNames();
    
    Get.snackbar(
      "DELETED",
      "CONTACT REMOVED: ${name.toUpperCase()}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}