import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/model/responses/base_model.dart';
import 'package:swastik/model/responses/category_model.dart';
import 'package:swastik/model/responses/vendor_model.dart';

import '../model/responses/build_model.dart';
import '../model/responses/invoice_item_model.dart';
import '../model/responses/po_model.dart';
import '../model/responses/project_model.dart';
import '../presentation/view/invoice_screen.dart';
import '../repository/api_call.dart';

class AddInvoiceController extends GetxController {
  // List<VendorData> vendorList = [];
  var vendorList = <VendorData>[].obs;
  var allInvoiceItemList = <InvoiceItems>[].obs;
  var categoryItemList = <CategoryData>[].obs;
  var projectList = <ProjectData>[].obs;
  var buildList = <BuildData>[].obs;
  var poList = <PoList>[].obs;
  RxBool loading = false.obs;
  RxBool step1Loading = true.obs;
  var selectedDate;
  var vendorData = <VendorData>[].obs;
  InvoiceIDetailModel invoiceIDetailModel = InvoiceIDetailModel();
  RxBool cgstFlag = true.obs;
  RxBool igstFlag = true.obs;

  RxString cgstValue1 = "CGST".obs;
  RxString sgstValue1 = "SGST".obs;
  RxString igstValue1 = "IGST".obs;
  RxString companyName = "".obs;

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
  String? projectId;

  Future<void> onGetVendor() async {
    step1Loading.value = true;
    VendorModel vendorModel = await ApiRepo.getVendors();
    if (vendorModel.data != null) {
      vendorList.value = vendorModel.data!;
    }
    Helper.getToastMsg(inVoiceId.toString());
    if (inVoiceId != "" && inVoiceId != null) {
      selectedVendor = invoiceIDetailModel.data!.companyName;
      onVendorSelection(selectedVendor!);
    }

    step1Loading.value = false;
    update();
  }

  void init() {
    selectedCategory = null;
    categoryItemList.clear();
    selectedBuild = null;
    buildList.clear();
    companyName.value = "";
    vendorData.clear();
    DateTime dateTime = DateTime.now();
    String date = "${dateTime.year}-"
        "${Helper.padWithZero(dateTime.month)}-"
        "${Helper.padWithZero(dateTime.day)}";
    selectedDate = date;
    VendorData data = VendorData();
    vendorData.add(data);
    update();
  }

  void onVendorSelection(String vendorName) {
    debugPrint("vendorName -> $vendorName");
    for (var element in vendorList) {
      if (element.companyName == vendorName) {
        vendorData.clear();
        vendorData.add(element);
        vendorId = element.id!;
      }
    }
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
    buildList.clear();
    selectedBuild = null;
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
    ledgerId = data.data!.ledgerId;
    if (data.data!.poList!.isNotEmpty) {
      //poList.value = data.data!.poList!;
      poList.add(data.data!.poList![0]);
    }
    update();
  }

  Future<void> onGetInvoiceDetails(String invoiceId) async {
    invoiceIDetailModel = await ApiRepo.getInvoiceDetails(invoiceId);
    // invoiceDetail.value = data.data!;
    debugPrint("vendorData 2024 -> ${jsonEncode(invoiceIDetailModel)}");

    if (invoiceIDetailModel.data != null) {
      debugPrint("vendorData 2024 -> ${invoiceIDetailModel.data!.project}");
      await onGetBuilding(invoiceIDetailModel.data!.project!);

      companyName.value = invoiceIDetailModel.data!.companyname!;
      selectedProject = invoiceIDetailModel.data!.projectname;
      selectedCategory = invoiceIDetailModel.data!.invcat;
      selectedBuild = invoiceIDetailModel.data!.building;
      selectedDate = invoiceIDetailModel.data!.invDate!;
      invRefController.text = invoiceIDetailModel.data!.invref.toString();
      pdfUrl = invoiceIDetailModel.data!.filename.toString();
      debugPrint("pdfUrl -> $pdfUrl");
      if (invoiceIDetailModel.data!.invoiceItems!.isNotEmpty) {
        allInvoiceItemList.value = invoiceIDetailModel.data!.invoiceItems!;
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

  Future<BaseModel?> addInvoiceAPi(BuildContext context) async {
    BaseModel baseModel = BaseModel();
    if (allInvoiceItemList.isNotEmpty) {
      loading.value = true;
      baseModel = (await ApiRepo.addInvoiceData(
          invDate: DateFormat("dd-MM-yy").format(DateTime.parse(selectedDate)),
          invRef: invRefController.text.trim(),
          invComments: noteController.text.trim(),
          invProject: projectId,
          invBuilding: selectedBuild,
          invCategory: selectedCategory,
          ldgrTdsPcnt: "0",

          ///invoice details
          invPo: selectedPo,
          vendorId: vendorId,
          createdDate: DateFormat("dd-MM-yy").format(DateTime.now()),
          vendorLinkedLdgr: ledgerId,

          /// on project change
          itemList: allInvoiceItemList))!;

      if (baseModel.status == "true") {
        loading.value = false;
        Helper.getToastMsg(baseModel.message!);
        Get.offAll(InvoiceScreen());
      } else {
        loading.value = false;
        Helper.getToastMsg("Server Error");

        debugPrint("Not get response");
      }
    } else {
      Helper.getToastMsg("add at least one item");
    }
    return baseModel;
  }

  bool validateStep2() {
    bool isValidate = true;
    if (selectedProject == null) {
      Helper.getToastMsg("Select project");
      isValidate = false;
    } else if (selectedBuild == null) {
      isValidate = false;
      Helper.getToastMsg("Select building name");
    } else if (selectedCategory == null) {
      isValidate = false;
      Helper.getToastMsg("Select category");
    } else if (invRefController.text.trim() == "") {
      isValidate = false;
      Helper.getToastMsg("Enter invoice reference");
    } else if (noteController.text.trim() == "") {
      isValidate = false;
      Helper.getToastMsg("Enter invoice note");
    }
    return isValidate;
  }
}
