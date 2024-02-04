class AllInvoiceItems {
  String? status;
  String? message;
  List<AllItemData>? data;

  AllInvoiceItems({this.status, this.message, this.data});

  AllInvoiceItems.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllItemData>[];
      json['data'].forEach((v) {
        data!.add(AllItemData.fromJson(v));
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

class AllItemData {
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

  AllItemData(
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

  AllItemData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
