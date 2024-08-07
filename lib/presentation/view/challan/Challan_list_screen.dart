import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/presentation/widget/custom_text_style.dart';

import '../../../config/colorConstant.dart';
import '../../../controller/challan_list_controller.dart';
import '../../../model/responses/challan_model.dart';
import '../../../model/responses/project_model.dart';

class ChallanListScreen extends StatefulWidget {
  ChallanListScreen({super.key});

  @override
  State<ChallanListScreen> createState() => _ChallanListScreenState();
}

class _ChallanListScreenState extends State<ChallanListScreen> {
  List<String> listOfStatus = [
    "PENDING",
    // "VERIFIED",
    "APPROVED",
    "REJECTED",
    "0",
  ];

  // late ChallanListController controller;
  final controller = Get.find<ChallanListController>();

  @override
  void initState() {
    controller.onGetProject();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // controller.onGetProject();
        controller.getAllChalanList();
        // controller.selectedProject = ProjectData().obs;
      },
      child: Scaffold(
        // floatingActionButton: FloatingActionButton.extended(
        //     icon: const Icon(Icons.add),
        //     onPressed: () {},
        //     label: const Text("Add Vendor")),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              projectDropDownList(context),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Wrap(
                  spacing: 8.0,
                  children: listOfStatus.map((status) {
                    return Obx(
                      () => ChoiceChip(
                        labelPadding: const EdgeInsets.only(left: 8, right: 8),
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        selectedColor: AppColors.worningColor,
                        label: Text(_getChipStatusText(status)),
                        selected: controller.selectedStatus.value == status,
                        onSelected: (isSelected) {
                          if (isSelected) {
                            controller.selectedStatus.value = status;
                            controller.getProjectSelected();
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => CustomTextStyle.regular(
                        text: "Count : ${controller.challanList.length}"),
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
              const Divider(
                thickness: 1,
                color: Colors.orange,
              ),
              Obx(
                () => controller.isLoading.value == false
                    ? Expanded(
                        child: controller.challanList.isNotEmpty
                            ? ListView.separated(
                                itemCount: controller.challanList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ChallanData data =
                                      controller.challanList[index];

                                  return // Generated code for this Row Widget...
                                      InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      openBottomSheet(context, (key) {
                                        if (key == "edit") {}
                                      }, data);
                                    },
                                    child: Card(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 0, 0, 0),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF1F4F8),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xFFE5E7EB),
                                                ),
                                              ),
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0, 0),
                                                child: Image(
                                                  image: const AssetImage(
                                                      'assets/rms-challan.png'),
                                                  height: 32,
                                                  width: 32,
                                                  color: Helper.getStatusColor(
                                                      "${data.chlStatus}"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(12, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            -1, -1),
                                                    child: CustomTextStyle.bold(
                                                        text:
                                                            "${data.companyname}"),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: CustomTextStyle
                                                            .regular(
                                                                text:
                                                                    data.projectname ??
                                                                        "NA",
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            -1, 0),
                                                    child: CustomTextStyle.regular(
                                                        text:
                                                            "Challan No : ${data.challanNo}",
                                                        color: Colors.grey),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            -1, 0),
                                                    child: CustomTextStyle.regular(
                                                        text:
                                                            "Truck No : ${data.vehicleNo}",
                                                        color: Colors.grey),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            -1, 0),
                                                    child: CustomTextStyle.regular(
                                                        text:
                                                            "Date : ${data.challanDt}",
                                                        color: Colors.grey),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0, -1),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              1, 0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: CustomTextStyle
                                                            .regular(
                                                                text:
                                                                    "${data.grade}",
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            1, 0),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: CustomTextStyle.regular(
                                                            text: "${data.quantity!
                                                                /*int.parse(
                                                      data.quantity!.split(
                                                          ".")[0])*/
                                                                } ${data.unit!.toUpperCase()}",
                                                            color: Colors.black)),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Helper
                                                              .getStatusColor(
                                                                  "${data.chlStatus}"),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          4))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: CustomTextStyle
                                                            .regular(
                                                                text:
                                                                    data.chlStatus ??
                                                                        "NA",
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ),
                                                  /* Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            1, 0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: CustomTextStyle
                                                          .regular(
                                                        text:
                                                            "${data.chlStatus}",
                                                        color: Helper
                                                            .getStatusColor(
                                                                "${data.chlStatus}"),
                                                      ),
                                                    ),
                                                  ),*/
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        // openBottomSheet(context, (key) {
                                        //   if (key == "edit") {}
                                        // }, data);
                                      },
                                      child: ListTile(
                                        title: CustomTextStyle.bold(
                                            text: data.challanNo!.toUpperCase(),
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
                                                    "${data.companyname == "" ? "NA" : data.companyname}",
                                                fontSize: 12),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            CustomTextStyle.regular(
                                                text:
                                                    "${data.challanNo == "" ? "NA" : data.challanNo}",
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
                                                      data.challanNo!
                                                          .substring(0, 1)
                                                          .toLowerCase()),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(24))),
                                              child: Center(
                                                  child: CustomTextStyle.bold(
                                                      color: Colors.white,
                                                      text: data.challanNo!
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
                      )
                    : const Expanded(
                        child: Center(child: CircularProgressIndicator())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future openBottomSheet(
      BuildContext context, Function(String key) onClick, ChallanData data) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: CustomTextStyle.bold(
                    text: "${data.companyname}",
                    color: Colors.white,
                    fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: const Icon(Icons.edit)),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CustomTextStyle.regular(
                                      text: data.projectname ?? "NA",
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: CustomTextStyle.regular(
                                  text: "Challan No : ${data.challanNo}",
                                  color: Colors.grey),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: CustomTextStyle.regular(
                                  text: "Truck No : ${data.vehicleNo}",
                                  color: Colors.grey),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: CustomTextStyle.regular(
                                  text: "Date : ${data.challanDt}",
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        data.challanAppBy == "NA"
                            ? Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.watch_later_rounded,
                                      color: AppColors.bsWarning,
                                      size: 48,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    CustomTextStyle.regular(
                                        text: "Approval pending"),
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 48,
                                  ),
                                  CustomTextStyle.regular(
                                      text:
                                          "Approved by : ${data.challanAppBy}",
                                      fontSize: 12),
                                  CustomTextStyle.regular(
                                      text: "Time : ${data.approveTime}",
                                      fontSize: 12)
                                ],
                              )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
              // InkWell(
              //   onTap: () {
              //     onClick("edit");
              //   },
              //   child: ListTile(
              //     trailing: Row(
              //       children: [
              //         Expanded(child: Text("Edit Challan")),
              //         Expanded(
              //           child: Padding(
              //             padding: const EdgeInsets.only(right: 8),
              //             child: Container(
              //                 width: 40,
              //                 height: 40,
              //                 decoration: BoxDecoration(
              //                     color: Colors.grey.shade300,
              //                     borderRadius: const BorderRadius.all(
              //                         Radius.circular(20))),
              //                 child: const Icon(Icons.edit)),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              /* Row(
                children: [
                  Spacer(),
                  // Text("Edit Challan"),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(Icons.edit)),
                  )
                ],
              ),*/

              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (true) ...[
                    ElevatedButton(
                      onPressed: data.chlStatus!.toUpperCase() != "PENDING"
                          ? null
                          : () {
                              Helper.deleteDialog(context,
                                  "Do you want to approve this challan ${data.challanNo}",
                                  () {
                                controller.onUpdateChallan(context,
                                    challanStatus: "2", challanID: data.id!);
                              });
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
                  if (true) ...[
                    ElevatedButton(
                      onPressed: data.chlStatus!.toUpperCase() != "PENDING"
                          ? null
                          : () {
                              Helper.deleteDialog(context,
                                  "Do you want to reject this challan ${data.challanNo}",
                                  () {
                                controller.onUpdateChallan(context,
                                    challanStatus: "1", challanID: data.id!);
                              });
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
                    )
                  ],
                ],
              ),
              const SizedBox(
                height: 8,
              )
              // InkWell(
              //   onTap: () {
              //     onClick("email");
              //   },
              //   child: ListTile(
              //     title: const Text("Email"),
              //     leading: Padding(
              //       padding: const EdgeInsets.only(right: 8),
              //       child: Container(
              //           width: 40,
              //           height: 40,
              //           decoration: BoxDecoration(
              //               color: Colors.grey.shade300,
              //               borderRadius:
              //                   const BorderRadius.all(Radius.circular(20))),
              //           child: const Icon(Icons.email)),
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     onClick("call");
              //   },
              //   child: ListTile(
              //     title: const Text("Call"),
              //     leading: Padding(
              //       padding: const EdgeInsets.only(right: 8),
              //       child: Container(
              //           width: 40,
              //           height: 40,
              //           decoration: BoxDecoration(
              //               color: Colors.grey.shade300,
              //               borderRadius:
              //                   const BorderRadius.all(Radius.circular(20))),
              //           child: const Icon(Icons.call)),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget projectDropDownList(BuildContext context) {
    TextEditingController searchBar = TextEditingController();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<ProjectData>(
            isExpanded: true,
            hint: Text(
              'Select project',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: controller.projectList
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.projectname!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: controller.selectedProject.value.projectname == null
                ? null
                : controller.selectedProject.value,
            onChanged: (value) {
              controller.selectedProject.value = value!;
              controller.projectId = value.projectcode!;
              controller.getProjectSelected();
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
            dropdownStyleData: DropdownStyleData(
              maxHeight: 250,
              width: double.infinity - 256,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                // color: Colors.redAccent,
              ),
              // offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all<double>(10.0),
                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                  trackVisibility: MaterialStateProperty.all(true),
                  interactive: true,
                  trackColor: MaterialStateProperty.all(Colors.grey)),
            ),
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
                return item.value!.projectname!
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

  String _getChipStatusText(String status) {
    switch (status) {
      case "0":
        return 'All';
      case "PENDING":
        return 'Pending';
      case "VERIFIED":
        return 'Verified';
      case "APPROVED":
        return 'Approved';
      case "REJECTED":
        return 'Rejected';
      default:
        return 'NA';
    }
  }
}
