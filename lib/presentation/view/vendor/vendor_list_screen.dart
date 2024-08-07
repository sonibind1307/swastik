import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/presentation/widget/custom_text_style.dart';

import '../../../config/colorConstant.dart';
import '../../../controller/vendor_list_controller.dart';
import '../../../model/responses/vendor_model.dart';
import 'add_vendor_screen.dart';

class VendorListScreen extends StatelessWidget {
  VendorListScreen({super.key});

  final controller = Get.find<VendorListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddVendorScreen(
                        vendorData: null,
                      )),
            );
          },
          label: const Text("Add Vendor")),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: TextField(
                  onChanged: (value) {
                    controller.onSearchVendor(value.toString());
                  },
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8.0)))),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                      () =>
                      CustomTextStyle.regular(
                          text: "Count : ${controller.vendorList.length}"),
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
            Obx(
                  () =>
              controller.isLoading.value == false
                  ? Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.getAllVendorList();
                  },
                  child: controller.vendorList.isNotEmpty
                      ? ListView.separated(
                    itemCount: controller.vendorList.length,
                    itemBuilder: (BuildContext context, int index) {
                      VendorData data =
                      controller.vendorList[index];

                      return Card(
                        child: InkWell(
                          onTap: () {
                            openBottomSheet(context, (key) async {
                              if (key == "edit") {
                                Navigator.of(context).pop();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddVendorScreen(
                                            vendorData: data,
                                          )),
                                );
                              } else if (key == "call") {
                                if (data.contactNo != null &&
                                    data.contactNo! != "") {
                                  Helper.makePhoneCall(
                                      data.contactNo!);
                                }
                              } else if (key == "email") {
                                if (data.email != null &&
                                    data.email! != "" &&
                                    data.email!.toLowerCase() !=
                                        "na") {
                                  Helper.sendEmail(data.email!);
                                } else {
                                  Helper.getToastMsg(
                                      "Email not found");
                                }
                              }
                            }, data);
                          },
                          child: ListTile(
                            title: CustomTextStyle.bold(
                                text:
                                data.companyName!.toUpperCase(),
                                fontSize: 14),
                            subtitle: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                CustomTextStyle.regular(
                                    text:
                                    "${data.email == "" ? "NA" : data.email}",
                                    fontSize: 12),
                                const SizedBox(
                                  height: 4,
                                ),
                                CustomTextStyle.regular(
                                    text:
                                    "${data.contactNo == "" ? "NA" : data
                                        .contactNo}",
                                    fontSize: 12),
                              ],
                            ),
                            leading: Padding(
                              padding:
                              const EdgeInsets.only(right: 8),
                              child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: Helper.getCardColor(
                                          data.companyName!
                                              .substring(0, 1)
                                              .toLowerCase()),
                                      borderRadius:
                                      const BorderRadius.all(
                                          Radius.circular(24))),
                                  child: Center(
                                      child: CustomTextStyle.bold(
                                          color: Colors.white,
                                          text: data.companyName!
                                              .substring(0, 1),
                                          fontSize: 20))),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder:
                        (BuildContext context, int index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                  )
                      : SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                        child: CustomTextStyle.regular(
                            text: "No data found")),
                  ),
                ),
              )
                  : const Expanded(
                  child: Center(child: CircularProgressIndicator())),
            ),
          ],
        ),
      ),
    );
  }

  Future openBottomSheet(BuildContext context, Function(String key) onClick,
      VendorData vendorData) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          height: MediaQuery
              .of(context)
              .size
              .height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: CustomTextStyle.bold(
                    text: "Vendor: ${vendorData.companyName}",
                    color: Colors.white,
                    fontSize: 16),
              ),
              // Row(
              //   children: [
              //     const Spacer(),
              //     CustomTextStyle.regular(text: "Total amount :"),
              //     const SizedBox(
              //       width: 8,
              //     ),
              //     CustomTextStyle.bold(
              //         text: double.parse("0").toInt().inRupeesFormat(),
              //         fontSize: 14),
              //     const SizedBox(
              //       width: 8,
              //     ),
              //   ],
              // ),
              InkWell(
                onTap: () {
                  onClick("edit");
                },
                child: ListTile(
                  title: const Text("Edit Vendor"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(Icons.edit)),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onClick("email");
                },
                child: ListTile(
                  title: const Text("Email"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(Icons.email)),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onClick("call");
                },
                child: ListTile(
                  title: const Text("Call"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(Icons.call)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
