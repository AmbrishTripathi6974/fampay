import 'package:flutter/material.dart';
import '../../models/contextual_card_model.dart';

class HC9Card extends StatelessWidget {
  final List<CardDetails> cards;
  final bool isScrollable;

  const HC9Card({
    required this.cards,
    this.isScrollable = true, // Default to scrollable
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220, // Set the max height to accommodate varying card heights
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: isScrollable
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: cards.length,
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Spacing on the left and right
        itemBuilder: (context, index) {
          final card = cards[index];
          final double cardWidth = card.aspectRatio != null
              ? 195 * card.aspectRatio!.toDouble() // Ensure it's explicitly a double
              : 195.0; // Default value as double

          return Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : 8.0, // No margin on the left for the first card
              right: index == cards.length - 1 ? 0 : 8.0, // No margin on the right for the last card
            ),
            width: cardWidth,
            height: cardWidth * 0.5, // Adjust the height dynamically
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: card.bgGradient != null
                  ? LinearGradient(
                      colors: card.bgGradient!.colors
                          .map((color) =>
                              Color(int.parse(color.replaceFirst('#', '0xff'))))
                          .toList(),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      transform: GradientRotation(
                        (card.bgGradient!.angle ?? 0) * 3.14159 / 180,
                      ),
                    )
                  : null,
              image: card.bgImageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(card.bgImageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: card.cta != null && card.cta!.isNotEmpty
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(int.parse(
                              card.cta![0].bgColor.replaceFirst('#', '0xff'))),
                        ),
                        onPressed: () {
                          // Handle CTA action
                        },
                        child: Text(card.cta![0].text),
                      ),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}
