import 'package:fashion_lens/themes/app_theme.dart';
import 'package:fashion_lens/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimarySafeArea extends StatelessWidget {
  final Widget child;

  const PrimarySafeArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Keep status bar transparent
        statusBarIconBrightness: Brightness.dark, // Black icons on light bg
        statusBarBrightness: Brightness.light, // For iOS

        systemNavigationBarColor: AppTheme.milkyWhite, // Bottom nav bar background
        systemNavigationBarIconBrightness: Brightness.dark, // White icons
        systemNavigationBarDividerColor: AppTheme.primaryColor,
      ),
      child: Container(
        color: AppTheme.milkyWhite,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              Utils.hideKeyboard(context);
            },
            child: child,
          ),
        ),
      ),
    );
  }
}
