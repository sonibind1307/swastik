import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:swastik/model/responses/build_model.dart';
import 'package:swastik/model/responses/invoice_item_model.dart';

import '../model/responses/all_invoice_items.dart';
import '../model/responses/category_model.dart';
import '../model/responses/project_model.dart';
import '../model/responses/vendor_model.dart';

class ApiRepo {

  static Future<ProjectModel> getProjectList() async {
    ProjectModel data = ProjectModel();
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_projects',
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      data = ProjectModel.fromJson(res);
    } else {
      print(response.statusMessage);
    }
    return data;
  }

  static Future<VendorModel> getVendors() async {
    VendorModel vendorModel = VendorModel();
    try{
      var dio = Dio();
      var response = await dio.request(
        'https://swastik.online/Mobile/get_all_vendors',
        options: Options(
          method: 'GET',
        ),);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.data);
        vendorModel = VendorModel.fromJson(res);
      } else {
        print(response.statusMessage);
      }
    }catch(e){
      debugPrint("message :-> $e");
    }
    return vendorModel;
  }


  static Future<BuildModel> getBuilding(String projectId) async {
    BuildModel buildModel = BuildModel();
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_buildings/$projectId',
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      buildModel = BuildModel.fromJson(res);
    } else {
      print(response.statusMessage);
    }
    return buildModel;
  }

  static Future<InvoiceIDetailModel> getInvoiceDetails(String invoiceId) async {
    InvoiceIDetailModel invoiceItemModel = InvoiceIDetailModel();
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_invoice/$invoiceId',
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      invoiceItemModel = InvoiceIDetailModel.fromJson(res);
    } else {
      print(response.statusMessage);
    }
    return invoiceItemModel;
  }

  static Future<CategoryModel> getInvoiceCategory() async {
    CategoryModel categoryModel = CategoryModel();
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_all_invcat',
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      categoryModel = CategoryModel.fromJson(res);
    } else {
      print(response.statusMessage);
    }
    return categoryModel;
  }

  static Future<AllInvoiceItems> getAllInvoiceItems() async {
    AllInvoiceItems allInvoiceItems = AllInvoiceItems();
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_inv_items/9774',
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      allInvoiceItems = AllInvoiceItems.fromJson(res);
    } else {
      print(response.statusMessage);
    }
    return allInvoiceItems;
  }

  static Future<void> addInvoiceData() async {
    var data = FormData.fromMap(
        {
      'inv_date': '',
      'inv_ref': '',
      'invcomments': '',
      'inv_project': '',
      'inv_building': '',
      'inv_category': '',
      'ldgr_tds_pcnt': '',
      'inv_po': '',
      'vendor_id': '',
      'created_date': '',
      'vendor_linked_ldgr': '',
      'invoice_id': '',
      'user_id': '',
      'project_id': '',
      'username': '',
      'file': '',
      'item_amount': '',
      'item_cgst':'',
      'item_sgst':'',
      "item_igst":'',
      'item_description':'',
      'item_qty':'',
      'item_code':'',
      'invoice_item_id':''

    }

    );

    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/add_invoice_step1?inv_ref=234&inv_date=2023-02-02&invcomments=testing&inv_project=234&inv_building=234&inv_category=234&ldgr_tds_pcnt=234&inv_po=234&vendor_id=234&created_date=234&vendor_linked_ldgr=234',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }





}
