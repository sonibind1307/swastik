import 'package:get/get.dart';

import '../config/Helper.dart';
import '../config/sharedPreferences.dart';
import '../model/responses/base_model.dart';
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
  String apiStatus = "0";

  @override
  void onInit() {
    getAllInvoiceList(apiStatus);
    onGetProject();
  }

  Future<void> getAllInvoiceList(String status) async {
    isLoading.value = true;
    apiInvoiceList.clear();
    invoiceList.clear();
    InvoiceModel responseData = await ApiRepo.getAllInvoiceList(status);
    if (responseData.data != null) {
      invoiceList.value = responseData.data!;
      apiInvoiceList.value = responseData.data!;
      print("getAllInvoiceList-${responseData.data!.length}");
      isLoading.value = false;
    }
    isLoading.value = false;
    chipChoiceCardSelected(selectedStatus.value);

    print("isLoading-${isLoading.value}");
    update();
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
      print("else");
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
              (data.vendorCmpny!
                      .toString()
                      .toLowerCase()
                      .contains(companyname.toLowerCase()) ||
                  data.projectname!
                      .toString()
                      .toLowerCase()
                      .contains(companyname.toLowerCase()) ||
                  data.invcat!
                      .toString()
                      .toLowerCase()
                      .contains(companyname.toLowerCase()) ||
                  data.invref!
                      .toString()
                      .toLowerCase()
                      .contains(companyname.toLowerCase())))
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

  void chipChoiceCardSelected1(String choiceChip) {
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
    // isLoading.value = false;
  }

  void chipChoiceCardSelected(String choiceChip) {
    print("chipChoiceCardSelected-${apiInvoiceList.length}");
    print("choiceChip $choiceChip");
    print("projectId $projectId");

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
    // isLoading.value = false;
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

  void showLoading() {
    // Helper.getToastMsg(invoiceList.length.toString());
    isLoading.value = true;
    if (invoiceList.isNotEmpty) {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  Future<void> deleteInvoice(String invoiceId) async {
    BaseModel data = await ApiRepo.deleteInvoice(invoiceId);
    if (data.status == "true") {
      Helper.getToastMsg(data.message ?? "Invoice deleted");
      getAllInvoiceList(apiStatus);
    } else {
      Helper.getToastMsg(data.message ?? "Try Again");
    }
  }
}
