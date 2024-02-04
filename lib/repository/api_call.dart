import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:swastik/model/responses/build_model.dart';
import 'package:swastik/model/responses/invoice_item_model.dart';

import '../model/responses/all_invoice_items.dart';
import '../model/responses/category_model.dart';
import '../model/responses/project_model.dart';
import '../model/responses/vendor_model.dart';

class ApiRepo {
  static Future<ProjectModel> getProjectList() async {
    String response1 =
        '{"status":"true","message":"Data loaded","data":[{"companyid":"cmpny_003","companyname":"Suvasya Builders & Developers Llp","gst":"27ADNFS4515N1ZG","pan":"ADNFS4515N","tan":"MUMS93458B","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Pearl","projectcode":"p_006","buildingcode":"b_012","nameofbuilding":"Main","proj_build_name":"Swastik Pearl - Main","site_address":"Building No. 08, Swastik Pearl, Vikhroli"},{"companyid":"cmpny_004","companyname":"Swastik Developers","gst":"27ABGFS9045Q1ZA","pan":"ABGFS9045Q","tan":"MUMS53969G","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Signature Business Park","projectcode":"p_009","buildingcode":"b_013","nameofbuilding":"Main","proj_build_name":"Signature Business Park - Main","site_address":"NA"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Emerald","projectcode":"p_002","buildingcode":"b_015","nameofbuilding":"Main","proj_build_name":"Swastik Emerald - Main","site_address":"NA"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Sapphire","projectcode":"p_008","buildingcode":"b_016","nameofbuilding":"Main","proj_build_name":"Swastik Sapphire - Main","site_address":"NA"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Elegance","projectcode":"p_010","buildingcode":"b_017","nameofbuilding":"Main","proj_build_name":"Swastik Elegance - Main","site_address":"Swastik Elegance - Chembur"},{"companyid":"cmpny_003","companyname":"Suvasya Builders & Developers Llp","gst":"27ADNFS4515N1ZG","pan":"ADNFS4515N","tan":"MUMS93458B","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Platinum","projectcode":"p_011","buildingcode":"b_018","nameofbuilding":"Main","proj_build_name":"Swastik Platinum - Main","site_address":"Building No. 43,44,45, Swastik Platinum, Vikhroli"},{"companyid":"cmpny_003","companyname":"Suvasya Builders & Developers Llp","gst":"27ADNFS4515N1ZG","pan":"ADNFS4515N","tan":"MUMS93458B","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Onyx","projectcode":"p_015","buildingcode":"b_021","nameofbuilding":"Main","proj_build_name":"Swastik Onyx - Main","site_address":"Building No. 09, Swastik Pearl, Vikhroli"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Sanghani","projectcode":"p_012","buildingcode":"b_022","nameofbuilding":"Sale","proj_build_name":"Swastik Sanghani - Sale","site_address":"Swastik Sanghani, Ghatkopar"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Sanghani","projectcode":"p_012","buildingcode":"b_023","nameofbuilding":"Rehab","proj_build_name":"Swastik Sanghani - Rehab","site_address":"Swastik Sanghani, Ghatkopar"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Divine","projectcode":"p_013","buildingcode":"b_028","nameofbuilding":"Main","proj_build_name":"Swastik Divine - Main","site_address":"NA"},{"companyid":"cmpny_006","companyname":"Shiv Mangal Developers","gst":"27ABXFS0135L1ZG","pan":"ABXFS0135L","tan":"MUMS12345X","address":"2nd Floor","projectname":"Abhilash","projectcode":"p_018","buildingcode":"b_029","nameofbuilding":"Abhilash","proj_build_name":"Abhilash - Abhilash","site_address":"NA"},{"companyid":"cmpny_005","companyname":"Swastik Homes","gst":"27ADYFS4233L1ZF","pan":"ADYFS4233L","tan":"MUMS10522I","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Tulip","projectcode":"p_016","buildingcode":"b_030","nameofbuilding":"Main","proj_build_name":"Swastik Tulip - Main","site_address":"NA"},{"companyid":"cmpny_007","companyname":"Sanjona Builders","gst":"27AAAFS3232Q1ZX","pan":"AAAFS3232Q","tan":"MUMS17114G","address":"Sanjona Complex, Plot No. 11-A, Hemu Kalani Marg, Sindhi Society, Chembur, Mumbai, Suburban Mumbai.","projectname":"Abhilash","projectcode":"p_019","buildingcode":"b_037","nameofbuilding":"Main","proj_build_name":"Abhilash - Main","site_address":"NA"},{"companyid":"cmpny_005","companyname":"Swastik Homes","gst":"27ADYFS4233L1ZF","pan":"ADYFS4233L","tan":"MUMS10522I","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Coral","projectcode":"p_017","buildingcode":"b_039","nameofbuilding":"Main","proj_build_name":"Swastik Coral - Main","site_address":"NA"},{"companyid":"cmpny_003","companyname":"Suvasya Builders & Developers Llp","gst":"27ADNFS4515N1ZG","pan":"ADNFS4515N","tan":"MUMS93458B","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Iris","projectcode":"p_020","buildingcode":"b_040","nameofbuilding":"Main","proj_build_name":"Swastik Iris - Main","site_address":"NA"},{"companyid":"cmpny_008","companyname":"Swastik Manthan Jv","gst":"27AAWAS6092D1ZW","pan":"AAWAS6092D","tan":"MUMS95492F","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Manthan Galaxy","projectcode":"p_021","buildingcode":"b_041","nameofbuilding":"Main","proj_build_name":"Manthan Galaxy - Main","site_address":"NA"}]}';
    var res = jsonDecode(response1);

    return ProjectModel.fromJson(res);

    /* var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_projects',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);

      listProject = ProjectModel.fromJson(res);
      emit(LoadedState(listProject, listInvoice));
    } else {
      print(response.statusMessage);
    }*/
  }

  static Future<VendorModel> getVendors() async {
    VendorModel vendorModel = VendorModel();
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

  static Future<InvoiceItemModel> getInvoiceItem() async {
    InvoiceItemModel invoiceItemModel = InvoiceItemModel();
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_invoice/9774',
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      invoiceItemModel = InvoiceItemModel.fromJson(res);
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





}
