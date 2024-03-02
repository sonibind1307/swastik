import 'package:get/get.dart';

import '../model/responses/vendor_model.dart';
import '../repository/api_call.dart';

class VendorListController extends GetxController {
  var vendorList = <VendorData>[].obs;
  var apiVendorList = <VendorData>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getAllVendorList();
  }

  Future<void> getAllVendorList() async {
    isLoading.value = false;
    apiVendorList.value.clear();
    VendorModel vendorModel = await ApiRepo.getVendors();
    if (vendorModel.data != null) {
      apiVendorList.value = vendorModel.data!;
      vendorList.value = apiVendorList.value;
    }
    isLoading.value = true;
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
}
