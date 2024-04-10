import 'package:get/get.dart';

import '../config/sharedPreferences.dart';
import '../model/responses/invoice_model.dart';
import '../model/responses/project_model.dart';
import '../repository/api_call.dart';

class InvoiceListController extends GetxController {
  var invoiceList = <InvoiceData>[].obs;
  var apiInvoiceList = <InvoiceData>[].obs;
  var projectList = <ProjectData>[].obs;
  var selectedProject = ProjectData().obs;
  RxBool isLoading = false.obs;
  RxString selectedStatus = "PENDING".obs;
  String projectId = "";

  @override
  void onInit() {
    getAllInvoiceList();
    onGetProject();
  }

  Future<void> getAllInvoiceList() async {
    isLoading.value = true;
    apiInvoiceList.value.clear();
    InvoiceModel responseData = await ApiRepo.getAllInvoiceList();
    if (responseData.data != null) {
      invoiceList.value = responseData.data!;
      apiInvoiceList.value = responseData.data!;
    }
    chipChoiceCardSelected(selectedStatus.value);
    isLoading.value = false;
  }

  Future<void> onSearchVendor(String companyname) async {
    List<InvoiceData> filterList = [];

    if (projectId == "") {
      projectId = "0";
    }
    print("selectedStatus : $selectedStatus");
    print("projectId : $projectId");
    if (selectedStatus.value == "0" && projectId == "0") {
      filterList = apiInvoiceList
          .where((data) => data.vendorCmpny!
              .toString()
              .toLowerCase()
              .contains(companyname.toLowerCase()))
          .toList();
      invoiceList.value = filterList;
    } else {
      filterList = apiInvoiceList
          .where((data) =>
              data.invoiceStatus!
                  .toString()
                  .toLowerCase()
                  .contains(selectedStatus.value.toLowerCase()) &&
              data.prjId!
                  .toString()
                  .toLowerCase()
                  .contains(projectId.toLowerCase()) &&
              data.vendorCmpny!
                  .toString()
                  .toLowerCase()
                  .contains(companyname.toLowerCase()))
          .toList();
      invoiceList.value = filterList;
    }
  }

  Future<void> onGetProject() async {
    String userId = await Auth.getUserID() ?? "0";
    ProjectModel projectModel = await ApiRepo.getProjectList(userId: userId);
    projectList.value = projectModel.data!;
    update();
  }

  void chipChoiceCardSelected(String choiceChip) {
    print("choiceChip $choiceChip");
    print("projectId $projectId");
    selectedStatus.value = choiceChip;
    List<InvoiceData> filterList = [];
    if (choiceChip == "0") {
      filterList = apiInvoiceList
          .where((data) => data.prjId!
              .toString()
              .toLowerCase()
              .contains(projectId.toLowerCase()))
          .toList();
      invoiceList.value = filterList;
    } else {
      if (projectId == "") {
        filterList = apiInvoiceList
            .where((data) => data.invoiceStatus!
                .toString()
                .toLowerCase()
                .contains(choiceChip.toLowerCase()))
            .toList();
        invoiceList.value = filterList;
      } else {
        filterList = apiInvoiceList
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
        invoiceList.value = filterList;
      }
    }
  }

  void getProjectSelected(String projectName) {
    List<InvoiceData> filterList = [];
    for (var element in projectList) {
      if (element.projectname == projectName) {
        projectId = element.projectcode!;
      }
    }

    print("selectedStatus : $selectedStatus");
    print("projectId : $projectId");

    if (projectId == "" || projectId == "0") {
      if (selectedStatus.value == "0") {
        filterList = apiInvoiceList;
        invoiceList.value = filterList;
      } else {
        filterList = apiInvoiceList
            .where((data) => data.invoiceStatus!
                .toString()
                .toLowerCase()
                .contains(selectedStatus.toLowerCase()))
            .toList();
        invoiceList.value = filterList;
      }
    } else {
      if (selectedStatus.value == "0") {
        filterList = apiInvoiceList
            .where((data) => data.prjId!
                .toString()
                .toLowerCase()
                .contains(projectId.toLowerCase()))
            .toList();
        invoiceList.value = filterList;
      } else {
        filterList = apiInvoiceList
            .where((data) =>
                data.invoiceStatus!
                    .toString()
                    .toLowerCase()
                    .contains(selectedStatus.toLowerCase()) &&
                data.prjId!
                    .toString()
                    .toLowerCase()
                    .contains(projectId.toLowerCase()))
            .toList();
        invoiceList.value = filterList;
      }
    }
    return;

    filterList = apiInvoiceList
        .where((data) => data.prjId!
            .toString()
            .toLowerCase()
            .contains(projectId.toLowerCase()))
        .toList();

    invoiceList.value = filterList;
  }

  void clearData() {
    selectedProject.value = ProjectData();
    isLoading.value = false;
    selectedStatus.value = "PENDING";
    projectId = "0";
  }
}
