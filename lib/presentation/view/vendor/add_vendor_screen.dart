import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/constant.dart';
import 'package:swastik/presentation/widget/custom_text_style.dart';

import '../../../config/Helper.dart';
import '../../../config/text-style.dart';
import '../../../controller/add_vendor_controller.dart';
import '../../../model/responses/vendor_model.dart';
import '../../widget/custom_text_decoration.dart';
import '../../widget/edit_text_widgets.dart';

class AddVendorScreen extends StatefulWidget {
  VendorData? vendorData;

  AddVendorScreen({super.key, required this.vendorData});

  @override
  State<AddVendorScreen> createState() => _AddVendorScreenState();
}

class _AddVendorScreenState extends State<AddVendorScreen> {
  final avController = Get.put(AddVendorController());
  final _emailKey = GlobalKey<FormState>();
  final _mobileKey = GlobalKey<FormState>();
  final _gstKey = GlobalKey<FormState>();
  final _panKey = GlobalKey<FormState>();

  @override
  void initState() {
    avController.clearFormData();
    avController.updateFormData(widget.vendorData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Vendor"),
        ),
        body: Obx(() => avController.isUILoading.value == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: avController.addVendorFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        CustomEditTestWidgets.commonEditText(
                            avController.cNameController,
                            lable: Constant.cName),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomEditTestWidgets.commonEditText(
                            avController.cPersonNameController,
                            lable: Constant.cPersonName,
                            isOptional: true),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          key: _mobileKey,
                          controller: avController.mobileController,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 1,
                          keyboardType: TextInputType.phone,
                          decoration: CustomTextDecoration.textFieldDecoration(
                              labelText: Constant.mobileNumber),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (value.length != 10) {
                                return "Enter a valid mobile number";
                              }
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (_mobileKey.currentState != null) {
                              if (_mobileKey.currentState!.validate()) {}
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          key: _emailKey,
                          controller: avController.emailController,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: CustomTextDecoration.textFieldDecoration(
                              labelText: Constant.email),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Constant.enterTextError;
                            } else if (!value.isValidEmail()) {
                              return "Enter a valid email address";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (_emailKey.currentState != null) {
                              if (_emailKey.currentState!.validate()) {}
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomTextStyle.regular(text: "Type"),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        dropDownList(context, () {}),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          key: _panKey,
                          controller: avController.panNumberController,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 1,
                          decoration: CustomTextDecoration.textFieldDecoration(
                              labelText: Constant.panNumber),
                          validator: (value) {
                            if (avController.selectedVendor != "NA" &&
                                avController.selectedVendor == "URD") {
                              if (value == null || value.isEmpty) {
                                return Constant.enterTextError;
                              } else if (!Helper.isPanValidator(value)) {
                                return "Enter a valid PAN number";
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          key: _gstKey,
                          controller: avController.gstController,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 1,
                          decoration: CustomTextDecoration.textFieldDecoration(
                              labelText: Constant.gst),
                          validator: (value) {
                            if (avController.selectedVendor != "NA" &&
                                avController.selectedVendor == "Registered") {
                              if (value == null || value.isEmpty) {
                                return Constant.enterTextError;
                              } else if (!Helper.isGSTValidator(value)) {
                                return "Enter a valid GST number";
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomEditTestWidgets.commonEditText(
                            avController.addressController,
                            lable: Constant.address,
                            maxLine: 3),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomEditTestWidgets.commonMobileNumber(
                            avController.pinCodeController,
                            lable: Constant.pinCode),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomEditTestWidgets.commonEditText(
                            avController.cityController,
                            lable: Constant.city),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 48,
                          margin: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (avController.addVendorFormKey.currentState!
                                  .validate()) {
                                avController.addVendorApi(context);
                              } else {
                                if (avController.selectedVendor == "NA") {
                                  Helper.getToastMsg("Select type");
                                }
                              }
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.vendorData == null ? "Save" : "Update",
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
            items: avController.vendorList
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
            value: avController.selectedVendor,
            onChanged: (value) {
              setState(() {
                avController.selectedVendor = value!;
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
