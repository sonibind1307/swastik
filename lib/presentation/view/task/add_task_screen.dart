import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/Helper.dart';
import '../../../config/colorConstant.dart';
import '../../../config/constant.dart';
import '../../../config/text-style.dart';
import '../../../controller/add_task_controller.dart';
import '../../../controller/invoice_list_controller.dart';
import '../../../model/responses/project_model.dart';
import '../../widget/custom_text_style.dart';
import '../../widget/edit_text_widgets.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final aTController = Get.put(AddTaskController());
  final controllerI = Get.find<InvoiceListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Task"),
        ),
        body: Obx(() => aTController.isUILoading.value == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: aTController.addVendorFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        CustomEditTestWidgets.commonEditText(
                            aTController.cNameController,
                            lable: Constant.cTask),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomEditTestWidgets.commonEditText(
                            aTController.cPersonNameController,
                            lable: Constant.description,
                            isOptional: true),
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
                              onPressed: () {},
                              icon: const Icon(Icons.upload_file),
                              label: const Text('Upload File'),
                            ),
                            const Spacer(),
                            CustomTextStyle.regular(
                                text: "sample_pdf.pdf", color: Colors.grey),
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
                          child: Wrap(
                            spacing: 8.0,
                            children: aTController.userList.map((status) {
                              return ChoiceChip(
                                labelPadding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                selectedColor: AppColors.conGrey,
                                label: Row(
                                  children: [
                                    Text(status),
                                    const Spacer(),
                                    const Icon(Icons.cancel),
                                  ],
                                ),
                                selected: true,
                                onSelected: (isSelected) {},
                              );
                            }).toList(),
                          ),
                        ),
                        CustomTextStyle.regular(text: "Select project"),
                        dropDownList(context, controllerI.projectList),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomEditTestWidgets.dateEditText(
                          aTController.pinCodeController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextStyle.regular(text: "Set Priority"),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: const Text('High'),
                                leading: Radio(
                                  value: "Low",
                                  groupValue: "Low",
                                  onChanged: (value) {},
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: const Text('Low'),
                                leading: Radio(
                                  value: "Low",
                                  groupValue: "High",
                                  onChanged: (value) {},
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 48,
                          margin: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (aTController.addVendorFormKey.currentState!
                                  .validate()) {
                                aTController.addVendorApi(context);
                              } else {
                                if (aTController.selectedVendor == "NA") {
                                  Helper.getToastMsg("Select type");
                                }
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
      () => Padding(
        padding: const EdgeInsets.only(),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select user',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: aTController.vendorList
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
            value: aTController.selectedVendor,
            onChanged: (value) {
              // setState(() {
              //   avController.selectedVendor = value!;
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

  Widget dropDownList(BuildContext context, List<ProjectData>? listProject) {
    TextEditingController searchBar = TextEditingController();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 16),
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
            value: null,
            onChanged: (value) {
              // setState(() {
              //   selectedProject = value;
              //   controllerI.getProjectSelected(value.toString());
              // });
            },
            buttonStyleData: ButtonStyleData(
              height: 48,
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
}
