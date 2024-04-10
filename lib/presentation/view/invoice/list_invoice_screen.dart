import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/config/RupeesConverter.dart';
import 'package:swastik/config/colorConstant.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../controller/invoice_details_controller.dart';
import '../../../controller/invoice_list_controller.dart';
import '../../../model/responses/invoice_model.dart';
import '../../../model/responses/project_model.dart';
import '../../bloc/bloc_logic/invoice_bloc.dart';
import '../../widget/custom_text_style.dart';
import '../dashboard_screen.dart';
import '../pdfexport/multipleImageScreen.dart';
import 'add_invoice_screen.dart';
import 'invoice_details_screen.dart';

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  String _selectedStatus = "PENDING";
  String? selectedProject;
  List<String> listOfStatus = [
    "PENDING",
    "VERIFIED",
    "APPROVED",
    "REJECTED",
    "0",
  ];
  final key = GlobalKey<ScaffoldState>();
  final controller = Get.find<InvoiceDetailsController>();
  final controllerD = Get.put(DashboardController());
  final controllerI = Get.put(InvoiceListController());
  Helper helper = Helper();
  HomePageState dashBoardScreen = HomePageState();

  @override
  void initState() {
    controllerI.clearData();
    controllerI.chipChoiceCardSelected("PENDING");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: RefreshIndicator(
        onRefresh: () async {
          controllerI.getAllInvoiceList();
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              dropDownList(context, controllerI.projectList),
              const SizedBox(
                height: 8,
              ),
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
                        selected: controllerI.selectedStatus.value == status,
                        onSelected: (isSelected) {
                          controllerI.chipChoiceCardSelected(status);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: CustomTextStyle.regular(
                          text:
                              "Count: ${controllerI.invoiceList.isEmpty ? "0.0" : controllerI.invoiceList.length}")),
                ),
              ),
              Obx(
                () => controllerI.isLoading.value == false
                    ? Expanded(
                        child: controllerI.invoiceList.isNotEmpty
                            ? ListView.builder(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: controllerI.invoiceList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      openBottomSheet(context, (key) {
                                        if (key == "edit") {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddInvoiceScreen(
                                                scheduleId: controllerI
                                                    .invoiceList[index]
                                                    .invoiceId!,
                                                imageLogo: [],
                                                imageList: [],
                                              ),
                                            ),
                                          );
                                        } else if (key == "delete") {
                                          Navigator.pop(context);
                                          Helper.deleteDialog(context,
                                              "Do you want to delete an invoice no ${controllerI.invoiceList[index].invoiceNo!}",
                                              () {
                                            context
                                                .read<InvoiceBloc>()
                                                .deleteInvoice(controllerI
                                                    .invoiceList[index]
                                                    .invoiceId!
                                                    .toString());
                                          });
                                        } else if (key == "share") {
                                          Share.share(controllerI
                                              .invoiceList[index].shareUrl!);
                                        } else if (key == "approve") {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  InvoiceDetailsScreen(
                                                invoiceId: controllerI
                                                    .invoiceList[index]
                                                    .invoiceId!
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        }
                                      }, controllerI.invoiceList[index]);
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Center(
                                                  child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade300,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          4))),
                                                      child: Helper.getIcon(
                                                          controllerI
                                                              .invoiceList[index]
                                                              .invoiceStatus!)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextStyle.extraBold(
                                                      text: controllerI
                                                          .invoiceList[index]
                                                          .vendorCmpny),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                                color: AppColors
                                                                    .worningColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4))),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: CustomTextStyle.regular(
                                                                  text: controllerI
                                                                          .invoiceList[
                                                                              index]
                                                                          .projectname ??
                                                                      "NA",
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  CustomTextStyle.regular(
                                                      text:
                                                          "Inv Ref: ${controllerI.invoiceList[index].invref}"),
                                                  CustomTextStyle.regular(
                                                      text: controllerI
                                                          .invoiceList[index]
                                                          .invcat),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CustomTextStyle.extraBold(
                                                      text: double.parse(
                                                              controllerI
                                                                  .invoiceList[
                                                                      index]
                                                                  .totalamount
                                                                  .toString())
                                                          .toInt()
                                                          .inRupeesFormat()),
                                                  const SizedBox(height: 4),
                                                  CustomTextStyle.regular(
                                                      text: controllerI
                                                          .invoiceList[index]
                                                          .invDate),
                                                  const SizedBox(height: 8),
                                                  CustomTextStyle.regular(
                                                      text: _getStatusText(
                                                          controllerI
                                                              .invoiceList[
                                                                  index]
                                                              .invoiceStatus
                                                              .toString())),
                                                  InkWell(
                                                    onTap: () {
                                                      controller.isNoteApiCall =
                                                          false;
                                                      controller.getComments(
                                                          controllerI
                                                              .invoiceList[
                                                                  index]
                                                              .invoiceId
                                                              .toString());
                                                      controller
                                                          .buildShowAddComment(
                                                              context, (value) {
                                                        // Navigator.pop(context);
                                                        controller.addComment(
                                                          context,
                                                          controllerI
                                                              .invoiceList[
                                                                  index]
                                                              .invoiceId,
                                                          value,
                                                          controllerI
                                                              .invoiceList[
                                                                  index]
                                                              .cmpId,
                                                        );
                                                      }, (value) {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                        if (value) {
                                                          controllerI
                                                              .getAllInvoiceList();
                                                        }
                                                      },
                                                              controllerI
                                                                  .invoiceList[
                                                                      index]
                                                                  .vendorCmpny!,
                                                              controllerI
                                                                  .invoiceList[
                                                                      index]
                                                                  .invref!,
                                                              controllerI
                                                                  .invoiceList[
                                                                      index]
                                                                  .totalamount!);
                                                    },
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 40,
                                                      // color: Colors.green,
                                                      child: Stack(
                                                        children: [
                                                          const Positioned(
                                                            top: 20,
                                                            left: 4,
                                                            child: Icon(
                                                              Icons.messenger,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          if (controllerI
                                                                  .invoiceList[
                                                                      index]
                                                                  .commentCount! >
                                                              0) ...[
                                                            Positioned(
                                                              top: 6,
                                                              right: 4,
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(12))),
                                                                child: Center(
                                                                  child: CustomTextStyle.extraBold(
                                                                      text:
                                                                          "${controllerI.invoiceList[index].commentCount! >= 10 ? "10+" : controllerI.invoiceList[index].commentCount!}",
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          8),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // const SizedBox(height: 8),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
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
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiImageScreen(
                      isEdit: false,
                      onSubmit: (imageLogo, imageList) {
                        // Helper.getToastMsg("invoice");
                      },
                    )),
          );
        },
        label: const Text("New Invoice"),
        icon: const Icon(Icons.camera_alt),
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

  String _getStatusText(String status) {
    switch (status) {
      case "0":
        return 'ALl';
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

  Widget dropDownList(BuildContext context, List<ProjectData>? listProject) {
    TextEditingController searchBar = TextEditingController();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select project',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: listProject == null
                ? []
                : listProject!
                    .map((item) => DropdownMenuItem(
                          value: item.projectname,
                          child: Text(
                            item.projectname!,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
            value: selectedProject,
            onChanged: (value) {
              setState(() {
                selectedProject = value;
                controllerI.getProjectSelected(value.toString());
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 45,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              // elevation: 2,
            ),
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
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
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

  Future openBottomSheet(
      BuildContext context, Function(String key) onClick, InvoiceData data) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    text: "Vendor: ${data.vendorCmpny}",
                    color: Colors.white,
                    fontSize: 16),
              ),
              Row(
                children: [
                  const Spacer(),
                  CustomTextStyle.regular(text: "Total amount :"),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomTextStyle.bold(
                      text: double.parse("${data.totalamount}")
                          .toInt()
                          .inRupeesFormat(),
                      fontSize: 14),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  onClick("share");
                },
                child: ListTile(
                  title: const Text("Share"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(
                          Icons.share,
                          color: AppColors.primaryColor,
                        )),
                  ),
                ),
              ),
              /*ListTile(
                title: const Text("Get Link"),
                leading: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: const Icon(Icons.link)),
                ),
              ),*/
              InkWell(
                onTap: () {
                  onClick("edit");
                },
                child: ListTile(
                  title: const Text("Edit"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(
                          Icons.edit,
                          color: AppColors.primaryColor,
                        )),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onClick("delete");
                },
                child: ListTile(
                  title: const Text("Delete"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(
                          Icons.delete,
                          color: AppColors.primaryColor,
                        )),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onClick("approve");
                },
                child: ListTile(
                  title: const Text("Invoice Status"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(
                          Icons.check_circle_outline,
                          color: AppColors.primaryColor,
                        )),
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
