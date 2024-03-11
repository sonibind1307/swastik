import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastik/model/responses/project_model.dart';
import 'package:swastik/model/responses/vendor_model.dart';
import 'package:swastik/presentation/bloc/state/add_invoice_state.dart';
import 'package:swastik/repository/api_call.dart';

import '../../../config/sharedPreferences.dart';

class AddInvoiceBloc extends Cubit<AddInvoiceState> {
  AddInvoiceBloc() : super(InitialState()) {
    getAllVendor();
  }

  VendorModel listVendor = VendorModel();

  Future<void> getAllVendor() async {
    emit(LoadingState());

    var dio = Dio();
    var response = await dio.request(
      'https://swastik.online/Mobile/get_all_vendors',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);

      listVendor = VendorModel.fromJson(res);
      emit(LoadedVendorState(listVendor));
    } else {
      emit(ErrorState(""));
      print(response.statusMessage);
    }
  }

  onVendorSelection(VendorData vendorData) {
    emit(VendorSelectedState(vendorData));
  }

  onNextSelection() async {
    String userId = await Auth.getUserID() ?? "0";
    ProjectModel projectModel = await ApiRepo.getProjectList(userId: userId);
    emit(SecondVendorState(projectModel));
  }
}
