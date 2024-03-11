import 'package:get/get.dart';

import '../../../config/sharedPreferences.dart';
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

  Future<void> getAllProject() async {
    ProjectModel projectModel = await ApiRepo.getProjectList(userId: '92');
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
}
