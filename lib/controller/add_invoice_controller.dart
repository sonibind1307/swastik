import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/model/responses/all_invoice_items.dart';
import 'package:swastik/model/responses/category_model.dart';
import 'package:swastik/model/responses/vendor_model.dart';

import '../model/responses/build_model.dart';
import '../model/responses/invoice_item_model.dart';
import '../model/responses/project_model.dart';
import '../repository/api_call.dart';

class AddInvoiceController extends GetxController {
  // List<VendorData> vendorList = [];
  var vendorList = <VendorData>[].obs;
  var allInvoiceItemList = <AllItemData>[].obs;
  var categoryItemList = <CategoryData>[].obs;
  var projectList = <ProjectData>[].obs;
  var buildList = <BuildData>[].obs;

  var selectedDate;

  VendorData vendorData = VendorData();
  RxBool cgstFlag = true.obs;
  RxBool igstFlag = true.obs;

  // String? cgstValue;
  // String? sgstValue;
  // String? igstValue;

  RxString cgstValue1 = "CGST".obs;
  RxString sgstValue1 = "SGST".obs;
  RxString igstValue1 = "IGST".obs;

  String? selectedCategory;
  String? selectedProject;
  String? selectedBuild;

  TextEditingController invRefController = TextEditingController();

  String? selectedVendor;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  TextEditingController itemDesc = TextEditingController();
  TextEditingController hCode = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController amountTax = TextEditingController();
  TextEditingController amountFinal = TextEditingController();
  TextEditingController quanity = TextEditingController();

  TextEditingController cgstController = TextEditingController();
  TextEditingController sgstController = TextEditingController();
  TextEditingController igstController = TextEditingController();

  List<VendorData> listofVenderData = [];
  List<ProjectData> projectData = [];
  List<String> cgstList = ["CGST", "0%", "2.5%", "6%", "9%", "14%"];
  List<String> sgstList = ["SGST", "0%", "2.5%", "6%", "9%", "14%"];
  List<String> igstList = ["IGST", "0%", "5%", "12%", "18%", "28%"];

  // double? totalAmount;

  Future<void> onGetVendor() async {
    VendorModel vendorModel = await ApiRepo.getVendors();
    if (vendorModel.data != null) {
      vendorList.value = vendorModel.data!;
    }
    update();
  }

  void onVendorSelection(VendorData value) {
    vendorData = value;

    update();
  }

  void onGstCalculation() {
    debugPrint("quanity ${quanity.text}");
    debugPrint("amount ${amount.text}");
    double _amount = 0.0;
    double cgstPer = 0.0;
    double sgstPer = 0.0;
    double igstPer = 0.0;
    double _gst = 0.0;

    if (amount.text.trim().isNotEmpty) {
      _amount = double.parse(amount.text);
      if (cgstFlag == true) {
        double cgstVal = 0.0;
        double sgstVal = 0.0;
        if (cgstValue1.value != cgstList[0]) {
          cgstPer = double.parse(cgstValue1.value
              .substring(0, cgstValue1.value.length - 1)
              .toString());
          cgstVal = (cgstPer * _amount) / 100;
        }
        if (sgstValue1.value != sgstList[0]) {
          sgstPer = double.parse(sgstValue1.value
              .substring(0, sgstValue1.value.length - 1)
              .toString());
          sgstVal = (sgstPer * _amount) / 100;
        }
        cgstController.text = cgstVal.toString();
        sgstController.text = sgstVal.toString();

        _gst = cgstVal + sgstVal;
      } else {
        double sgstVal = 0.0;
        if (sgstValue1.value != sgstList[0]) {
          sgstVal = double.parse(sgstValue1.value
              .substring(0, sgstValue1.value.length - 1)
              .toString());
          igstPer = (sgstVal * _amount) / 100;
        }
        _gst = igstPer;
      }
      amountTax.text = _gst.toString();
      amountFinal.text = (_amount + _gst).toString();
    }
  }

  double totalAmount(double amount,
      {double? cgst, double? sgst, double? igst}) {
    var total = amount + cgst! + sgst! + igst!;
    return total;
  }

  Future<void> onGetAllInvoiceItem() async {
    AllInvoiceItems allInvoiceItems = await ApiRepo.getAllInvoiceItems();
    allInvoiceItemList.value = allInvoiceItems.data!;
    update();
  }

  Future<void> onGetInvoiceCategoryItem() async {
    CategoryModel categoryModel = await ApiRepo.getInvoiceCategory();
    categoryItemList.value = categoryModel.data!;
    update();
  }

  Future<void> onGetProject() async {
    ProjectModel projectModel = await ApiRepo.getProjectList();
    projectList.value = projectModel.data!;
    update();
  }

  Future<void> onGetBuilding(String projectId) async {
    BuildModel data = await ApiRepo.getBuilding(projectId);
    buildList.value = data.data!;
    update();
  }

  Future<void> onGetInvoiceDetails(String invoiceId) async {
    InvoiceIDetailModel data = await ApiRepo.getInvoiceDetails(invoiceId);
    // invoiceDetail.value = data.data!;
    debugPrint("vendorData 2024 -> ${jsonEncode(data)}");

    if (data.data != null) {
      debugPrint("vendorData 2024 -> ${data.data!.project}");
      // await onGetBuilding(data.data![0].project!);
      selectedProject = data.data!.projectname;
      selectedCategory = data.data!.invcat;
      selectedBuild = data.data!.nameofbuilding;
      selectedDate = data.data!.invDate;
      invRefController.text = data.data!.invref.toString();
    }

    update();
  }
}
