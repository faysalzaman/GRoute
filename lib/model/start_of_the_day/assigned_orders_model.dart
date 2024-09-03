class AssignedOrdersModel {
  String? id;
  String? memberId;
  String? pickingRouteId;
  String? inventLocationId;
  String? transRefId;
  String? wmsLocationId;
  String? images;
  String? status;
  String? signature;
  String? assignedTime;
  String? startJourneyTime;
  String? arrivalTime;
  String? unloadingTime;
  String? invoiceCreationTime;
  String? endJourneyTime;
  String? tblGoodsIssueMasterId;
  String? driverId;
  String? createdAt;
  String? updatedAt;
  Member? member;
  Driver? driver;
  TblGoodsIssueMaster? tblGoodsIssueMaster;

  AssignedOrdersModel({
    this.id,
    this.memberId,
    this.pickingRouteId,
    this.inventLocationId,
    this.transRefId,
    this.wmsLocationId,
    this.images,
    this.status,
    this.signature,
    this.assignedTime,
    this.startJourneyTime,
    this.arrivalTime,
    this.unloadingTime,
    this.invoiceCreationTime,
    this.endJourneyTime,
    this.tblGoodsIssueMasterId,
    this.driverId,
    this.createdAt,
    this.updatedAt,
    this.member,
    this.driver,
    this.tblGoodsIssueMaster,
  });

  AssignedOrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    pickingRouteId = json['pickingRouteId'];
    inventLocationId = json['inventLocationId'];
    transRefId = json['transRefId'];
    wmsLocationId = json['wmsLocationId'];
    images = json['images'];
    status = json['status'];
    signature = json['signature'];
    assignedTime = json['assignedTime'];
    startJourneyTime = json['startJourneyTime'];
    arrivalTime = json['arrivalTime'];
    unloadingTime = json['unloadingTime'];
    invoiceCreationTime = json['invoiceCreationTime'];
    endJourneyTime = json['endJourneyTime'];
    tblGoodsIssueMasterId = json['tblGoodsIssueMasterId'];
    driverId = json['driverId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    member = json['member'] != null ? Member.fromJson(json['member']) : null;
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    tblGoodsIssueMaster = json['tblGoodsIssueMaster'] != null
        ? TblGoodsIssueMaster.fromJson(json['tblGoodsIssueMaster'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member_id'] = memberId;
    data['pickingRouteId'] = pickingRouteId;
    data['inventLocationId'] = inventLocationId;
    data['transRefId'] = transRefId;
    data['wmsLocationId'] = wmsLocationId;
    data['images'] = images;
    data['status'] = status;
    data['signature'] = signature;
    data['assignedTime'] = assignedTime;
    data['startJourneyTime'] = startJourneyTime;
    data['arrivalTime'] = arrivalTime;
    data['unloadingTime'] = unloadingTime;
    data['invoiceCreationTime'] = invoiceCreationTime;
    data['endJourneyTime'] = endJourneyTime;
    data['tblGoodsIssueMasterId'] = tblGoodsIssueMasterId;
    data['driverId'] = driverId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (member != null) {
      data['member'] = member!.toJson();
    }
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    if (tblGoodsIssueMaster != null) {
      data['tblGoodsIssueMaster'] = tblGoodsIssueMaster!.toJson();
    }
    return data;
  }
}

class Member {
  String? id;
  String? name;
  String? companyName;
  String? mobile;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;

  Member({
    this.id,
    this.name,
    this.companyName,
    this.mobile,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyName = json['companyName'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['companyName'] = companyName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['password'] = password;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Driver {
  String? id;
  String? memberId;
  String? email;
  String? password;
  String? name;
  String? gsrnIdNumber;
  String? mobileNumber;
  String? residenceIdNumber;
  String? nationalAddressQRCode;
  String? role;
  String? routeAreaId;
  String? createdAt;
  String? updatedAt;

  Driver({
    this.id,
    this.memberId,
    this.email,
    this.password,
    this.name,
    this.gsrnIdNumber,
    this.mobileNumber,
    this.residenceIdNumber,
    this.nationalAddressQRCode,
    this.role,
    this.routeAreaId,
    this.createdAt,
    this.updatedAt,
  });

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['memberId'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    gsrnIdNumber = json['gsrnIdNumber'];
    mobileNumber = json['mobileNumber'];
    residenceIdNumber = json['residenceIdNumber'];
    nationalAddressQRCode = json['nationalAddressQRCode'];
    role = json['role'];
    routeAreaId = json['routeAreaId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['memberId'] = memberId;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['gsrnIdNumber'] = gsrnIdNumber;
    data['mobileNumber'] = mobileNumber;
    data['residenceIdNumber'] = residenceIdNumber;
    data['nationalAddressQRCode'] = nationalAddressQRCode;
    data['role'] = role;
    data['routeAreaId'] = routeAreaId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class TblGoodsIssueMaster {
  String? id;
  String? shippingTrxCode;
  String? shipToLocation;
  String? growerSupplierGLN;
  String? shipFromGLN;
  String? shipDate;
  String? activityType;
  String? bisStep;
  String? disposition;
  String? bisTransactionType;
  String? bisTransactionID;
  String? purchaseOrderNo;
  String? salesOrderNo;
  String? salesInvoiceNo;
  String? transactionDateTime;
  String? gcpGLNID;
  String? gCPNo;
  String? createdAt;
  String? updatedAt;
  String? memberId;

  TblGoodsIssueMaster({
    this.id,
    this.shippingTrxCode,
    this.shipToLocation,
    this.growerSupplierGLN,
    this.shipFromGLN,
    this.shipDate,
    this.activityType,
    this.bisStep,
    this.disposition,
    this.bisTransactionType,
    this.bisTransactionID,
    this.purchaseOrderNo,
    this.salesOrderNo,
    this.salesInvoiceNo,
    this.transactionDateTime,
    this.gcpGLNID,
    this.gCPNo,
    this.createdAt,
    this.updatedAt,
    this.memberId,
  });

  TblGoodsIssueMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shippingTrxCode = json['ShippingTrxCode'];
    shipToLocation = json['ShipToLocation'];
    growerSupplierGLN = json['GrowerSupplierGLN'];
    shipFromGLN = json['ShipFromGLN'];
    shipDate = json['ShipDate'];
    activityType = json['ActivityType'];
    bisStep = json['BisStep'];
    disposition = json['Disposition'];
    bisTransactionType = json['BisTransactionType'];
    bisTransactionID = json['BisTransactionID'];
    purchaseOrderNo = json['PurchaseOrderNo'];
    salesOrderNo = json['SalesOrderNo'];
    salesInvoiceNo = json['SalesInvoiceNo'];
    transactionDateTime = json['TransactionDateTime'];
    gcpGLNID = json['gcpGLNID'];
    gCPNo = json['GCPNo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    memberId = json['member_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ShippingTrxCode'] = shippingTrxCode;
    data['ShipToLocation'] = shipToLocation;
    data['GrowerSupplierGLN'] = growerSupplierGLN;
    data['ShipFromGLN'] = shipFromGLN;
    data['ShipDate'] = shipDate;
    data['ActivityType'] = activityType;
    data['BisStep'] = bisStep;
    data['Disposition'] = disposition;
    data['BisTransactionType'] = bisTransactionType;
    data['BisTransactionID'] = bisTransactionID;
    data['PurchaseOrderNo'] = purchaseOrderNo;
    data['SalesOrderNo'] = salesOrderNo;
    data['SalesInvoiceNo'] = salesInvoiceNo;
    data['TransactionDateTime'] = transactionDateTime;
    data['gcpGLNID'] = gcpGLNID;
    data['GCPNo'] = gCPNo;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['member_id'] = memberId;
    return data;
  }
}
