import 'package:flutter/material.dart';

class BigCardWidget extends StatelessWidget {
  const BigCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(FamxPayController());
    return const SizedBox(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Image(
          image: NetworkImage(
            'https://hok.famapp.co.in/hok-assets/feedMedia/ext/70db327c-b5a0-4485-b97d-6b5eae1f1614-1734193722611.webp',
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
