import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../config/Helper.dart';
import '../config/sharedPreferences.dart';
import '../model/responses/assign_user_model.dart';
import '../model/responses/base_model.dart';
import '../model/responses/invoice_summary_model.dart';
import '../presentation/view/dashboard_screen.dart';
import '../repository/api_call.dart';

class InvoiceDetailsController extends GetxController {
  InvoiceSummaryModel invoiceIDetailModel = InvoiceSummaryModel();
  TextEditingController noteController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isApiLoading = false.obs;
  var userList = <UserData>[].obs;
  var selectedUser = UserData().obs;
  RxString note = "".obs;

  Future<void> onGetInvoiceDetails(String invoiceId) async {
    clearData();
    isLoading.value = true;
    invoiceIDetailModel = await ApiRepo.getInvoiceSummaryDetails(invoiceId);
    isLoading.value = false;
  }

  Future<void> getAssignUserList() async {
    ValidateUserModel projectModel = await ApiRepo.getAssignUserList();
    userList.value = projectModel.data!;
    update();
  }

  Future<void> approveInvoice(
      {required String status_button,
      required String reAssign,
      required BuildContext context}) async {
    print("status->$status_button");
    print("reAssign->$reAssign");

    if (isApiLoading.value == false) {
      isApiLoading.value = true;
      EasyLoading.show(status: 'loading...');

      String? dropDownUSerID = "0";

      String? currentUserID = await Auth.getUserID();
      if (status_button == "0" || status_button == "2") {
        dropDownUSerID = selectedUser.value.userId;
      }
      BaseModel data = await ApiRepo.approveInvoiceStatus(
          status_button: status_button,
          invoiceID: invoiceIDetailModel.data!.invoiceId,
          reAssign: reAssign,
          dropDownUser: dropDownUSerID);

      if (data.status == "true") {
        isApiLoading.value = false;
        EasyLoading.dismiss();
        Helper.getToastMsg(data.message ?? "Invoice Updated");
        Helper().showServerSuccessDialog(context, data.message!, () async {
          if (currentUserID == dropDownUSerID) {
            onGetInvoiceDetails(invoiceIDetailModel.data!.invoiceId!);
          } else {
            Get.offAll(DashBoardScreen(
              index: 1,
            ));
          }
        });
      } else {
        EasyLoading.dismiss();
        isApiLoading.value = false;
        Helper.getToastMsg(data.message ?? "Try Again");
        Helper().showServerErrorDialog(context, data.message ?? "Try Again",
            () async {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
        });
      }
    }
  }

  Future<void> addComment(BuildContext context) async {
    EasyLoading.show(status: 'loading...');

    BaseModel response = await ApiRepo.addComment(
        invoiceId: invoiceIDetailModel.data!.invoiceId,
        comment: noteController.text.trim(),
        companyId: invoiceIDetailModel.data!.company_id!);
    if (response.status == "true") {
      Helper.getToastMsg(response.message!);
      EasyLoading.dismiss();
      Helper().showServerSuccessDialog(context, response.message!, () async {
        Navigator.pop(context);
      });
    } else {
      Helper.getToastMsg("Something went wrong");
      EasyLoading.dismiss();
      Helper().showServerErrorDialog(context, "Something went wrong", () async {
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
      });
    }
  }

  void clearData() {
    noteController.text = "";
    isLoading.value = false;
    isApiLoading.value = false;
    selectedUser.value = UserData();
    note.value = "";
  }
}
