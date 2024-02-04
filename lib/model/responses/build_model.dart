class BuildModel {
  String? status;
  String? message;
  List<BuildData>? data;

  BuildModel({this.status, this.message, this.data});

  BuildModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BuildData>[];
      json['data'].forEach((v) {
        data!.add(new BuildData.fromJson(v));
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

class BuildData {
  String? projectcode;
  String? buildingcode;
  String? nameofbuilding;

  BuildData({this.projectcode, this.buildingcode, this.nameofbuilding});

  BuildData.fromJson(Map<String, dynamic> json) {
    projectcode = json['projectcode'];
    buildingcode = json['buildingcode'];
    nameofbuilding = json['nameofbuilding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectcode'] = this.projectcode;
    data['buildingcode'] = this.buildingcode;
    data['nameofbuilding'] = this.nameofbuilding;
    return data;
  }
}
