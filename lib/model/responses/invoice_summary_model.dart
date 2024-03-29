class InvoiceSummaryModel {
  String? status;
  String? message;
  Data? data;

  InvoiceSummaryModel({this.status, this.message, this.data});

  InvoiceSummaryModel.fromJson(Map<String, dynamic> json) {
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
  String? invoiceId;
  String? companyname;
  String? projectname;
  String? nameofbuilding;
  String? invref;
  int? poId;
  String? vendorName;
  String? invDate;
  String? invcat;
  String? status;
  String? filename;
  String? filetype;
  String? subtotal;
  String? taxamount;
  String? totalamount;
  String? invoiceStatus;
  String? step1;
  String? step1Username;
  String? step1Timestamp;
  String? step2;
  String? step2Username;
  String? step2Timestamp;
  String? step3;
  String? step3Username;
  String? step3Timestamp;
  String? gst;
  String? pan;
  String? company_id;
  int? commentCount;

  Data({
    this.invoiceId,
    this.companyname,
    this.projectname,
    this.nameofbuilding,
    this.invref,
    this.poId,
    this.vendorName,
    this.invDate,
    this.invcat,
    this.status,
    this.filename,
    this.filetype,
    this.subtotal,
    this.taxamount,
    this.totalamount,
    this.invoiceStatus,
    this.step1,
    this.step1Username,
    this.step1Timestamp,
    this.step2,
    this.step2Username,
    this.step2Timestamp,
    this.step3,
    this.step3Username,
    this.step3Timestamp,
    this.gst,
    this.pan,
    this.company_id,
    this.commentCount,
  });

  Data.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    companyname = json['companyname'];
    projectname = json['projectname'];
    nameofbuilding = json['nameofbuilding'];
    invref = json['invref'];
    poId = json['po_id'];
    vendorName = json['vendor_name'];
    invDate = json['inv_date'];
    invcat = json['invcat'];
    status = json['status'];
    filename = json['filename'];
    filetype = json['filetype'];
    subtotal = json['subtotal'];
    taxamount = json['taxamount'];
    totalamount = json['totalamount'];
    invoiceStatus = json['invoice_status'];
    step1 = json['step1'];
    step1Username = json['step1_username'];
    step1Timestamp = json['step1_timestamp'];
    step2 = json['step2'];
    step2Username = json['step2_username'];
    step2Timestamp = json['step2_timestamp'];
    step3 = json['step3'];
    step3Username = json['step3_username'];
    step3Timestamp = json['step3_timestamp'];
    gst = json['gst'];
    pan = json['pan'];
    company_id = json['company_id'];
    commentCount = json['comment_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['companyname'] = this.companyname;
    data['company_id'] = this.company_id;
    data['projectname'] = this.projectname;
    data['nameofbuilding'] = this.nameofbuilding;
    data['invref'] = this.invref;
    data['po_id'] = this.poId;
    data['vendor_name'] = this.vendorName;
    data['inv_date'] = this.invDate;
    data['invcat'] = this.invcat;
    data['status'] = this.status;
    data['filename'] = this.filename;
    data['filetype'] = this.filetype;
    data['subtotal'] = this.subtotal;
    data['taxamount'] = this.taxamount;
    data['totalamount'] = this.totalamount;
    data['invoice_status'] = this.invoiceStatus;
    data['step1'] = this.step1;
    data['step1_username'] = this.step1Username;
    data['step1_timestamp'] = this.step1Timestamp;
    data['step2'] = this.step2;
    data['step2_username'] = this.step2Username;
    data['step2_timestamp'] = this.step2Timestamp;
    data['step3'] = this.step3;
    data['step3_username'] = this.step3Username;
    data['step3_timestamp'] = this.step3Timestamp;
    data['gst'] = this.gst;
    data['pan'] = this.pan;
    data['comment_count'] = this.commentCount;
    return data;
  }
}
