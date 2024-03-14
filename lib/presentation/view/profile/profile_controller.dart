import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../config/Helper.dart';
import '../../../config/sharedPreferences.dart';
import '../../../model/responses/base_model.dart';
import '../../../model/responses/project_model.dart';
import '../../../repository/api_call.dart';

class ProfileController extends GetxController {
  bool isPhoto = false;
  RxBool isLoading = false.obs;
  RxList<String> selectedCheckBoxList = <String>[].obs;
  var allProjectList = <ProjectData>[].obs;
  var myProjectList = <ProjectData>[].obs;
  RxString userName = "NA".obs;
  RxString email = "NA".obs;
  RxString name = "NA".obs;
  RxString phone = "NA".obs;
  RxString designation = "NA".obs;
  RxBool isOpen = false.obs;

  // bool isLoading = false;

  Future<void> getAllProject() async {
    ProjectModel projectModel = await ApiRepo.getProjectList(userId: '0');
    allProjectList.value = projectModel.data!;
    update();
  }

  Future<void> myProjectLsi() async {
    String? userId = await Auth.getUserID();
    ProjectModel projectModel = await ApiRepo.getProjectList(userId: userId!);
    myProjectList.value = projectModel.data!;
    update();
  }

  void init() async {
    isLoading.value = true;
    userName.value = await Auth.getUserName() ?? "NA";
    phone.value = await Auth.getMobileNo() ?? "NA";
    email.value = await Auth.getEmail() ?? "NA";
    name.value = await Auth.getName() ?? "NA";
    designation.value = await Auth.getDesignation() ?? "NA";
    isLoading.value = false;
  }

  Future<void> onUpdateProfile(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    String projectIDs =
        myProjectList.map((model) => model.projectcode).join(', ');
    BaseModel response = await ApiRepo.updateProject(assignProject: projectIDs);
    if (response.status == "true") {
      Helper.getToastMsg(response.message!);
      EasyLoading.dismiss();
      Helper().showServerSuccessDialog(context, response.message!, () async {
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

  void onExpansionChanged() {
    if (isOpen.value == true) {
      isOpen.value = false;
    } else {
      isOpen.value = true;
    }
    update();
  }
}
