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
      maxLines: 6,
      decoration:
          CustomTextDecoration.textFieldDecoration(labelText: Constant.remark),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Constant.enterTextError;
        }
        return null;
      },
    );
  }
}