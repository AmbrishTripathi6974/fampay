import 'package:flutter/material.dart';
import '../../models/contextual_card_model.dart';

class HC9Card extends StatelessWidget {
  final List<CardDetails> cards;
  final bool isScrollable;

  const HC9Card({
    required this.cards,
    this.isScrollable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: isScrollable
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Container(
            width: card.aspectRatio != null ? 195 * card.aspectRatio! : 195,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
