import 'package:flutter/material.dart';
import '../../models/contextual_card_model.dart';

class HC5Card extends StatelessWidget {
  final List<CardDetails> cards;

  const HC5Card(this.cards, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: cards.map((card) {
          return GestureDetector(
            onTap: () {
              // Handle card tap action
            },
            child: Container(
              height: 150, // Fixed height to avoid extra space
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: card.bgImageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(card.bgImageUrl!),
                        fit: BoxFit.cover, // Changed to cover for proper scaling
                      )
                    : null,
                color: card.bgImageUrl == null ? Colors.grey : null, // Fallback color
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
