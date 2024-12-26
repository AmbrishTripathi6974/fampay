import 'package:fampay/src/bindings/general_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/views/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBinding(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
