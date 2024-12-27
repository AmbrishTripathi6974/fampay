import 'package:flutter/material.dart';

import '../../models/contextual_card_model.dart';

class HC6Card extends StatelessWidget {
  final List<CardDetails> cards;

  HC6Card(this.cards);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cards.map((card) {
        return ListTile(
          leading: card.icon != null
              ? Image.network(card.icon!.imageUrl, width: 32, height: 32)
              : null,
          title: Text(
            card.title ?? '',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Add navigation or action
          },
        );
      }).toList(),
    );
  }
}
