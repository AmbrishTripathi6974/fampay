import 'package:flutter/material.dart';
import '../../models/contextual_card_model.dart';

class HC5Card extends StatelessWidget {
  final List<CardDetails> cards;

  const HC5Card(this.cards, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cards.map((card) {
        return GestureDetector(
          onTap: () {
            // Handle card tap action
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: card.bgImageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(card.bgImageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: card.bgColor != null
                  ? Color(int.parse(card.bgColor!.replaceFirst('#', '0xff')))
                  : Colors.grey,
            ),
            height: 200.0,
          ),
        );
      }).toList(),
    );
  }
}
