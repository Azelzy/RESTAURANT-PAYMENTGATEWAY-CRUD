import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/football_controller.dart';
import '../../routes/routes.dart';
import '../../models/football_model.dart';

class FootballMobile extends StatelessWidget {
  const FootballMobile({super.key});

  FootballController get footballController => Get.find<FootballController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => footballController.players.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: footballController.players.length,
              itemBuilder: (context, index) {
                return _buildPlayerCard(index);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.rectangle,
              ),
              child: Icon(
                Icons.sports_soccer,
                size: 40,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "LIST PEMAIN KOSONG",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerCard(int index) {
    final player = footballController.players[index];
    return Dismissible(
      key: Key(player.name + index.toString()),
      background: Container(
        color: Colors.black,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white, size: 24),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => _handleDismiss(player, index),
      child: _buildPlayerTile(player, index),
    );
  }

  Widget _buildPlayerTile(Player player, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: _buildPlayerImage(player),
        title: Text(
          player.name.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 14,
            letterSpacing: 0.5,
            color: Colors.black,
          ),
        ),
        subtitle: _buildPlayerSubtitle(player),
        trailing: _buildEditButton(player, index),
        onTap: () => _handleTap(player),
      ),
    );
  }

  Widget _buildPlayerImage(Player player) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: player.imageUrl.isNotEmpty
          ? Image.network(
              player.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.person, color: Colors.grey[600]);
              },
            )
          : Icon(Icons.person, color: Colors.grey[600]),
    );
  }

  Widget _buildPlayerSubtitle(Player player) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        "${player.position.toUpperCase()} • ${player.number}",
        style: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.w600,
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildEditButton(Player player, int index) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.edit, color: Colors.black, size: 18),
        onPressed: () => _handleEdit(player, index),
      ),
    );
  }

  void _handleDismiss(Player player, int index) {
    footballController.deletePlayer(index);
    Get.snackbar(
      "TELAH DIHAPUS",
      player.name.toUpperCase(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(63, 112, 111, 111),
      colorText: Colors.black,
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

  void _handleTap(Player player) {
    Get.snackbar(
      "ANDA MENEKAN",
      player.name.toUpperCase(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(63, 112, 111, 111),
      colorText: Colors.black,
    );
  }
}