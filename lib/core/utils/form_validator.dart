import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FormValidator {
  static String? empty(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 'RequiredField'.tr();
    }
    return null;
  }

  static String? validateEmail(value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value ?? '');
    if (value == null || value.isEmpty || !emailValid) {
      return 'Please enter email';
    }
    return null;
  }

  static String? password(String? value) {
    if (empty(value) != null) {
      return empty(value);
    }

    RegExp regEx = RegExp(r"(?=.*[A-Z])\w+");

    if (value!.length < 8 || !regEx.hasMatch(value)) {
      return 'Please enter password';
    }

    return null;
  }

  static String? passwordConfirm(value, TextEditingController controller) {
    if (value == null || value.isEmpty) {
      return '';
    }

    if (value.toString() != controller.text) {
      return 'Required';
    }

    return null;
  }

  static String? sumIsLessThanLimit(String? value, double limit) {
    if (value == null || value.isEmpty) {
      return "";
    }

    final sum = double.parse(value ?? "0");
    if (sum > limit) {
      return "errorTextBalanceLess".tr();
    }

    return null;
  }
}
