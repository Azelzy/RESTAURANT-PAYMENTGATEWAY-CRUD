import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  final txtAngka1 = TextEditingController();
  final txtAngka2 = TextEditingController();
  final hasil = "0".obs;
  final operator = "".obs;

  @override
  void onClose() {
    txtAngka1.dispose();
    txtAngka2.dispose();
    super.onClose();
  }

  void tambah() {
    if (_isValidInput()) {
      double angka1 = double.parse(txtAngka1.text);
      double angka2 = double.parse(txtAngka2.text);
      double result = angka1 + angka2;
      hasil.value = _formatResult(result);
      operator.value = "+";
    }
  }

  void kurang() {
    if (_isValidInput()) {
      double angka1 = double.parse(txtAngka1.text);
      double angka2 = double.parse(txtAngka2.text);
      double result = angka1 - angka2;
      hasil.value = _formatResult(result);
      operator.value = "-";
    }
  }

  void kali() {
    if (_isValidInput()) {
      double angka1 = double.parse(txtAngka1.text);
      double angka2 = double.parse(txtAngka2.text);
      double result = angka1 * angka2;
      hasil.value = _formatResult(result);
      operator.value = "×";
    }
  }

  void bagi() {
    if (_isValidInput()) {
      double angka1 = double.parse(txtAngka1.text);
      double angka2 = double.parse(txtAngka2.text);

      if (angka2 == 0) {
        hasil.value = "ERROR";
        operator.value = "÷";
        Get.snackbar(
          "ERROR",
          "Pembagian dengan nol tidak diperbolehkan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(63, 112, 111, 111),
          colorText: Colors.black,
        );
        return;
      }

      double result = angka1 / angka2;
      hasil.value = _formatResult(result);
      operator.value = "÷";
    }
  }

  void clear() {
    txtAngka1.clear();
    txtAngka2.clear();
    hasil.value = "0";
    operator.value = "";
  }

  bool _isValidInput() {
    if (txtAngka1.text.isEmpty || txtAngka2.text.isEmpty) {
      hasil.value = "ERROR";
      Get.snackbar(
        "ERROR",
        "Isian tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(63, 112, 111, 111),
        colorText: Colors.black,
      );
      return false;
    }

    if (double.tryParse(txtAngka1.text) == null ||
        double.tryParse(txtAngka2.text) == null) {
      hasil.value = "ERROR";
      Get.snackbar(
        "ERROR",
        "Isian harus berupa angka",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(63, 112, 111, 111),
        colorText: Colors.black,
      );
      return false;
    }

    return true;
  }

  String _formatResult(double result) {
    if (result == result.toInt()) {
      return result.toInt().toString();
    } else {
      return result.toStringAsFixed(2);
    }
  }
}
