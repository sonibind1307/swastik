import 'dart:io';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/DraverItem.dart';
import '../presentation/widget/custom_text_style.dart';
import 'colorConstant.dart';

class Helper {
  final drawerItems = [
    DrawerItem("Dashboard", Icons.home),
    DrawerItem("Invoices", Icons.ballot_outlined),
    DrawerItem("RMC Challans", Icons.fire_truck),
    DrawerItem("Vendors", Icons.people_alt_rounded),
    DrawerItem("Task", Icons.line_style_outlined),
    DrawerItem("PO/WO", Icons.content_paste_sharp),
    DrawerItem("Site Report", Icons.business),
    DrawerItem("Attendance", Icons.fingerprint),
    DrawerItem("Settings", Icons.settings),
    DrawerItem("Logout", Icons.logout),
  ];

  static getErrorLog(String error) {
    // log(error as num);
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(error).forEach((match) => print(match.group(0)));
  }

  static getToastMsg(String toastMessage) {
    Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: AppColors.darkGery100,
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

  static Future<void> makePhoneCall(String phoneNo) async {
    getErrorLog(phoneNo);

    launchUrlString("tel://$phoneNo");
    // final Uri url = Uri.parse('tel:$phoneNo');
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  /*static Future<void> urlLaunch(String link, BuildContext context) async {
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
    var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
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
      width: MediaQuery.of(context).size.width - 64,
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

  static DropdownStyleData dropdownStyleDataPop(BuildContext context) {
    return DropdownStyleData(
      maxHeight: 250,
      width: double.infinity - 128,
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
      height: 48,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
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

  /*customGetDialogWithButton({String? title, String? subTitle, VoidCallback? onTap,IconData? iconData}){
    Get.dialog(
      Dialog(
        child: SizedBox(
          width: 150,
          height: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Icon(iconData,color: Colors.red,size: 50,),
              Padding(
                padding: const EdgeInsets.only(top: 10,),
                child: CustomTextStyle.bold(
                  text:title ?? "",
                ),
              ),
              CustomTextStyle.regular(
                text: subTitle ?? "",
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 8.0),
                child: CustomButton(
                  height: getVerticalSize(55),
                  text: Loc.alized.lbl_login,
                  shape: ButtonShape.CircleBorder25,
                  onTap: () {
                    onTap!.call();
                    // Get.offNamed(Routes.LOGIN);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
*/

  static customGetDialogWithoutButton(
      {String? title,
      String? subTitle,
      IconData? iconData,
      bool? autoColsePopup}) {
    Get.dialog(Dialog(
      child: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Icon(
              iconData,
              color: Colors.red,
              size: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: CustomTextStyle.bold(
                text: title ?? "",
              ),
            ),
            CustomTextStyle.regular(
              text: subTitle ?? "",
            ),
          ],
        ),
      ),
    ));
    if (autoColsePopup == true) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.back(); // Close the dialog
      });
    }
  }

  void showServerErrorDialog(
      BuildContext context, String error, VoidCallback callback) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Center(
              child: Container(
                height: 200,
                width: 220,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: AppColors.redColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child:
                                  const Icon(Icons.cancel, color: Colors.white))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: DefaultTextStyle(
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal),
                          child: SelectableText(
                            error,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                      OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          callback();
                        },
                        child: const Text("Ok"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void showCropAndOCRDialog(BuildContext context, String error, File file,
      {required VoidCallback callbackCancel,
      required VoidCallback callbackCrop,
      required VoidCallback callbackOcr}) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Center(
              child: Container(
                height: 230,
                width: 220,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal),
                        child: Text(
                          error,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey.withOpacity(0.5),
                      child: Stack(
                        children: [
                          const Center(child: CircularProgressIndicator()),
                          Image.file(
                            File(file.path),
                            height: 180,
                            width: 180,
                            gaplessPlayback: true,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              callbackCancel();
                            },
                            child: const Text("Cancel")),
                        ElevatedButton(
                            onPressed: () {
                              callbackCrop();
                            },
                            child: const Text("Crop")),
                        ElevatedButton(
                            onPressed: () {
                              callbackOcr();
                            },
                            child: const Text("OCR")),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  static void sendEmail(String sendTo) async {
    final Email email = Email(
      body: 'Add body here.',
      subject: 'Email subject',
      recipients: [sendTo],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print(error);
    }
  }

  void showServerSuccessDialog(
      BuildContext context, String error, VoidCallback callback) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Center(
              child: Container(
                height: 200,
                width: 220,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Icon(Icons.check, color: Colors.white))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal),
                        child: Text(
                          error,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                    const Spacer(),
                    OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.primaryColor)),
                      onPressed: () {
                        callback();
                      },
                      child:
                          CustomTextStyle.bold(text: "OK", color: Colors.white),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  static Future<bool> closeAppDialog(BuildContext context) async {
    return (await showDialog(
          barrierDismissible: false,
          // barrierColor: Colors.transparent,
          barrierColor: Colors.black.withOpacity(0.5),
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Are you sure?',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2),
            ),
            content: const Text('Do you want to exit an App',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2)),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2)),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor)),
                onPressed: () {
                  // StorageUtil.instance.removeAll();
                  exit(0);
                },
                child: const Text('Yes',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2)),
              ),
            ],
          ),
        )) ??
        false;
  }

  static Future<bool> deleteDialog(
      BuildContext context, String title, VoidCallback callback) async {
    return (await showDialog(
          barrierDismissible: false,
          // barrierColor: Colors.transparent,
          barrierColor: Colors.black.withOpacity(0.5),
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Are you sure?',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2),
            ),
            content: Text(title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2)),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2)),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop(false);
                  callback();
                  // StorageUtil.instance.removeAll();
                  // exit(0);
                },
                child: const Text('Yes',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2)),
              ),
            ],
          ),
        )) ??
        false;
  }

  static Color getCardColor2(String status) {
    switch (status) {
      case "a":
        return const Color(0xFFCC0033);
      case "b":
        return const Color(0xFFFF0033);
      case "c":
        return const Color(0xFFFF3366);
      case "d":
        return Color(0xFFCC3300);
      case "e":
        return Color(0xFFFF3333);
      case "f":
        return Color(0xFFCC6633);
      case "g":
        return Color(0xFF993300);
      case "h":
        return Color(0xFF663300);
      case "i":
        return Color(0xFFCC6600);
      case "j":
        return Color(0xFFFF9933);
      case "k":
        return Color(0xFFCC9933);
      case "l":
        return Color(0xFF996600);
      case "m":
        return Color(0xFF996633);
      case "n":
        return Color(0xFFcc9900);
      case "o":
        return Color(0xFF99ccff);
      case "p":
        return Color(0xFF3399ff);
      case "q":
        return Color(0xFF006699);
      case "r":
        return Color(0xFF6699ff);
      case "s":
        return Color(0xFF0033cc);
      case "t":
        return Color(0xFFff9900);
      case "u":
        return Color(0xFF996633);
      case "v":
        return Color(0xFF999933);
      case "w":
        return Color(0xFF99cc66);
      case "x":
        return Color(0xFF00ff99);
      case "y":
        return Color(0xFFcc99ff);
      case "z":
        return Color(0xFF660066);
      default:
        return AppColors.primaryColor;
    }
  }

  static Color getCardColor(String status) {
    switch (status) {
      case "a" || "e" || "i" || "m" || "q" || "u" || "y":
        return AppColors.bsPrimary;
      case "b" || "f" || "j" || "n" || "r" || "v" || "z":
        return AppColors.bsWarning;
      case "c" || "g" || "k" || "o" || "s" || "w":
        return AppColors.bsDanger;
      case "d" || "h" || "l" || "p" || "t" || "x":
        return AppColors.bsSuccess;
      default:
        return AppColors.primaryColor;
    }
  }

  static Color getCardColor1(String status) {
    List<Color> colors = [
      AppColors.bsPrimary,
      AppColors.bsWarning,
      AppColors.bsDanger,
      AppColors.bsSuccess
    ];
    Random random = Random();
    int index = 0;
    index = random.nextInt(4);

    return colors[index];
  }

  static bool isGSTValidator(String value) {
    return RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$')
        .hasMatch(value);
  }

  static bool isPanValidator(String value) {
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value);
  }

  static String addDecimalIfNeeded(String input) {
    if (!input.contains('.')) {
      input += '.0';
    }
    return input;
  }

  static Color getStatusColor(String status) {
    print("object - > $status");
    switch (status) {
      case "0" || "All":
        return Colors.grey;
      case "1" || "PENDING":
        return Colors.orange;
      case "2" || "APPROVED":
        return AppColors.bsSuccess;
      case "3" || "VERIFIED":
        return Colors.blueAccent;
      case "4" || "REJECTED":
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  static Widget? getIcon(String status) {
    switch (status) {
      case "PENDING":
        return Icon(
          Icons.watch_later,
          color: Colors.orange,
        );
      case "APPROVED":
        return Icon(
          Icons.check_circle,
          color: Colors.green,
        );
      case "VERIFIED":
        return const Icon(
          Icons.verified,
          color: Colors.blueAccent,
        );
      case "REJECTED":
        return Icon(
          Icons.cancel,
          color: Colors.red,
        );
      case "4":
        return Icon(
          Icons.watch_later,
          color: Colors.red,
        );
      default:
        return Icon(
          Icons.watch_later,
          color: Colors.red,
        );
    }
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class MyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Popup Title'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter text...',
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                  onTap: () {
                    // Do something when list item is tapped
                  },
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
