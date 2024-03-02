import 'package:get/get.dart';
import 'package:swastik/model/responses/vendor_model.dart';

import '../model/responses/invoice_item_model.dart';
import '../repository/api_call.dart';

class InvoiceDetailsController extends GetxController {
  var vendorData = <VendorData>[].obs;
  InvoiceIDetailModel invoiceIDetailModel = InvoiceIDetailModel();
  RxBool isLoading = false.obs;

  Future<void> onGetInvoiceDetails(String invoiceId) async {
    isLoading.value = true;
    invoiceIDetailModel = await ApiRepo.getInvoiceDetails(invoiceId);
    isLoading.value = false;
  }
}
