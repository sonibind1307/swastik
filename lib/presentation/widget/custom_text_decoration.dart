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

  static InputDecoration loginDecoration({String? labelText}) {
    return InputDecoration(
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: AppColors.black300),
        ),
        hintText: labelText);
  }
}
