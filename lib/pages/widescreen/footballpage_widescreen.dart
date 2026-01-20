import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/football_controller.dart';
import '../../controllers/football_responsive_controller.dart';
import '../../routes/routes.dart';
import '../../models/football_model.dart';

class FootballWidescreen extends StatelessWidget {
  const FootballWidescreen({super.key});

  FootballController get footballController => Get.find<FootballController>();
  FootballResponsiveController get responsiveController =>
      Get.find<FootballResponsiveController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => footballController.players.isEmpty
          ? _buildEmptyState()
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsiveController.gridCrossAxisCount.value,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.2,
              ),
              itemCount: footballController.players.length,
              itemBuilder: (context, index) => _buildPlayerCard(index),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sports_soccer, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text(
            "LIST PEMAIN KOSONG",
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCard(int index) {
    final player = footballController.players[index];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildPlayerImage(player),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    player.name.isEmpty ? "(Tanpa Nama)" : player.name.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: Colors.black,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${player.position.toUpperCase()} • ${player.number}",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _buildActionButton(Icons.edit, () => _handleEdit(player, index)),
                const SizedBox(width: 8),
                _buildActionButton(Icons.delete, () => _handleDelete(player, index)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerImage(Player player) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
        color: Colors.grey[300],
      ),
      child: player.imageUrl.isNotEmpty
          ? ClipRRect(
              child: Image.network(
                player.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.person, color: Colors.grey[600]),
              ),
            )
          : Icon(Icons.person, color: Colors.grey[600]),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 38,
      height: 38,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black, width: 1),
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }

  void _handleEdit(Player player, int index) {
    Get.toNamed(
      AppRoutes.footballedit,
      arguments: {
        'index': index,
        'player': player,
        'isNewPlayer': false,
      },
    );
  }

  void _handleDelete(Player player, int index) {
    footballController.deletePlayer(index);
    Get.snackbar(
      "TELAH DIHAPUS",
      player.name.toUpperCase(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(63, 112, 111, 111),
      colorText: Colors.black,
    );
  }
}
