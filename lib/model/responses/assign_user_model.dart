class ValidateUserModel {
  String? status;
  String? message;
  List<UserData>? data;

  ValidateUserModel({this.status, this.message, this.data});

  ValidateUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(new UserData.fromJson(v));
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

class UserData {
  String? userId;
  String? firstName;
  String? lastName;
  String? userName;
  String? userMobile;
  String? userLevel;
  String? cancSwitchRights;
  String? enggInvAccess;
  String? companyId;
  String? userCompany;
  String? userDepartment;
  String? userPassword;
  String? userPermission;
  String? accessPermission;
  String? userStatus;
  String? calEventType;
  String? cpId;
  String? lastLogin;

  UserData(
      {this.userId,
      this.firstName,
      this.lastName,
      this.userName,
      this.userMobile,
      this.userLevel,
      this.cancSwitchRights,
      this.enggInvAccess,
      this.companyId,
      this.userCompany,
      this.userDepartment,
      this.userPassword,
      this.userPermission,
      this.accessPermission,
      this.userStatus,
      this.calEventType,
      this.cpId,
      this.lastLogin});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['user_name'];
    userMobile = json['user_mobile'];
    userLevel = json['user_level'];
    cancSwitchRights = json['canc_switch_rights'];
    enggInvAccess = json['engg_inv_access'];
    companyId = json['company_id'];
    userCompany = json['user_company'];
    userDepartment = json['user_department'];
    userPassword = json['user_password'];
    userPermission = json['user_permission'];
    accessPermission = json['access_permission'];
    userStatus = json['user_status'];
    calEventType = json['cal_event_type'];
    cpId = json['cp_id'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['user_name'] = this.userName;
    data['user_mobile'] = this.userMobile;
    data['user_level'] = this.userLevel;
    data['canc_switch_rights'] = this.cancSwitchRights;
    data['engg_inv_access'] = this.enggInvAccess;
    data['company_id'] = this.companyId;
    data['user_company'] = this.userCompany;
    data['user_department'] = this.userDepartment;
    data['user_password'] = this.userPassword;
    data['user_permission'] = this.userPermission;
    data['access_permission'] = this.accessPermission;
    data['user_status'] = this.userStatus;
    data['cal_event_type'] = this.calEventType;
    data['cp_id'] = this.cpId;
    data['last_login'] = this.lastLogin;
    return data;
  }
}
