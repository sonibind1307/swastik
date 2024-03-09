import 'dart:math' as math;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/presentation/widget/edit_text_widgets.dart';

import '../../../config/Helper.dart';
import '../../../config/colorConstant.dart';
import '../../../controller/invoice_details_controller.dart';
import '../../widget/custom_text_style.dart';
import '../pdfexport/pdf_url_viewer.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  final String invoiceId;

  const InvoiceDetailsScreen({super.key, required this.invoiceId});

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  final controller = Get.find<InvoiceDetailsController>();

  @override
  void initState() {
    controller.onGetInvoiceDetails(widget.invoiceId);
    controller.getAssignUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Status"),
      ),
      body: Obx(() => controller.isLoading.value != true
          ? SingleChildScrollView(
              child: (Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: CustomTextStyle.bold(
                          text:
                              "Invoice status -> ${controller.invoiceIDetailModel.data!.status}",
                          fontSize: 16)),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: CustomTextStyle.bold(
                        text:
                            "Company name: ${controller.invoiceIDetailModel.data!.companyname}",
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///first
                      Spacer(),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: const BoxDecoration(
                                color: AppColors.ap1,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: AppColors.ap1,
                                  )
                                ]),
                            child: const Center(
                              child: Text(
                                '01',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 4,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(2, 2),
                                blurRadius: 24,
                                color: AppColors.ap1,
                              )
                            ]),
                      ),
                      Expanded(
                        child: Container(
                          height: 4,
                          color: Colors.grey,
                        ),
                      ),

                      ///second
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: const BoxDecoration(
                                color: AppColors.ap2,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: AppColors.ap2,
                                  )
                                ]),
                            child: const Center(
                              child: Text(
                                '02',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 4,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 4,
                          color: Colors.grey,
                        ),
                      ),

                      ///third
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: const BoxDecoration(
                                color: AppColors.ap3,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: AppColors.ap3,
                                  )
                                ]),
                            child: const Center(
                              child: Text(
                                '03',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 4,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                              color: AppColors.ap1,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextStyle.regular(
                                    text: "Uploaded By", color: Colors.black),
                                CustomTextStyle.regular(
                                    text: controller.invoiceIDetailModel.data!
                                                .step1Username ==
                                            null
                                        ? "NA"
                                        : controller.invoiceIDetailModel.data!
                                                    .step1Username!
                                                    .trim() ==
                                                ""
                                            ? "NA"
                                            : controller.invoiceIDetailModel
                                                .data!.step1Username!
                                                .trim(),
                                    color: Colors.black),
                                CustomTextStyle.regular(
                                    text: controller.invoiceIDetailModel.data!
                                                .step1Timestamp!
                                                .trim() ==
                                            ""
                                        ? "NA"
                                        : controller.invoiceIDetailModel.data!
                                            .step1Timestamp!
                                            .trim(),
                                    color: Colors.black),
                                // CustomTextStyle.regular(
                                //     text: "NA", color: Colors.black),
                              ],
                            ),
                          )),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                              color: AppColors.ap2,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextStyle.regular(
                                    text: "For Verification:",
                                    color: Colors.black),
                                CustomTextStyle.regular(
                                    text: controller.invoiceIDetailModel.data!
                                                .step2Username ==
                                            null
                                        ? "NA"
                                        : "${controller.invoiceIDetailModel.data!.step2Username!.trim() == "" ? "NA" : controller.invoiceIDetailModel.data!.step2Username!.trim()}",
                                    color: Colors.black),
                                CustomTextStyle.regular(
                                    text: controller.invoiceIDetailModel.data!
                                                .step2Timestamp ==
                                            null
                                        ? "NA"
                                        : "${controller.invoiceIDetailModel.data!.step2Timestamp!.trim() == "" ? "NA" : controller.invoiceIDetailModel.data!.step2Timestamp!.trim()}",
                                    color: Colors.black),
                              ],
                            ),
                          )),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                              color: AppColors.ap3,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextStyle.regular(
                                    text: "For Approval:", color: Colors.black),
                                CustomTextStyle.regular(
                                    text: controller.invoiceIDetailModel.data!
                                                .step3Username ==
                                            null
                                        ? "NA"
                                        : controller.invoiceIDetailModel.data!
                                                    .step3Username!
                                                    .trim() ==
                                                ""
                                            ? "NA"
                                            : controller.invoiceIDetailModel
                                                .data!.step3Username!
                                                .trim(),
                                    color: Colors.black),
                                CustomTextStyle.regular(
                                    text: controller.invoiceIDetailModel.data!
                                                .step3Timestamp!
                                                .trim() ==
                                            ""
                                        ? "NA"
                                        : controller.invoiceIDetailModel.data!
                                            .step3Timestamp!
                                            .trim(),
                                    color: Colors.black),
                              ],
                            ),
                          )),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Table(
                      // defaultColumnWidth: MediaQuery,
                      border: TableBorder.all(
                        color:
                            Colors.grey, /*style: BorderStyle.solid, width: 2*/
                      ),
                      children: [
                        TableRow(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            height: 48,
                            color: Colors.grey.shade200,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextStyle.regular(text: "Vendor")
                                ]),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            height: 48,
                            color: Colors.grey.shade200,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextStyle.bold(
                                      text:
                                          "${controller.invoiceIDetailModel.data!.vendorName}")
                                ]),
                          ),
                        ]),
                        if (controller.invoiceIDetailModel.data!.gst != "") ...[
                          TableRow(children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              height: 48,
                              color: Colors.grey.shade300,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextStyle.regular(text: "GSTN")
                                  ]),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              height: 48,
                              color: Colors.grey.shade300,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextStyle.bold(
                                        text: controller
                                            .invoiceIDetailModel.data!.gst!)
                                  ]),
                            ),
                          ]),
                        ],
                        if (controller.invoiceIDetailModel.data!.pan != "") ...[
                          TableRow(children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              height: 48,
                              color: Colors.grey.shade300,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextStyle.regular(text: "PAN")
                                  ]),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              height: 48,
                              color: Colors.grey.shade300,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextStyle.bold(
                                        text: controller
                                            .invoiceIDetailModel.data!.pan!)
                                  ]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              height: 48,
                              color: Colors.grey.shade200,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextStyle.regular(
                                        text: "Invoice Category")
                                  ]),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              height: 48,
                              color: Colors.grey.shade200,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CustomTextStyle.regular(
                                            text: controller.invoiceIDetailModel
                                                .data!.invcat,
                                            color: Colors.white),
                                      ),
                                    )
                                  ]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              height: 48,
                              color: Colors.grey.shade200,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextStyle.regular(
                                        text: "Add Comments")
                                  ]),
                            ),
                            InkWell(
                              onTap: () {
                                buildShowAddComment(context, () {
                                  controller.addComment();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                height: 48,
                                color: Colors.grey.shade200,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CustomTextStyle.regular(
                                              text: "Add", color: Colors.white),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ]),
                        ],
                        TableRow(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            height: 48,
                            color: Colors.grey.shade200,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextStyle.regular(text: "Description")
                                ]),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            height: 48,
                            color: Colors.grey.shade200,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextStyle.bold(
                                      text:
                                          "${controller.invoiceIDetailModel.data!.invref}")
                                ]),
                          ),
                        ]),
                        TableRow(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            height: 48,
                            color: Colors.grey.shade300,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextStyle.regular(text: "Invoice File")
                                ]),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            height: 48,
                            color: Colors.grey.shade300,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PdfUrlView(
                                                  url:
                                                      "${controller.invoiceIDetailModel.data!.filename}",
                                                )),
                                      );
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.upload,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ]),
                        TableRow(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            height: 48,
                            color: Colors.grey.shade300,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextStyle.regular(text: "PO File")
                                ]),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            height: 48,
                            color: Colors.grey.shade300,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CustomTextStyle.regular(
                                          text: "NOT LIMITED",
                                          color: Colors.white),
                                    ),
                                  )
                                ]),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (controller.invoiceIDetailModel.data!.status ==
                          "2") ...[
                        ElevatedButton(
                          onPressed: () {
                            controller.approveInvoice(
                                status_button: '3', reAssign: '0');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: Row(
                            children: [
                              const Icon(Icons.thumb_up_rounded),
                              CustomTextStyle.regular(
                                  text: "Approve", color: Colors.white),
                            ],
                          ),
                        )
                      ],
                      if (controller.invoiceIDetailModel.data!.status ==
                          "1") ...[
                        ElevatedButton(
                          onPressed: () {
                            buildShowDialog(context, () {
                              controller.approveInvoice(
                                  status_button: '2', reAssign: '0');
                            }, label: 'Assign user for verification.');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor),
                          child: Row(
                            children: [
                              const Icon(Icons.verified),
                              CustomTextStyle.regular(
                                  text: "Verify", color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                      if (controller.invoiceIDetailModel.data!.status == "1" ||
                          controller.invoiceIDetailModel.data!.status ==
                              "2") ...[
                        ElevatedButton(
                          onPressed: () {
                            buildShowDialog(context, () {
                              controller.approveInvoice(
                                  status_button: '0', reAssign: '1');
                            }, label: 'Re-Assign user for verification');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.ap2),
                          child: Row(
                            children: [
                              const Icon(Icons.verified),
                              CustomTextStyle.regular(
                                  text: "Re-Assign ", color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                      ElevatedButton(
                        onPressed: () {
                          controller.approveInvoice(
                              status_button: '4', reAssign: '0');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redColor),
                        child: Row(
                          children: [
                            const Icon(Icons.thumb_down_alt_rounded),
                            CustomTextStyle.regular(
                                text: " Reject ", color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              )),
            )
          : const Center(child: CircularProgressIndicator())),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context, VoidCallback callback,
      {required String label}) {
    return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          label,
          style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2),
        ),
        content: dropDownUserList(context, () {}),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2)),
          ),
          TextButton(
            onPressed: () {
              if (controller.selectedUser.value == "") {
                Helper.getToastMsg(label);
              } else {
                Navigator.pop(context);
                callback();
              }
            },
            child: const Text('Yes',
                style: TextStyle(
                    color: AppColors.blueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2)),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildShowAddComment(
      BuildContext context, VoidCallback callback) {
    return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add comment',
          style: TextStyle(
              color: Colors.redAccent,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2),
        ),
        content: CustomEditTestWidgets.commonEditText(controller.noteController,
            lable: "Add note"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2)),
          ),
          TextButton(
            onPressed: () {
              if (controller.noteController.text == "") {
                Helper.getToastMsg("Enter note");
              } else {
                Navigator.pop(context);
                callback();
              }
            },
            child: const Text('Yes',
                style: TextStyle(
                    color: AppColors.blueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2)),
          ),
        ],
      ),
    );
  }

  Widget dropDownUserList(BuildContext context, VoidCallback onSelection) {
    TextEditingController searchBar = TextEditingController();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select user',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: controller.userList
                .map((item) => DropdownMenuItem(
                      value: item.userId,
                      child: Text(
                        item.firstName!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: controller.selectedUser.value == ""
                ? null
                : controller.selectedUser.value,
            onChanged: (value) {
              controller.selectedUser.value = value!;
              setState(() {});
            },
            buttonStyleData: Helper.buttonStyleData(context),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down,
              ),
              // iconSize: 14,
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: Helper.dropdownStyleDataPop(context),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: searchBar,
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
                  controller: searchBar,
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
                return item.value!
                    .toLowerCase()
                    .contains(searchValue.toLowerCase());
              },
            ),
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                searchBar.clear();
                // addInvoiceController.searchTextBar.clear();
              }
            },
          ),
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    const rect = Rect.fromLTWH(50, 50, 100, 200);
    const startAngle = -math.pi / 45;
    const sweepAngle = math.pi / 1;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ArcWidget extends StatelessWidget {
  const ArcWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArcPainter(),
      size: const Size(300, 300),
    );
  }
}
