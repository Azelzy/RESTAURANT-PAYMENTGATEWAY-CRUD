import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/calculator_controller.dart';
import '../widget/NavDrawer.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  // Use Get.find with safe access
  CalculatorController get calculatorController => Get.find<CalculatorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "CALCULATORS",
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
          preferredSize: Size.fromHeight(2),
          child: Container(color: Colors.black, height: 2),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 24),
          _buildInputField(
            controller: calculatorController.txtAngka1,
            label: "ANGKA PERTAMAX",
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: calculatorController.txtAngka2,
            label: "ANGKA KEDUAX",
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _buildOperatorButton(
                  text: "+",
                  onPressed: calculatorController.tambah,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildOperatorButton(
                  text: "−",
                  onPressed: calculatorController.kurang,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildOperatorButton(
                  text: "×",
                  onPressed: calculatorController.kali,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildOperatorButton(
                  text: "÷",
                  onPressed: calculatorController.bagi,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              children: [
                Text(
                  "RESULT",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey[400],
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Text(
                    calculatorController.hasil.value,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextButton(
              onPressed: calculatorController.clear,
              child: const Text(
                "CLEAR",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
        ),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildOperatorButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}