import 'package:get/get.dart';

import '../model/responses/dashboard_model.dart';
import '../repository/api_call.dart';

class InvoiceDashboardController extends GetxController {
  RxInt pendingCount = 0.obs;
  RxInt verifiedCount = 0.obs;
  RxInt approvedCount = 0.obs;
  RxInt rejectedCount = 0.obs;

  Future<void> onGetInvoiceDetails() async {
    DashboardModel response = await ApiRepo.getDashboard();
    if (response.data != null) {
      if (response.data!.invoiceStatusData != null &&
          response.data!.invoiceStatusData!.isNotEmpty) {
        for (var element in response.data!.invoiceStatusData!) {
          if (element.status == "1") {
            pendingCount.value = int.parse(element.invoiceCount!);
          } else if (element.status == "2") {
            verifiedCount.value = int.parse(element.invoiceCount!);
          } else if (element.status == "3") {
            approvedCount.value = int.parse(element.invoiceCount!);
          } else if (element.status == "4") {
            rejectedCount.value = int.parse(element.invoiceCount!);
          }
        }
      }
    }
    print("PendingCount->${pendingCount.value}");
    update();
  }
}
