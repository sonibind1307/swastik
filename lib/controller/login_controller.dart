import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/Helper.dart';

import '../config/sharedPreferences.dart';
import '../model/responses/user_info_model.dart';
import '../presentation/view/ashboard_screen.dart';
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
      errorMsg.value = "";
      errorUser.value = "";
      isLoading.value = true;
      UserModel userModel = UserModel();
      try {
        userModel = await ApiRepo.onLogin(option, phoneController.text,
            userNameController.text, passwordController.text);
        if (userModel.status == "true") {
          Auth.setUserID(userModel.data!.userId!);
          Auth.setUserName(userModel.data!.userName!);
          Auth.setMobileNo(userModel.data!.userMobile!);
          isLoading.value = false;
          Helper.getToastMsg(userModel.message!);
          Get.offAll(DashBoardScreen(
            index: 1,
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

  bool checkValidation(String option) {
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
