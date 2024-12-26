import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contextual_card_controller.dart';
import 'card_types/hc3_card.dart';
import 'card_types/hc6_card.dart';

// ignore: use_key_in_widget_constructors
class ContextualContainer extends StatelessWidget {
  final controller = Get.put(ContextualCardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      } else {
        return RefreshIndicator(
          onRefresh: () async => controller.fetchCards(),
          child: ListView.builder(
            itemCount: controller.cards.length,
            itemBuilder: (context, index) {
              final cardGroup = controller.cards[index];
              switch (cardGroup.designType) {
                case 'HC3':
                  return HC3Card(cardGroup.cards);
                case 'HC6':
                  return HC6Card(cardGroup.cards);
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        );
      }
    });
  }
}
