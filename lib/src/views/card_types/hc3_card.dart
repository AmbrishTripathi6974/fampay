import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/contextual_card_controller.dart';
import '../../models/contextual_card_model.dart';

class HC3Card extends StatefulWidget {
  final CardDetails card;

  const HC3Card({super.key, required this.card});

  @override
  State<HC3Card> createState() => _HC3CardState();
}

class _HC3CardState extends State<HC3Card> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  final ContextualCardController _controller = Get.find();
  bool isActionTriggered = false;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Initialize Slide Animation
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.35, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void toggleActionButtons() {
    if (isActionTriggered) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      isActionTriggered = !isActionTriggered;
    });
  }

  void handleDismiss() {
    _controller.dismissCard(widget.card.id);
    toggleActionButtons();
  }

  void handleRemindLater() {
    _controller.remindLater(widget.card.id);
    toggleActionButtons();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.02,
      ),
      child: Stack(
        children: [
          // Background Container with Action Buttons
          Positioned.fill(
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.3,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: handleRemindLater,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F6F3), // Background color
                            borderRadius:
                                BorderRadius.circular(12), // Optional rounding
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                            horizontal: screenWidth * 0.03,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/remind.png',
                                height: screenWidth * 0.1,
                                width: screenWidth * 0.1,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              const Text(
                                'remind later',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      GestureDetector(
                        onTap: handleDismiss,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F6F3), // Background color
                            borderRadius:
                                BorderRadius.circular(12), // Optional rounding
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                            horizontal: screenWidth * 0.03,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/dismiss.png',
                                height: screenWidth * 0.1,
                                width: screenWidth * 0.1,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              const Text(
                                'dismiss now',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()), // Empty space for slide effect
              ],
            ),
          ),

          // Main Card with Slide Transition
          SlideTransition(
            position: _slideAnimation,
            child: GestureDetector(
              onTap: toggleActionButtons, // Toggle on tap
              child: Container(
                width: screenWidth - (screenWidth * 0.08),
                height: screenHeight * 0.43,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: widget.card.bgImageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(widget.card.bgImageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: widget.card.bgColor != null
                      ? widget.card.getParsedBgColor()
                      : Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.card.icon != null)
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Image.network(
                          widget.card.icon!.imageUrl,
                          height: screenWidth * 0.1,
                          width: screenWidth * 0.1,
                        ),
                      ),
                    const Spacer(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            // Big Display Card
                            TextSpan(
                              text:
                                  "${widget.card.formattedTitle?.entities[0].text}\n", // First entity
                              style: TextStyle(
                                color: Color(int.parse(widget
                                    .card.formattedTitle!.entities[0].color
                                    .replaceFirst('#', '0xFF'))),
                                fontSize: widget.card.formattedTitle!
                                        .entities[0].fontSize
                                        ?.toDouble() ??
                                    16,
                                fontWeight: widget.card.formattedTitle!
                                            .entities[0].fontStyle ==
                                        "underline"
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontFamily: widget.card.formattedTitle!
                                        .entities[0].fontFamily ??
                                    'default',
                              ),
                            ),
                            // Static "with action" Text
                            const TextSpan(
                              text: "with action\n", // Hardcoded text
                              style: TextStyle(
                                color: Colors.white, // Default color
                                fontSize:
                                    30, // Slightly smaller font size for "with action"
                                fontWeight: FontWeight.normal,
                                fontFamily: 'default',
                              ),
                            ),
                            // Subtitle Text
                            TextSpan(
                              text:
                                  "\n${widget.card.formattedTitle?.entities[1].text}\n", // Second entity
                              style: TextStyle(
                                color: Color(int.parse(widget
                                    .card.formattedTitle!.entities[1].color
                                    .replaceFirst('#', '0xFF'))),
                                fontSize: widget.card.formattedTitle!
                                        .entities[1].fontSize
                                        ?.toDouble() ??
                                    16,
                                fontWeight: widget.card.formattedTitle!
                                            .entities[1].fontStyle ==
                                        "underline"
                                    ? FontWeight.normal
                                    : FontWeight.normal,
                                fontFamily: widget.card.formattedTitle!
                                        .entities[1].fontFamily ??
                                    'default',
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    if (widget.card.cta != null && widget.card.cta!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(int.parse(widget
                                .card.cta![0].bgColor
                                .replaceFirst('#', '0xFF'))),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: toggleActionButtons,
                          child: Text(
                            widget.card.cta![0].text,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
