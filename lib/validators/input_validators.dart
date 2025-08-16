import 'package:flutter/material.dart';

class InputValidators {
  static String? name(String? value) {
    if (value == null || value.isEmpty || value.trim() == "") {
      return 'Name is required';
    }
    return null;
  }

  static String? isEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? required(String? value) {
    if (value == null || value.isEmpty || value.trim() == "") {
      return 'This field is required';
    }
    return null;
  }

  static String? optional(String? value) {
    return null;
  }

  static String? isPhoneNumber(String? value) {
    int maxLength = 10;
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    String pattern =
        r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value.length > maxLength) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? isValidPassword(String? password) {
    //Contains at least one uppercase letter.
    //Contains at least one lowercase letter.
    //Contains at least one digit.
    //Has a minimum length of 8 characters.
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    // RegExp regex = RegExp(pattern);
    // if (!regex.hasMatch(password)) {
    //   return 'Password must meet complexity requirements'; // Replace with your specific message
    // }
    if (password.length < 8) {
      return "Password must be atleast 8 characters";
    }
    return null;
  }

  static bool confirmMatch(String value, String compareTo) {
    if (value != compareTo) {
      return false;
    }
    return true;
  }

  bool emptyAndNullCheck(List<TextEditingController> inputControllers) {
    for (TextEditingController controller in inputControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  // static String? url(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'URL is required';
  //   }
  //   String pattern =
  //       r'^(https?:\/\/)([a-zA-Z0-9.-]+)\.([a-zA-Z]{2,6})([\/\w .-]*)*\/?$';
  //   RegExp regex = RegExp(pattern);
  //   if (!regex.hasMatch(value)) {
  //     return 'Enter a valid URL starting with http:// or https://';
  //   }
  //   return null;
  // }

  // Integer validation
  static String? isInteger(String? value) {
    if (value == null || value.isEmpty) {
      return 'Value is required';
    }
    String pattern = r'^[0-9]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid integer';
    }
    return null;
  }

  // Integer or double validation
  static String? isNumeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'Value is required';
    }
    String pattern = r'^[0-9]+(\.[0-9]+)?$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid number';
    }
    return null;
  }

  /// 12ABCDE1234F1Z5
  static String? isGst(String? value) {
    if (value == null || value.isEmpty) {
      return "GSTIN is required";
    }
    RegExp regExp =
        RegExp(r'\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}');
    if (!regExp.hasMatch(value)) {
      return "Invalid GSTIN";
    }
    return null;
  }

  static String? instagramUsername(String? value) {
    if (value == null || value.isEmpty) return null; // optional

    final regex = RegExp(r'^(?!.*https?://)(?!@)[A-Za-z0-9._]{1,30}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid Instagram username (no @ or URL)';
    }
    return null;
  }

  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // optional — return null if empty is allowed
    }

    final uri = Uri.tryParse(value.trim());
    final isValid = uri != null && uri.hasScheme && uri.host.isNotEmpty;

    if (!isValid) {
      return 'Please enter a valid URL (e.g. https://example.com)';
    }
    return null;
  }

}
