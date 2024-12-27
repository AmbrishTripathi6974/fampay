import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/contextual_card_controller.dart';
import 'card_types/hc1_card.dart';
import 'card_types/hc3_card.dart';
import 'card_types/hc5_card.dart';
import 'card_types/hc6_card.dart';
import 'card_types/hc9_card.dart';

class ContextualContainer extends StatelessWidget {
  final controller = Get.put(ContextualCardController());

  ContextualContainer({super.key});

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
                  return HC3Card(card: cardGroup.cards.first); // Adjusted call
                case 'HC6':
                  return HC6Card(cardGroup.cards);
                case 'HC5':
                  return HC5Card(cardGroup.cards);
                case 'HC1':
                  return HC1Card(cardGroup.cards);
                case 'HC9':
                  return HC9Card(cards: cardGroup.cards);
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
