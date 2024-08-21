class SalesOrderDetailModel {
  String? id;
  String? rPDocNo;
  String? dateTimeCreated;
  String? sORefCodeNo;
  String? sOItemCode;
  String? sOItemDescription;
  String? sOOrderQty;
  String? sOItemUnit;
  int? sOItemPrice;
  String? sOCustomerNo;
  int? sOAlreadySelected;
  String? sOItemFreeQty;
  int? sOTotalAmountPrice;
  int? sOTotalAmountNetPrice;
  int? sOTotalVatAmount;
  int? sOTotalDiscountAmount;
  String? sORemarks;
  TblSalesOrder? tblSalesOrder;
  String? order;

  SalesOrderDetailModel({
    this.id,
    this.rPDocNo,
    this.dateTimeCreated,
    this.sORefCodeNo,
    this.sOItemCode,
    this.sOItemDescription,
    this.sOOrderQty,
    this.sOItemUnit,
    this.sOItemPrice,
    this.sOCustomerNo,
    this.sOAlreadySelected,
    this.sOItemFreeQty,
    this.sOTotalAmountPrice,
    this.sOTotalAmountNetPrice,
    this.sOTotalVatAmount,
    this.sOTotalDiscountAmount,
    this.sORemarks,
    this.order,
    this.tblSalesOrder,
  });

  SalesOrderDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rPDocNo = json['RPDocNo'];
    dateTimeCreated = json['DateTimeCreated'];
    sORefCodeNo = json['SORefCodeNo'];
    sOItemCode = json['SOItemCode'];
    sOItemDescription = json['SOItemDescription'];
    sOOrderQty = json['SOOrderQty'];
    sOItemUnit = json['SOItemUnit'];
    sOItemPrice = json['SOItemPrice'];
    sOCustomerNo = json['SOCustomerNo'];
    sOAlreadySelected = json['SOAlreadySelected'];
    sOItemFreeQty = json['SOItemFreeQty'];
    sOTotalAmountPrice = json['SOTotalAmountPrice'];
    sOTotalAmountNetPrice = json['SOTotalAmountNetPrice'];
    sOTotalVatAmount = json['SOTotalVatAmount'];
    sOTotalDiscountAmount = json['SOTotalDiscountAmount'];
    sORemarks = json['SORemarks'];
    order = json['Order'].toString();
    tblSalesOrder = json['tblSalesOrder'] != null
        ? TblSalesOrder.fromJson(json['tblSalesOrder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['RPDocNo'] = rPDocNo;
    data['DateTimeCreated'] = dateTimeCreated;
    data['SORefCodeNo'] = sORefCodeNo;
    data['SOItemCode'] = sOItemCode;
    data['SOItemDescription'] = sOItemDescription;
    data['SOOrderQty'] = sOOrderQty;
    data['SOItemUnit'] = sOItemUnit;
    data['SOItemPrice'] = sOItemPrice;
    data['SOCustomerNo'] = sOCustomerNo;
    data['SOAlreadySelected'] = sOAlreadySelected;
    data['SOItemFreeQty'] = sOItemFreeQty;
    data['SOTotalAmountPrice'] = sOTotalAmountPrice;
    data['SOTotalAmountNetPrice'] = sOTotalAmountNetPrice;
    data['SOTotalVatAmount'] = sOTotalVatAmount;
    data['SOTotalDiscountAmount'] = sOTotalDiscountAmount;
    data['SORemarks'] = sORemarks;
    data['Order'] = order;
    if (tblSalesOrder != null) {
      data['tblSalesOrder'] = tblSalesOrder!.toJson();
    }
    return data;
  }
}

class TblSalesOrder {
  String? id;
  String? sORefCodeNo;
  String? billTo;
  String? shipTo;
  String? paymentTerms;
  String? mobileNo;
  String? shiperGLNNo;
  String? rPDocNo;
  int? sOStatus;
  String? sODateTimeCreated;
  String? sOSalesManIdNo;
  int? sOTotalAmountNoVat;
  int? sOTotalAmountWVat;
  int? sOTotalVatAmount;
  String? sOTotalItemFreeQty;
  int? sOTotalItemFreeAmount;

  TblSalesOrder({
    this.id,
    this.sORefCodeNo,
    this.billTo,
    this.shipTo,
    this.paymentTerms,
    this.mobileNo,
    this.shiperGLNNo,
    this.rPDocNo,
    this.sOStatus,
    this.sODateTimeCreated,
    this.sOSalesManIdNo,
    this.sOTotalAmountNoVat,
    this.sOTotalAmountWVat,
    this.sOTotalVatAmount,
    this.sOTotalItemFreeQty,
    this.sOTotalItemFreeAmount,
  });

  TblSalesOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sORefCodeNo = json['SORefCodeNo'];
    billTo = json['BillTo'];
    shipTo = json['ShipTo'];
    paymentTerms = json['PaymentTerms'];
    mobileNo = json['MobileNo'];
    shiperGLNNo = json['ShiperGLNNo'];
    rPDocNo = json['RPDocNo'];
    sOStatus = json['SOStatus'];
    sODateTimeCreated = json['SODateTimeCreated'];
    sOSalesManIdNo = json['SOSalesManIdNo'];
    sOTotalAmountNoVat = json['SOTotalAmountNoVat'];
    sOTotalAmountWVat = json['SOTotalAmountWVat'];
    sOTotalVatAmount = json['SOTotalVatAmount'];
    sOTotalItemFreeQty = json['SOTotalItemFreeQty'];
    sOTotalItemFreeAmount = json['SOTotalItemFreeAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['SORefCodeNo'] = sORefCodeNo;
    data['BillTo'] = billTo;
    data['ShipTo'] = shipTo;
    data['PaymentTerms'] = paymentTerms;
    data['MobileNo'] = mobileNo;
    data['ShiperGLNNo'] = shiperGLNNo;
    data['RPDocNo'] = rPDocNo;
    data['SOStatus'] = sOStatus;
    data['SODateTimeCreated'] = sODateTimeCreated;
    data['SOSalesManIdNo'] = sOSalesManIdNo;
    data['SOTotalAmountNoVat'] = sOTotalAmountNoVat;
    data['SOTotalAmountWVat'] = sOTotalAmountWVat;
    data['SOTotalVatAmount'] = sOTotalVatAmount;
    data['SOTotalItemFreeQty'] = sOTotalItemFreeQty;
    data['SOTotalItemFreeAmount'] = sOTotalItemFreeAmount;
    return data;
  }
}
