import 'package:flutter/material.dart';
import '../../models/contextual_card_model.dart';

class HC3Card extends StatelessWidget {
  final CardDetails card;

  const HC3Card({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: card.bgImageUrl != null
              ? DecorationImage(
                  image: NetworkImage(card.bgImageUrl!),
                  fit: BoxFit.cover,
                )
              : null,
          color: card.bgColor != null ? card.getParsedBgColor() : Colors.grey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (card.icon != null) // Display the icon if available
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  card.icon!.imageUrl,
                  height: 50,
                  width: 50,
                ),
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RichText(
                text: TextSpan(
                  children: card.formattedTitle?.entities.map((entity) {
                        return TextSpan(
                          text: "${entity.text}\n", // Add newline if needed
                          style: TextStyle(
                            color: entity.color.isNotEmpty
                                ? Color(int.parse(entity.color.replaceFirst('#', '0xFF')))
                                : Colors.black,
                            fontSize: entity.fontSize?.toDouble() ?? 16,
                            fontWeight: entity.fontStyle == "underline"
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontFamily: entity.fontFamily ?? 'default',
                          ),
                        );
                      }).toList() ??
                      [],
                ),
                textAlign: TextAlign.left, // Align text to the left
              ),
            ),
            const SizedBox(height: 8),
            if (card.cta != null && card.cta!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(
                        int.parse(card.cta![0].bgColor.replaceFirst('#', '0xFF'))),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // Add the action for the button (e.g., navigate to URL)
                    if (card.cta![0].text.isNotEmpty) {
                      print("Button tapped: ${card.cta![0].text}");
                    }
                  },
                  child: Text(
                    card.cta![0].text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
