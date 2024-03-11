import 'package:flutter/material.dart';
import 'package:swastik/config/colorConstant.dart';
import 'package:swastik/presentation/widget/custom_text_style.dart';

BoxDecoration boxDecoration(
    {double radius = 4,
    Color color = AppColors.conGrey,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? Colors.white,
    boxShadow: showShadow
        ? [BoxShadow(color: Colors.black)]
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

Row rowHeading(var label) {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Text(label,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 18,
                fontFamily: 'Bold'),
            textAlign: TextAlign.left),
      ),
    ],
  );
}

Row profileText(var label, {var maxline = 1}) {
  return Row(
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: CustomTextStyle.regular(
            text: label,
          )),
    ],
  );
}

Divider view() {
  return Divider(color: AppColors.t1_view_color, height: 0.5);
}
