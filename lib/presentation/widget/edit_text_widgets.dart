import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/constant.dart';
import 'custom_text_decoration.dart';

class CustomEditTestWidgets {
  static final amountRegex = RegExp(r'^\d+(\.\d{1,2})?$');
  static final FocusNode _focusNode = FocusNode();
  Offset _position = Offset.zero;

  static void _handlePanEnd(DragEndDetails details) {
    // Handle pan end logic here
    print('Pan gesture ended');
  }

  static Widget amountEditText(
      TextEditingController controller, bool isEnable, BuildContext context) {
    // _focusNode.addListener(_onFocusChange);
    // controller.addListener(_onFocusChange);
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: isEnable,
      keyboardType:
          const TextInputType.numberWithOptions(signed: false, decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter(RegExp(r'\d+'), allow: true)
      ],
      maxLength: 6,
      decoration:
          CustomTextDecoration.textFieldDecoration(labelText: Constant.amount),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Constant.enterTextError;
        }
        if (!amountRegex.hasMatch(value)) {
          return 'Please enter a valid amount';
        }
        return null;
      },
      onEditingComplete: () {},
      // onTapOutside: (value) {
      //   MoneyFormatter fmf =
      //       MoneyFormatter(amount: double.parse(controller.text.toString()));
      //   MoneyFormatterOutput fo = fmf.output;
      //   controller.text = fo.nonSymbol;
      // },
    );
  }

  static void _onFocusChange() {
    if (!_focusNode.canRequestFocus) {
      print("object");
      _handleTapOutside();
      // TextField has gained focus
    }
  }

  static void _handleTapOutside() {
    // Handle tap outside logic here
    print('Tapped outside TextField');
  }

  static Widget textEditText(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: 1,
      decoration: CustomTextDecoration.textFieldDecoration(
          labelText: Constant.txtRemarks),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Constant.enterTextError;
        }
        return null;
      },
    );
  }

  static Widget dateEditText(
      TextEditingController controller, BuildContext context,
      {required Function(String value) callBack}) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: 1,
      decoration: CustomTextDecoration.dateFieldDecoration(
          labelText: "Due Date",
          context: context,
          callBack: (String value) {
            callBack(value);
          }),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Constant.enterTextError;
        }
        return null;
      },
    );
  }

  static Widget textEditTextLogin(
      {TextEditingController? controller,
      BuildContext? context,
      required String hint}) {
    return Container(
      height: 48,
      margin: EdgeInsets.only(left: 4),
      padding: EdgeInsets.only(left: 4),
      // color: Colors.red,
      color: Colors.grey.shade200,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: 1,
        decoration: CustomTextDecoration.loginDecoration(labelText: hint),
      ),
    );
  }

  static Widget textEditPhoneLogin(
      {TextEditingController? controller,
      BuildContext? context,
      required String hint,
      required Function() onTap}) {
    return Container(
      height: 48,
      margin: EdgeInsets.only(left: 4),
      padding: EdgeInsets.only(left: 4),
      // color: Colors.red,
      color: Colors.grey.shade200,
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: controller,
        readOnly: true,
        onTap: onTap,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: 1,
        decoration: CustomTextDecoration.loginDecoration(labelText: hint),
      ),
    );
  }

  static Widget commonEditText(TextEditingController controller,
      {String? lable, int? maxLine, bool? isOptional}) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLine ?? 1,
      textAlign: TextAlign.start,
      decoration: CustomTextDecoration.textFieldDecoration(labelText: lable),
      validator: (value) {
        if (isOptional == null) {
          if (value == null || value.isEmpty) {
            return Constant.enterTextError;
          }
        }
        return null;
      },
    );
  }

  static Widget commonMobileNumber(TextEditingController controller,
      {String? lable, int? maxLine}) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLine ?? 1,
      keyboardType: TextInputType.phone,
      decoration: CustomTextDecoration.textFieldDecoration(labelText: lable),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Constant.enterTextError;
        }
        return null;
      },
    );
  }
}
