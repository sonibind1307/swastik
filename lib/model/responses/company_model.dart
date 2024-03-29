class CompanyModel {
  String? status;
  String? message;
  List<CompanyData>? data;

  CompanyModel({this.status, this.message, this.data});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CompanyData>[];
      json['data'].forEach((v) {
        data!.add(CompanyData.fromJson(v));
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

class CompanyData {
  String? companyid;
  String? companyname;

  CompanyData({this.companyid, this.companyname});

  CompanyData.fromJson(Map<String, dynamic> json) {
    companyid = json['companyid'];
    companyname = json['companyname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyid'] = this.companyid;
    data['companyname'] = this.companyname;
    return data;
  }
}
