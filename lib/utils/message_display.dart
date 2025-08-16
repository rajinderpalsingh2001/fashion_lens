import 'package:fashion_lens/themes/app_theme.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageDisplay {
  static void _getSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    bool showPulse = false,
    bool minimal = false,
    Duration? duration,
    Icon? icon,
  }) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      snackPosition: snackPosition,
      backgroundColor: backgroundColor.withAlpha(200),
      colorText: AppTheme.milkyWhite,
      borderRadius: 25.0,
      isDismissible: true,
      padding: minimal ? const EdgeInsets.all(6.0) : const EdgeInsets.all(20.0),
      margin: minimal ? EdgeInsets.zero : const EdgeInsets.all(10.0),
      snackStyle: minimal ? SnackStyle.GROUNDED : SnackStyle.FLOATING,
      icon: icon ??
          const Icon(HugeIcons.strokeRoundedInformationCircle,
              color: Colors.white),
      shouldIconPulse: showPulse,
      barBlur: minimal ? 0.0 : 10.0,
    );
  }

  static void success(String title, String message, {Duration? duration}) {
    _getSnackBar(
      title: title,
      message: message,
      backgroundColor: AppTheme.primaryColor,
      duration: duration,
      showPulse: false,
      icon: Icon(HugeIcons.strokeRoundedCheckmarkCircle03,
          color: AppTheme.milkyWhite),
    );
  }

  static void fail(String title, String message, {Duration? duration}) {
    _getSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.red,
      duration: duration,
      showPulse: true,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  static void successMinimal(String message, {Duration? duration, bool top = false}) {
    _getSnackBar(
      title: "Success",
      message: message,
      backgroundColor: AppTheme.primaryColor,
      duration: duration,
      showPulse: false,
      snackPosition: top ? SnackPosition.TOP : SnackPosition.BOTTOM,
      minimal: true,
      icon: Icon(HugeIcons.strokeRoundedCheckmarkCircle03,
          color: AppTheme.milkyWhite),
    );
  }

  static void failMinimal(String message, {Duration? duration, bool top = false}) {
    _getSnackBar(
      title: "Oops!",
      message: message,
      backgroundColor: Colors.red,
      duration: duration,
      snackPosition: top ? SnackPosition.TOP : SnackPosition.BOTTOM,
      minimal: true,
      showPulse: true,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

}
