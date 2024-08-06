import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/responses/task_list_model.dart';
import '../repository/api_call.dart';

class TaskListController extends GetxController {
  var taskList = <TaskData>[].obs;
  var apiTaskList = <TaskData>[].obs;
  RxBool isLoading = false.obs;
  RxBool isCalendar = true.obs;
  DateTime focusedDay = DateTime.now();

  @override
  void onInit() {
    getAllVendorList(DateTime.now());
  }

  Future<void> getAllVendorList(DateTime? selectedDay) async {
    print("date ---------------> ${selectedDay!.month}");
    print("date ---------------> ${selectedDay!.year}");
    isLoading.value = true;
    apiTaskList.value.clear();
    TaskListModel vendorModel = await ApiRepo.getAllTask(
        selectedDay.month.toString(), selectedDay.year.toString());
    if (vendorModel.data != null) {
      apiTaskList.value = vendorModel.data!;
      taskList.value = apiTaskList.value;
    }
    isLoading.value = false;
    getTaskBasedOnDate(focusedDay);
  }

  Future<void> onSearchVendor(String searchKey) async {
    List<TaskData> filterList = [];
    filterList = apiTaskList!
        .where((data) => data.taskTitle!
            .toString()
            .toLowerCase()
            .contains(searchKey.toLowerCase()))
        .toList();
    taskList.value = filterList;
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

  void getTaskBasedOnDate(DateTime focusedDay) {
    print("selectedDate ---------------> ${focusedDay}");
    isCalendar.value = false;
    isLoading.value = true;
    List<TaskData> filterList = [];
    filterList = apiTaskList
        .where((data) => data.targetDate
            .toString()
            .toLowerCase()
            .contains(focusedDay.toString().substring(0, 10).toLowerCase()))
        .toList();
    taskList.value = filterList;

    isLoading.value = false;
    isCalendar.value = true;
    update();
  }

  List<Event> getEventsForDay(DateTime day) {
    Map<DateTime, List<String>> _selectedEvents = {
      DateTime.utc(2023, 7, 29): [
        'Event 1',
        'Event 2',
        'Event 3',
        'Event 4',
        'Event 5'
      ],
      // Add more events here
    };

    List<Event> events = [];

    List<TaskData> filterList = [];
    filterList = apiTaskList!
        .where((data) => data.targetDate
            .toString()
            .toLowerCase()
            .contains(day.toString().substring(0, 10).toLowerCase()))
        .toList();

    for (var element in filterList) {
      events.add(Event(element.taskTitle!,
          getTaskCardColor(element.priority!, element.status!)));
    }
    return events;
  }

  Color getTaskCardColor(String priority, String status) {
    print("priority - > $priority status -> $status");
    if (status == "Open") {
      if (priority == "High") {
        return Colors.red;
      } else {
        return Colors.blue;
      }
    } else {
      return Colors.grey;
    }
  }
}

class Event {
  final String title;
  final Color color;

  const Event(this.title, this.color);

  @override
  String toString() => title;
}
