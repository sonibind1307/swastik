import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:swastik/config/RupeesConverter.dart';

import '../config/Helper.dart';
import '../config/colorConstant.dart';
import '../config/sharedPreferences.dart';
import '../model/responses/assign_user_model.dart';
import '../model/responses/base_model.dart';
import '../model/responses/comments_model.dart';
import '../model/responses/invoice_summary_model.dart';
import '../presentation/widget/app_widget.dart';
import '../presentation/widget/custom_text_style.dart';
import '../presentation/widget/edit_text_widgets.dart';
import '../repository/api_call.dart';

class InvoiceDetailsController extends GetxController {
  InvoiceSummaryModel invoiceIDetailModel = InvoiceSummaryModel();
  TextEditingController noteController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isApiLoading = false.obs;
  RxBool isLoadingComment = false.obs;
  bool isNoteApiCall = false;
  bool isNoteApiCheck = false;
  var userList = <UserData>[].obs;
  var commentList = <CommentData>[].obs;
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
          Navigator.pop(context);
          if (currentUserID == dropDownUSerID) {
            onGetInvoiceDetails(invoiceIDetailModel.data!.invoiceId!);
          } else {
            // Get.offAll(DashBoardScreen(
            //   index: 1,
            // ));

            onGetInvoiceDetails(invoiceIDetailModel.data!.invoiceId!);
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

  Future<void> addComment1(BuildContext context) async {
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

  Future<void> getComments(String invoiceId) async {
    isLoadingComment.value = true;
    CommentsModel response = await ApiRepo.getComments(invoiceId: invoiceId);
    commentList.value = response.data!;
    isLoadingComment.value = false;
    update();
  }

  Future<void> addComment(
      BuildContext context, invoiceId, comment, companyId) async {
    if (isNoteApiCall == false) {
      isNoteApiCall = true;
      isNoteApiCheck = true;
      EasyLoading.show(status: 'loading...');
      BaseModel response = await ApiRepo.addComment(
          invoiceId: invoiceId, comment: comment, companyId: companyId);
      if (response.status == "true") {
        Helper.getToastMsg(response.message!);
        EasyLoading.dismiss();
        isNoteApiCall = false;
        Helper().showServerSuccessDialog(context, response.message!, () async {
          Navigator.pop(context);
          getComments(invoiceId);
          noteController.text = "";
        });
      } else {
        isNoteApiCall = false;
        Helper.getToastMsg("Something went wrong");
        EasyLoading.dismiss();
        Helper().showServerErrorDialog(context, "Something went wrong",
            () async {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
        });
      }
    }
  }

  Future<dynamic> buildShowAddComment(
      BuildContext context,
      Function callback,
      Function closeCallback,
      String vendorName,
      String refNumber,
      String amount) {
    // TextEditingController noteController = TextEditingController();

    return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add comment',
                style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: CustomTextStyle.bold(
                  text: vendorName, color: Colors.white, fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: CustomTextStyle.regular(
                    text: "Inv.Ref:$refNumber",
                    fontSize: 14,
                    color: Colors.grey)),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                CustomTextStyle.regular(text: "Total amount :"),
                const SizedBox(
                  width: 8,
                ),
                CustomTextStyle.bold(
                    text: double.parse(amount.toString())
                        .toInt()
                        .inRupeesFormat(),
                    fontSize: 14),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            CustomEditTestWidgets.commonEditText(noteController,
                isOptional: true, lable: "Add Comment here"),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {
                if (noteController.text == "") {
                  Helper.getToastMsg("Enter note");
                } else {
                  FocusScope.of(context).unfocus();
                  callback(noteController.text.trim());
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryColor)),
              child: const Text('Add',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2)),
            ),
          ],
        ),
        content: Obx(
          () => SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextStyle.regular(text: "Total:${commentList.length}"),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: isLoadingComment.isTrue
                        ? const Center(child: CircularProgressIndicator())
                        : commentList.isEmpty
                            ? Center(
                                child: Container(
                                  child: CustomTextStyle.regular(
                                      text: "No comments added"),
                                ),
                              )
                            : ListView.separated(
                                itemCount: commentList.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == commentList.length) {
                                    return Container(
                                      height: 50,
                                    );
                                  } else {
                                    CommentData data = commentList[index];
                                    return Container(
                                      decoration:
                                          boxDecoration(showShadow: true),
                                      child: ListTile(
                                        title: CustomTextStyle.bold(
                                            text:
                                                "${data.postedBy == "" ? "NA" : data.postedBy}",
                                            fontSize: 12),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            CustomTextStyle.regular(
                                                text:
                                                    "${data.comments == "" ? "NA" : data.comments}",
                                                fontSize: 14),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            CustomTextStyle.regular(
                                                text:
                                                    "${data.date == "" ? "NA" : Helper.convertDateTime(data.date!)}",
                                                fontSize: 12)
                                          ],
                                        ),
                                        leading: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Helper.getCardColor(
                                                      data.postedBy!
                                                          .substring(0, 1)
                                                          .toLowerCase()),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Center(
                                                  child: CustomTextStyle.bold(
                                                      color: Colors.white,
                                                      text: data.postedBy!
                                                          .substring(0, 1)
                                                          .toUpperCase(),
                                                      fontSize: 20))),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 4,
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () => closeCallback(isNoteApiCheck),
            child: const Text('Close',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2)),
          ),
        ],
      ),
    );
  }
}
