import 'package:flutter/material.dart';

import '../../../config/colorConstant.dart';
import '../../widget/custom_text_style.dart';

class InviceDetailsScreen extends StatelessWidget {
  const InviceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Details"),
      ),
      body: SingleChildScrollView(
        child: (Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            CustomTextStyle.regular(text: "Invoice status"),
            const SizedBox(
              height: 8,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: CustomTextStyle.bold(
                  text: "Company name: Swastik",
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
                      color: Colors.black,
                      width: 4.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: const BoxDecoration(
                          color: AppColors.hoverColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: AppColors.hoverColor,
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
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 24,
                          color: Colors.deepPurpleAccent,
                        )
                      ]),
                ),
                Expanded(
                  child: Container(
                    height: 4,
                    color: Colors.black,
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
                      color: Colors.black,
                      width: 4.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.deepPurpleAccent,
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
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 4,
                    color: Colors.black,
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
                      color: Colors.black,
                      width: 4.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.deepPurpleAccent,
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
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 24,
                          color: Colors.deepPurpleAccent,
                        )
                      ]),
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
                        color: Colors.blue,
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
                        color: Colors.yellow,
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
                              text: "For Verification:", color: Colors.black),
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
                        color: Colors.green,
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
                  color: Colors.grey, /*style: BorderStyle.solid, width: 2*/
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
                          children: [CustomTextStyle.regular(text: "Vendor")]),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      height: 48,
                      color: Colors.grey.shade200,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CustomTextStyle.bold(text: "Soni Bind")]),
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
                          children: [CustomTextStyle.regular(text: "GSTN")]),
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
                            CustomTextStyle.bold(text: "G111111MDLSJDFN")
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
                          children: [CustomTextStyle.bold(text: "NA")]),
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
                            Container(
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.upload,
                                  color: Colors.white,
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
                            CustomTextStyle.regular(text: "Invoice Category")
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
                                  color: AppColors.greenColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CustomTextStyle.regular(
                                    text: "Rmc Material", color: Colors.white),
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
                          children: [CustomTextStyle.regular(text: "PO File")]),
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
                                  color: AppColors.chilliRed,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CustomTextStyle.regular(
                                    text: "NOT LIMITED", color: Colors.white),
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
                      Icon(Icons.thumb_up_rounded),
                      CustomTextStyle.regular(
                          text: "Approve", color: Colors.white),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenColor),
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
                      backgroundColor: AppColors.chilliRed),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
