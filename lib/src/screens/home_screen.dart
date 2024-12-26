import 'package:fampay/src/widgets/big_card.dart';
import 'package:fampay/src/widgets/card_with_arrow.dart';
import 'package:fampay/src/widgets/dynamic_card.dart';
import 'package:fampay/src/widgets/horizontal_cards.dart';
import 'package:fampay/src/widgets/small_display_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/fampay_logo.png',
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      // Body

      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 233, 250, 234),
          // color: Colors.amber,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: const Column(
          children: [
            // HC3 : Big Data Card

            BigCardWidget(),

            // HC6 : Cards with Arrow

            CardWithArrow(),

            // HC5 : Card with dynamic height

            DynamicCard(),

            // HC9 : Scrollable horizontal cards
            HorizontalCards(),

            // HC1 : Small display card
            SmallDisplayCard(),
          ],
        ),
      ),
    );
  }
}
