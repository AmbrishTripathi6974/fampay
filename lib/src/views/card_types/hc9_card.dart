import 'package:flutter/material.dart';
import '../../models/contextual_card_model.dart';

class HC9Card extends StatelessWidget {
  final List<CardDetails> cards;

  const HC9Card(this.cards, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cards.map((card) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: card.bgColor != null
                ? Color(int.parse(card.bgColor!.replaceFirst('#', '0xff')))
                : Colors.purple,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(card.bgImageUrl ?? ''),
            ),
            title: Text(
              card.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              card.description ?? '',
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        );
      }).toList(),
    );
  }
}
