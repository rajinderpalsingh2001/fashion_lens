import 'package:flutter/services.dart';

class InputFormatters {
  /// Accepts only positive integers (0-9)
  static final List<TextInputFormatter> integerOnly = [FilteringTextInputFormatter.digitsOnly];

  //accepts positive decimal and integers only
  static final List<TextInputFormatter> decimalAndInteger = <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];

  /// Accepts only alphabetic characters (A-Z, a-z)
  static final List<TextInputFormatter> alphabetsOnly = [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
  ];

  /// Accepts only uppercase alphanumeric characters up to 15 chars for GSTIN
  static final List<TextInputFormatter> gstin = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]')),
    LengthLimitingTextInputFormatter(15),
  ];

  static final List<TextInputFormatter> instagramUsernameInputFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9._]')),
    LengthLimitingTextInputFormatter(30),
  ];
}
