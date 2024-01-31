import 'package:flutter/material.dart';
import 'package:swastik/config/colorConstant.dart';

class CustomTextDecoration {
  static InputDecoration textFieldDecoration({String? labelText}) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      labelText: labelText,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
    );
  }

  static InputDecoration passwordFieldDecoration(
      {Widget? suffixIcon, String? labelText}) {
    return InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        labelText: labelText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        suffixIcon: suffixIcon);
  }

  static InputDecoration dateFieldDecoration({String? labelText}) {
    return InputDecoration(
      suffixIcon: IconButton(
        icon: const Icon(Icons.calendar_month),
        onPressed: () {},
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      labelText: labelText,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
    );
  }
}
