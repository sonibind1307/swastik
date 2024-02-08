import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/config/colorConstant.dart';
import 'package:swastik/controller/add_invoice_controller.dart';
import 'package:swastik/model/responses/vendor_model.dart';
import 'package:swastik/repository/api_call.dart';

import '../../../config/constant.dart';
import '../../../config/text-style.dart';
import '../../../model/responses/all_invoice_items.dart';
import '../../../model/responses/project_model.dart';
import '../../widget/custom_date_picker.dart';
import '../../widget/custom_text_decoration.dart';
import '../../widget/custom_text_style.dart';
import '../../widget/edit_text_widgets.dart';

class AddInvoiceScreen extends StatefulWidget {
  const AddInvoiceScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AddInvoiceScreen> {
  int _activeCurrentStep = 0;
  final addInvoiceController = Get.find<AddInvoiceController>();
  final _addInvoiceFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    addInvoiceController.onGetVendor();
    addInvoiceController.onGetAllInvoiceItem();
    addInvoiceController.onGetInvoiceCategoryItem();
    addInvoiceController.onGetProject();
    addInvoiceController.onGetInvoiceDetails("9589");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Vendor Invoices',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // Here we have initialized the stepper widget
      body: Stepper(
        physics: const ScrollPhysics(),
        type: StepperType.horizontal,
        currentStep: _activeCurrentStep,
        controlsBuilder: (context, controller) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                  if (addInvoiceController.selectedVendor != null) {
                    if (_activeCurrentStep == 2) {
                      // Helper.getToastMsg("toastMessage");
                      Helper.getSnackBarError(context, "call api");
                    }
                    if (_activeCurrentStep < (3 - 1)) {
                      setState(() {
                        _activeCurrentStep += 1;
                      });
                    }
                  } else {
                    Helper.getSnackBarError(context, "Select vendor");
                  }
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
                    child: Text(
                      _activeCurrentStep == 2 ? "Submit" : "Next",
                      style: AppTextStyles.btn1TextStyle,
                    )),
              )
            ],
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
      /*   floatingActionButton: FloatingActionButton(
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
    );
  }

  Future<void> getProjectList() async {
    ProjectModel projectModel = await ApiRepo.getProjectList();
    addInvoiceController.projectData = projectModel.data!;
  }

  AlertDialog addInvoiceDialog(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
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
                      controller: addInvoiceController.quanity,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomTextDecoration.textFieldDecoration(
                          labelText: "Quantity"),
                      // inputFormatters: [
                      //   FilteringTextInputFormatter(RegExp(r'[a-z A-Z]'), allow: true)
                      // ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Constant.enterTextError;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        addInvoiceController.onGstCalculation();
                      },
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: addInvoiceController.amount,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomTextDecoration.textFieldDecoration(
                          labelText: "Amount"),
                      onChanged: (value) {
                        addInvoiceController.onGstCalculation();
                      },
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
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: addInvoiceController.amountFinal,
                      readOnly: true,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomTextDecoration.textFieldDecoration(
                          labelText: "Final Amount"),
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
                      controller: addInvoiceController.amountTax,
                      readOnly: true,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomTextDecoration.textFieldDecoration(
                          labelText: "Tax Amount"),
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
                              Navigator.pop(context);
                              addInvoiceController.addItems();
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
                addInvoiceController.vendorList.forEach((element) {
                  if (element.companyName == value) {
                    VendorData vendorData = element;
                    addInvoiceController.onVendorSelection(vendorData);
                  }
                });
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
          ),
        ),
      ),
    );
  }

  Widget projectDropDownList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Select Item',
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

            addInvoiceController.projectList.forEach((element) {
              debugPrint("projectcode : ${element.projectcode!}");
              debugPrint("sample 1 ${element.projectname!}");
              debugPrint("value ${value}");
              if (element.projectname == value) {
                debugPrint("sample code ${element.projectcode!}");
                addInvoiceController.onGetBuilding(element.projectcode!);
              }
            });

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
        ),
      ),
    );
  }

  Widget categoryDropDownList(BuildContext context) {
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
              'Other',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: addInvoiceController.buildList
                .map((item) => DropdownMenuItem(
                      value: item.nameofbuilding,
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
          ),
        ),
      ),
    );
  }

  Widget PODropDownList(BuildContext context, List<ProjectData>? listProject) {
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
          items: listProject == null
              ? []
              : listProject
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
          value: addInvoiceController.selectedVendor,
          onChanged: (value) {
            // selectedProject = value;
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
        ),
      ),
    );
  }

  stepOneUI() {
    return Step(
      state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 0,
      title: const Text('Step 1'),
      content: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dropDownList(context, () {}),
          const SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Preview PDF")),
          ),
          const SizedBox(
            height: 8,
          ),
          Card(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextStyle.bold(
                      text: "Vendor Details",
                      fontSize: 18,
                      color: AppColors.blueColor),
                  const SizedBox(
                    height: 8,
                  ),
                  builderToShowData(
                      "Contact Person",
                      addInvoiceController.vendorData.contactName ?? "NA",
                      "Mobile",
                      addInvoiceController.vendorData.contactNo ?? "NA"),
                  builderToShowData(
                      "Email ",
                      addInvoiceController.vendorData.email ?? "NA",
                      "GST ",
                      addInvoiceController.vendorData.gst ?? "NA"),
                  builderToShowData(
                      "Pan ",
                      addInvoiceController.vendorData.pan ?? "NA",
                      "Address ",
                      addInvoiceController.vendorData.address ?? "NA"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Container builderToShowData(
      String title1, String value1, String title2, String value2) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextStyle.bold(text: title1, fontSize: 16),
                  CustomTextStyle.regular(text: value1, fontSize: 14),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Column(
                children: [
                  CustomTextStyle.bold(text: title2, fontSize: 16),
                  CustomTextStyle.regular(text: value2, fontSize: 14)
                ],
              ),
            ),
          ),
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
              const SizedBox(
                height: 8,
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
              InkWell(
                onTap: () {
                  CustomDateTime.buildShowDatePicker(context)
                      .then((DateTime? onValue) {
                    if (onValue != null) {
                      String date = "${onValue.year}-"
                          "${Helper.padWithZero(onValue.month)}-"
                          "${Helper.padWithZero(onValue.day)}";
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
              CustomTextStyle.regular(
                text: "Link PO",
                fontSize: 12,
              ),
              const SizedBox(
                height: 8,
              ),
              PODropDownList(context, []),
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
                TextEditingController(),
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
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: OutlinedButton.icon(
                // <-- OutlinedButton
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return addInvoiceDialog(context);
                      });
                },
                icon: Icon(
                  Icons.add,
                  size: 24.0,
                ),
                label: Text('Add Item'),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: addInvoiceController.allInvoiceItemList.isEmpty
                  ? Center(
                      child: CustomTextStyle.regular(text: "No Item Added"),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      itemCount: addInvoiceController.allInvoiceItemList.length,
                      itemBuilder: (BuildContext context, int index) {
                        AllItemData data =
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
                                            text: data.itemDescription ?? "NA",
                                            fontSize: 16)),
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
                                          text: 'Rate: 10000', fontSize: 12)),
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
                                              builder: (BuildContext context) {
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
                    ),
            )
          ],
        ),
      ),
    );
  }
}
