import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/manga_table_controller.dart';

class MangaPage extends GetView<MangaController> {
  const MangaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Manga"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.mangaList.isEmpty) {
          return const Center(child: Text("No Manga Found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.mangaList.length,
          itemBuilder: (context, index) {
            final manga = controller.mangaList[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 3,
              child: ListTile(
                leading: manga.coverImageUrl != null
                    ? Image.network(
                        manga.coverImageUrl!,
                        height: 80,
                        width: 60,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 80,
                        width: 60,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
                title: Text(manga.title),
                subtitle: Text(
                  manga.tags.join(", "),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
