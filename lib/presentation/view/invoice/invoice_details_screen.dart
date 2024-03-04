import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Details"),
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
                          text: "Invoice status", fontSize: 16)),
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
                        decoration: BoxDecoration(
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
                        decoration: BoxDecoration(
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
                                    text:
                                        "${controller.invoiceIDetailModel.data!.updatedBy!.trim() == "" ? "NA" : controller.invoiceIDetailModel.data!.updatedBy!.trim()}",
                                    color: Colors.black),
                                CustomTextStyle.regular(
                                    text:
                                        "${controller.invoiceIDetailModel.data!.updatedDate!.trim() == "" ? "NA" : controller.invoiceIDetailModel.data!.updatedDate!.trim()}",
                                    color: Colors.black),
                                CustomTextStyle.regular(
                                    text: "NA", color: Colors.black),
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
                                    text: "Soni Bind", color: Colors.black),
                                CustomTextStyle.regular(
                                    text: DateTime.now().toString(),
                                    color: Colors.black),
                                CustomTextStyle.regular(
                                    text: "NA", color: Colors.black),
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
                                    text: "Soni Bind", color: Colors.black),
                                CustomTextStyle.regular(
                                    text: DateTime.now().toString(),
                                    color: Colors.black),
                                CustomTextStyle.regular(
                                    text: "NA", color: Colors.black),
                              ],
                            ),
                          )),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
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
                                      text:
                                          "${controller.invoiceIDetailModel.data!.gst}")
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
                                          "${controller.invoiceIDetailModel.data!.invcomments}")
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
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
                                          text: "Rmc Material",
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
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.verified),
                            CustomTextStyle.regular(
                                text: "Verify", color: Colors.white),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.ap1),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.thumb_up_rounded),
                            CustomTextStyle.regular(
                                text: "Approve", color: Colors.white),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.thumb_down_alt_rounded),
                            CustomTextStyle.regular(
                                text: " Reject ", color: Colors.white),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redColor),
                      ),
                    ],
                  )
                ],
              )),
            )
          : const Center(child: CircularProgressIndicator())),
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

    final rect = Rect.fromLTWH(50, 50, 100, 200);
    final startAngle = -math.pi / 45;
    final sweepAngle = math.pi / 1;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ArcWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArcPainter(),
      size: Size(300, 300),
    );
  }
}
