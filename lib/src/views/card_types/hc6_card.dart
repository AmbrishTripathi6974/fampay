import 'package:flutter/material.dart';
import '../../models/contextual_card_model.dart';

class HC6Card extends StatelessWidget {
  final List<CardDetails> cards;

  const HC6Card(this.cards, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cards.map((card) {
        // Extract entity text and style details
        final entity = card.formattedTitle?.entities.first;
        final text = entity?.text ?? '';
        final textColor = entity?.color != null
            ? Color(int.parse(entity!.color.replaceFirst('#', '0xFF')))
            : Colors.black;
        final fontFamily = entity?.fontFamily ?? 'default';
        final fontWeight = entity?.fontStyle == 'underline'
            ? FontWeight.bold
            : FontWeight.normal;

        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon
                if (card.icon != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Image.network(
                      card.icon!.imageUrl,
                      width: 30,
                      height: 30,
                    ),
                  ),
                // Text
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontFamily: fontFamily,
                      fontWeight: fontWeight,
                      fontSize: 14,
                    ),
                  ),
                ),
                // Arrow Icon
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
