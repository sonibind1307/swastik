import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:swastik/model/responses/base_model.dart';
import 'package:swastik/model/responses/build_model.dart';
import 'package:swastik/model/responses/invoice_item_model.dart';

import '../config/Helper.dart';
import '../model/responses/category_model.dart';
import '../model/responses/po_model.dart';
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

  static Future<BaseModel> deleteInvoice(String invoiceId) async {
    BaseModel data = BaseModel();
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/mobile/del_invoice/$invoiceId',
      options: Options(
        method: 'GET',
      ),
    );

    print("del_invoice: ${response.data}");
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      data = BaseModel.fromJson(res);
    } else {
      print(response.statusMessage);
    }
    return data;
  }

  static Future<POModel> getVendorPO(String vendorId, String projectId) async {
    POModel data = POModel();
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_vendor_ledger/$vendorId/$projectId',
      options: Options(
        method: 'GET',
      ),
    );

    print("getVendorPO: ${response.data}");

    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      data = POModel.fromJson(res);
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
      print("Build data $res");
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

  static Future<BaseModel?> addInvoiceData(
      {required invoice_id,
      required upload_file,
      required invDate,
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
      required List<InvoiceItems> itemList,
      required var file,
      required context}) async {
    BaseModel baseModel = BaseModel();

    var url = 'https://swastik.online/Mobile/add_invoice';

    // print("soni list => ${jsonEncode(itemList)}");

    print("invoice_id - >$invoice_id");
    print("upload_file - >$upload_file");
    // Define your form data
    var data = FormData.fromMap({
      'invoice_id': invoice_id,
      'upload_file': upload_file, // 0 - no changes // 1 - new changes
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
      'user_id': "92",
      'vendor_linked_ldgr': vendorLinkedLdgr,
      'file': upload_file == "0" && invoice_id != "0"
          ? file
          : [
              await MultipartFile.fromFile(
                  '/data/user/0/com.swastik.swastik/app_flutter/example.pdf',
                  filename: 'example.pdf')
            ],
      'item_list': json.encode(itemList)
    });
    print(" RequestData => ${data.fields}");

    Helper().showServerErrorDialog(context, "Request : ->${data.fields}",
        () async {
      FocusScope.of(context).unfocus();
      Navigator.of(context, rootNavigator: true).pop();

      try {
        // Initialize dio instance
        var dio = Dio();

        // Send POST request
        var response = await dio.post(
          url,
          data: data,
        );

        Helper().showServerErrorDialog(
            context, "Response : ->${jsonDecode(response.data)}", () async {
          FocusScope.of(context).unfocus();
          Navigator.of(context, rootNavigator: true).pop();
        });

        print("response : ${response.data}");
        // Check the response status code
        if (response.statusCode == 200) {
          var res = jsonDecode(response.data);
          baseModel = BaseModel.fromJson(res);
          print(json.encode(response.data));
        } else {
          print(response.statusMessage.toString());
        }
      } catch (e) {
        print('Error: $e');
      }
    });
    return BaseModel();

    return baseModel;
    // return baseModel;
  }
}
