import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/Helper.dart';

import '../config/internet_conectivity.dart';
import '../config/sharedPreferences.dart';
import '../model/responses/user_info_model.dart';
import '../presentation/view/dashboard_screen.dart';
import '../repository/api_call.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString errorMsg = "".obs;
  RxString errorUser = "".obs;

  Future<void> onLoginClick(String option) async {
    if (checkValidation(option) == true) {
      Auth.clearUserData();
      errorMsg.value = "";
      errorUser.value = "";
      isLoading.value = true;
      UserModel userModel = UserModel();

      if (await InternetConnectivityCheck.getInstance()
              .chkInternetConnectivity() ==
          false) {
        Helper.getToastMsg("No internet connection");
        isLoading.value = false;
        return;
      }

      try {
        userModel = await ApiRepo.onLogin(option, phoneController.text,
            userNameController.text, passwordController.text);
        if (userModel.status == "true") {
          Auth.setUserID(userModel.data!.userId!);
          Auth.setName(userModel.data!.fullName!);
          Auth.setUserName(userModel.data!.userName!);
          Auth.setEmail(userModel.data!.email!);
          Auth.setDesignation(userModel.data!.userDepartment!);
          Auth.setMobileNo(userModel.data!.userMobile!);
          isLoading.value = false;
          String? token = await FirebaseMessaging.instance.getToken();
          onUpdateToken(token: token!);
          Helper.getToastMsg(userModel.message!);
          Get.offAll(const DashBoardScreen(
            index: 0,
          ));
        } else {
          isLoading.value = false;
          Helper.getToastMsg(userModel.message!);
        }
      } catch (e) {
        isLoading.value = false;
        Helper.getToastMsg(e.toString());
      }
      isLoading.value = false;
    }
  }

  Future<void> onUpdateToken({required String token}) async {
    String userId = await Auth.getUserID() ?? "0";
    final responseData = await ApiRepo.onUpdateToken(userId, token);
    if (responseData.status == "true") {
      Helper.getToastMsg(responseData.message!);
    }
  }

  bool checkValidation(String option) {
    // phoneController.text = "9359309108";

    if (option == "1") {
      if (_validateMobile(phoneController.text.trim().toString())) {
        errorMsg.value = "";
        return true;
      } else {
        errorMsg.value = "Invalid mobile number";
        return false;
      }
    } else {
      print("username-> ${userNameController.text.trim()}");
      if (userNameController.text.trim().toString() == "") {
        errorUser.value = "Please enter username";
        return false;
      } else if (passwordController.text.trim().toString() == "") {
        errorUser.value = "Please enter password";
        return false;
      } else {
        errorUser.value = "";
        return true;
      }
    }
  }

  bool _validateMobile(String value) {
    // Regular expression for a valid mobile number (10 digits)
    final RegExp regex = RegExp(r'^[0-9]{10}$');
    return regex.hasMatch(value);
  }
}
