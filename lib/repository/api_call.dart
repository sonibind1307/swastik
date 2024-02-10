import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:swastik/model/responses/build_model.dart';
import 'package:swastik/model/responses/invoice_item_model.dart';

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

    print("get_projects: ${response.data}");
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
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://swastik.online/Mobile/get_all_vendors',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        var res = jsonDecode(response.data);
        vendorModel = VendorModel.fromJson(res);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
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

  static Future<void> addInvoiceData(
      {required invDate,
      required invRef,
      required invComments,
      required invProject,
      required invBuilding,
      required invCategory,
      required ldgrTdsPcnt,
      required invPo,
      required vendorId,
      required createdDate,
      required vendorLinkedLdgr,
      required List<InvoiceItems> itemList}) async {
    var url = 'https://swastik.online/Mobile/add_invoice';

    // Define your form data
    var data = FormData.fromMap({
      'inv_date': invDate,
      'inv_ref': invRef,
      'invcomments': invComments,
      'inv_project': invProject,
      'inv_building': invBuilding,
      'inv_category': invCategory,
      'ldgr_tds_pcnt': ldgrTdsPcnt,
      'inv_po': invPo,
      'vendor_id': vendorId,
      'created_date': createdDate,
      'vendor_linked_ldgr': vendorLinkedLdgr,
      'file': "",
      'item_list': json.encode(itemList)
    });

    // Create your request parameters
    var params = {
      'inv_date': invDate,
      'inv_ref': invRef,
      'invcomments': invComments,
      'inv_project': invProject,
      'inv_building': invBuilding,
      'inv_category': invCategory,
      'ldgr_tds_pcnt': ldgrTdsPcnt,
      'inv_po': invPo,
      'vendor_id': vendorId,
      'created_date': createdDate,
      'vendor_linked_ldgr': vendorLinkedLdgr,
      'file': "",
      'item_list': json.encode(itemList) // Convert item list to JSON string
    };

    try {
      // Initialize dio instance
      var dio = Dio();

      // Send POST request
      var response = await dio.post(
        url,
        // data: data,
        queryParameters: params,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
