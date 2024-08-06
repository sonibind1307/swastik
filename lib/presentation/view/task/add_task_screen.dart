import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/Helper.dart';
import '../../../config/colorConstant.dart';
import '../../../config/constant.dart';
import '../../../config/text-style.dart';
import '../../../controller/add_invoice_controller.dart';
import '../../../controller/add_task_controller.dart';
import '../../../model/responses/assign_user_model.dart';
import '../../../model/responses/project_model.dart';
import '../../widget/custom_text_style.dart';
import '../../widget/edit_text_widgets.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final aTController = Get.find<AddTaskController>();
  final addInvoiceController = Get.find<AddInvoiceController>();

  @override
  void initState() {
    addInvoiceController.getAssignUserList();
    addInvoiceController.onGetProject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Task"),
        ),
        body: Obx(() =>
        aTController.isUILoading.value == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: aTController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  CustomEditTestWidgets.commonEditText(
                      aTController.titleCtrl,
                      lable: Constant.cTask),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomEditTestWidgets.commonEditText(
                      aTController.descCtrl,
                      lable: Constant.description),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextStyle.regular(text: "Upload Document"),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      FilledButton.tonalIcon(
                        onPressed: () {
                          aTController.pickFilesOthersMobile(
                              callBack: (fileName) {
                                setState(() {
                                  aTController.fileName = fileName;
                                });
                              });
                        },
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Upload File'),
                      ),
                    ],
                  ),
                  Row(children: [
                    if (aTController.fileName != null) ...[
                      const Spacer(),
                      CustomTextStyle.regular(
                          text: aTController.fileName,
                          color: Colors.grey),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            aTController.fileName = null;
                          });
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      )
                    ]
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      FilledButton.tonalIcon(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_voice_outlined),
                        label: const Text('Voice Note'),
                      ),
                      const Spacer(),
                      CustomTextStyle.regular(
                          text: "voice.ex", color: Colors.grey),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextStyle.regular(text: "Assign User"),
                  const SizedBox(
                    height: 8,
                  ),
                  userDropDownList(context, () {}),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Obx(
                          () =>
                          Wrap(
                            spacing: 8.0,
                            children:
                            aTController.selectedUserList.map((value) {
                              return ChoiceChip(
                                labelPadding:
                                const EdgeInsets.only(left: 8, right: 8),
                                padding:
                                const EdgeInsets.only(left: 8, right: 8),
                                selectedColor: AppColors.worningColor,
                                label: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: DefaultTextStyle
                                        .of(context)
                                        .style,
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                        child: Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 4.0),
                                            child: Text(
                                                "${value.firstName!}  ")),
                                      ),
                                      WidgetSpan(
                                        child: InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 1.0),
                                            child: Icon(Icons.cancel,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                selected: true,
                                onSelected: (isSelected) {
                                  setState(() {
                                    aTController.onRemoveUser(value);
                                  });
                                },
                              );
                            }).toList(),
                          ),
                    ),
                  ),
                  CustomTextStyle.regular(text: "Select project"),
                  dropDownList(context),
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
                  CustomEditTestWidgets.dateEditText(
                      aTController.dateCtrl, context,
                      callBack: (String value) {
                        setState(() {
                          aTController.dateCtrl.text = value.substring(0, 19);
                        });
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextStyle.regular(text: "Set Priority"),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Text(aTController.priorityList[0]),
                          leading: Radio(
                            value: aTController.priorityList[0],
                            groupValue:
                            aTController.selectedPriority.value,
                            onChanged: (value) {
                              setState(() {
                                aTController.onPriorityChange(value);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(aTController.priorityList[1]),
                          leading: Radio(
                            value: aTController.priorityList[1],
                            groupValue:
                            aTController.selectedPriority.value,
                            onChanged: (value) {
                              setState(() {
                                aTController.onPriorityChange(value);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 48,
                    margin: const EdgeInsets.all(0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (aTController.formKey.currentState!
                            .validate()) {
                          aTController.addTaskApi(context);
                        } else if (aTController
                            .selectedUserList.isEmpty) {
                          Helper.getToastMsg(
                              "Please select user to assign this task.");
                        } else if (aTController
                            .selectProject.value.projectname ==
                            null) {
                          Helper.getToastMsg("Please select project.");
                        } else if (aTController.selectedBuilding ==
                            null) {
                          Helper.getToastMsg("Please select building.");
                        }
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            // widget.vendorData == null ? "Save" : "Update",
                            true ? "Save Task" : "Update",
                            style: AppTextStyles.btn1TextStyle,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        )));
  }

  Widget userDropDownList(BuildContext context, VoidCallback onSelection) {
    TextEditingController searchBar = TextEditingController();
    return Obx(
          () =>
          Padding(
            padding: const EdgeInsets.only(),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<UserData>(
                isExpanded: true,
                hint: Text(
                  'Select user',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme
                        .of(context)
                        .hintColor,
                  ),
                ),
                items: addInvoiceController.userList
                    .map((item) =>
                    DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.firstName!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                    .toList(),
                value: aTController.selectedUser.value.firstName == null
                    ? null
                    : aTController.selectedUser.value,
                onChanged: (value) {
                  setState(() {
                    aTController.onUserSelected(value);
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
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value!.userName!
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

  Widget dropDownList(BuildContext context) {
    TextEditingController searchBar = TextEditingController();
    return Obx(
          () =>
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<ProjectData>(
                isExpanded: true,
                hint: Text(
                  'Select project',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme
                        .of(context)
                        .hintColor,
                  ),
                ),
                items: addInvoiceController.projectList
                    .map((item) =>
                    DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.projectname!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                    .toList(),
                value: aTController.selectProject.value.projectname == null
                    ? null
                    : aTController.selectProject.value,
                onChanged: (value) {
                  setState(() {
                    addInvoiceController.onGetBuilding(value!.projectcode!);
                    aTController.onProjectChange(value);
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: 48,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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

  Widget buildDropDownList(BuildContext context) {
    return Obx(
          () =>
          Padding(
            padding: const EdgeInsets.only(),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'Select building',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme
                        .of(context)
                        .hintColor,
                  ),
                ),
                items: addInvoiceController.buildList
                    .map((item) =>
                    DropdownMenuItem(
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
                  setState(() {
                    aTController.onBuildingChange(value!);
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
}
