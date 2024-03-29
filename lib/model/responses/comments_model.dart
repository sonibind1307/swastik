class CommentsModel {
  String? status;
  String? message;
  List<CommentData>? data;

  CommentsModel({this.status, this.message, this.data});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CommentData>[];
      json['data'].forEach((v) {
        data!.add(CommentData.fromJson(v));
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

class CommentData {
  String? id;
  String? companyId;
  String? entity;
  String? comments;
  String? postedBy;
  String? isRemainder;
  String? remainderDate;
  String? remainderTime;
  String? date;
  String? module;
  String? subModule;
  String? status;
  String? bookingId;
  String? clientId;
  String? followup;

  CommentData(
      {this.id,
      this.companyId,
      this.entity,
      this.comments,
      this.postedBy,
      this.isRemainder,
      this.remainderDate,
      this.remainderTime,
      this.date,
      this.module,
      this.subModule,
      this.status,
      this.bookingId,
      this.clientId,
      this.followup});

  CommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    entity = json['entity'];
    comments = json['comments'];
    postedBy = json['posted_by'];
    isRemainder = json['is_remainder'];
    remainderDate = json['remainder_date'];
    remainderTime = json['remainder_time'];
    date = json['date'];
    module = json['module'];
    subModule = json['sub_module'];
    status = json['status'];
    bookingId = json['booking_id'];
    clientId = json['client_id'];
    followup = json['followup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['entity'] = this.entity;
    data['comments'] = this.comments;
    data['posted_by'] = this.postedBy;
    data['is_remainder'] = this.isRemainder;
    data['remainder_date'] = this.remainderDate;
    data['remainder_time'] = this.remainderTime;
    data['date'] = this.date;
    data['module'] = this.module;
    data['sub_module'] = this.subModule;
    data['status'] = this.status;
    data['booking_id'] = this.bookingId;
    data['client_id'] = this.clientId;
    data['followup'] = this.followup;
    return data;
  }
}
