class UserModel {
  String? status;
  String? message;
  Data? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? fullName;
  String? userName;
  String? userId;
  String? firstName;
  String? lastName;
  String? userMobile;
  String? userLevel;
  String? userDepartment;
  String? cpId;

  Data(
      {this.fullName,
      this.userName,
      this.userId,
      this.firstName,
      this.lastName,
      this.userMobile,
      this.userLevel,
      this.userDepartment,
      this.cpId});

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    userName = json['user_name'];
    userId = json['user_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userMobile = json['user_mobile'];
    userLevel = json['user_level'];
    userDepartment = json['user_department'];
    cpId = json['cp_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['user_name'] = this.userName;
    data['user_id'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['user_mobile'] = this.userMobile;
    data['user_level'] = this.userLevel;
    data['user_department'] = this.userDepartment;
    data['cp_id'] = this.cpId;
    return data;
  }
}
