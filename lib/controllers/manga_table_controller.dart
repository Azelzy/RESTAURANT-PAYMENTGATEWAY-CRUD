import 'package:get/get.dart';
import '../models/manga_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MangaController extends GetxController {
  var isLoading = true.obs;
  var mangaList = <Manga>[].obs;

  @override
  void onInit() {
    fetchManga();
    super.onInit();
  }

  Future<void> fetchManga() async {
    try {
      isLoading(true);

      final url =
          "https://api.mangadex.org/manga?contentRating[]=safe&order[followedCount]=desc&limit=30&includes[]=cover_art";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        List data = jsonData["data"];
        List includes = jsonData["includes"] ?? [];

        List<Manga> temp = [];

        for (var item in data) {
          Manga manga = Manga.fromJson(item);

          // Cari cover yang cocok di includes
          final coverJson = includes.firstWhere(
            (e) =>
                e["type"] == "cover_art" &&
                e["relationships"] != null &&
                e["relationships"].any(
                  (r) => r["id"] == manga.id,
                ),
            orElse: () => null,
          );

          manga = manga.copyWithCover(coverJson);
          temp.add(manga);
        }

        mangaList.assignAll(temp);
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
