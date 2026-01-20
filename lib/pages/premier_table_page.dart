import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laihan01/controllers/premier_table_contoller.dart';

class PremierTablePage extends StatelessWidget {
  PremierTablePage({super.key});

  final controller = Get.find<PremierTableContoller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white, // Background utama PUTIH
      appBar: AppBar(
        backgroundColor: Colors.black, // AppBar tetap HITAM
        title: const Text(
          'PREMIER LEAGUE TABLE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 16,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(4), // <<< DIKURANGI: Margin Container luar
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2), // Border HITAM
          color: Colors.white,
        ),
        child: Obx(() {
          if (controller.isloading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 3,
              ),
            );
          }

          if (controller.standings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sports_soccer, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'NO DATA AVAILABLE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            color: Colors.black,
            backgroundColor: Colors.white,
            onRefresh: () {
              return controller.fetchPremierTable();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: controller.standings.length,
              itemBuilder: (context, index) {
                final team = controller.standings[index];
                final rank = int.parse(team.intRank);

                // --- BRUTALIST ACCENT COLORS (Dipadukan dengan tema Putih) ---
                Color itemBgColor = Colors.white; // Default item background PUTIH
                Color itemBorderColor = Colors.black; // Default border HITAM
                Color rankBoxColor = Colors.black; // Default Rank Box HITAM
                Color pointsBoxColor = Colors.black; // Default Points Box HITAM

                if (rank <= 4) {
                  // Champions League - Hijau gelap
                  itemBgColor = Colors.white;
                  itemBorderColor = Colors.green[900]!; // Border Hijau Tua
                  rankBoxColor = Colors.green[900]!;
                  pointsBoxColor = Colors.green[900]!;
                } else if (rank == 5) {
                  // Europa League - Oranye gelap
                  itemBgColor = Colors.white;
                  itemBorderColor = Colors.orange[900]!; // Border Oranye Tua
                  rankBoxColor = Colors.orange[900]!;
                  pointsBoxColor = Colors.orange[900]!;
                } else if (rank >= 18) {
                  // Relegation - Merah gelap
                  itemBgColor = Colors.white;
                  itemBorderColor = Colors.red[900]!; // Border Merah Tua
                  rankBoxColor = Colors.red[900]!;
                  pointsBoxColor = Colors.red[900]!;
                }

                return Container(
                  decoration: BoxDecoration(
                    color: itemBgColor,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black, // Divider Hitam
                        width: index == controller.standings.length - 1 ? 0 : 1,
                      ),
                      top: BorderSide(
                        color: Colors.black,
                        width: index == 0 ? 0 : 0.5,
                      )
                    ),
                  ),
                  child: ListTile(
                    // <<< DIKURANGI: Padding dikurangi untuk mengatasi Overflow
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8, 
                      vertical: 4, 
                    ),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Rank
                        Container(
                          width: 32, // <<< DIKURANGI: Ukuran kotak rank
                          height: 32,
                          decoration: BoxDecoration(
                            color: rankBoxColor, // Warna kotak rank
                            border: Border.all(color: itemBorderColor, width: 2), 
                            borderRadius: BorderRadius.circular(0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            team.intRank,
                            style: TextStyle(
                              // Angka Rank berwarna Putih/Kuning Muda di atas kotak berwarna (sesuai visualisasi Anda)
                              color: rank <= 5 ? Colors.white : Colors.white, 
                              fontWeight: FontWeight.w900,
                              fontSize: 14, 
                            ),
                          ),
                        ),
                        const SizedBox(width: 8), // <<< DIKURANGI: Spacing
                        // Team Badge
                        Container(
                          width: 36, // <<< DIKURANGI: Ukuran Badge
                          height: 36,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1), // Border tipis
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Image.network(
                            team.strBadge,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.sports_soccer, size: 20, color: Colors.grey[800]); 
                            },
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      team.strTeam.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black, // Nama tim HITAM
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "P: ${team.intPlayed} | W: ${team.intWin} | D: ${team.intDraw} | L: ${team.intLoss}",
                        style: TextStyle(
                          color: Colors.grey[700], 
                          fontWeight: FontWeight.w700,
                          fontSize: 10, // <<< DIKURANGI: Ukuran font subtitle
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8, // <<< DIKURANGI: Padding
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: pointsBoxColor, // Warna kotak Points
                            border: Border.all(color: itemBorderColor, width: 2),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Text(
                            team.intPoints,
                            style: TextStyle(
                              // Angka Points berwarna Putih/Kuning Muda di atas kotak berwarna
                              color: pointsBoxColor == Colors.black ? Colors.white : Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 15, // <<< DIKURANGI: Ukuran font points
                            ),
                          ),
                        ),
                        const SizedBox(height: 2), // <<< DIKURANGI: Spacing
                        Text(
                          'PTS',
                          style: TextStyle(
                            fontSize: 8, // <<< DIKURANGI: Ukuran font PTS
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[700],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}