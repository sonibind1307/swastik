import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/model/responses/base_model.dart';
import 'package:swastik/model/responses/category_model.dart';
import 'package:swastik/model/responses/vendor_model.dart';

import '../model/responses/build_model.dart';
import '../model/responses/invoice_item_model.dart';
import '../model/responses/po_model.dart';
import '../model/responses/project_model.dart';
import '../repository/api_call.dart';

class AddInvoiceController extends GetxController {
  // List<VendorData> vendorList = [];
  var vendorList = <VendorData>[].obs;
  var allInvoiceItemList = <InvoiceItems>[].obs;
  var categoryItemList = <CategoryData>[].obs;
  var projectList = <ProjectData>[].obs;
  var buildList = <BuildData>[].obs;
  var poList = <PoList>[].obs;

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
  String? pdfUrl;

  TextEditingController invRefController = TextEditingController();

  String? selectedVendor;
  String? selectedPo;

  TextEditingController itemDesc = TextEditingController();
  TextEditingController hCode = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController amountTax = TextEditingController();
  TextEditingController amountFinal = TextEditingController();
  TextEditingController quanity = TextEditingController();
  TextEditingController noteController = TextEditingController();

  TextEditingController cgstController = TextEditingController();
  TextEditingController sgstController = TextEditingController();
  TextEditingController igstController = TextEditingController();

  TextEditingController searchProjectDropDown = TextEditingController();
  TextEditingController searchCategoryDropDown = TextEditingController();

  List<VendorData> listofVenderData = [];
  List<ProjectData> projectData = [];
  List<String> cgstList = ["CGST", "0%", "2.5%", "6%", "9%", "14%"];
  List<String> sgstList = ["SGST", "0%", "2.5%", "6%", "9%", "14%"];
  List<String> igstList = ["IGST", "0%", "5%", "12%", "18%", "28%"];

  // double? totalAmount;
  String? vendorId;
  String? ledgerId;
  String? inVoiceId;

  Future<void> onGetVendor() async {
    VendorModel vendorModel = await ApiRepo.getVendors();
    if (vendorModel.data != null) {
      vendorList.value = vendorModel.data!;
    }
    update();
  }

  void init() {
    DateTime dateTime = DateTime.now();
    String date = "${dateTime.year}-"
        "${Helper.padWithZero(dateTime.month)}-"
        "${Helper.padWithZero(dateTime.day)}";
    selectedDate = date;
  }

  void onVendorSelection(VendorData value) {
    vendorData = value;
    vendorId = value.id!;
    update();
  }

  void onGstCalculation() {
    double _amount = 0.0;
    double _quanity = 0.0;
    double cgstPer = 0.0;
    double sgstPer = 0.0;
    double igstPer = 0.0;
    double _gst = 0.0;
    double cgstVal = 0.0;
    double sgstVal = 0.0;
    double igstVal = 0.0;
    double _finalAmount = 0.0;

    if (amount.text.trim().isNotEmpty && quanity.text.trim().isNotEmpty) {
      _amount = double.parse(amount.text);
      _quanity = double.parse(quanity.text);
      _finalAmount = _amount * _quanity;

      if (cgstValue1.value != cgstList[0]) {
        cgstPer = double.parse(cgstValue1.value
            .substring(0, cgstValue1.value.length - 1)
            .toString());
        cgstVal = (cgstPer * _finalAmount) / 100;
      }
      if (sgstValue1.value != sgstList[0]) {
        sgstPer = double.parse(sgstValue1.value
            .substring(0, sgstValue1.value.length - 1)
            .toString());
        sgstVal = (sgstPer * _finalAmount) / 100;
      }
      _gst = cgstVal + sgstVal;

      if (igstValue1.value != igstList[0]) {
        igstPer = double.parse(igstValue1.value
            .substring(0, igstValue1.value.length - 1)
            .toString());
        igstVal = (igstPer * _finalAmount) / 100;
        _gst = igstVal;
      }
    }
    cgstController.text = cgstVal.toString();
    sgstController.text = sgstVal.toString();
    igstController.text = igstVal.toString();
    amountTax.text = _gst.toString();
    amountFinal.text = (_finalAmount + _gst).toString();
  }

  Future<void> onGetAllInvoiceItem() async {
    // AllInvoiceItems allInvoiceItems = await ApiRepo.getAllInvoiceItems();
    // allInvoiceItemList.value = allInvoiceItems.data!;
    // update();
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

  Future<void> onGetVendorPO(
    String projectId,
  ) async {
    debugPrint("vendorId -> $vendorId");
    debugPrint("projectId -> $projectId");

    POModel data = await ApiRepo.getVendorPO(vendorId!, projectId);
    ledgerId =data.data!.ledgerId;
    if (data.data!.poList!.isNotEmpty) {
      //poList.value = data.data!.poList!;
      poList.add(data.data!.poList![0]);
    }
    update();
  }

  Future<void> onGetInvoiceDetails(String invoiceId) async {
    InvoiceIDetailModel data = await ApiRepo.getInvoiceDetails(invoiceId);
    // invoiceDetail.value = data.data!;
    debugPrint("vendorData 2024 -> ${jsonEncode(data)}");

    if (data.data != null) {
      debugPrint("vendorData 2024 -> ${data.data!.project}");
      await onGetBuilding(data.data!.project!);
      selectedProject = data.data!.projectname;
      selectedCategory = data.data!.invcat;
      selectedBuild = data.data!.nameofbuilding;
      selectedDate = data.data!.invDate!;
      invRefController.text = data.data!.invref.toString();
      pdfUrl = data.data!.filename.toString();
      debugPrint("pdfUrl -> $pdfUrl");
      if (data.data!.invoiceItems!.isNotEmpty) {
        allInvoiceItemList.value = data.data!.invoiceItems!;
        update();
      }
    }

    update();
  }

  addItems() {
    InvoiceItems allItemData = InvoiceItems();
    //allItemData.invoiceItemId = "1234";
    allItemData.itemDescription = itemDesc.text.toString();
    allItemData.invoiceId = inVoiceId;
    allItemData.itemAmount = amount.text.toString();
    allItemData.qty = quanity.text.toString();
    allItemData.hsnCode = hCode.text.toString();
    allItemData.itemCgst = cgstController.text.toString();
    allItemData.itemSgst = sgstController.text.toString();
    allItemData.itemIgst = igstController.text.toString();
    allItemData.itemTds = itemDesc.text.toString();
    allItemData.itemTax = amountTax.text.toString();
    allItemData.itemTotal = amountFinal.text.toString();
    allItemData.itemVat = itemDesc.text.toString();
    allInvoiceItemList.add(allItemData);
    update();
  }

  void clearAddFormData() {
    itemDesc.clear();
    hCode.clear();
    amount.clear();
    amountTax.clear();
    amountFinal.clear();
    quanity.clear();
    cgstController.clear();
    sgstController.clear();
    igstController.clear();
    cgstValue1.value = "CGST";
    sgstValue1.value = "SGST";
    igstValue1.value = "IGST";
    cgstFlag.value = true;
    igstFlag.value = true;
  }

  Future<void> addInvoiceAPi(BuildContext context) async {
    if (allInvoiceItemList.isNotEmpty) {
    BaseModel? baseModel = await ApiRepo.addInvoiceData(
          invDate: selectedDate,
          invRef: invRefController.text.trim(),
          invComments: noteController.text.trim(),
          invProject: selectedProject,
          invBuilding: selectedBuild,
          invCategory: selectedCategory,
          ldgrTdsPcnt: "0",

          ///invoice details
          invPo: selectedPo,
          vendorId: vendorId,
          createdDate: DateTime.now(),
          vendorLinkedLdgr: ledgerId,

          /// on project change
          itemList: allInvoiceItemList);

     // if(baseModel!.status == true){
     //   Helper.getToastMsg(baseModel.message!);
     // }else{
     //   Helper.getToastMsg(baseModel.message!);
     //   debugPrint("Not get response");
     // }

    } else {
      Helper.getSnackBarError(context, "add at least one item");
    }
  }
}
