class ProjectModel {
  String? status;
  String? message;
  List<ProjectData>? data;

  ProjectModel({this.status, this.message, this.data});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProjectData>[];
      json['data'].forEach((v) {
        data!.add(ProjectData.fromJson(v));
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

class ProjectData {
  String? companyid;
  String? companyname;
  String? gst;
  String? pan;
  String? tan;
  String? address;
  String? projectname;
  String? projectcode;
  String? buildingcode;
  String? nameofbuilding;
  String? projBuildName;
  String? siteAddress;
  String? companycode;

  ProjectData({
    this.companyid,
    this.companyname,
    this.gst,
    this.pan,
    this.tan,
    this.address,
    this.projectname,
    this.projectcode,
    this.buildingcode,
    this.nameofbuilding,
    this.projBuildName,
    this.siteAddress,
    this.companycode,
  });

  ProjectData.fromJson(Map<String, dynamic> json) {
    companyid = json['companyid'];
    companyname = json['companyname'];
    gst = json['gst'];
    pan = json['pan'];
    tan = json['tan'];
    address = json['address'];
    projectname = json['projectname'];
    projectcode = json['projectcode'];
    buildingcode = json['buildingcode'];
    nameofbuilding = json['nameofbuilding'];
    projBuildName = json['proj_build_name'];
    siteAddress = json['site_address'];
    companycode = json['companycode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyid'] = this.companyid;
    data['companyname'] = this.companyname;
    data['gst'] = this.gst;
    data['pan'] = this.pan;
    data['tan'] = this.tan;
    data['address'] = this.address;
    data['projectname'] = this.projectname;
    data['projectcode'] = this.projectcode;
    data['buildingcode'] = this.buildingcode;
    data['nameofbuilding'] = this.nameofbuilding;
    data['proj_build_name'] = this.projBuildName;
    data['site_address'] = this.siteAddress;
    data['companycode'] = this.companycode;
    return data;
  }
}
