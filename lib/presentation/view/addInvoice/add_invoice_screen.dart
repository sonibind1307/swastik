import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:swastik/config/colorConstant.dart';

import '../../../config/constant.dart';
import '../../../config/text-style.dart';
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
  String? selectedVendor;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  TextEditingController itemDesc = TextEditingController();
  TextEditingController hCode = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController quanity = TextEditingController();

  List<Step> stepList() => [
        stepOneUI(),
        stepTwoUI(),
        stepThreeUI(),
      ];

  List<String> cgstList = ["Tax 1", "Tax 2"];
  List<String> sgstList = ["Tax 1", "Tax 2"];
  List<String> igstList = ["Tax 1", "Tax 2"];

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
        steps: stepList(),

        // onStepContinue takes us to the next step
        onStepContinue: () {
          if (_activeCurrentStep < (stepList().length - 1)) {
            setState(() {
              _activeCurrentStep += 1;
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Add',
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return leadDialog(context);
              });
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  AlertDialog leadDialog(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
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
                        "Add Invoice",
                        style: AppTextStyles.modalTitleText,
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: TextEditingController(),
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
                    controller: TextEditingController(),
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
                    controller: TextEditingController(),
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
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: TextEditingController(),
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: CustomTextDecoration.textFieldDecoration(
                        labelText: "Amount"),
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
                  cgstDropDownList(context),
                  const SizedBox(
                    height: 5.0,
                  ),
                  sgstDropDownList(context),
                  const SizedBox(
                    height: 8.0,
                  ),
                  sgstDropDownList(context),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: TextEditingController(),
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
                    controller: TextEditingController(),
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
                                return AppColors.btnBorderColor; //<-- SEE HERE
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
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {},
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
          ],
        ),
      ),
    );
  }

  Widget cgstDropDownList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: cgstList
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
              value: selectedVendor,
              onChanged: (value) {
                selectedVendor = value;
                // context.read<InvoiceBloc>().getProjectSelected(value.toString());
              },
              buttonStyleData: ButtonStyleData(
                height: 45,
                width: 150,
                padding: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
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
                width: 150,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
            ),
          ),
          SizedBox(
            width: 150,
            child: TextFormField(
              controller: TextEditingController(),
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration:
                  CustomTextDecoration.textFieldDecoration(labelText: ""),
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
          ),
        ],
      ),
    );
  }

  Widget sgstDropDownList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: sgstList
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
              value: selectedVendor,
              onChanged: (value) {
                selectedVendor = value;
                // context.read<InvoiceBloc>().getProjectSelected(value.toString());
              },
              buttonStyleData: ButtonStyleData(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.20,
                padding: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
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
                width: 150,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: TextFormField(
              controller: TextEditingController(),
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration:
                  CustomTextDecoration.textFieldDecoration(labelText: ""),
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
          ),
        ],
      ),
    );
  }

  Widget igstDropDownList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: igstList
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
              value: selectedVendor,
              onChanged: (value) {
                selectedVendor = value;
                // context.read<InvoiceBloc>().getProjectSelected(value.toString());
              },
              buttonStyleData: ButtonStyleData(
                height: 45,
                width: 150,
                padding: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
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
                width: 150,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
            ),
          ),
          SizedBox(
            width: 150,
            child: TextFormField(
              controller: TextEditingController(),
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration:
                  CustomTextDecoration.textFieldDecoration(labelText: ""),
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
          ),
        ],
      ),
    );
  }

  Widget dropDownList(BuildContext context, List<ProjectData>? listProject) {
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
          value: selectedVendor,
          onChanged: (value) {
            // selectedProject = value;
            // context.read<InvoiceBloc>().getProjectSelected(value.toString());
          },
          buttonStyleData: ButtonStyleData(
            height: 45,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
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
        ),
      ),
    );
  }

  Widget categoryDropDownList(
      BuildContext context, List<ProjectData>? listProject) {
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
          value: selectedVendor,
          onChanged: (value) {
            // selectedProject = value;
            // context.read<InvoiceBloc>().getProjectSelected(value.toString());
          },
          buttonStyleData: ButtonStyleData(
            height: 45,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
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
          value: selectedVendor,
          onChanged: (value) {
            // selectedProject = value;
            // context.read<InvoiceBloc>().getProjectSelected(value.toString());
          },
          buttonStyleData: ButtonStyleData(
            height: 45,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
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
        ),
      ),
    );
  }

  stepOneUI() {
    return Step(
      state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 0,
      title: const Text('Step 1'),
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dropDownList(context, []),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Preview PDF")),
            Card(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextStyle.bold(
                        text: Constant.atmStatus,
                        fontSize: 18,
                        color: AppColors.blueColor),
                    const SizedBox(
                      height: 8,
                    ),
                    builderToShowData(
                        "Contact Person", "Snehal", "Mobile", "8108519788"),
                    builderToShowData("Email ", "bharatgangwane@gmail.com",
                        "GST ", "27AOCPK6216L1ZT	"),
                    builderToShowData("Pan ", "ABGFS9045Q", "Address ",
                        "Room No - 1102, Valmiki Chs, Tagore Nagar, Group No - 5, Vikhroli East , (400 08), mumbai"),
                  ],
                ),
              ),
            )
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
              dropDownList(context, []),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: TextEditingController(),
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
              categoryDropDownList(context, []),
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
              categoryDropDownList(context, []),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  CustomDateTime.buildShowDatePicker(context)
                      .then((DateTime? onValue) {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListTile(
                    title: Text("" == "" ? "Date" : ""),
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
            ],
          ),
        ));
  }

  stepThreeUI() {
    return Step(
        state: StepState.complete,
        isActive: _activeCurrentStep >= 2,
        title: const Text('Step 3'),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
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
                          flex: 2,
                          child: Container(
                              // color: Colors.red,
                              child: CustomTextStyle.bold(
                                  text: 'Cement bag', fontSize: 16)),
                        ),
                        Expanded(
                            flex: 1,
                            child: CustomTextStyle.regular(
                                text: 'Qty: ${index + 1}', fontSize: 12)),
                        Expanded(
                            child: CustomTextStyle.bold(
                                text: '10000', fontSize: 16)),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: CustomTextStyle.regular(text: ' 300344')),
                        Expanded(
                            flex: 1,
                            child: CustomTextStyle.regular(
                                text: 'Rate: 10000', fontSize: 12)),
                        Expanded(
                            child: Row(
                          children: [
                            CustomTextStyle.regular(
                                text: 'Rs. 18 GST', fontSize: 12),
                            Icon(
                              Icons.info_rounded,
                              color: Colors.grey,
                            )
                          ],
                        )),
                      ],
                    ),
                    SizedBox(
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
                                text: 'RS.1018000', fontSize: 16)),
                      ],
                    ),

                    /*Divider(),
                    ListTile(
                      title: CustomTextStyle.regular(text: "Amount"),
                      trailing: CustomTextStyle.bold(text: "2000"),
                    ),
                    // Divider(),

                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16),
                      child: Row(
                        children: [
                          CustomTextStyle.regular(text: 'Qty: '),
                          CustomTextStyle.regular(text: '24'),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16),
                      child: Row(
                        children: [
                          CustomTextStyle.regular(text: 'GST: '),
                          CustomTextStyle.regular(text: '24'),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.info_rounded,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(right: 16.0, left: 16),
                    //   child: Row(
                    //     children: [
                    //       CustomTextStyle.regular(text: 'CGST ${email.text}'),
                    //       Spacer(),
                    //       CustomTextStyle.regular(text: '24'),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 16.0, left: 16),
                    //   child: Row(
                    //     children: [
                    //       CustomTextStyle.regular(text: 'SGST ${email.text}'),
                    //       Spacer(),
                    //       CustomTextStyle.regular(text: '28'),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 16.0, left: 16),
                    //   child: Row(
                    //     children: [
                    //       Text('IGSC ${email.text}'),
                    //       Spacer(),
                    //       Text('3'),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 16.0, left: 16),
                    //   child: Row(
                    //     children: [
                    //       CustomTextStyle.regular(text: 'GST  ${email.text}'),
                    //       Spacer(),
                    //       CustomTextStyle.regular(text: '8'),
                    //     ],
                    //   ),
                    // ),
                    // Divider(),*/
                    // ListTile(
                    //   title: CustomTextStyle.regular(text: "Total Amt"),
                    //   trailing: CustomTextStyle.bold(
                    //       text: "303000", color: AppColors.greenColor),
                    // ),
                  ],
                ),
              ));
            },
          ),
        ));
  }
}
