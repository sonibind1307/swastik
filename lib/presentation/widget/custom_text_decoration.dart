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

  static InputDecoration dateFieldDecoration(
      {String? labelText,
      BuildContext? context,
      required Function(String value) callBack}) {
    return InputDecoration(
      suffixIcon: IconButton(
        icon: const Icon(Icons.calendar_month),
        onPressed: () {
          // Helper.selectDate(
          //     callBack: (String selectedDate) {
          //       callBack(selectedDate);
          //     },
          //     context: context!);

          showDatePicker(
            context: context!,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          ).then((selectedDate) {
            // After selecting the date, display the time picker.
            if (selectedDate != null) {
              showTimePicker(
                context: context!,
                initialTime: TimeOfDay.now(),
              ).then((selectedTime) {
                // Handle the selected date and time here.
                if (selectedTime != null) {
                  DateTime selectedDateTime = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );
                  print(
                      selectedDateTime); // You can use the selectedDateTime as needed.

                  callBack(selectedDateTime.toString());
                }
              });
            }
          });
        },
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
