class TestModel {
  int? status;
  String? msg;
  List<Data>? data;

  TestModel({this.status, this.msg, this.data});

  TestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? rfqAutoId;
  String? assemblyNames;
  List<ProcessDetails>? processDetails;

  Data({this.rfqAutoId, this.assemblyNames, this.processDetails});

  Data.fromJson(Map<String, dynamic> json) {
    rfqAutoId = json['rfq_auto_id'];
    assemblyNames = json['assembly_names'];
    if (json['process_details'] != null) {
      processDetails = <ProcessDetails>[];
      json['process_details'].forEach((v) {
        processDetails!.add(new ProcessDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rfq_auto_id'] = this.rfqAutoId;
    data['assembly_names'] = this.assemblyNames;
    if (this.processDetails != null) {
      data['process_details'] =
          this.processDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProcessDetails {
  String? processNames;
  int? processImageCount;
  String? processCompletionPercentage;
  String? holdStatus;
  String? lastUpdatedDate;
  List<ProjectDetails>? projectDetails;

  ProcessDetails(
      {this.processNames,
      this.processImageCount,
      this.processCompletionPercentage,
      this.holdStatus,
      this.lastUpdatedDate,
      this.projectDetails});

  ProcessDetails.fromJson(Map<String, dynamic> json) {
    processNames = json['process_names'];
    processImageCount = json['process_image_count'];
    processCompletionPercentage = json['process_completion_percentage'];
    holdStatus = json['hold_status'];
    lastUpdatedDate = json['last_updated_date'];
    if (json['project_details'] != null) {
      projectDetails = <ProjectDetails>[];
      json['project_details'].forEach((v) {
        projectDetails!.add(new ProjectDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['process_names'] = this.processNames;
    data['process_image_count'] = this.processImageCount;
    data['process_completion_percentage'] = this.processCompletionPercentage;
    data['hold_status'] = this.holdStatus;
    data['last_updated_date'] = this.lastUpdatedDate;
    if (this.projectDetails != null) {
      data['project_details'] =
          this.projectDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectDetails {
  String? vendorProjectTrackingAutoId;
  String? vendorAutoId;
  String? rfqAutoId;
  String? assemblyAutoId;
  String? processName;
  String? date;
  String? processImage;
  String? holdStatus;
  String? remark;

  ProjectDetails(
      {this.vendorProjectTrackingAutoId,
      this.vendorAutoId,
      this.rfqAutoId,
      this.assemblyAutoId,
      this.processName,
      this.date,
      this.processImage,
      this.holdStatus,
      this.remark});

  ProjectDetails.fromJson(Map<String, dynamic> json) {
    vendorProjectTrackingAutoId = json['vendor_project_tracking_auto_id'];
    vendorAutoId = json['vendor_auto_id'];
    rfqAutoId = json['rfq_auto_id'];
    assemblyAutoId = json['assembly_auto_id'];
    processName = json['process_name'];
    date = json['date'];
    processImage = json['process_image'];
    holdStatus = json['hold_status'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_project_tracking_auto_id'] = this.vendorProjectTrackingAutoId;
    data['vendor_auto_id'] = this.vendorAutoId;
    data['rfq_auto_id'] = this.rfqAutoId;
    data['assembly_auto_id'] = this.assemblyAutoId;
    data['process_name'] = this.processName;
    data['date'] = this.date;
    data['process_image'] = this.processImage;
    data['hold_status'] = this.holdStatus;
    data['remark'] = this.remark;
    return data;
  }
}

class TestCustomeModelClass {
  ProcessDetails processDetails;
  String rfqAutoId;
  String assemblyNames;

  TestCustomeModelClass(
      {required this.processDetails,
      required this.assemblyNames,
      required this.rfqAutoId});
}
