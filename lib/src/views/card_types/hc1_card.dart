import 'package:flutter/material.dart';
import '../../models/contextual_card_model.dart';

class HC1Card extends StatelessWidget {
  final List<CardDetails> cards;
  final bool isScrollable;

  const HC1Card({
    required this.cards,
    required this.isScrollable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.01,
      ),
      child: SizedBox(
        height: 100, // Fixed height for cards
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return _buildCard(
              cards[index],
              context,
              isScrollable ? screenWidth * 0.7 : screenWidth * 0.5,
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(CardDetails card, BuildContext context, double cardWidth) {
    // Extracting formatted title and description
    final formattedTitleEntity =
        card.formattedTitle?.entities.isNotEmpty == true
            ? card.formattedTitle!.entities.first
            : null;
    final formattedDescriptionEntity =
        card.formattedDescription?.entities.isNotEmpty == true
            ? card.formattedDescription!.entities.first
            : null;

    // Setting title and description text
    final titleText =
        isScrollable ? (formattedTitleEntity?.text) : 'Small card';
    final descriptionText = formattedDescriptionEntity?.text ?? '';

    // Extracting colors and fonts
    final titleColor = formattedTitleEntity?.color != null
        ? Color(int.parse(formattedTitleEntity!.color.replaceAll('#', ''),
                radix: 16) +
            0xFF000000)
        : Colors.black;
    final descriptionColor = formattedDescriptionEntity?.color != null
        ? Color(int.parse(formattedDescriptionEntity!.color.replaceAll('#', ''),
                radix: 16) +
            0xFF000000)
        : Colors.black;

    final titleFontFamily = formattedTitleEntity?.fontFamily ?? 'Roboto';
    final descriptionFontFamily =
        formattedDescriptionEntity?.fontFamily ?? 'Roboto';

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4)
          .copyWith(bottom: 12), // Added spacing at the bottom
      child: Card(
        color: card.bgColor != null
            ? Color(int.parse(card.bgColor!.replaceAll('#', ''), radix: 16) +
                0xFF000000)
            : Colors.amber, // Default color
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding:
              const EdgeInsets.all(16.0), // Added padding of 12 from all sides
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon or image
              if (card.icon != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(18), // Circular image
                  child: Image.network(
                    card.icon!.imageUrl,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              const SizedBox(width: 12), // Spacing between icon and text
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      titleText!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: titleFontFamily,
                        color: titleColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (descriptionText.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        descriptionText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: descriptionFontFamily,
                          color: descriptionColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
