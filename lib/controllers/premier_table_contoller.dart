import 'dart:convert';

import 'package:get/get.dart';
import 'package:laihan01/models/table_model.dart';
import 'package:http/http.dart' as http;

class PremierTableContoller extends GetxController {
  var isloading = false.obs;
  var standings = <Table>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPremierTable();
  }

  Future <void> fetchPremierTable() async {
    const url =
        'https://www.thesportsdb.com/api/v1/json/3/lookuptable.php?l=4328&s=2025-2026';

    try {
      isloading.value = true;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List? standingsData = data['table'] as List?;

        if (standingsData != null) {
          standings.assignAll(
            standingsData.map((e) => Table.fromJson(e)).toList(),
          );
        } else {
          // Handle case where 'table' key is null or missing in the response body
          Get.snackbar(
            "Data Error",
            "The 'table' data is missing or invalid in the response.",
          );
        }
      } else {
        // CRITICAL CORRECTION: Proper placement of the 'else' block for failed status code.
        // Added the status code to the message for better debugging.
        Get.snackbar(
          "Failed",
          "Failed loading data. Status: ${response.statusCode}",
        );
      }
    } catch (e) {
      // 4. Added proper error logging.
      print('Error fetching premier table: $e');
      Get.snackbar("Network Error", "An unexpected error occurred: $e");
    } finally {
      // 5. IMPORTANT: Ensure loading is set to false in all cases.
      isloading.value = false;
    }
  }
}
