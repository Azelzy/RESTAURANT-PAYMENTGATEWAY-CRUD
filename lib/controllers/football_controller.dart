import 'package:get/get.dart';
import '../models/football_model.dart';

class FootballController extends GetxController {
  var players = <Player>[
    Player(name: "A", position: "Penyerang", number: 1, imageUrl: "a.png"),
    Player(name: "B", position: "Penyerang", number: 2, imageUrl: "b.png"),
    Player(name: "C", position: "Gelandang", number: 3, imageUrl: "c.png"),
  ].obs;

  void addPlayer(Player player) {
    players.add(player);
  }

  void deletePlayer(int index) {
    players.removeAt(index);
  }

  void updatePlayer(int index, Player player) {
    players[index] = player;
    update();
  }
}
