import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as gt;
import 'package:swastik/model/responses/base_model.dart';
import 'package:swastik/model/responses/build_model.dart';
import 'package:swastik/model/responses/invoice_item_model.dart';

import '../config/Helper.dart';
import '../config/sharedPreferences.dart';
import '../model/responses/assign_user_model.dart';
import '../model/responses/category_model.dart';
import '../model/responses/po_model.dart';
import '../model/responses/project_model.dart';
import '../model/responses/user_info_model.dart';
import '../model/responses/vendor_model.dart';
import '../presentation/view/invoice/add_invoice_screen.dart';
import '../presentation/view/invoice/list_invoice_screen.dart';

class ApiRepo {
  // static baseUrl = 'https://swastik.online/Mobile/';
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

  static Future<ValidateUserModel> getAssignUserList() async {
    ValidateUserModel model = ValidateUserModel();
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/mobile/get_allusers',
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      model = ValidateUserModel.fromJson(res);
    } else {
      print(response.statusMessage);
    }
    return model;
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
      required step2_userid,
      required context}) async {
    BaseModel baseModel = BaseModel();

    var url = 'https://swastik.online/Mobile/add_invoice';

    // print("soni list => ${jsonEncode(itemList)}");

    print("invoice_id - >$invoice_id");
    print("upload_file - >$upload_file");
    final downloadPath = await FileStorage.localPath;
    String folderName = "swastik";
    Directory newDirectory = Directory('${downloadPath}/$folderName');
    var path = "";
    if (await newDirectory.exists()) {
      path = '${newDirectory.path}/invoice.pdf';
    }

    print("pdf_pathe - ${path}");

    // Save the PDF to the path
    // final File file = File(path);
    try {
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
        'step2_userid': step2_userid,
        'vendor_linked_ldgr': vendorLinkedLdgr,
        'file': upload_file == "0" && invoice_id != "0"
            ? file
            : [await MultipartFile.fromFile(path, filename: 'example.pdf')],
        'item_list': json.encode(itemList)
      });

      print(" add_invoice_request => ${data.fields}");

      ///

      var dio = Dio();

      try {
        var response = await dio.post(
          url,
          data: data,
        );

        if (response.statusCode == 200) {
          var res = jsonDecode(response.data);
          baseModel = BaseModel.fromJson(res);
        }
      } catch (e) {
        Helper.getToastMsg("Server error");
      }
      return baseModel;

      ///

      Helper().showServerErrorDialog(context,
          "File_path:${path == "" ? file : path} \n Request : ->${data.fields}",
          () async {
        FocusScope.of(context).unfocus();
        Navigator.of(context, rootNavigator: true).pop();

        // Initialize dio instance
        var dio = Dio();

        // Send POST request
        var response = await dio.post(
          url,
          data: data,
        );
        //
        Helper().showServerErrorDialog(
            context, "Response : ->${jsonDecode(response.data)}", () async {
          FocusScope.of(context).unfocus();
          Navigator.of(context, rootNavigator: true).pop();
          gt.Get.offAll(InvoiceScreen());
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
      });
    } catch (e) {
      Helper().showServerErrorDialog(context, "File error : ->${e}", () async {
        FocusScope.of(context).unfocus();
        Navigator.of(context, rootNavigator: true).pop();
        // gt.Get.offAll(InvoiceScreen());
      });
      Helper.getToastMsg("${e}");
      print('Error: $e');
    }
    return BaseModel();

    return baseModel;
    // return baseModel;
  }

  static Future<BaseModel?> addInvoiceData1(
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

    // Helper().showServerErrorDialog(context, "Request : ->${data.fields}",
    //     () async {
    //   FocusScope.of(context).unfocus();
    //   Navigator.of(context, rootNavigator: true).pop();

    try {
      // Initialize dio instance
      var dio = Dio();

      // Send POST request
      var response = await dio.post(
        url,
        data: data,
      );
      //
      // Helper().showServerErrorDialog(
      //     context, "Response : ->${jsonDecode(response.data)}", () async {
      //   FocusScope.of(context).unfocus();
      //   Navigator.of(context, rootNavigator: true).pop();
      // });

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
    // });
    // return BaseModel();

    return baseModel;
    // return baseModel;
  }

  static Future<UserModel> onLogin(
      String option, String mobileNo, String username, String password) async {
    UserModel model = UserModel();
    var dio = Dio();
    var data = FormData.fromMap({
      'login_option': option,
      // 'mobile_no': mobileNo, // 0 - no changes // 1 - new changes
      'mobile_no': "9359309108", // 0 - no changes // 1 - new changes
      'user_name': username,
      'password': password
    });

    var url = 'https://swastik.online/Mobile/login';
    var response = await dio.post(
      url,
      data: data,
    );

    print("LoginResponse -> ${response.data}");
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      model = UserModel.fromJson(res);
    } else {
      print(response.statusMessage);
    }
    return model;
  }

  static Future<BaseModel> onVendorSubmit(
      {required companyName,
      required conName,
      required mobile,
      required email,
      required vendorType,
      required pan,
      required gst,
      required address,
      required pincode,
      required city,
      required vendorId,
      required context}) async {
    BaseModel responseModel = BaseModel();
    var dio = Dio();
    String userName = await Auth.getUserName() ?? "";
    var data = FormData.fromMap({
      'vendor_id': vendorId,
      'vc_name': companyName,
      'v_name': conName,
      'mobile': mobile,
      'vendor_type': vendorType,
      'email': email,
      'v_gst': gst,
      'pan': pan,
      'address': address,
      'pincode': pincode,
      'vendor_city': city,
      'user_name': userName,
    });
    var url = 'https://swastik.online/Mobile/add_vendor';
    try {
      var response = await dio.post(
        url,
        data: data,
      );
      if (response.statusCode == 200) {
        var res = jsonDecode(response.data);
        responseModel = BaseModel.fromJson(res);
      }
    } catch (e) {
      Helper.getToastMsg(e.toString());
    }
    return responseModel;
  }

  static Future<BaseModel> approveInvoiceStatus(
      {required companyName,
      required conName,
      required mobile,
      required email,
      required vendorType,
      required pan,
      required gst,
      required address,
      required pincode,
      required city,
      required vendorId,
      required context}) async {
    BaseModel responseModel = BaseModel();
    var dio = Dio();
    String userName = await Auth.getUserName() ?? "";
    var data = FormData.fromMap({
      'vendor_id': vendorId,
      'vc_name': companyName,
      'v_name': conName,
      'mobile': mobile,
      'vendor_type': vendorType,
      'email': email,
      'v_gst': gst,
      'pan': pan,
      'address': address,
      'pincode': pincode,
      'vendor_city': city,
      'user_name': userName,
    });
    var url = 'https://swastik.online/Mobile/add_vendor';
    try {
      var response = await dio.post(
        url,
        data: data,
      );
      if (response.statusCode == 200) {
        var res = jsonDecode(response.data);
        responseModel = BaseModel.fromJson(res);
      }
    } catch (e) {
      Helper.getToastMsg(e.toString());
    }
    return responseModel;
  }
}
