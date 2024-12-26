import 'package:flutter/material.dart';
import '../../models/contextual_card_model.dart';

class HC3Card extends StatelessWidget {
  final List<CardDetails> cards;

  const HC3Card(this.cards, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cards.map((card) {
        return Container(
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
                : Colors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                if (card.description != null)
                  Text(
                    card.description!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                const SizedBox(height: 8.0),
                if (card.cta != null && card.cta!.isNotEmpty)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        int.parse(card.cta![0].bgColor.replaceFirst('#', '0xff')),
                      ),
                    ),
                    onPressed: () {
                      // Handle CTA action
                    },
                    child: Text(card.cta![0].text),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
