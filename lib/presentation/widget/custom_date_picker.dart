import 'package:flutter/material.dart';

class CustomDateTime {
  static DateTime now = DateTime.now();

  static Future<DateTime?> buildShowDatePicker(BuildContext context) {
    // int day = getDaysBeforeMonth(2);
    return showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime.now(),
        lastDate: now);
  }

  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[month - 1];
  }

  static int getDaysBeforeMonth(beforeMonth) {
    int month = now.month;
    int days = now.day - 1;
    for (int i = 0; i < beforeMonth; i++) {
      month--;
      days = days + getDaysInMonth(now.year, month);
    }
    return days;
  }

  static bool isBeforeOrEqualTo(String date1, String date2) {
    // DateTime dt1 = DateTime.parse(convertDBDate(date1));
    // DateTime dt2 = DateTime.parse(convertDBDate(date2));
    // if (dt1.compareTo(dt2) == 0) {
    //   return true;
    // }
    // if (dt1.compareTo(dt2) < 0) {
    //   ///DT1 is before DT2
    //   return true;
    // }
    //
    // if (dt1.compareTo(dt2) > 0) {
    //   ///DT1 is after DT2
    //   return false;
    // }
    return false;
  }

  static String getDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
    } else {
      return "00:$twoDigitMinutes";
    }
  }
}
