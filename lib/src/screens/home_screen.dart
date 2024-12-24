import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/fampay_controller.dart';
import '../data/repository/fampay_repo.dart';
import '../services/api_service.dart';

class HomeScreen extends StatelessWidget {
  final FamxPayController controller = Get.put(
    FamxPayController(
      repository: FamxPayRepository(
        apiService: FamxPayApiService(client: http.Client()),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/fampay_logo.png',
          height: 40, // Adjust as needed
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final hcGroups = controller.famxPayData['hc_groups'] ?? [];

        return ListView.builder(
          itemCount: hcGroups.length,
          itemBuilder: (context, index) {
            final group = hcGroups[index];
            return buildGroup(group);
          },
        );
      }),
    );
  }

  Widget buildGroup(Map<String, dynamic> group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${group['name']} (${group['design_type']})',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: group['cards'].length,
          itemBuilder: (context, cardIndex) {
            final card = group['cards'][cardIndex];
            return GestureDetector(
              onLongPress: () => controller.handleLongPress(card['id']), // Updated
              onTap: () => controller.clearLongPress(),
              child: Obx(() {
                final isLongPressed =
                    controller.longPressedCardId.value == card['id'].toString(); // Updated

                return Stack(
                  children: [
                    buildCard(card),
                    if (isLongPressed)
                      Positioned.fill(
                        child: buildLongPressOverlay(card),
                      ),
                  ],
                );
              }),
            );
          },
        ),
      ],
    );
  }

  Widget buildCard(Map<String, dynamic> card) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (card['bg_image'] != null)
            Image.network(
              card['bg_image']['image_url'],
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: const Center(child: Text("Image failed to load")),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              card['title'] ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          if (card['cta'] != null)
            TextButton(
              onPressed: () {
                // Handle CTA action
              },
              child: Text(card['cta'][0]['text']),
            ),
        ],
      ),
    );
  }

  Widget buildLongPressOverlay(Map<String, dynamic> card) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.timer, color: Colors.white),
            onPressed: () {
              // Handle "Remind Later"
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              // Handle "Dismiss Now"
            },
          ),
        ],
      ),
    );
  }
}
