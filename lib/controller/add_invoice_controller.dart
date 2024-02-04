import 'dart:convert';

import 'package:dio/dio.dart';
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
  var invoiceDetail = <DetailData>[].obs;


  VendorData vendorData = VendorData();
  RxBool cgstFlag = true.obs;
  RxBool igstFlag = true.obs;

  String? cgstValue;
  String? sgstValue;
  String? igstValue;

  RxString cgstValue1 ="".obs;
  RxString sgstValue1 ="".obs;
  RxString igstValue1 ="".obs;

  String? selectedCategory;
  String? selectedProject;
  String? selectedBuild;




  Future<void> onGetVendor() async {
    VendorModel vendorModel= await ApiRepo.getVendors();
    if(vendorModel.data != null){
      vendorList.value = vendorModel.data!;
    }
    update();
  }

  void onVendorSelection(VendorData value){
    vendorData = value;
    debugPrint("vendorData 2024 -> ${jsonEncode(vendorData)}");
    update();
  }

  double onGstCalculation(double percent, double amount){
    var gst = (percent*amount) / 100;
    debugPrint("gst $gst");
    return gst;
  }

  Future<void> onGetAllInvoiceItem() async {
    AllInvoiceItems  allInvoiceItems = await ApiRepo.getAllInvoiceItems();
    allInvoiceItemList.value = allInvoiceItems.data!;
    update();
  }

  Future<void> onGetInvoiceCategoryItem() async {
    CategoryModel  categoryModel = await ApiRepo.getInvoiceCategory();
    categoryItemList.value = categoryModel.data!;
    update();
  }

  Future<void> onGetProject() async {
    ProjectModel  projectModel = await ApiRepo.getProjectList();
    projectList.value = projectModel.data!;
    update();
  }

  Future<void> onGetBuilding(String projectId) async {
    BuildModel  data = await ApiRepo.getBuilding(projectId);
    buildList.value = data.data!;
    update();
  }

  Future<void> onGetInvoiceDetails(String invoiceId) async {
    InvoiceIDetailModel  data = await ApiRepo.getInvoiceDetails(invoiceId);
    invoiceDetail.value = data.data!;
    update();
  }




}