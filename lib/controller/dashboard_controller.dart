import 'package:get/get.dart';

import '../config/sharedPreferences.dart';

class DashboardController extends GetxController {
  RxString userName = "NA".obs;
  RxString userMobile = "NA".obs;
  RxBool isLoading = false.obs;

  void getUserInfoData() async {
    // isLoading.value = true;
    // Helper.getToastMsg(isLoading.value.toString());
    userName.value = await Auth.getUserName() ?? "NA";
    userMobile.value = await Auth.getMobileNo() ?? "NA";
    // isLoading.value = false;
    // Helper.getToastMsg(isLoading.value.toString());
    print("username - >${userName.value}");
    // update();
  }
}
