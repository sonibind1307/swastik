class TaskListModel {
  String? status;
  String? message;
  List<TaskData>? data;

  TaskListModel({this.status, this.message, this.data});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TaskData>[];
      json['data'].forEach((v) {
        data!.add(new TaskData.fromJson(v));
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

class TaskData {
  String? id;
  String? userId;
  String? projectId;
  String? buildingId;
  String? taskTitle;
  String? taskDesc;
  String? priority;
  String? status;
  String? assignedBy;
  String? assignedTo;
  String? targetDate;
  String? closedDate;
  String? delayId;
  String? uploads;
  String? projectname;
  String? assignedByNames;

  TaskData({
    this.id,
    this.userId,
    this.projectId,
    this.buildingId,
    this.taskTitle,
    this.taskDesc,
    this.priority,
    this.status,
    this.assignedBy,
    this.assignedTo,
    this.targetDate,
    this.closedDate,
    this.delayId,
    this.uploads,
    this.projectname,
    this.assignedByNames,
  });

  TaskData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    projectId = json['project_id'];
    buildingId = json['building_id'];
    taskTitle = json['task_title'];
    taskDesc = json['task_desc'];
    priority = json['priority'];
    status = json['status'];
    assignedBy = json['assigned_by'];
    assignedTo = json['assigned_to'];
    targetDate = json['target_date'];
    closedDate = json['closed_date'];
    delayId = json['delay_id'];
    uploads = json['uploads'];
    projectname = json['projectname'];
    assignedByNames = json['assigned_by_names'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['project_id'] = this.projectId;
    data['building_id'] = this.buildingId;
    data['task_title'] = this.taskTitle;
    data['task_desc'] = this.taskDesc;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['assigned_by'] = this.assignedBy;
    data['assigned_to'] = this.assignedTo;
    data['target_date'] = this.targetDate;
    data['closed_date'] = this.closedDate;
    data['delay_id'] = this.delayId;
    data['uploads'] = this.uploads;
    data['projectname'] = this.projectname;
    data['assigned_by_names'] = this.assignedByNames;
    return data;
  }
}
