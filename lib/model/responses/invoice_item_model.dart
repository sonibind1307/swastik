class InvoiceIDetailModel {
  String? status;
  String? message;
  Data? data;

  InvoiceIDetailModel({this.status, this.message, this.data});

  InvoiceIDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? companyId;
  String? companyname;
  String? project;
  String? projectname;
  String? building;
  String? nameofbuilding;
  String? ledgerid;
  String? invref;
  String? poId;
  String? vendorId;
  String? vendorName;
  String? address;
  String? city;
  String? pincode;
  String? email;
  String? gst;
  String? pan;
  String? invDate;
  String? invcat;
  String? invcomments;
  String? cgstPercent;
  String? cgstAmount;
  String? sgstPercent;
  String? sgstAmount;
  String? igstPercent;
  String? igstAmount;
  String? invamount;
  String? subtotal;
  String? taxamount;
  String? totalamount;
  String? createdDate;
  String? createdBy;
  String? updatedBy;
  String? updatedDate;
  String? status;
  String? filename;
  String? filetype;
  String? size;
  String? uploaduser;
  String? uploaddate;
  String? current_userid;
  List<InvoiceItems>? invoiceItems;

  Data({
    this.invoiceId,
    this.companyId,
    this.companyname,
    this.project,
    this.projectname,
    this.building,
    this.nameofbuilding,
    this.ledgerid,
    this.invref,
    this.poId,
    this.vendorId,
    this.vendorName,
    this.address,
    this.city,
    this.pincode,
    this.email,
    this.gst,
    this.pan,
    this.invDate,
    this.invcat,
    this.invcomments,
    this.cgstPercent,
    this.cgstAmount,
    this.sgstPercent,
    this.sgstAmount,
    this.igstPercent,
    this.igstAmount,
    this.invamount,
    this.subtotal,
    this.taxamount,
    this.totalamount,
    this.createdDate,
    this.createdBy,
    this.updatedBy,
    this.updatedDate,
    this.status,
    this.filename,
    this.filetype,
    this.size,
    this.uploaduser,
    this.uploaddate,
    this.invoiceItems,
    this.current_userid,
  });

  Data.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    companyId = json['company_id'];
    companyname = json['companyname'];
    project = json['project'];
    projectname = json['projectname'];
    building = json['building'];
    nameofbuilding = json['nameofbuilding'];
    ledgerid = json['ledgerid'];
    invref = json['invref'];
    poId = json['po_id'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    address = json['address'];
    city = json['city'];
    pincode = json['pincode'];
    email = json['email'];
    gst = json['gst'];
    pan = json['pan'];
    invDate = json['inv_date'];
    invcat = json['invcat'];
    invcomments = json['invcomments'];
    cgstPercent = json['cgst_percent'];
    cgstAmount = json['cgst_amount'];
    sgstPercent = json['sgst_percent'];
    sgstAmount = json['sgst_amount'];
    igstPercent = json['igst_percent'];
    igstAmount = json['igst_amount'];
    invamount = json['invamount'];
    subtotal = json['subtotal'];
    taxamount = json['taxamount'];
    totalamount = json['totalamount'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    updatedDate = json['updated_date'];
    status = json['status'];
    filename = json['filename'];
    filetype = json['filetype'];
    size = json['size'];
    uploaduser = json['uploaduser'];
    uploaddate = json['uploaddate'];
    current_userid = json['current_userid'];
    if (json['invoice_items'] != null) {
      invoiceItems = <InvoiceItems>[];
      json['invoice_items'].forEach((v) {
        invoiceItems!.add(new InvoiceItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['company_id'] = this.companyId;
    data['companyname'] = this.companyname;
    data['project'] = this.project;
    data['projectname'] = this.projectname;
    data['building'] = this.building;
    data['nameofbuilding'] = this.nameofbuilding;
    data['ledgerid'] = this.ledgerid;
    data['invref'] = this.invref;
    data['po_id'] = this.poId;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['address'] = this.address;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['email'] = this.email;
    data['gst'] = this.gst;
    data['pan'] = this.pan;
    data['inv_date'] = this.invDate;
    data['invcat'] = this.invcat;
    data['invcomments'] = this.invcomments;
    data['cgst_percent'] = this.cgstPercent;
    data['cgst_amount'] = this.cgstAmount;
    data['sgst_percent'] = this.sgstPercent;
    data['sgst_amount'] = this.sgstAmount;
    data['igst_percent'] = this.igstPercent;
    data['igst_amount'] = this.igstAmount;
    data['invamount'] = this.invamount;
    data['subtotal'] = this.subtotal;
    data['taxamount'] = this.taxamount;
    data['totalamount'] = this.totalamount;
    data['created_date'] = this.createdDate;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['updated_date'] = this.updatedDate;
    data['status'] = this.status;
    data['filename'] = this.filename;
    data['filetype'] = this.filetype;
    data['size'] = this.size;
    data['uploaduser'] = this.uploaduser;
    data['uploaddate'] = this.uploaddate;
    data['current_userid'] = this.current_userid;
    if (this.invoiceItems != null) {
      data['invoice_items'] =
          this.invoiceItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceItems {
  String? invoiceItemId;
  String? invoiceId;
  String? itemDescription;
  String? itemAmount;
  String? qty;
  String? hsnCode;
  String? itemCgst;
  String? itemSgst;
  String? itemIgst;
  String? itemTds;
  String? itemTax;
  String? itemTotal;
  String? itemVat;

  InvoiceItems(
      {this.invoiceItemId,
      this.invoiceId,
      this.itemDescription,
      this.itemAmount,
      this.qty,
      this.hsnCode,
      this.itemCgst,
      this.itemSgst,
      this.itemIgst,
      this.itemTds,
      this.itemTax,
      this.itemTotal,
      this.itemVat});

  InvoiceItems.fromJson(Map<String, dynamic> json) {
    invoiceItemId = json['invoice_item_id'];
    invoiceId = json['invoice_id'];
    itemDescription = json['item_description'];
    itemAmount = json['item_amount'];
    qty = json['qty'];
    hsnCode = json['hsn_code'];
    itemCgst = json['item_cgst'];
    itemSgst = json['item_sgst'];
    itemIgst = json['item_igst'];
    itemTds = json['item_tds'];
    itemTax = json['item_tax'];
    itemTotal = json['item_total'];
    itemVat = json['item_vat'];
    // qty = json['item_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_item_id'] = this.invoiceItemId;
    data['invoice_id'] = this.invoiceId;
    data['item_description'] = this.itemDescription;
    data['item_amount'] = this.itemAmount;
    data['qty'] = this.qty;
    data['hsn_code'] = this.hsnCode;
    data['item_cgst'] = this.itemCgst;
    data['item_sgst'] = this.itemSgst;
    data['item_igst'] = this.itemIgst;
    data['item_tds'] = this.itemTds;
    data['item_tax'] = this.itemTax;
    data['item_total'] = this.itemTotal;
    data['item_vat'] = this.itemVat;
    data['item_qty'] = this.qty;
    data['item_code'] = this.hsnCode;
    return data;
  }
}
