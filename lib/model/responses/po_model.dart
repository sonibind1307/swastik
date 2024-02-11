class POModel {
  String? status;
  String? message;
  POData? data;

  POModel({this.status, this.message, this.data});

  POModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new POData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class POData {
  String? id;
  String? companyName;
  String? projectId;
  String? ledgerId;
  String? ledgername;
  List<PoList>? poList;

  POData(
      {this.id,
      this.companyName,
      this.projectId,
      this.ledgerId,
      this.ledgername,
      this.poList});

  POData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    projectId = json['project_id'];
    ledgerId = json['ledger_id'];
    ledgername = json['ledgername'];
    if (json['po_list'] != null) {
      poList = <PoList>[];
      json['po_list'].forEach((v) {
        poList!.add(new PoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['project_id'] = this.projectId;
    data['ledger_id'] = this.ledgerId;
    data['ledgername'] = this.ledgername;
    if (this.poList != null) {
      data['po_list'] = this.poList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PoList {
  String? id;
  String? projectId;
  String? vendorId;
  String? companyName;
  String? orderType;
  String? poDt;
  String? path;
  String? document;
  String? activeStatus;
  String? status;

  PoList(
      {this.id,
      this.projectId,
      this.vendorId,
      this.companyName,
      this.orderType,
      this.poDt,
      this.path,
      this.document,
      this.activeStatus,
      this.status});

  PoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    vendorId = json['vendor_id'];
    companyName = json['company_name'];
    orderType = json['order_type'];
    poDt = json['po_dt'];
    path = json['path'];
    document = json['document'];
    activeStatus = json['active_status'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['vendor_id'] = this.vendorId;
    data['company_name'] = this.companyName;
    data['order_type'] = this.orderType;
    data['po_dt'] = this.poDt;
    data['path'] = this.path;
    data['document'] = this.document;
    data['active_status'] = this.activeStatus;
    data['status'] = this.status;
    return data;
  }
}
