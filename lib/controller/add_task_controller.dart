import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/model/responses/project_model.dart';

import '../config/sharedPreferences.dart';
import '../model/add_task_model.dart';
import '../model/responses/assign_user_model.dart';
import '../model/responses/base_model.dart';
import '../presentation/view/dashboard_screen.dart';
import '../repository/api_call.dart';

class AddTaskController extends GetxController {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();

  var selectedUser = UserData().obs;
  var selectProject = ProjectData().obs;
  var selectedUserList = <UserData>[].obs;
  RxBool isUILoading = false.obs;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  String vendorId = "0";
  List<String> priorityList = ["High", "Low"];
  RxString selectedPriority = "High".obs;
  String? selectedBuilding;
  String? selectedDate;
  String? fileName;

  void addTaskApi(BuildContext context) async {
    if (selectedUserList.isEmpty) {
      Helper.getToastMsg("Please select user to assign this task.");
    } else if (selectProject.value.projectname == null) {
      Helper.getToastMsg("Please select project.");
    } else if (selectedBuilding == null) {
      Helper.getToastMsg("Please select building.");
    } else {
      if (isLoading == false) {
        String userTo = selectedUserList.map((item) => item.userId).join(',');
        isLoading = true;
        EasyLoading.show(status: 'loading...');
        String userId = await Auth.getUserID() ?? "";
        AddTaskModel addTaskModel = AddTaskModel();
        addTaskModel.targetDate = dateCtrl.text;
        addTaskModel.closedDate = dateCtrl.text;
        addTaskModel.taskTitle = titleCtrl.text;
        addTaskModel.taskDesc = descCtrl.text;
        addTaskModel.assignedTo = userTo;
        addTaskModel.targetDate = dateCtrl.text;
        addTaskModel.userid = userId;
        addTaskModel.assignedBy = userId;
        addTaskModel.projectId = selectProject.value.projectcode;
        addTaskModel.buildingId = selectedBuilding;
        addTaskModel.priority = selectedPriority.value;
        addTaskModel.status = "Open";

        BaseModel response =
            (await ApiRepo.addTask(addTaskModel: addTaskModel))!;
        if (response.status == "true") {
          isLoading = false;
          Helper.getToastMsg(response.message!);
          EasyLoading.dismiss();
          Helper().showServerSuccessDialog(context, response.message!,
              () async {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
            // Navigator.pop(context);
            Get.offAll(DashBoardScreen(
              index: 4,
            ));
          });
        } else {
          isLoading = false;
          Helper.getToastMsg("Something went wrong");
          EasyLoading.dismiss();
          Helper().showServerErrorDialog(context, "Something went wrong",
              () async {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          });
        }
      }
    }
  }

  void onUserSelected(UserData? value) {
    selectedUser.value = value!;
    if (!selectedUserList.contains(value)) {
      selectedUserList.add(value);
    }
    update();
  }

  void onProjectChange(ProjectData? value) {
    selectProject.value = value!;

    update();
  }

  void onPriorityChange(String? value) {
    selectedPriority.value = value!;
  }

  void onBuildingChange(String s) {
    selectedBuilding = s;
  }

  void onRemoveUser(UserData value) {
    selectedUserList.remove(value);
    update();
  }

  Future<List<PlatformFile>?> pickFilesOthersMobile(
      {required Function(String fileName) callBack}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: [
          'xlsx',
          'csv',
          'pdf',
          'jpg',
          'png',
          'mp4',
          'avi',
          'mkv',
          'mov'
        ],
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        // setState(() {
        //   otherDocuments = result.files;
        //   isOtherdoc = true;
        // });
        callBack(file.name);
        print("file ->${file.name}");
      }
    } on PlatformException catch (e) {
      // log('Unsupported operation   $e');
    } catch (e) {
      // log(e.toString());
    }
    // return otherDocuments;
  }
}
