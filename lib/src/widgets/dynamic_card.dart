import 'package:flutter/material.dart';

class DynamicCard extends StatelessWidget {
  const DynamicCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: AspectRatio(
          aspectRatio: 2.406015,
          child: Image(
            image: NetworkImage(
              'https://hok.famapp.co.in/hok-assets/feedMedia/ext/055c4856-53fc-41a1-8a30-354abfaa270c-1734193759460.webp',
            ),
          ),
        ),
      ),
    );
  }
}
