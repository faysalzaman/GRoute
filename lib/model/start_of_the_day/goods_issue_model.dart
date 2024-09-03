class GoodsIssueModel {
  String? id;
  String? shippingTrxCode;
  String? gTIN;
  String? itemSKU;
  String? batchNo;
  String? serialNo;
  String? manufacturingDate;
  String? expiryDate;
  String? packagingDate;
  String? sellBy;
  String? receivingUOM;
  String? boxBarcode;
  String? sSCCBarcode;
  String? qty;
  String? eUDAMEDCode;
  String? uDICode;
  String? gPCCode;
  String? tblGoodsIssueMasterId;

  GoodsIssueModel({
    this.id,
    this.shippingTrxCode,
    this.gTIN,
    this.itemSKU,
    this.batchNo,
    this.serialNo,
    this.manufacturingDate,
    this.expiryDate,
    this.packagingDate,
    this.sellBy,
    this.receivingUOM,
    this.boxBarcode,
    this.sSCCBarcode,
    this.qty,
    this.eUDAMEDCode,
    this.uDICode,
    this.gPCCode,
    this.tblGoodsIssueMasterId,
  });

  GoodsIssueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shippingTrxCode = json['ShippingTrxCode'];
    gTIN = json['GTIN'];
    itemSKU = json['ItemSKU'];
    batchNo = json['BatchNo'];
    serialNo = json['SerialNo'];
    manufacturingDate = json['ManufacturingDate'];
    expiryDate = json['ExpiryDate'];
    packagingDate = json['PackagingDate'];
    sellBy = json['SellBy'];
    receivingUOM = json['ReceivingUOM'];
    boxBarcode = json['BoxBarcode'];
    sSCCBarcode = json['SSCCBarcode'];
    qty = json['Qty'];
    eUDAMEDCode = json['EUDAMED_Code'];
    uDICode = json['UDI_Code'];
    gPCCode = json['GPC_Code'];
    tblGoodsIssueMasterId = json['tblGoodsIssueMasterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ShippingTrxCode'] = shippingTrxCode;
    data['GTIN'] = gTIN;
    data['ItemSKU'] = itemSKU;
    data['BatchNo'] = batchNo;
    data['SerialNo'] = serialNo;
    data['ManufacturingDate'] = manufacturingDate;
    data['ExpiryDate'] = expiryDate;
    data['PackagingDate'] = packagingDate;
    data['SellBy'] = sellBy;
    data['ReceivingUOM'] = receivingUOM;
    data['BoxBarcode'] = boxBarcode;
    data['SSCCBarcode'] = sSCCBarcode;
    data['Qty'] = qty;
    data['EUDAMED_Code'] = eUDAMEDCode;
    data['UDI_Code'] = uDICode;
    data['GPC_Code'] = gPCCode;
    data['tblGoodsIssueMasterId'] = tblGoodsIssueMasterId;
    return data;
  }
}
