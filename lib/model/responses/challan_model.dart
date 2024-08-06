class ChallanModel {
  String? status;
  String? message;
  List<ChallanData>? data;

  ChallanModel({this.status, this.message, this.data});

  ChallanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ChallanData>[];
      json['data'].forEach((v) {
        data!.add(new ChallanData.fromJson(v));
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

class ChallanData {
  String? id;
  String? cmpnyId;
  String? challanStatus;
  String? projectId;
  String? challanDt;
  String? challanNo;
  String? vehicleNo;
  String? grade;
  String? quantity;
  String? unit;
  String? rate;
  String? challanAppBy;
  String? profCode;
  String? companyname;
  String? projectname;
  String? invoiceId;
  String? invoiceNo;
  String? approveTime;
  String? chlStatus;

  ChallanData({
    this.id,
    this.cmpnyId,
    this.challanStatus,
    this.projectId,
    this.challanDt,
    this.challanNo,
    this.vehicleNo,
    this.grade,
    this.quantity,
    this.unit,
    this.rate,
    this.challanAppBy,
    this.profCode,
    this.companyname,
    this.projectname,
    this.invoiceId,
    this.invoiceNo,
    this.chlStatus,
    this.approveTime,
  });

  ChallanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cmpnyId = json['cmpny_id'];
    challanStatus = json['challan_status'];
    projectId = json['project_id'];
    challanDt = json['challan_dt'];
    challanNo = json['challan_no'];
    vehicleNo = json['vehicle_no'];
    grade = json['grade'];
    quantity = json['quantity'];
    unit = json['unit'];
    rate = json['rate'];
    challanAppBy = json['challan_app_by'];
    profCode = json['prof_code'];
    companyname = json['companyname'];
    projectname = json['projectname'];
    invoiceId = json['invoice_id'];
    invoiceNo = json['invoice_no'];
    chlStatus = json['chl_status'];
    approveTime = json['approve_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cmpny_id'] = this.cmpnyId;
    data['challan_status'] = this.challanStatus;
    data['project_id'] = this.projectId;
    data['challan_dt'] = this.challanDt;
    data['challan_no'] = this.challanNo;
    data['vehicle_no'] = this.vehicleNo;
    data['grade'] = this.grade;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['rate'] = this.rate;
    data['challan_app_by'] = this.challanAppBy;
    data['prof_code'] = this.profCode;
    data['companyname'] = this.companyname;
    data['projectname'] = this.projectname;
    data['invoice_id'] = this.invoiceId;
    data['invoice_no'] = this.invoiceNo;
    data['chl_status'] = this.chlStatus;
    data['approve_time'] = this.approveTime;
    return data;
  }
}
