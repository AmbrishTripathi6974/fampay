import 'package:fampay/src/bindings/general_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
