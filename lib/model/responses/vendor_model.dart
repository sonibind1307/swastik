class VendorModel {
  String? status;
  String? message;
  List<VendorData>? data;

  VendorModel({this.status, this.message, this.data});

  VendorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VendorData>[];
      json['data'].forEach((v) {
        data!.add(new VendorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VendorData {
  String? id;
  String? companyId;
  String? projectId;
  String? buildingId;
  String? companyName;
  String? contactName;
  String? contactNo;
  String? vendorType;
  String? gst;
  String? pan;
  String? address;
  String? pincode;
  String? city;
  String? email;
  String? addedBy;
  String? addedDate;
  String? uppdatedBy;
  String? updatedDate;
  String? status;
  String? gstCheck;
  String? tradeName;
  String? ledger;

  VendorData(
      {this.id,
      this.companyId,
      this.projectId,
      this.buildingId,
      this.companyName,
      this.contactName,
      this.contactNo,
      this.vendorType,
      this.gst,
      this.pan,
      this.address,
      this.pincode,
      this.city,
      this.email,
      this.addedBy,
      this.addedDate,
      this.uppdatedBy,
      this.updatedDate,
      this.status,
      this.gstCheck,
      this.tradeName,
      this.ledger});

  VendorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    projectId = json['project_id'];
    buildingId = json['building_id'];
    companyName = json['company_name'];
    contactName = json['contact_name'];
    contactNo = json['contact_no'];
    vendorType = json['vendor_type'];
    gst = json['gst'];
    pan = json['pan'];
    address = json['address'];
    pincode = json['pincode'];
    city = json['city'];
    email = json['email'];
    addedBy = json['added_by'];
    addedDate = json['added_date'];
    uppdatedBy = json['uppdated_by'];
    updatedDate = json['updated_date'];
    status = json['status'];
    gstCheck = json['gst_check'];
    tradeName = json['trade_name'];
    ledger = json['ledger'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['project_id'] = this.projectId;
    data['building_id'] = this.buildingId;
    data['company_name'] = this.companyName;
    data['contact_name'] = this.contactName;
    data['contact_no'] = this.contactNo;
    data['vendor_type'] = this.vendorType;
    data['gst'] = this.gst;
    data['pan'] = this.pan;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['city'] = this.city;
    data['email'] = this.email;
    data['added_by'] = this.addedBy;
    data['added_date'] = this.addedDate;
    data['uppdated_by'] = this.uppdatedBy;
    data['updated_date'] = this.updatedDate;
    data['status'] = this.status;
    data['gst_check'] = this.gstCheck;
    data['trade_name'] = this.tradeName;
    data['ledger'] = this.ledger;
    return data;
  }
}
