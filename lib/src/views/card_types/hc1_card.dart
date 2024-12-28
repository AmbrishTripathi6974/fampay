import 'package:flutter/material.dart';
import '../../models/contextual_card_model.dart';

class HC1Card extends StatelessWidget {
  final List<CardDetails> cards;

  const HC1Card(this.cards, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: cards.map((card) {
          // Extract formatted title and description
          final formattedTitleEntity =
              card.formattedTitle?.entities.isNotEmpty == true
                  ? card.formattedTitle!.entities.first
                  : null;
          final formattedDescriptionEntity =
              card.formattedDescription?.entities.isNotEmpty == true
                  ? card.formattedDescription!.entities.first
                  : null;

          // Title and Description with their respective font families
          final formattedTitle = formattedTitleEntity?.text ?? '';
          final titleFontFamily = formattedTitleEntity?.fontFamily ?? 'Roboto';
          final formattedDescription = formattedDescriptionEntity?.text ?? '';
          final descriptionFontFamily =
              formattedDescriptionEntity?.fontFamily ?? 'Roboto';

          return Card(
            color: card.bgColor != null
                ? Color(int.parse(card.bgColor!.replaceAll('#', ''), radix: 16) +
                    0xFF000000) // Ensures color parsing
                : Colors.white,
            child: ListTile(
              leading: card.icon != null
                  ? Image.network(card.icon!.imageUrl, width: 36, height: 36)
                  : null,
              title: Text(
                formattedTitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: titleFontFamily, // Use font family for the title
                ),
              ),
              subtitle: Text(
                formattedDescription,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily:
                      descriptionFontFamily, // Use font family for the description
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
