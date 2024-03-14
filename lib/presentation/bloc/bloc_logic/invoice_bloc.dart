import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/config/sharedPreferences.dart';
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
    String? userId = await Auth.getUserID();
    var dio = Dio();
    var data = FormData.fromMap({
      'session_user_id': userId,
    });

    var url = 'https://swastik.online/Mobile/get_projects';
    var response = await dio.post(
      url,
      data: data,
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
    if (choiceChip == "0") {
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
    if (listInvoice.data != null) {
      filterInvoice.data = listInvoice.data!
          .where((data) => data.vendorCmpny!
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    }
    emit(LoadedState(listProject, filterInvoice));
  }

  Future<void> getInvoiceList() async {
    emit(LoadingState());

    String? userId = await Auth.getUserID();
    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_invoice_list/$userId',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      listInvoice = InvoiceModel.fromJson(res);
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

var bloc = InvoiceBloc();
