import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/responses/assign_user_model.dart';

class AddTaskController extends GetxController {
  TextEditingController cNameController = TextEditingController();
  TextEditingController cPersonNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  UserData selectedUser = UserData();
  RxList<String> vendorList = <String>["NA", "Registered", "URD"].obs;
  RxList<String> userList = <String>["user 1", "user 2"].obs;
  RxBool isUILoading = false.obs;
  bool isLoading = false;
  final addVendorFormKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  String vendorId = "0";

  void addVendorApi(BuildContext context) async {
    /* if (isLoading == false) {
      isLoading = true;
      EasyLoading.show(status: 'loading...');
      // try {
      BaseModel response ;
      if (response.status == "true") {
        isLoading = false;
        Helper.getToastMsg(response.message!);
        EasyLoading.dismiss();
        Helper().showServerSuccessDialog(context, response.message!, () async {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
          // Navigator.pop(context);
          Get.offAll(DashBoardScreen(
            index: 2,
          ));
        });
      } else {
        isLoading = false;
        Helper.getToastMsg("Something went wrong");
        EasyLoading.dismiss();
        Helper().showServerErrorDialog(context, "Something went wrong",
            () async {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
        });
      }
    }
    // catch (e) {
    //     isLoading = false;
    //     Helper.getToastMsg(e.toString());
    //     EasyLoading.dismiss();
    //     Helper().showServerErrorDialog(context, e.toString().substring(0, 10),
    //         () async {
    //       FocusScope.of(context).unfocus();
    //       Navigator.pop(context);
    //     });
    //   }
    // }*/
  }

  void onUserSelected(UserData? value) {
    selectedUser = value!;
    update();
  }
}
