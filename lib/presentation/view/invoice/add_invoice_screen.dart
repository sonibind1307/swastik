import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/config/RupeesConverter.dart';
import 'package:swastik/config/colorConstant.dart';
import 'package:swastik/controller/add_invoice_controller.dart';
import 'package:swastik/repository/api_call.dart';

import '../../../config/constant.dart';
import '../../../config/sharedPreferences.dart';
import '../../../config/text-style.dart';
import '../../../model/responses/assign_user_model.dart';
import '../../../model/responses/company_model.dart';
import '../../../model/responses/invoice_item_model.dart';
import '../../../model/responses/project_model.dart';
import '../../widget/custom_date_picker.dart';
import '../../widget/custom_text_decoration.dart';
import '../../widget/custom_text_style.dart';
import '../../widget/edit_text_widgets.dart';
import '../pdfexport/multipleImageScreen.dart';
import '../pdfexport/pdf_preview.dart';
import '../pdfexport/pdf_url_viewer.dart';

class AddInvoiceScreen extends StatefulWidget {
  final String scheduleId;
  List<MemoryImage> imageLogo = [];
  List<File> imageList = [];

  AddInvoiceScreen(
      {Key? key,
      required this.scheduleId,
      required this.imageLogo,
      required this.imageList})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AddInvoiceScreen> {
  int _activeCurrentStep = 0;
  final addInvoiceController = Get.find<AddInvoiceController>();
  final _addInvoiceFormKey = GlobalKey<FormState>();
  final _quantityKey = GlobalKey<FormState>();
  final _amountKey = GlobalKey<FormState>();

  // final data = Get.find<Logic>();

  @override
  void initState() {
    super.initState();
    addInvoiceController.clearDirectory();
    addInvoiceController.clearAllData();
    addInvoiceController.init();
    debugPrint("widget.scheduleId ${widget.scheduleId}");
    addInvoiceController.getAssignUserList();
    if (widget.scheduleId != "") {
      addInvoiceController.onGetInvoiceDetails(widget.scheduleId);
      addInvoiceController.inVoiceId = widget.scheduleId;
    }
    addInvoiceController.onGetVendor();
    addInvoiceController.getAssignUserList();
    addInvoiceController.onGetInvoiceCategoryItem();
    addInvoiceController.onGetProject();
    addInvoiceController.getCompanyCode();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.scheduleId == ""
                ? "Add Vendor Invoice"
                : "Update Vendor Invoice",
            style: TextStyle(color: Colors.white),
          ),
        ),
        // Here we have initialized the stepper widget
        body: Stepper(
          physics: const ScrollPhysics(),
          type: StepperType.horizontal,
          currentStep: _activeCurrentStep,
          controlsBuilder: (context, controller) {
            return Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_activeCurrentStep != 0)
                    ElevatedButton(
                      onPressed: () {
                        if (_activeCurrentStep == 0) {
                          return;
                        }
                        setState(() {
                          _activeCurrentStep -= 1;
                        });
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return AppColors.btnBorderColor; //<-- SEE HERE
                            }
                            return null; // Defer to the widget's default.
                          },
                        ),
                        side: MaterialStateProperty.all(
                            const BorderSide(color: AppColors.btnBorderColor)),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.whiteColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Back",
                          //"strCancel".tr(),
                          style: AppTextStyles.btn3TextStyle,
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (addInvoiceController.isPdf.value == false) {
                        Helper.getToastMsg("Attach pdf");
                      } else {
                        if (addInvoiceController.selectedVendor != null) {
                          if (_activeCurrentStep == 2) {
                            if (addInvoiceController
                                .allInvoiceItemList.isNotEmpty) {
                              // Get.dialog(
                              //     AlertDialog(
                              //       title: const Text(
                              //         'Assign user',
                              //         style: TextStyle(
                              //             color: Colors.redAccent,
                              //             fontSize: 18,
                              //             fontWeight: FontWeight.w600,
                              //             letterSpacing: 0.2),
                              //       ),
                              //       content: dropDownUserList(context, () {}),
                              //       actions: <Widget>[
                              //         TextButton(
                              //           onPressed: () =>
                              //               Navigator.of(context).pop(false),
                              //           child: const Text('No',
                              //               style: TextStyle(
                              //                   color: Colors.redAccent,
                              //                   fontSize: 18,
                              //                   fontWeight: FontWeight.w600,
                              //                   letterSpacing: 0.2)),
                              //         ),
                              //         TextButton(
                              //           onPressed: () {
                              //             addInvoiceController
                              //                 .addInvoiceAPi(context);
                              //             Navigator.of(context).pop(false);
                              //           },
                              //           child: const Text('Yes',
                              //               style: TextStyle(
                              //                   color: AppColors.blueColor,
                              //                   fontSize: 18,
                              //                   fontWeight: FontWeight.w600,
                              //                   letterSpacing: 0.2)),
                              //         ),
                              //       ],
                              //     )
                              // );

                              showDialog(
                                barrierDismissible: false,
                                // barrierColor: Colors.transparent,
                                barrierColor: Colors.black.withOpacity(0.5),
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Assign user',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.2),
                                  ),
                                  content: dropDownUserList(context, () {}),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text('No',
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.2)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Navigator.pop(context);

                                        if (addInvoiceController.selectedUser
                                                    .value.firstName ==
                                                "" ||
                                            addInvoiceController.selectedUser
                                                    .value.firstName ==
                                                null) {
                                          Helper.getToastMsg("Assign user");
                                        } else {
                                          // Navigator.pop(context);
                                          addInvoiceController
                                              .addInvoiceAPi(context);
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
                            } else {
                              Helper.getToastMsg("add at least one item");
                            }
                          }
                          if (_activeCurrentStep < (3 - 1)) {
                            setState(() {
                              if (_activeCurrentStep == 1) {
                                if (addInvoiceController.validateStep2() ==
                                    true) {
                                  _activeCurrentStep += 1;
                                }
                              }
                              if (_activeCurrentStep == 0) {
                                if (widget.scheduleId == "") {
                                  generatePdf(widget.imageList);
                                } else {
                                  if (addInvoiceController.isPdfChange.value ==
                                      "1") {
                                    generatePdf(widget.imageList);
                                  }
                                }
                                _activeCurrentStep += 1;
                              }
                            });
                          }
                        } else {
                          Helper.getToastMsg("Select vendor");
                        }
                      }
                      setState(() {});
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return AppColors.hoverColor; //<-- SEE HERE
                          }
                          return null; // Defer to the widget's default.
                        },
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primaryColor),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: addInvoiceController.loading.isTrue
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                )))
                            : Text(
                                _activeCurrentStep == 2 ? "Save" : "Next",
                                style: AppTextStyles.btn1TextStyle,
                              )),
                  ),
                ],
              ),
            );
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    if (_activeCurrentStep == 0) {
                      return;
                    }

                    setState(() {
                      _activeCurrentStep -= 1;
                    });
                  },
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    if (_activeCurrentStep < (3 - 1)) {
                      setState(() {
                        _activeCurrentStep += 1;
                        getProjectList();
                      });
                    }
                  },
                  child: const Text('NEXT'),
                ),
              ],
            );
          },
          steps: [
            stepOneUI(),
            stepTwoUI(),
            stepThreeUI(),
          ],

          /*    // onStepContinue takes us to the next step
          onStepContinue: () {
            if (_activeCurrentStep < (3 - 1)) {
              setState(() {
                _activeCurrentStep += 1;
                getProjectList();
              });
            }
          },

          // onStepCancel takes us to the previous step
          onStepCancel: () {
            if (_activeCurrentStep == 0) {
              return;
            }

            setState(() {
              _activeCurrentStep -= 1;
            });
          },

          // onStepTap allows to directly click on the particular step we want
          onStepTapped: (int index) {
            setState(() {
              _activeCurrentStep = index;
            });
          },*/
        ),
        /* floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
          tooltip: 'Add',
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return addInvoiceDialog(context);
                });
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),*/
      ),
    );
  }

  Future<void> getProjectList() async {
    String userId = await Auth.getUserID() ?? "0";
    ProjectModel projectModel = await ApiRepo.getProjectList(userId: userId);
    addInvoiceController.projectData = projectModel.data!;
  }

  AlertDialog addInvoiceDialog(
      BuildContext context, String event, Function onSubmit) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: _addInvoiceFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Item",
                          style: AppTextStyles.modalTitleText,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: addInvoiceController.itemDesc,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomTextDecoration.textFieldDecoration(
                          labelText: "Item Description"),
                      // inputFormatters: [
                      //   FilteringTextInputFormatter(RegExp(r'[a-z A-Z]'), allow: true)
                      // ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Constant.enterTextError;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: addInvoiceController.hCode,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomTextDecoration.textFieldDecoration(
                          labelText: "HSN/SAC Code"),
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp(r'\d+'), allow: true)
                      ],
                      maxLength: 15,
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      key: _quantityKey,
                      controller: addInvoiceController.quanity,
                      textInputAction: TextInputAction.done,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp(r'\d+'), allow: true)
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomTextDecoration.textFieldDecoration(
                          labelText: "Quantity"),
                      // inputFormatters: [
                      //   FilteringTextInputFormatter(RegExp(r'[a-z A-Z]'), allow: true)
                      // ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Constant.enterTextError;
                        } else if (value.trim().toString() == "0") {
                          return "Quantity can not be 0";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_quantityKey.currentState != null) {
                          if (_quantityKey.currentState!.validate()) {}
                        }
                        addInvoiceController.onGstCalculation();
                      },
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      key: _amountKey,
                      controller: addInvoiceController.amount,
                      textInputAction: TextInputAction.done,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp(r'\d+'), allow: true)
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomTextDecoration.textFieldDecoration(
                          labelText: "Rate"),
                      onChanged: (value) {
                        if (_amountKey.currentState != null) {
                          if (_amountKey.currentState!.validate()) {}
                        }
                        addInvoiceController.onGstCalculation();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Constant.enterTextError;
                        } else if (value.trim().toString() == "0") {
                          return "Rate can not be 0";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    cgstDropDownList(context, "CGST",
                        addInvoiceController.cgstList, (value) {}),
                    const SizedBox(
                      height: 5.0,
                    ),
                    sgstDropDownList(context, "SGST",
                        addInvoiceController.sgstList, (value) {}),
                    const SizedBox(
                      height: 8.0,
                    ),
                    igstDropDownList(context, "IGST",
                        addInvoiceController.igstList, (value) {}),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextStyle.regular(text: "Tax Amount"),
                        Obx(() => CustomTextStyle.bold(
                            text: "${addInvoiceController.amountTax.value}"))
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextStyle.regular(text: "Final Amount"),
                        CustomTextStyle.bold(
                            text: "${addInvoiceController.amountFinal.text}")
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    // TextFormField(
                    //   controller: addInvoiceController.amountFinal,
                    //   readOnly: true,
                    //   enabled: false,
                    //   decoration: CustomTextDecoration.textFieldDecoration(
                    //       labelText: "Final Amount"),
                    // ),
                    // const SizedBox(
                    //   height: 8.0,
                    // ),
                    // TextFormField(
                    //   controller: addInvoiceController.amountTax,
                    //   readOnly: true,
                    //   enabled: false,
                    //   decoration: CustomTextDecoration.textFieldDecoration(
                    //       labelText: "Tax Amount"),
                    // ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return AppColors
                                      .btnBorderColor; //<-- SEE HERE
                                }
                                return null; // Defer to the widget's default.
                              },
                            ),
                            side: MaterialStateProperty.all(const BorderSide(
                                color: AppColors.btnBorderColor)),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.whiteColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Text(
                              "Cancel",
                              //"strCancel".tr(),
                              style: AppTextStyles.btn3TextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_addInvoiceFormKey.currentState!.validate()) {
                              if (event == "add") {
                                addInvoiceController.addItems(itemId: '0');
                              } else {
                                onSubmit();
                              }
                            }
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return AppColors.hoverColor; //<-- SEE HERE
                                }
                                return null; // Defer to the widget's default.
                              },
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryColor),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: CustomTextStyle.regular(
                                  text: event == "add"
                                      ? "Add Item"
                                      : "Update Item",
                                  color: Colors.white)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog gstDialog(
      BuildContext context, String? cgst, String? sgst, String? igst) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Gst Detail",
                        style: AppTextStyles.modalTitleText,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextStyle.regular(text: 'CGST', fontSize: 12),
                      CustomTextStyle.bold(text: cgst ?? "0.0", fontSize: 14),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextStyle.regular(text: 'SGST', fontSize: 12),
                      CustomTextStyle.bold(text: sgst ?? "0.0", fontSize: 14),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextStyle.regular(text: 'IGST', fontSize: 12),
                      CustomTextStyle.bold(text: igst ?? "0.0", fontSize: 14),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cgstDropDownList(BuildContext context, String key,
      List<String> listOfData, Function(String value) voidCallback) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    key,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: listOfData
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: addInvoiceController.cgstValue1.value,

                  ///CGST
                  onChanged: addInvoiceController.cgstFlag.value == false
                      ? null
                      : (value) {
                          if (value == "CGST") {
                            addInvoiceController.sgstValue1.value = "SGST";
                          } else {
                            addInvoiceController.sgstValue1.value = value!;
                          }
                          addInvoiceController.cgstValue1.value = value!;

                          if (value == addInvoiceController.cgstList[0] &&
                              addInvoiceController.sgstValue1.value ==
                                  addInvoiceController.sgstList[0]) {
                            addInvoiceController.cgstFlag.value = true;
                            addInvoiceController.igstFlag.value = true;
                          } else {
                            addInvoiceController.cgstFlag.value = true;
                            addInvoiceController.igstFlag.value = false;
                          }

                          addInvoiceController.onGstCalculation();
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
                  dropdownStyleData: Helper.dropdownStyleData(context),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 42,
                width: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(addInvoiceController.cgstController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sgstDropDownList(BuildContext context, String key,
      List<String> listOfData, Function(String value) voidCallback) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    key,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: listOfData
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: addInvoiceController.sgstValue1.value,

                  ///SGST
                  onChanged: addInvoiceController.cgstFlag.value == false
                      ? null
                      : (value) {
                          if (value == "SGST") {
                            addInvoiceController.cgstValue1.value = "CGST";
                          } else {
                            addInvoiceController.cgstValue1.value = value!;
                          }
                          addInvoiceController.sgstValue1.value = value!;
                          voidCallback(addInvoiceController.sgstValue1.value);
                          if (value == addInvoiceController.sgstList[0] &&
                              addInvoiceController.cgstValue1.value ==
                                  addInvoiceController.cgstList[0]) {
                            addInvoiceController.cgstFlag.value = true;
                            addInvoiceController.igstFlag.value = true;
                          } else {
                            addInvoiceController.cgstFlag.value = true;
                            addInvoiceController.igstFlag.value = false;
                          }
                          addInvoiceController.onGstCalculation();
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
                  dropdownStyleData: Helper.dropdownStyleData(context),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 42,
                width: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(addInvoiceController.sgstController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget igstDropDownList(BuildContext context, String key,
      List<String> listOfData, Function(String value) voidCallback) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    key,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: listOfData
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: addInvoiceController.igstValue1.value,
                  onChanged: addInvoiceController.igstFlag.value == false
                      ? null
                      : (value) {
                          addInvoiceController.igstValue1.value = value!;
                          if (value == addInvoiceController.igstList[0]) {
                            addInvoiceController.cgstFlag.value = true;
                            addInvoiceController.igstFlag.value = true;
                          } else {
                            addInvoiceController.cgstFlag.value = false;
                            addInvoiceController.igstFlag.value = true;
                          }
                          addInvoiceController.onGstCalculation();
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
                  dropdownStyleData: Helper.dropdownStyleData(context),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 42,
                width: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(addInvoiceController.igstController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDownList(BuildContext context, VoidCallback onSelection) {
    TextEditingController searchBar = TextEditingController();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select vendor',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: addInvoiceController.vendorList
                .map((item) => DropdownMenuItem(
                      value: item.companyName,
                      child: Text(
                        item.companyName!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: addInvoiceController.selectedVendor,
            onChanged: (value) {
              setState(() {
                addInvoiceController.selectedVendor = value;
                addInvoiceController.onVendorSelection(value!);
              });
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
            dropdownStyleData: Helper.dropdownStyleData(context),
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

  Widget dropDownUserList(BuildContext context, VoidCallback onSelection) {
    TextEditingController searchBar = TextEditingController();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<UserData>(
            isExpanded: true,
            hint: Text(
              'Select user',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: addInvoiceController.userList
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.firstName!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: addInvoiceController.selectedUser.value.userId == null
                ? null
                : addInvoiceController.selectedUser.value,
            onChanged: (value) {
              addInvoiceController.selectedUser.value = value!;
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
                return item.value!.firstName!
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

  Widget projectDropDownList(BuildContext context) {
    TextEditingController searchBar = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(),
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
          items: addInvoiceController.projectList
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
          value: addInvoiceController.selectedProject,
          onChanged: (value) {
            addInvoiceController.selectedProject = value;
            for (var element in addInvoiceController.projectList) {
              if (element.projectname == value) {
                addInvoiceController.projectId = element.projectcode!;
                addInvoiceController.onGetBuilding(element.projectcode!);
                addInvoiceController.onGetCompanyCode(element.projectcode!);
                // addInvoiceController.onGetVendorPO(element.projectcode!);
              }
            }

            setState(() {});

            // listData!.forEach((element) {
            //   if (element.companyName == value) {
            //     VendorData vendorData = element;
            //     context.read<AddInvoiceBloc>().onVendorSelection(vendorData);
            //   }
            // });
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
          dropdownStyleData: Helper.dropdownStyleData(context),
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
    );
  }

  Widget companyCodeDropDownList(BuildContext context) {
    TextEditingController searchBar = TextEditingController();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<CompanyData>(
            isExpanded: true,
            hint: Text(
              'Select company code',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: addInvoiceController.companyList
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.companyname!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: addInvoiceController.selectedCompany.value.companyid == null
                ? null
                : addInvoiceController.selectedCompany.value,
            onChanged: addInvoiceController.isCompanyCode.value == true
                ? null
                : (value) {
                    addInvoiceController.selectedCompany.value = value!;
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
                return item.value!.companyname!
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

  Widget categoryDropDownList(BuildContext context) {
    TextEditingController searchBar = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Other',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: addInvoiceController.categoryItemList
              .map((item) => DropdownMenuItem(
                    value: item.categoryName,
                    child: Text(
                      item.categoryName!,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: addInvoiceController.selectedCategory,
          onChanged: (value) {
            addInvoiceController.selectedCategory = value;
            setState(() {});
            // context.read<InvoiceBloc>().getProjectSelected(value.toString());
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
          dropdownStyleData: Helper.dropdownStyleData(context),
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
    );
  }

  Widget buildDropDownList(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select building',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: addInvoiceController.buildList
                .map((item) => DropdownMenuItem(
                      value: item.buildingcode,
                      child: Text(
                        item.nameofbuilding!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: addInvoiceController.selectedBuild,
            onChanged: (value) {
              addInvoiceController.selectedBuild = value;
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
            dropdownStyleData: Helper.dropdownStyleData(context),
          ),
        ),
      ),
    );
  }

  Widget PODropDownList(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'PO',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: addInvoiceController.poList
                .map((item) => DropdownMenuItem(
                      value: item.id,
                      child: Text(
                        "${item.companyName!} | ${item.poDt!}",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: addInvoiceController.selectedPo,
            onChanged: (value) {
              addInvoiceController.selectedPo = value;
              setState(() {});
              debugPrint(
                  "addInvoiceController.selectedPo ${addInvoiceController.selectedPo}");
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
            dropdownStyleData: Helper.dropdownStyleData(context),
          ),
        ),
      ),
    );
  }

  stepOneUI() {
    return Step(
      state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 0,
      title: const Text('Step 1'),
      content: Obx(
        () => Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.70,
              child: addInvoiceController.step1Loading.value
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addInvoiceController.isPdf == false
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  margin: const EdgeInsets.all(8),
                                  child: OutlinedButton(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.upload),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        CustomTextStyle.regular(
                                            text: "drop a file here"),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MultiImageScreen(
                                                  isEdit: true,
                                                  onSubmit:
                                                      (imageLogo, imageList) {
                                                    widget.imageLogo =
                                                        imageLogo;
                                                    widget.imageList =
                                                        imageList;
                                                    if (widget.scheduleId ==
                                                        "") {
                                                      addInvoiceController
                                                          .isPdfChange
                                                          .value = "0";
                                                    } else {
                                                      addInvoiceController
                                                          .isPdfChange
                                                          .value = "1";
                                                    }
                                                    addInvoiceController
                                                        .isPdf.value = true;
                                                  },
                                                )),
                                      );
                                    },
                                  ),
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.all(8),
                                  child: Stack(
                                    children: [
                                      OutlinedButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.picture_as_pdf,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                              height: 100,
                                            ),
                                            CustomTextStyle.regular(
                                                text: "Invoice PDF"),
                                          ],
                                        ),
                                        onPressed: () {
                                          if (widget.scheduleId == "") {
                                            // imageLogo = Helper
                                            //     .convertFilesToMemoryImages(
                                            //         imageList);
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PdfPreviewPage(
                                                  imageLogo: widget.imageLogo,
                                                  imageList: widget.imageList,
                                                  title: "Invoice - ",
                                                ),
                                              ),
                                            );
                                          } else {
                                            // Helper.getToastMsg(
                                            //     addInvoiceController
                                            //         .isPdfChange.value);
                                            if (addInvoiceController
                                                    .isPdfChange.value ==
                                                "0") {
                                              if (addInvoiceController.pdfUrl !=
                                                  null) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PdfUrlView(
                                                            url:
                                                                addInvoiceController
                                                                    .pdfUrl!,
                                                            title:
                                                                'Invoice - ${addInvoiceController.invoiceIDetailModel.data!.vendorName}',
                                                            amount: double.parse(addInvoiceController
                                                                    .invoiceIDetailModel
                                                                    .data!
                                                                    .totalamount
                                                                    .toString())
                                                                .toInt()
                                                                .inRupeesFormat(),
                                                          )),
                                                );
                                              }
                                            } else {
                                              // imageLogo = Helper
                                              //     .convertFilesToMemoryImages(
                                              //         imageList);
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PdfPreviewPage(
                                                    imageLogo: widget.imageLogo,
                                                    imageList: widget.imageList,
                                                    title: addInvoiceController
                                                            .selectedVendor ??
                                                        "NA",
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: InkWell(
                                          onTap: () {
                                            Helper.deleteDialog(context,
                                                "Do you want to delete an file",
                                                () {
                                              addInvoiceController.isPdf.value =
                                                  false;
                                              setState(() {});
                                            });
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Container(
                                                width: 32,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                16))),
                                                child: const Icon(
                                                    Icons.delete_forever)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 8,
                          ),
                          Obx(
                            () => Card(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4))),
                                          child: CustomTextStyle.bold(
                                              text:
                                                  "${addInvoiceController.companyName == "" ? "Company Name: NA" : addInvoiceController.companyName}",
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    dropDownList(context, () {}),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    CustomTextStyle.bold(
                                        text: "Vendor Details",
                                        fontSize: 14,
                                        color: AppColors.blueColor),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextStyle.bold(
                                            text: "Address : ", fontSize: 16),
                                        Expanded(
                                          child: CustomTextStyle.regular(
                                              text: addInvoiceController
                                                      .vendorData[0].address ??
                                                  "NA",
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              CustomTextStyle.bold(
                                                  text: "PAN : ", fontSize: 16),
                                              CustomTextStyle.regular(
                                                  text: addInvoiceController
                                                          .vendorData[0].pan ??
                                                      "NA",
                                                  fontSize: 14)
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomTextStyle.bold(
                                                  text: "GST : ", fontSize: 16),
                                              Expanded(
                                                child: CustomTextStyle.regular(
                                                    text: addInvoiceController
                                                            .vendorData[0]
                                                            .gst ??
                                                        "NA",
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ),

                                        /* Expanded(
                                    flex: 1,
                                    child: CustomTextStyle.bold(
                                        text: "PAN :".trim(), fontSize: 16)),
                                Expanded(
                                    flex: 2,
                                    child: CustomTextStyle.regular(
                                        text: addInvoiceController.vendorData.pan ?? "NA",
                                        fontSize: 14)),
                                Expanded(
                                    flex: 1,
                                    child: CustomTextStyle.bold(
                                        text: "GST :".trim(), fontSize: 16)),
                                Expanded(
                                    flex: 2,
                                    child: CustomTextStyle.regular(
                                        text: addInvoiceController.vendorData.gst ?? "NA",
                                        fontSize: 14)),*/
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomTextStyle.bold(
                                                  text: "Contact : ",
                                                  fontSize: 16),
                                              Expanded(
                                                child: CustomTextStyle.regular(
                                                    text: addInvoiceController
                                                            .vendorData[0]
                                                            .contactName ??
                                                        "NA",
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              CustomTextStyle.bold(
                                                  text: "Mobile : ",
                                                  fontSize: 16),
                                              CustomTextStyle.regular(
                                                  text: addInvoiceController
                                                          .vendorData[0]
                                                          .contactNo ??
                                                      "NA",
                                                  fontSize: 14)
                                            ],
                                          ),
                                        ),

                                        /* Expanded(
                                    flex: 1,
                                    child: CustomTextStyle.bold(
                                        text: "Contact :", fontSize: 16)),
                                Expanded(
                                    flex: 1,
                                    child: CustomTextStyle.regular(
                                        text:
                                            addInvoiceController.vendorData.contactName ??
                                                "NA",
                                        fontSize: 14)),
                                Expanded(
                                    flex: 1,
                                    child: CustomTextStyle.bold(
                                        text: "Mobile :".trim(), fontSize: 16)),
                                Expanded(
                                    flex: 1,
                                    child: CustomTextStyle.regular(
                                        text: addInvoiceController.vendorData.contactNo ??
                                            "NA",
                                        fontSize: 14)),*/
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextStyle.bold(
                                            text: "Email : ", fontSize: 16),
                                        CustomTextStyle.regular(
                                            text: addInvoiceController
                                                    .vendorData[0].email ??
                                                "NA",
                                            fontSize: 14),
                                      ],
                                    ),

                                    /* builderToShowData(
                                "Address ",
                                addInvoiceController.vendorData.address ?? "NA",
                                "Address ",
                                addInvoiceController.vendorData.address ?? "NA"),
                            builderToShowData(
                                "Contact Person",
                                addInvoiceController.vendorData.contactName ?? "NA",
                                "Mobile",
                                addInvoiceController.vendorData.contactNo ?? "NA"),
                            builderToShowData(
                                "Email ",
                                addInvoiceController.vendorData.email ?? "NA",
                                "GST ",
                                addInvoiceController.vendorData.gst ?? "NA"),*/
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container builderToShowData(
      String title1, String value1, String title2, String value2) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: CustomTextStyle.bold(text: title1.trim(), fontSize: 16)),
          Expanded(
              flex: 2,
              child: CustomTextStyle.regular(text: value1, fontSize: 14)),
          // Expanded(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         CustomTextStyle.bold(text: title1, fontSize: 16),
          //         CustomTextStyle.regular(text: value1, fontSize: 14),
          //       ],
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          //     child: Column(
          //       children: [
          //         CustomTextStyle.bold(text: title2, fontSize: 16),
          //         CustomTextStyle.regular(text: value2, fontSize: 14)
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  stepTwoUI() {
    return Step(
        state: _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeCurrentStep >= 1,
        title: const Text('Step 2'),
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: CustomTextStyle.bold(
                    text: "${addInvoiceController.selectedVendor}",
                    color: Colors.white,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextStyle.regular(
                text: Constant.project,
                fontSize: 12,
              ),
              const SizedBox(
                height: 8,
              ),
              projectDropDownList(context),
              const SizedBox(
                height: 16,
              ),
              CustomTextStyle.regular(
                text: "Company Code",
                fontSize: 12,
              ),
              const SizedBox(
                height: 8,
              ),
              companyCodeDropDownList(context),
              const SizedBox(
                height: 16,
              ),
              CustomTextStyle.regular(
                text: "Building",
                fontSize: 12,
              ),
              const SizedBox(
                height: 8,
              ),
              buildDropDownList(
                context,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextStyle.regular(
                text: Constant.invoiceCategory,
                fontSize: 12,
              ),
              const SizedBox(
                height: 8,
              ),
              categoryDropDownList(
                context,
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  CustomDateTime.buildShowDatePicker(context)
                      .then((DateTime? dateTime) {
                    if (dateTime != null) {
                      String date =
                          "${Helper.padWithZero(dateTime.day)}-${Helper.padWithZero(dateTime.month)}-${dateTime.year}";

                      addInvoiceController.selectedDate = date;
                    }
                    setState(() {});
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListTile(
                    title: Text("Date : ${addInvoiceController.selectedDate}"),
                    trailing: const Icon(Icons.calendar_month),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: addInvoiceController.invRefController,
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: CustomTextDecoration.textFieldDecoration(
                    labelText: "Invoice Reference"),
                // inputFormatters: [
                //   FilteringTextInputFormatter(RegExp(r'[a-z A-Z]'), allow: true)
                // ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Constant.enterTextError;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextStyle.regular(
                text: "Link PO",
                fontSize: 12,
              ),
              const SizedBox(
                height: 8,
              ),
              PODropDownList(context),
              const SizedBox(
                height: 16,
              ),
              CustomTextStyle.regular(
                text: "Note",
                fontSize: 12,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomEditTestWidgets.textEditText(
                addInvoiceController.noteController,
              ),
              const SizedBox(
                height: 16,
              ),
              /* Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return AppColors.btnBorderColor; //<-- SEE HERE
                          }
                          return null; // Defer to the widget's default.
                        },
                      ),
                      side: MaterialStateProperty.all(
                          const BorderSide(color: AppColors.btnBorderColor)),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.whiteColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                        "Cancel",
                        //"strCancel".tr(),
                        style: AppTextStyles.btn3TextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return AppColors.hoverColor; //<-- SEE HERE
                          }
                          return null; // Defer to the widget's default.
                        },
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.bgColor),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          "Submit",
                          style: AppTextStyles.btn1TextStyle,
                        )),
                  )
                ],
              )*/
            ],
          ),
        ));
  }

  stepThreeUI() {
    return Step(
      state: StepState.complete,
      isActive: _activeCurrentStep >= 2,
      title: const Text('Step 3'),
      content: Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: CustomTextStyle.bold(
                            text: "${addInvoiceController.selectedVendor}",
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextStyle.regular(
                        text:
                            "Count ${addInvoiceController.allInvoiceItemList.length}  "),
                    Align(
                      alignment: Alignment.topRight,
                      child: OutlinedButton.icon(
                        // <-- OutlinedButton
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          addInvoiceController.clearAddFormData();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return addInvoiceDialog(context, "add", () {});
                              });
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 24.0,
                        ),
                        label: const Text('Add Item'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),

                ///list item code
                SizedBox(
                  child: addInvoiceController.allInvoiceItemList.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Center(
                            child:
                                CustomTextStyle.regular(text: "No Item Added"),
                          ),
                        )
                      : Container(
                          // color: AppColors.greenColor,
                          // height: double.infinity * 0.5,
                          child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 4,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              InvoiceItems data = addInvoiceController
                                  .allInvoiceItemList[index];
                              return Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Expanded(
                                          // flex: 2,
                                          child: Container(
                                              // color: Colors.red,
                                              child: CustomTextStyle.bold(
                                                  text: data.itemDescription ??
                                                      "NA",
                                                  fontSize: 16)),
                                        ),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerRight,
                                          child: CustomTextStyle.bold(
                                              text: data.itemTotal ?? "0.0",
                                              fontSize: 16),
                                        )),
                                      ]),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              addInvoiceController.onEditItem(
                                                  itemData: data);
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return addInvoiceDialog(
                                                        context, "edit", () {
                                                      addInvoiceController
                                                          .allInvoiceItemList
                                                          .remove(data);

                                                      addInvoiceController
                                                          .addItems(
                                                              itemId: data
                                                                  .invoiceItemId!);
                                                    });
                                                  });
                                            },
                                            child: Container(
                                                width: 22,
                                                height: 22,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.grey,
                                                  size: 20,
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              Helper.deleteDialog(context,
                                                  "Do you want to delete an item",
                                                  () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                addInvoiceController
                                                    .allInvoiceItemList
                                                    .remove(data);
                                                addInvoiceController
                                                    .updateSummaryItem();
                                              });
                                            },
                                            child: Container(
                                                width: 22,
                                                height: 22,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                14))),
                                                child: const Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.grey,
                                                  size: 20,
                                                )),
                                          )
                                        ],
                                      ),
/*                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: CustomTextStyle.regular(
                                                text: 'Rate: ${data.itemAmount}',
                                                fontSize: 12)),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CustomTextStyle.regular(
                                                  text: 'GST', fontSize: 12),
                                              const SizedBox(
                                                width: 4.0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return gstDialog(
                                                            context,
                                                            data.itemCgst,
                                                            data.itemSgst,
                                                            data.itemIgst);
                                                      });
                                                },
                                                child: const Icon(
                                                  Icons.info_rounded,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),*/
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount:
                                addInvoiceController.allInvoiceItemList.length,
                          ),
                        )
                  /*ListView.builder(
                          scrollDirection: Axis.vertical,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          physics: const ScrollPhysics(),
                          itemCount:
                              addInvoiceController.allInvoiceItemList.length,
                          itemBuilder: (BuildContext context, int index) {
                            InvoiceItems data =
                                addInvoiceController.allInvoiceItemList[index];
                            return Card(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        // flex: 2,
                                        child: Container(
                                            // color: Colors.red,
                                            child: CustomTextStyle.bold(
                                                text:
                                                    data.itemDescription ?? "NA",
                                                fontSize: 16)),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          addInvoiceController.onEditItem(
                                              itemData: data);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return addInvoiceDialog(
                                                    context, "edit", () {
                                                  addInvoiceController
                                                      .allInvoiceItemList
                                                      .remove(data);
                                                  addInvoiceController.addItems(
                                                      itemId:
                                                          data.invoiceItemId!);
                                                });
                                              });
                                        },
                                        child: Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16))),
                                            child: const Icon(Icons.edit)),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          Helper.deleteDialog(context,
                                              "Do you want to delete an item",
                                              () {
                                            FocusScope.of(context).unfocus();
                                            addInvoiceController
                                                .allInvoiceItemList
                                                .remove(data);
                                          });
                                        },
                                        child: Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16))),
                                            child:
                                                const Icon(Icons.delete_forever)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: CustomTextStyle.regular(
                                              text: data.hsnCode ?? "0.0")),
                                      Expanded(
                                          flex: 1,
                                          child: CustomTextStyle.regular(
                                              text: 'Qty: ${data.qty ?? "NA"}',
                                              fontSize: 12)),
                                      Expanded(
                                          child: CustomTextStyle.bold(
                                              text: data.itemAmount ?? "0.0",
                                              fontSize: 16)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: CustomTextStyle.regular(
                                              text: 'Rate: ${data.itemAmount}',
                                              fontSize: 12)),
                                      Expanded(
                                          child: Row(
                                        children: [
                                          CustomTextStyle.regular(
                                              text: 'GST', fontSize: 12),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return gstDialog(
                                                        context,
                                                        data.itemCgst,
                                                        data.itemSgst,
                                                        data.itemIgst);
                                                  });
                                            },
                                            child: const Icon(
                                              Icons.info_rounded,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Expanded(
                                          child: CustomTextStyle.bold(
                                              text:
                                                  'RS. ${data.itemTotal ?? "0.0"}',
                                              fontSize: 16)),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                          },
                        )*/
                  ,
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(
                  () => Container(
                    // color: Colors.red,
                    // margin: EdgeInsets.all(4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.yellow,
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 4.0, // soften the shadow
                            // spreadRadius: 4.0, //extend the shadow
                            offset: const Offset(
                              0.0, // Move to right 5  horizontally
                              0.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ]),

                    // height: MediaQuery.of(context).size.height * 0.1,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            border: Border.all(
                              color: Colors.orange,
                              width: 1,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: CustomTextStyle.extraBold(
                              text: "Items Summary",
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextStyle.regular(text: "Subtotal"),
                            CustomTextStyle.bold(
                                text:
                                    "RS. ${addInvoiceController.subtotal ?? "0.0"}")
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextStyle.regular(text: "Tax Amount"),
                            CustomTextStyle.bold(
                                text:
                                    "RS. ${addInvoiceController.taxTotal ?? "0.0"}")
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextStyle.regular(text: "Total"),
                            CustomTextStyle.bold(
                                text:
                                    "RS. ${(addInvoiceController.subtotal.value + addInvoiceController.taxTotal.value) ?? "0.0"}",
                                fontSize: 16)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> generatePdf(List<File> imageList) async {
    // Helper.getToastMsg("images${imageLogo.length}");

    ///pdf creation
    final pdf = pw.Document();
    try {
      for (var image in imageList) {
        var pdfImage = pw.MemoryImage(
          image!.readAsBytesSync(),
        );
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Stack(children: [
                pw.Image(pdfImage, fit: pw.BoxFit.contain),
                pw.Positioned(
                    bottom: 0,
                    right: 0,
                    child: pw.Text('Username: soni.b, Date: ${DateTime.now()}',
                        style: pw.TextStyle(fontSize: 16)))
              ]); // Center
            },
          ),
        );
      }

      ///file related login
      final path = await FileStorage.localPath;
      String folderName = "swastik";
      Directory newDirectory = Directory('${path}/$folderName');
      print('newDirectory:$newDirectory');

      if (await newDirectory.exists()) {
        print('Folder already exists, deleting...');
        await newDirectory.delete(recursive: true);
      }
      await newDirectory.create();
      final newpath = '${newDirectory.path}/invoice.pdf';
      print('new_path:$newpath');

      File file = File('$newpath');

      await file.writeAsBytes(await pdf.save());
      Helper.getToastMsg("Invoice.pdf saved");
    } catch (e) {
      print('error:${e.toString()}');
      // Helper.getToastMsg(e.toString());
    }
    return pdf.save();
  }

  pw.Widget buildPdfImage(MemoryImage memoryImage) {
    final Uint8List imageData = memoryImage.bytes;
    final pdfImage = pw.MemoryImage(imageData);
    return pw.Image(pdfImage, fit: pw.BoxFit.contain);
  }
}

class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    _directory = await getApplicationDocumentsDirectory();
    final exPath = _directory.path;
    // print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    // To get the external path from device of download folder
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<Uint8List> writeCounter(String bytes, String name) async {
    ///pdf creation
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          pw.Container(
            alignment: pw.Alignment.centerRight,
            child: pw.Text('Username: soni.b, Date: ${DateTime.now()}'),
          ),
        ],
      ),
    );

    ///file related login
    final path = await FileStorage.localPath;

    String folderName = "swastik";

    Directory newDirectory = Directory('${path}/$folderName');

    if (await newDirectory.exists()) {
      Helper.getToastMsg("Folder already exists, deleting...");
      print('Folder already exists, deleting...');
      await newDirectory.delete(recursive: true);
    }
    await newDirectory.create();
    final newpath = '${newDirectory.path}/invoice.pdf';

    print('new_path:$newpath');

    File file = File('$newpath');

    await file.writeAsBytes(await pdf.save());
    return pdf.save();
  }
}
