import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:swastik/config/colorConstant.dart';

import '../../../config/constant.dart';
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

  List<Step> stepList() => [
        stepOneUI(),
        stepTwoUI(),
        stepThreeUI(),
      ];

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
        physics: ScrollPhysics(),
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
                        CustomTextStyle.bold(text: '883883 - Description'),
                      ],
                    ),
                    ListTile(
                      title: CustomTextStyle.regular(text: "Amount"),
                      trailing: CustomTextStyle.bold(text: "3sss03000"),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16),
                      child: Row(
                        children: [
                          CustomTextStyle.regular(text: 'CGST ${email.text}'),
                          Spacer(),
                          CustomTextStyle.regular(text: '24'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16),
                      child: Row(
                        children: [
                          CustomTextStyle.regular(text: 'SGST ${email.text}'),
                          Spacer(),
                          CustomTextStyle.regular(text: '28'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16),
                      child: Row(
                        children: [
                          Text('IGSC ${email.text}'),
                          Spacer(),
                          Text('3'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16),
                      child: Row(
                        children: [
                          CustomTextStyle.regular(text: 'GST  ${email.text}'),
                          Spacer(),
                          CustomTextStyle.regular(text: '8'),
                        ],
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: CustomTextStyle.regular(text: "Total Amt"),
                      trailing: CustomTextStyle.bold(
                          text: "303000", color: AppColors.greenColor),
                    ),
                  ],
                ),
              ));
            },
          ),
        ));
  }
}
