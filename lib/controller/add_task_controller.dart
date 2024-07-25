import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../config/Helper.dart';
import '../model/responses/base_model.dart';
import '../model/responses/vendor_model.dart';
import '../presentation/view/dashboard_screen.dart';
import '../repository/api_call.dart';

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

  String? selectedVendor;
  RxList<String> vendorList = <String>["NA", "Registered", "URD"].obs;
  RxList<String> userList = <String>["user 1", "user 2"].obs;
  RxBool isUILoading = false.obs;
  bool isLoading = false;
  final addVendorFormKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  String vendorId = "0";

  void updateFormData(VendorData? vendorData) {
    isUILoading.value = true;
    if (vendorData != null) {
      vendorId = vendorData.id!;
      cNameController.text = vendorData.companyName!;
      emailController.text = vendorData.email!;
      cPersonNameController.text = vendorData.contactName!;
      mobileController.text = vendorData.contactNo!;
      panNumberController.text = vendorData.pan!;
      gstController.text = vendorData.gst!;
      addressController.text = vendorData.address!;
      pinCodeController.text = vendorData.pincode!;
      cityController.text = vendorData.city!;
      selectedVendor = vendorData.vendorType!.toUpperCase();
    }
    isUILoading.value = false;
  }

  void clearFormData() {
    vendorId = "0";
    cNameController.text = "";
    emailController.text = "";
    cPersonNameController.text = "";
    mobileController.text = "";
    panNumberController.text = "";
    gstController.text = "";
    addressController.text = "";
    pinCodeController.text = "";
    cityController.text = "";
    selectedVendor = vendorList.value[0];
  }

  void addVendorApi(BuildContext context) async {
    if (isLoading == false) {
      isLoading = true;
      EasyLoading.show(status: 'loading...');
      // try {
      BaseModel response = await ApiRepo.onVendorSubmit(
          companyName: cNameController.text.trim(),
          conName: cPersonNameController.text.trim(),
          mobile: mobileController.text.trim(),
          vendorType: selectedVendor,
          pan: panNumberController.text.trim(),
          gst: gstController.text.trim(),
          address: addressController.text.trim(),
          pincode: pinCodeController.text.trim(),
          city: cityController.text.trim(),
          vendorId: vendorId,
          email: emailController.text.trim(),
          context: context);
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
    // }
  }
}
