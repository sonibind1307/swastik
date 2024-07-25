import 'package:get/get.dart';

import '../model/responses/vendor_model.dart';
import '../repository/api_call.dart';

class TaskListController extends GetxController {
  var vendorList = <VendorData>[].obs;
  var apiVendorList = <VendorData>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getAllVendorList();
  }

  Future<void> getAllVendorList() async {
    isLoading.value = true;
    apiVendorList.value.clear();
    VendorModel vendorModel = await ApiRepo.getVendors();
    if (vendorModel.data != null) {
      apiVendorList.value = vendorModel.data!;
      vendorList.value = apiVendorList.value;
    }
    isLoading.value = false;
  }

  Future<void> onSearchVendor(String companyname) async {
    List<VendorData> filterList = [];
    filterList = apiVendorList!
        .where((data) => data.companyName!
            .toString()
            .toLowerCase()
            .contains(companyname.toLowerCase()))
        .toList();
    vendorList.value = filterList;
  }

  void dateWiseAppointments(DateTime now) async {
    // appointments.clear();
    // appointments = [];
    // String date = Helper.getSubstring(now.toString(), 0, 10);
    // await InternetConnectivityCheck.getInstance()
    //     .chkInternetConnectivity()
    //     .then((value) async {
    //   if(value!){
    //     SmartDialog.showLoading(clickMaskDismiss: true);
    //     ViewAppointmentRequest request = ViewAppointmentRequest(
    //         correlationId: Helper.getCorrelationId(),
    //         time: DateTime.now().toString(),
    //         date: date
    //     );
    //     final token =
    //     await StorageUtil.instance.getStringValue(AppStrings.strPrefAuthToken);
    //     final response = await _apiRepository.viewAppointmentsList(
    //         token: "Bearer $token", request: request);
    //     SmartDialog.dismiss();
    //     if (response is DataSuccess) {
    //       res = response.data!;
    //       if (res.success == true) {
    //         for (var hisElement in res.data!.clinics!) {
    //           for(var en in hisElement.appointments!){
    //             Appointments historyData = Appointments();
    //             historyData.appointDate = res.data!.appointmentDate.toString();
    //             historyData.clinicName = hisElement.clinicName;
    //             historyData.clinicId = hisElement.clinicId;
    //             historyData.doctorUserId = en.doctorUserId;
    //             historyData.doctorName = en.doctorName;
    //             historyData.doctorSpecialization = en.doctorSpecialization;
    //             historyData.patientDbId = en.patientDbId;
    //             historyData.patientFullName = en.patientFullName;
    //             historyData.patientAge = en.patientAge;
    //             historyData.patientGender = en.patientGender;
    //             historyData.slotStartTime = en.slotStartTime;
    //             historyData.slotEndTime = en.slotEndTime;
    //             historyData.isAccepted = en.isAccepted;
    //             historyData.appointmentId = en.appointmentId;
    //             historyData.pid = en.pid;
    //             historyData.endTime = Helper.isPastTime(en.slotEndTime.toString(), today);
    //             appointments.add(historyData);
    //           }
    //         }
    //
    //         if(appointments.isNotEmpty){
    //           emit(ApiSuccessState(appointments));
    //         }else{
    //           emit(ApiFailState("No appointments found"));
    //         }
    //
    //       } else {
    //         emit(ApiFailState(res.message.toString()));
    //       }
    //     } else if (response is DataFailed) {
    //       String error = response.error!.response!.data['message'].toString();
    //       emit(ApiFailState(error));
    //     }
    //   }else{
    //     emit(NoInternetState(AppStrings.noInternetMsg));
    //   }
    // });
  }
}
