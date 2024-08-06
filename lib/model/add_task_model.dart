class AddTaskModel {
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
  String? userid;

  AddTaskModel(
      {this.projectId,
      this.buildingId,
      this.taskTitle,
      this.taskDesc,
      this.priority,
      this.status,
      this.assignedBy,
      this.assignedTo,
      this.targetDate,
      this.closedDate,
      this.userid});

  AddTaskModel.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    buildingId = json['building_id'];
    taskTitle = json['task_title'];
    taskDesc = json['task_desc'];
    priority = json['priority'];
    status = json['status'];
    assignedBy = json['assigned_by'];
    assignedTo = json['assigned_to'].cast<String>();
    targetDate = json['target_date'];
    closedDate = json['closed_date'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['userid'] = this.userid;
    return data;
  }
}
