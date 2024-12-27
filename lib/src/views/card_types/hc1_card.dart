import 'package:flutter/material.dart';

import '../../models/contextual_card_model.dart';

class HC1Card extends StatelessWidget {
  final List<CardDetails> cards;

  const HC1Card(this.cards, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cards.map((card) {
        return Card(
          color: card.bgColor != null 
              ? Color(int.parse(card.bgColor!.replaceAll('#', ''), radix: 16) + 0xFF000000) // Adds the alpha value to ensure color is properly parsed
              : Colors.white,
          child: ListTile(
            leading: card.icon != null
                ? Image.network(card.icon!.imageUrl, width: 32, height: 32)
                : null,
            title: Text(
              card.title ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(card.description ?? ''),
          ),
        );
      }).toList(),
    );
  }
}
