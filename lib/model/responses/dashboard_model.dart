class DashboardModel {
  String? status;
  String? message;
  DashboardData? data;

  DashboardModel({this.status, this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DashboardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DashboardData {
  List<InvoiceStatusData>? invoiceStatusData;

  DashboardData({this.invoiceStatusData});

  DashboardData.fromJson(Map<String, dynamic> json) {
    if (json['invoice_status_data'] != null) {
      invoiceStatusData = <InvoiceStatusData>[];
      json['invoice_status_data'].forEach((v) {
        invoiceStatusData!.add(new InvoiceStatusData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.invoiceStatusData != null) {
      data['invoice_status_data'] =
          this.invoiceStatusData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceStatusData {
  String? invoiceCount;
  String? status;
  String? invoiceStatus;

  InvoiceStatusData({this.invoiceCount, this.status, this.invoiceStatus});

  InvoiceStatusData.fromJson(Map<String, dynamic> json) {
    invoiceCount = json['invoice_count'];
    status = json['status'];
    invoiceStatus = json['invoice_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_count'] = this.invoiceCount;
    data['status'] = this.status;
    data['invoice_status'] = this.invoiceStatus;
    return data;
  }
}
