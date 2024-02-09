import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastik/presentation/bloc/state/invoice_state.dart';

import '../../../model/responses/invoice_model.dart';
import '../../../model/responses/project_model.dart';

class InvoiceBloc extends Cubit<InvoiceState> {
  InvoiceBloc() : super(InitialState()) {
    getProjectList();
    getInvoiceList();
  }

  ProjectModel listProject = ProjectModel();
  InvoiceModel listInvoice = InvoiceModel();

  Future<void> getProjectList() async {
    emit(LoadingState());
/*    String response1 =
        '{"status":"true","message":"Data loaded","data":[{"companyid":"cmpny_003","companyname":"Suvasya Builders & Developers Llp","gst":"27ADNFS4515N1ZG","pan":"ADNFS4515N","tan":"MUMS93458B","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Pearl","projectcode":"p_006","buildingcode":"b_012","nameofbuilding":"Main","proj_build_name":"Swastik Pearl - Main","site_address":"Building No. 08, Swastik Pearl, Vikhroli"},{"companyid":"cmpny_004","companyname":"Swastik Developers","gst":"27ABGFS9045Q1ZA","pan":"ABGFS9045Q","tan":"MUMS53969G","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Signature Business Park","projectcode":"p_009","buildingcode":"b_013","nameofbuilding":"Main","proj_build_name":"Signature Business Park - Main","site_address":"NA"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Emerald","projectcode":"p_002","buildingcode":"b_015","nameofbuilding":"Main","proj_build_name":"Swastik Emerald - Main","site_address":"NA"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Sapphire","projectcode":"p_008","buildingcode":"b_016","nameofbuilding":"Main","proj_build_name":"Swastik Sapphire - Main","site_address":"NA"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Elegance","projectcode":"p_010","buildingcode":"b_017","nameofbuilding":"Main","proj_build_name":"Swastik Elegance - Main","site_address":"Swastik Elegance - Chembur"},{"companyid":"cmpny_003","companyname":"Suvasya Builders & Developers Llp","gst":"27ADNFS4515N1ZG","pan":"ADNFS4515N","tan":"MUMS93458B","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Platinum","projectcode":"p_011","buildingcode":"b_018","nameofbuilding":"Main","proj_build_name":"Swastik Platinum - Main","site_address":"Building No. 43,44,45, Swastik Platinum, Vikhroli"},{"companyid":"cmpny_003","companyname":"Suvasya Builders & Developers Llp","gst":"27ADNFS4515N1ZG","pan":"ADNFS4515N","tan":"MUMS93458B","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Onyx","projectcode":"p_015","buildingcode":"b_021","nameofbuilding":"Main","proj_build_name":"Swastik Onyx - Main","site_address":"Building No. 09, Swastik Pearl, Vikhroli"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Sanghani","projectcode":"p_012","buildingcode":"b_022","nameofbuilding":"Sale","proj_build_name":"Swastik Sanghani - Sale","site_address":"Swastik Sanghani, Ghatkopar"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Sanghani","projectcode":"p_012","buildingcode":"b_023","nameofbuilding":"Rehab","proj_build_name":"Swastik Sanghani - Rehab","site_address":"Swastik Sanghani, Ghatkopar"},{"companyid":"cmpny_002","companyname":"Swastik Realtors","gst":"27ABAFS2576A1ZF","pan":"ABAFS2576A","tan":"MUMS44852D","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Divine","projectcode":"p_013","buildingcode":"b_028","nameofbuilding":"Main","proj_build_name":"Swastik Divine - Main","site_address":"NA"},{"companyid":"cmpny_006","companyname":"Shiv Mangal Developers","gst":"27ABXFS0135L1ZG","pan":"ABXFS0135L","tan":"MUMS12345X","address":"2nd Floor","projectname":"Abhilash","projectcode":"p_018","buildingcode":"b_029","nameofbuilding":"Abhilash","proj_build_name":"Abhilash - Abhilash","site_address":"NA"},{"companyid":"cmpny_005","companyname":"Swastik Homes","gst":"27ADYFS4233L1ZF","pan":"ADYFS4233L","tan":"MUMS10522I","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Tulip","projectcode":"p_016","buildingcode":"b_030","nameofbuilding":"Main","proj_build_name":"Swastik Tulip - Main","site_address":"NA"},{"companyid":"cmpny_007","companyname":"Sanjona Builders","gst":"27AAAFS3232Q1ZX","pan":"AAAFS3232Q","tan":"MUMS17114G","address":"Sanjona Complex, Plot No. 11-A, Hemu Kalani Marg, Sindhi Society, Chembur, Mumbai, Suburban Mumbai.","projectname":"Abhilash","projectcode":"p_019","buildingcode":"b_037","nameofbuilding":"Main","proj_build_name":"Abhilash - Main","site_address":"NA"},{"companyid":"cmpny_005","companyname":"Swastik Homes","gst":"27ADYFS4233L1ZF","pan":"ADYFS4233L","tan":"MUMS10522I","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Coral","projectcode":"p_017","buildingcode":"b_039","nameofbuilding":"Main","proj_build_name":"Swastik Coral - Main","site_address":"NA"},{"companyid":"cmpny_003","companyname":"Suvasya Builders & Developers Llp","gst":"27ADNFS4515N1ZG","pan":"ADNFS4515N","tan":"MUMS93458B","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Swastik Iris","projectcode":"p_020","buildingcode":"b_040","nameofbuilding":"Main","proj_build_name":"Swastik Iris - Main","site_address":"NA"},{"companyid":"cmpny_008","companyname":"Swastik Manthan Jv","gst":"27AAWAS6092D1ZW","pan":"AAWAS6092D","tan":"MUMS95492F","address":"312, Swastik Disa Corporate Park, Lbs Road, Ghatkopar West, Mumbai - 400086","projectname":"Manthan Galaxy","projectcode":"p_021","buildingcode":"b_041","nameofbuilding":"Main","proj_build_name":"Manthan Galaxy - Main","site_address":"NA"}]}';
    var res = jsonDecode(response1);

    listProject = ProjectModel.fromJson(res);
    emit(LoadedState(listProject, listInvoice));
    return;*/

    var dio = Dio();
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
    }

    // var response = _apiRepository.getProjectList();
    //
    // if (response is DataSuccess) {
    //   Helper.getToastMsg("API success");
    //
    //
    //   // postsCat = List<CategoryModel>.from(
    //   //     res.map((model) => CategoryModel.fromJson(model)));
    //   //
    //   //
    //   // List<ProjectModel> projectList = response as List<ProjectModel>;
    //   // Helper.getToastMsg(projectList.length.toString());
    // } else if (response is DataFailed) {
    //   Helper.getToastMsg("API failed");
    // }
  }

  void getProjectSelected(String projectName) {
    listProject.data!.forEach((element) {
      if (element.projectname == projectName) {
        print("projectCode :${element.projectcode}");
        InvoiceModel filterInvoice = InvoiceModel();
        filterInvoice.data = listInvoice.data!
            .where((data) => data.poId!
                .toString()
                .toLowerCase()
                .contains(element.projectcode!.toLowerCase()))
            .toList();
        emit(LoadedState(listProject, filterInvoice));
      }
    });
  }

  void chipChoiceCardSelected(String choiceChip) {
    InvoiceModel filterInvoice = InvoiceModel();
    emit(LoadedState(listProject, filterInvoice));

    if (choiceChip == "0") {
      filterInvoice.data = listInvoice.data!;
    } else {
      filterInvoice.data = listInvoice.data!
          .where((data) => data.invoiceStatus!
              .toString()
              .toLowerCase()
              .contains(choiceChip.toLowerCase()))
          .toList();
    }
    emit(LoadedState(listProject, filterInvoice));
  }

  void onSearchInvoice(String value) {
    InvoiceModel filterInvoice = InvoiceModel();
    emit(LoadedState(listProject, filterInvoice));
    filterInvoice.data = listInvoice.data!
        .where((data) => data.projectname!
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();

    emit(LoadedState(listProject, filterInvoice));
  }

  Future<void> getInvoiceList() async {
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_invoice_list/92',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      // var res = jsonDecode(
      //     '{ "status": "true", "message": "Data loaded", "data": [ { "invoice_id": "9675", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Onyx", "totalamount": "35000.00", "cmp_id": "cmpny_003", "prj_id": "p_015", "build_id": "b_021", "invoice_no": "9537", "invref": "1162301976", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "1", "invoice_status": "REJECTED", "udpated_Date": "2024-01-25 18:13:39", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:55:32", "step2": "23,0,NA,2024-01-25 18:13:39", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX INDIA PVT LTD - ONYX", "po_id": "49", "approved_Date": "25-01-2024 06:13 PM", "ledgerid": "ldgr_4496", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9673", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9535", "invref": "1162301978", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "2", "invoice_status": "PENDING", "udpated_Date": "2024-01-25 17:38:37", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:32:38", "step2": "23,0,NA,2024-01-25 17:38:37", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 05:38 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9672", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9534", "invref": "1162301979", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "1", "invoice_status": "APPROVED", "udpated_Date": "2024-01-25 17:37:09", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:29:08", "step2": "23,0,NA,2024-01-25 17:37:09", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 05:37 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9671", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9533", "invref": "1162301980", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "3", "invoice_status": "PENDING", "udpated_Date": "2024-01-25 16:49:25", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:28:21", "step2": "23,0,NA,2024-01-25 16:49:25", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:49 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9670", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9532", "invref": "1162301981", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "3", "invoice_status": "REJECTED", "udpated_Date": "2024-01-25 16:27:58", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:27:38", "step2": "23,0,NA,2024-01-25 16:27:58", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:27 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9669", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9531", "invref": "1162301982", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "4", "invoice_status": "Assigned", "udpated_Date": "2024-01-25 16:27:07", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:26:36", "step2": "23,0,NA,2024-01-25 16:27:07", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:27 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9668", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9530", "invref": "1162301983", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "4", "invoice_status": "APPROVED", "udpated_Date": "2024-01-25 16:26:27", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:25:34", "step2": "23,0,NA,2024-01-25 16:26:27", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:26 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9667", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "142201.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9529", "invref": "1162301984", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "3", "invoice_status": "APPROVED", "udpated_Date": "2024-01-25 16:25:41", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:21:21", "step2": "23,0,NA,2024-01-25 16:25:41", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:25 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9666", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "142201.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9528", "invref": "1162301985", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "2", "invoice_status": "APPROVED", "udpated_Date": "2024-01-25 16:24:23", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:18:06", "step2": "23,0,NA,2024-01-25 16:24:23", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:24 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" } ] }');
      listInvoice = InvoiceModel.fromJson(res);
      print("soni: $res");
      emit(LoadedState(listProject, listInvoice));
    } else {
      print(response.statusMessage);
    }
  }
}
