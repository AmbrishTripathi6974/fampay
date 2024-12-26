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
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(
                card.title[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              card.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(card.description ?? ''),
            trailing: card.cta != null && card.cta!.isNotEmpty
                ? ElevatedButton(
                    onPressed: () {
                      // Handle CTA action
                    },
                    child: Text(card.cta![0].text),
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }
}
