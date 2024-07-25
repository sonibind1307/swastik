import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../config/Helper.dart';
import '../config/sharedPreferences.dart';
import '../model/responses/base_model.dart';
import '../model/responses/challan_model.dart';
import '../model/responses/project_model.dart';
import '../repository/api_call.dart';

class ChallanListController extends GetxController {
  var challanList = <ChallanData>[].obs;
  var apiChallanList = <ChallanData>[].obs;
  var projectList = <ProjectData>[].obs;
  var selectedProject = ProjectData().obs;
  RxBool isLoading = false.obs;
  RxString selectedStatus = "PENDING".obs;
  String projectId = "";

  @override
  void onInit() {
    getAllChalanList();
    onGetProject();
  }

  Future<void> getAllChalanList() async {
    isLoading.value = true;
    apiChallanList.value.clear();
    ChallanModel vendorModel = await ApiRepo.getChallans();
    if (vendorModel.data != null) {
      challanList.value = vendorModel.data!;
      apiChallanList.value = vendorModel.data!;
      chipChoiceCardSelected(selectedStatus.value);
    }
    isLoading.value = false;
  }

  Future<void> onSearchVendor(String companyName) async {
    List<ChallanData> filterList = [];
    if (projectId == "") {
      projectId = "0";
    }
    if (selectedStatus.value == "0" && projectId == "0") {
      filterList = apiChallanList
          .where((data) => data.companyname!
              .toString()
              .toLowerCase()
              .contains(companyName.toLowerCase()))
          .toList();
      challanList.value = filterList;
    } else {
      filterList = apiChallanList
          .where((data) =>
              data.chlStatus!
                  .toString()
                  .toLowerCase()
                  .contains(selectedStatus.toLowerCase()) &&
              data.projectId!
                  .toString()
                  .toLowerCase()
                  .contains(projectId.toLowerCase()) &&
              (data.companyname!
                      .toString()
                      .toLowerCase()
                      .contains(companyName.toLowerCase()) ||
                  data.projectname!
                      .toString()
                      .toLowerCase()
                      .contains(companyName.toLowerCase()) ||
                  data.grade!
                      .toString()
                      .toLowerCase()
                      .contains(companyName.toLowerCase()) ||
                  data.challanNo!
                      .toString()
                      .toLowerCase()
                      .contains(companyName.toLowerCase()) ||
                  data.vehicleNo!
                      .toString()
                      .toLowerCase()
                      .contains(companyName.toLowerCase())))
          .toList();
      challanList.value = filterList;
    }
  }

  Future<void> onGetProject() async {
    String userId = await Auth.getUserID() ?? "0";
    ProjectModel projectModel = await ApiRepo.getProjectList(userId: userId);
    projectList.value = projectModel.data!;
    update();
  }

  void getProjectSelected() {
    List<ChallanData> filterList = [];
    print("selectedStatus : $selectedStatus");
    print("projectId : $projectId");

    if (projectId == "" || projectId == "0") {
      if (selectedStatus.value == "0") {
        filterList = apiChallanList;
        challanList.value = filterList;
      } else {
        filterList = apiChallanList
            .where((data) => data.chlStatus!
                .toString()
                .toLowerCase()
                .contains(selectedStatus.toLowerCase()))
            .toList();
        challanList.value = filterList;
      }
    } else {
      if (selectedStatus.value == "0") {
        filterList = apiChallanList
            .where((data) => data.projectId!
                .toString()
                .toLowerCase()
                .contains(projectId.toLowerCase()))
            .toList();
        challanList.value = filterList;
      } else {
        filterList = apiChallanList
            .where((data) =>
                data.chlStatus!
                    .toString()
                    .toLowerCase()
                    .contains(selectedStatus.toLowerCase()) &&
                data.projectId!
                    .toString()
                    .toLowerCase()
                    .contains(projectId.toLowerCase()))
            .toList();
        challanList.value = filterList;
      }
    }
  }

  void chipChoiceCardSelected(String choiceChip) {
    print("choiceChip ${choiceChip}");
    // return;
    selectedStatus.value = choiceChip;
    List<ChallanData> filterList = [];
    if (choiceChip == "0") {
      filterList = apiChallanList
          .where((data) => data.projectId!
              .toString()
              .toLowerCase()
              .contains(projectId.toLowerCase()))
          .toList();
      challanList.value = filterList;
    } else {
      if (projectId == "") {
        filterList = apiChallanList
            .where((data) => data.chlStatus!
                .toString()
                .toLowerCase()
                .contains(choiceChip.toLowerCase()))
            .toList();
        challanList.value = filterList;
      } else {
        filterList = apiChallanList
            .where((data) =>
                data.chlStatus!
                    .toString()
                    .toLowerCase()
                    .contains(choiceChip.toLowerCase()) &&
                data.projectId!
                    .toString()
                    .toLowerCase()
                    .contains(projectId.toLowerCase()))
            .toList();
        challanList.value = filterList;
      }
    }
  }

  void clear() {
    // controller.onGetProject();
  }

  Future<void> onUpdateChallan(BuildContext context,
      {required String challanStatus, required String challanID}) async {
    EasyLoading.show(status: 'loading...');
    print("challanID - > $challanID");

    BaseModel response = await ApiRepo.updateChallan(
        challanStatus: challanStatus, challanID: challanID);
    if (response.status == "true") {
      Helper.getToastMsg(response.message!);
      EasyLoading.dismiss();
      Helper().showServerSuccessDialog(context, response.message!, () async {
        getAllChalanList();
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      Helper.getToastMsg("Something went wrong");
      EasyLoading.dismiss();
      Helper().showServerErrorDialog(context, "Something went wrong", () async {
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
      });
    }
  }
}
