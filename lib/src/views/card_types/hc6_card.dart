import 'package:flutter/material.dart';
import '../../models/contextual_card_model.dart';

class HC6Card extends StatelessWidget {
  final List<CardDetails> cards;

  const HC6Card(this.cards, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cards.map((card) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(card.bgImageUrl ?? ''),
            backgroundColor: Colors.grey,
          ),
          title: Text(
            card.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(card.description ?? ''),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              // Handle card dismissal
            },
          ),
        );
      }).toList(),
    );
  }
}
