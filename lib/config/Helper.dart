import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'colorConstant.dart';

class Helper {
  static getErrorLog(String error) {
    log(error);
  }

  static getToastMsg(String toastMessage) {
    Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.white200,
        fontSize: 16.0);
  }

  static getSnackBarError(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          backgroundColor: AppColors.grey700,
          content: Text(
            errorMsg,
            style: const TextStyle(color: Colors.white),
          )));
  }

  /*static Future<void> makePhoneCall(String phoneNo) async {
    getErrorLog(phoneNo);
    final Uri url = Uri.parse('tel:$phoneNo');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> urlLaunch(String link, BuildContext context) async {
    final Uri url = Uri.parse(link);

    if (await canLaunchUrl(url)) {
      await launchUrl(url,
          webViewConfiguration:
              const WebViewConfiguration(enableJavaScript: true),
          mode: LaunchMode.externalApplication);
    } else {
      getSnackBarError(context, "Could not launch this url");
      throw 'Could not launch $url';
    }
  }*/

  static convertDateTime(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd' 'hh:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MM-yyyy hh:mm:ss a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static getDateFromDateTiem(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd' 'hh:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static bool isValidPassword(String password) {
    RegExp passwordPattern = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordPattern.hasMatch(password);
  }

  static String getDateTimeString(DateTime dt) {
    String month = dt.month.toString();
    String day = dt.day.toString();
    if (month.length == 1) {
      month = '0$month';
    }
    if (day.length == 1) {
      day = '0$day';
    }
    final result = '${dt.year}-$month-$day';
    return result;
  }

  static const Map<int, String> monthsInYear = {
    // 1: "January",
    // 2: "February",
    // 3: "March",
    // 4: "April",
    // 5: "May",
    // 6: "June",
    // 7: "July",
    // 8: "August",
    // 9: "September",
    // 10: "October",
    // 11: "November",
    // 12: "December",
    1: "Jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "Jun",
    7: "Jul",
    8: "Aug",
    9: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec",
  };

  static resourceDateRange(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String padWithZero(int inputInt) {
    String result = inputInt.toString();

    // Check if the length is less than 2
    if (result.length == 1) {
      // Pad with '0' if necessary
      result = '0' + result;
    }

    return result;
  }

  static DateTime getLocalTimeToUTCTime(String time) {
    DateTime tempDate;
    if (time.contains('Z')) {
      tempDate = DateTime.parse(time);
    } else {
      tempDate = DateTime.parse('${time}Z');
    }
    return tempDate.toLocal();
  }

  static DropdownStyleData dropdownStyleData(BuildContext context) {
    return DropdownStyleData(
      maxHeight: 250,
      width: MediaQuery.of(context).size.width - 32,
      padding: const EdgeInsets.only(left: 14, right: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        // color: Colors.redAccent,
      ),
      // offset: const Offset(-20, 0),
      scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all<double>(10.0),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
          trackVisibility: MaterialStateProperty.all(true),
          interactive: true,
          trackColor: MaterialStateProperty.all(Colors.grey)),
    );
  }

  static ButtonStyleData buttonStyleData(BuildContext context) {
    return ButtonStyleData(
      height: 45,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      // elevation: 2,
    );
  }

/*  static DropdownSearchData dropdownSearchData(BuildContext context){
    return DropdownSearchData(
      searchController:TextEditingController(),
      searchInnerWidgetHeight: 50,
      searchInnerWidget: Container(
        height: 50,
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 4,
          right: 8,
          left: 8,
        ),
        child: TextFormField(
          expands: true,
          maxLines: null,
          controller:searchTextBar,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            hintText: 'Search...',
            hintStyle: const TextStyle(fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      searchMatchFn: (item, searchValue) {
        return item.value!.toLowerCase().contains(searchValue.toLowerCase());
      },
    );

  }*/

  static List<MemoryImage> convertFilesToMemoryImages(List<File> imageFiles) {
    return imageFiles.map((File file) {
      Uint8List bytes = file.readAsBytesSync();
      return MemoryImage(Uint8List.fromList(bytes));
    }).toList();
  }
}
