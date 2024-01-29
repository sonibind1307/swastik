import 'package:flutter/material.dart';
import 'package:swastik/config/colorConstant.dart';

class CustomTextStyle {
  static Widget extraBold({String? text, double? fontSize, Color? color}) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        color: color,
      ),
    );
  }

  static Widget bold({String? text, double? fontSize, Color? color}) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: color,
      ),
      softWrap: false,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget semiBold({String? text, double? fontSize, Color? color}) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      softWrap: false,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget regular(
      {String? text, double? fontSize, Color? color, int? maxLines}) {
    return Text(
      text!,
      style: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.dataCellColor,
      ),
      maxLines: maxLines,
    );
  }
}
