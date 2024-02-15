import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/presentation/bloc/state/invoice_state.dart';

import '../../../model/responses/base_model.dart';
import '../../../model/responses/invoice_model.dart';
import '../../../model/responses/project_model.dart';
import '../../../repository/api_call.dart';

class InvoiceBloc extends Cubit<InvoiceState> {
  InvoiceBloc() : super(InitialState()) {
    getProjectList();
    getInvoiceList();
  }

  List<ProjectData> listProject = [];
  InvoiceModel listInvoice = InvoiceModel();
  String projectId = "";

  Future<void> getProjectList() async {
    ProjectData projectData = ProjectData();
    projectData.projectname = "All";
    projectData.projectcode = "";
    listProject.add(projectData);

    emit(LoadingState());
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_projects',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);

      ProjectModel projectModel = ProjectModel.fromJson(res);

      listProject.addAll(projectModel.data!);

      emit(LoadedState(listProject, listInvoice));
    } else {
      print(response.statusMessage);
    }
  }

  void getProjectSelected(String projectName) {
    for (var element in listProject) {
      if (element.projectname == projectName) {
        projectId = element.projectcode!;
      }
    }
    // print("projectCode :${projectId}");
    InvoiceModel filterInvoice = InvoiceModel();
    filterInvoice.data = listInvoice.data!
        .where((data) => data.prjId!
            .toString()
            .toLowerCase()
            .contains(projectId.toLowerCase()))
        .toList();
    emit(LoadedState(listProject, filterInvoice));
  }

  void chipChoiceCardSelected(String choiceChip) {
    InvoiceModel filterInvoice = InvoiceModel();
    emit(LoadedState(listProject, filterInvoice));

    print("${projectId}");
    if (choiceChip == "0") {
      // filterInvoice.data = listInvoice.data!;
      filterInvoice.data = listInvoice.data!
          .where((data) => data.prjId!
              .toString()
              .toLowerCase()
              .contains(projectId.toLowerCase()))
          .toList();
    } else {
      if (projectId == "") {
        filterInvoice.data = listInvoice.data!
            .where((data) => data.invoiceStatus!
                .toString()
                .toLowerCase()
                .contains(choiceChip.toLowerCase()))
            .toList();
      } else {
        filterInvoice.data = listInvoice.data!
            .where((data) =>
                data.invoiceStatus!
                    .toString()
                    .toLowerCase()
                    .contains(choiceChip.toLowerCase()) &&
                data.prjId!
                    .toString()
                    .toLowerCase()
                    .contains(projectId.toLowerCase()))
            .toList();
      }
    }

    emit(LoadedState(listProject, filterInvoice));
  }

  void onSearchInvoice(String value) {
    InvoiceModel filterInvoice = InvoiceModel();
    emit(LoadedState(listProject, filterInvoice));
    filterInvoice.data = listInvoice.data!
        .where((data) => data.vendorCmpny!
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();

    emit(LoadedState(listProject, filterInvoice));
  }

  Future<void> getInvoiceList() async {
    emit(LoadingState());
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_invoice_list/92',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      // print("listInvoice: ${response.data}");
      var res = jsonDecode(response.data);
      // var res = jsonDecode(
      //     '{ "status": "true", "message": "Data loaded", "data": [ { "invoice_id": "9675", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Onyx", "totalamount": "35000.00", "cmp_id": "cmpny_003", "prj_id": "p_015", "build_id": "b_021", "invoice_no": "9537", "invref": "1162301976", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "1", "invoice_status": "REJECTED", "udpated_Date": "2024-01-25 18:13:39", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:55:32", "step2": "23,0,NA,2024-01-25 18:13:39", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX INDIA PVT LTD - ONYX", "po_id": "49", "approved_Date": "25-01-2024 06:13 PM", "ledgerid": "ldgr_4496", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9673", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9535", "invref": "1162301978", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "2", "invoice_status": "PENDING", "udpated_Date": "2024-01-25 17:38:37", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:32:38", "step2": "23,0,NA,2024-01-25 17:38:37", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 05:38 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9672", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9534", "invref": "1162301979", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "1", "invoice_status": "APPROVED", "udpated_Date": "2024-01-25 17:37:09", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:29:08", "step2": "23,0,NA,2024-01-25 17:37:09", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 05:37 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9671", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9533", "invref": "1162301980", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "3", "invoice_status": "PENDING", "udpated_Date": "2024-01-25 16:49:25", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:28:21", "step2": "23,0,NA,2024-01-25 16:49:25", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:49 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9670", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9532", "invref": "1162301981", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "3", "invoice_status": "REJECTED", "udpated_Date": "2024-01-25 16:27:58", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:27:38", "step2": "23,0,NA,2024-01-25 16:27:58", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:27 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9669", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9531", "invref": "1162301982", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "4", "invoice_status": "Assigned", "udpated_Date": "2024-01-25 16:27:07", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:26:36", "step2": "23,0,NA,2024-01-25 16:27:07", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:27 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9668", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "189600.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9530", "invref": "1162301983", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "4", "invoice_status": "APPROVED", "udpated_Date": "2024-01-25 16:26:27", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:25:34", "step2": "23,0,NA,2024-01-25 16:26:27", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:26 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9667", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "142201.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9529", "invref": "1162301984", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "3", "invoice_status": "APPROVED", "udpated_Date": "2024-01-25 16:25:41", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:21:21", "step2": "23,0,NA,2024-01-25 16:25:41", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:25 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" }, { "invoice_id": "9666", "invstatus": "3", "inv_date": "18-01-2024", "invcomments": "Na", "projectname": "Swastik Coral", "totalamount": "142201.00", "cmp_id": "cmpny_005", "prj_id": "p_017", "build_id": "b_039", "invoice_no": "9528", "invref": "1162301985", "vendor_cmpny": "Tna Readymix India Pvt Ltd", "invcat": "Rmc Material", "inv_status": "1", "status": "2", "invoice_status": "APPROVED", "udpated_Date": "2024-01-25 16:24:23", "updated_for": "23", "re_vefify": "0", "step1": "74,0,NA,2024-01-24 16:18:06", "step2": "23,0,NA,2024-01-25 16:24:23", "step3": "0,0,NA,0000-00-00", "reassign": 1, "added_by": "vinashree.p", "ledgername": "TNA READYMIX (INDIA) PVT LTD - CORAL", "po_id": "0", "approved_Date": "25-01-2024 04:24 PM", "ledgerid": "ldgr_5478", "user1": "Shailesh mahtre", "days_diff": 11, "current_user_id": "23" } ] }');
      listInvoice = InvoiceModel.fromJson(res);
      // print("listInvoice: $res");
      emit(LoadedState(listProject, listInvoice));
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> deleteInvoice(String invoiceId) async {
    BaseModel data = await ApiRepo.deleteInvoice(invoiceId);
    if (data.status == "true") {
      Helper.getToastMsg(data.message ?? "Invoice deleted");

      getInvoiceList();
    } else {
      Helper.getToastMsg(data.message ?? "Try Again");
    }
  }
}
