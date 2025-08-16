import 'dart:ui';

import 'package:fashion_lens/constants/app_constants.dart';
import 'package:fashion_lens/controllers/binding/initial_binding.dart';
import 'package:fashion_lens/themes/app_theme.dart';
import 'package:fashion_lens/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      title: AppConstants.appName,
      theme: AppTheme.themeData,
      home: HomeView(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods like buildOverscrollIndicator and buildScrollbar
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
