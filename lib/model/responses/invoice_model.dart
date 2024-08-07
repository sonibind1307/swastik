/*
class InvoiceModel {
  String? status;
  String? message;
  List<InvoiceData>? data;

  InvoiceModel({this.status, this.message, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <InvoiceData>[];
      json['data'].forEach((v) {
        data!.add(new InvoiceData.fromJson(v));
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

class InvoiceData {
  String? invoiceId;
  String? invstatus;
  String? invDate;
  String? invcomments;
  String? projectname;
  String? totalamount;
  String? cmpId;
  String? prjId;
  String? buildId;
  String? invoiceNo;
  String? invref;
  String? vendorCmpny;
  String? invcat;
  String? invStatus;
  String? status;
  String? invoiceStatus;
  String? udpatedDate;
  String? updatedFor;
  String? reVefify;
  String? step1;
  String? step2;
  String? step3;
  int? reassign;
  String? addedBy;
  String? ledgername;
  String? poId;
  String? approvedDate;
  String? ledgerid;
  String? user1;
  int? daysDiff;
  String? currentUserId;
  String? user2;
  String? shareUrl;
  int? step2Rights;
  int? commentCount;

  InvoiceData({
    this.invoiceId,
    this.invstatus,
    this.invDate,
    this.invcomments,
    this.projectname,
    this.totalamount,
    this.cmpId,
    this.prjId,
    this.buildId,
    this.invoiceNo,
    this.invref,
    this.vendorCmpny,
    this.invcat,
    this.invStatus,
    this.status,
    this.invoiceStatus,
    this.udpatedDate,
    this.updatedFor,
    this.reVefify,
    this.step1,
    this.step2,
    this.step3,
    this.reassign,
    this.addedBy,
    this.ledgername,
    this.poId,
    this.approvedDate,
    this.ledgerid,
    this.user1,
    this.daysDiff,
    this.currentUserId,
    this.user2,
    this.step2Rights,
    this.shareUrl,
    this.commentCount,
  });

  InvoiceData.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    invstatus = json['invstatus'];
    invDate = json['inv_date'];
    invcomments = json['invcomments'];
    projectname = json['projectname'];
    totalamount = json['totalamount'];
    cmpId = json['cmp_id'];
    prjId = json['prj_id'];
    buildId = json['build_id'];
    invoiceNo = json['invoice_no'];
    invref = json['invref'];
    vendorCmpny = json['vendor_cmpny'];
    invcat = json['invcat'];
    invStatus = json['inv_status'];
    status = json['status'];
    invoiceStatus = json['invoice_status'];
    udpatedDate = json['udpated_Date'];
    updatedFor = json['updated_for'];
    reVefify = json['re_vefify'];
    step1 = json['step1'];
    step2 = json['step2'];
    step3 = json['step3'];
    reassign = json['reassign'];
    addedBy = json['added_by'];
    ledgername = json['ledgername'];
    poId = json['po_id'];
    approvedDate = json['approved_Date'];
    ledgerid = json['ledgerid'];
    user1 = json['user1'];
    daysDiff = json['days_diff'];
    currentUserId = json['current_user_id'];
    user2 = json['user2'];
    step2Rights = json['step2_rights'];
    shareUrl = json['share_url'];
    commentCount = json['comment_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['invstatus'] = this.invstatus;
    data['inv_date'] = this.invDate;
    data['invcomments'] = this.invcomments;
    data['projectname'] = this.projectname;
    data['totalamount'] = this.totalamount;
    data['cmp_id'] = this.cmpId;
    data['prj_id'] = this.prjId;
    data['build_id'] = this.buildId;
    data['invoice_no'] = this.invoiceNo;
    data['invref'] = this.invref;
    data['vendor_cmpny'] = this.vendorCmpny;
    data['invcat'] = this.invcat;
    data['inv_status'] = this.invStatus;
    data['status'] = this.status;
    data['invoice_status'] = this.invoiceStatus;
    data['udpated_Date'] = this.udpatedDate;
    data['updated_for'] = this.updatedFor;
    data['re_vefify'] = this.reVefify;
    data['step1'] = this.step1;
    data['step2'] = this.step2;
    data['step3'] = this.step3;
    data['reassign'] = this.reassign;
    data['added_by'] = this.addedBy;
    data['ledgername'] = this.ledgername;
    data['po_id'] = this.poId;
    data['approved_Date'] = this.approvedDate;
    data['ledgerid'] = this.ledgerid;
    data['user1'] = this.user1;
    data['days_diff'] = this.daysDiff;
    data['current_user_id'] = this.currentUserId;
    data['user2'] = this.user2;
    data['step2_rights'] = this.step2Rights;
    data['share_url'] = this.shareUrl;
    data['comment_count'] = this.commentCount;
    return data;
  }
}
*/

class InvoiceModel {
  String? status;
  String? message;
  List<InvoiceData>? data;

  InvoiceModel({this.status, this.message, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <InvoiceData>[];
      json['data'].forEach((v) {
        data!.add(new InvoiceData.fromJson(v));
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

class InvoiceData {
  String? invoiceId;
  String? invstatus;
  String? invDate;
  String? invcomments;
  String? projectname;
  String? totalamount;
  String? cmpId;
  String? prjId;
  String? buildId;
  String? invoiceNo;
  String? invref;
  String? vendorCmpny;
  String? invcat;
  String? id;
  String? step1;
  String? step1Timestamp;
  String? step2;
  String? step2Timestamp;
  String? step3;
  String? step3Timestamp;
  String? stepProcess;
  String? status;
  String? invStatus;
  String? reVefify;
  String? tallHold;
  String? holdBy;
  String? holdDatetime;
  String? addedBy;
  String? addedDate;
  String? updatedBy;
  String? updatedFor;
  String? udpatedDate;
  String? ledgername;
  String? poId;
  String? approvedDate;
  String? ledgerid;
  String? invoiceStatus;
  String? user1;
  String? user2;
  String? user3;
  String? shareUrl;
  int? commentCount;

  InvoiceData(
      {this.invoiceId,
      this.invstatus,
      this.invDate,
      this.invcomments,
      this.projectname,
      this.totalamount,
      this.cmpId,
      this.prjId,
      this.buildId,
      this.invoiceNo,
      this.invref,
      this.vendorCmpny,
      this.invcat,
      this.id,
      this.step1,
      this.step1Timestamp,
      this.step2,
      this.step2Timestamp,
      this.step3,
      this.step3Timestamp,
      this.stepProcess,
      this.status,
      this.invStatus,
      this.reVefify,
      this.tallHold,
      this.holdBy,
      this.holdDatetime,
      this.addedBy,
      this.addedDate,
      this.updatedBy,
      this.updatedFor,
      this.udpatedDate,
      this.ledgername,
      this.poId,
      this.approvedDate,
      this.ledgerid,
      this.invoiceStatus,
      this.user1,
      this.user2,
      this.user3,
      this.shareUrl,
      this.commentCount});

  InvoiceData.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    invstatus = json['invstatus'];
    invDate = json['inv_date'];
    invcomments = json['invcomments'];
    projectname = json['projectname'];
    totalamount = json['totalamount'];
    cmpId = json['cmp_id'];
    prjId = json['prj_id'];
    buildId = json['build_id'];
    invoiceNo = json['invoice_no'];
    invref = json['invref'];
    vendorCmpny = json['vendor_cmpny'];
    invcat = json['invcat'];
    id = json['id'];
    step1 = json['step1'];
    step1Timestamp = json['step1_timestamp'];
    step2 = json['step2'];
    step2Timestamp = json['step2_timestamp'];
    step3 = json['step3'];
    step3Timestamp = json['step3_timestamp'];
    stepProcess = json['step_process'];
    status = json['status'];
    invStatus = json['inv_status'];
    reVefify = json['re_vefify'];
    tallHold = json['tall_hold'];
    holdBy = json['hold_by'];
    holdDatetime = json['hold_datetime'];
    addedBy = json['added_by'];
    addedDate = json['added_date'];
    updatedBy = json['updated_by'];
    updatedFor = json['updated_for'];
    udpatedDate = json['udpated_Date'];
    ledgername = json['ledgername'];
    poId = json['po_id'];
    approvedDate = json['approved_Date'];
    ledgerid = json['ledgerid'];
    invoiceStatus = json['invoice_status'];
    user1 = json['user1'];
    user2 = json['user2'];
    user3 = json['user3'];
    shareUrl = json['share_url'];
    commentCount = json['comment_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['invstatus'] = this.invstatus;
    data['inv_date'] = this.invDate;
    data['invcomments'] = this.invcomments;
    data['projectname'] = this.projectname;
    data['totalamount'] = this.totalamount;
    data['cmp_id'] = this.cmpId;
    data['prj_id'] = this.prjId;
    data['build_id'] = this.buildId;
    data['invoice_no'] = this.invoiceNo;
    data['invref'] = this.invref;
    data['vendor_cmpny'] = this.vendorCmpny;
    data['invcat'] = this.invcat;
    data['id'] = this.id;
    data['step1'] = this.step1;
    data['step1_timestamp'] = this.step1Timestamp;
    data['step2'] = this.step2;
    data['step2_timestamp'] = this.step2Timestamp;
    data['step3'] = this.step3;
    data['step3_timestamp'] = this.step3Timestamp;
    data['step_process'] = this.stepProcess;
    data['status'] = this.status;
    data['inv_status'] = this.invStatus;
    data['re_vefify'] = this.reVefify;
    data['tall_hold'] = this.tallHold;
    data['hold_by'] = this.holdBy;
    data['hold_datetime'] = this.holdDatetime;
    data['added_by'] = this.addedBy;
    data['added_date'] = this.addedDate;
    data['updated_by'] = this.updatedBy;
    data['updated_for'] = this.updatedFor;
    data['udpated_Date'] = this.udpatedDate;
    data['ledgername'] = this.ledgername;
    data['po_id'] = this.poId;
    data['approved_Date'] = this.approvedDate;
    data['ledgerid'] = this.ledgerid;
    data['invoice_status'] = this.invoiceStatus;
    data['user1'] = this.user1;
    data['user2'] = this.user2;
    data['user3'] = this.user3;
    data['share_url'] = this.shareUrl;
    data['comment_count'] = this.commentCount;
    return data;
  }
}
