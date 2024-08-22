class OrdersModel {
  String? id;
  String? memberId;
  String? pickingRouteId;
  String? inventLocationId;
  String? transRefId;
  String? expeditionStatus;
  String? configId;
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
  String? userAssignmentId;
  String? createdAt;
  String? updatedAt;
  String? customerId;
  String? tblSalesOrderId;
  CustomerProfile? customerProfile;
  TblSalesOrder? tblSalesOrder;

  OrdersModel({
    this.id,
    this.memberId,
    this.pickingRouteId,
    this.inventLocationId,
    this.transRefId,
    this.expeditionStatus,
    this.configId,
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
    this.userAssignmentId,
    this.createdAt,
    this.updatedAt,
    this.customerId,
    this.tblSalesOrderId,
    this.customerProfile,
    this.tblSalesOrder,
  });

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    pickingRouteId = json['pickingRouteId'];
    inventLocationId = json['inventLocationId'];
    transRefId = json['transRefId'];
    expeditionStatus = json['expeditionStatus'];
    configId = json['configId'];
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
    userAssignmentId = json['userAssignment_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    customerId = json['customer_id'];
    tblSalesOrderId = json['tblSalesOrderId'];
    customerProfile = json['customerProfile'] != null
        ? CustomerProfile.fromJson(json['customerProfile'])
        : null;
    tblSalesOrder = json['tblSalesOrder'] != null
        ? TblSalesOrder.fromJson(json['tblSalesOrder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member_id'] = memberId;
    data['pickingRouteId'] = pickingRouteId;
    data['inventLocationId'] = inventLocationId;
    data['transRefId'] = transRefId;
    data['expeditionStatus'] = expeditionStatus;
    data['configId'] = configId;
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
    data['userAssignment_id'] = userAssignmentId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['customer_id'] = customerId;
    data['tblSalesOrderId'] = tblSalesOrderId;
    if (customerProfile != null) {
      data['customerProfile'] = customerProfile!.toJson();
    }
    if (tblSalesOrder != null) {
      data['tblSalesOrder'] = tblSalesOrder!.toJson();
    }
    return data;
  }
}

class CustomerProfile {
  String? id;
  String? memberId;
  String? customerName;
  String? contactPerson;
  String? photo;
  String? mobileNumber;
  String? email;
  String? address;
  String? area;
  String? city;
  String? latitude;
  String? longitude;
  String? companyName;
  String? gsrnNumber;
  String? glnLocationNo;
  String? paymentType;
  String? walletIdNo;
  String? dateTimeCreated;
  String? userId;
  String? customerId;

  CustomerProfile({
    this.id,
    this.memberId,
    this.customerName,
    this.contactPerson,
    this.photo,
    this.mobileNumber,
    this.email,
    this.address,
    this.area,
    this.city,
    this.latitude,
    this.longitude,
    this.companyName,
    this.gsrnNumber,
    this.glnLocationNo,
    this.paymentType,
    this.walletIdNo,
    this.dateTimeCreated,
    this.userId,
    this.customerId,
  });

  CustomerProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    customerName = json['customer_name'];
    contactPerson = json['contact_person'];
    photo = json['photo'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    address = json['address'];
    area = json['area'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    companyName = json['company_name'];
    gsrnNumber = json['gsrn_number'];
    glnLocationNo = json['gln_location_no'];
    paymentType = json['payment_type'];
    walletIdNo = json['wallet_id_no'];
    dateTimeCreated = json['dateTimeCreated'];
    userId = json['user_id'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member_id'] = memberId;
    data['customer_name'] = customerName;
    data['contact_person'] = contactPerson;
    data['photo'] = photo;
    data['mobile_number'] = mobileNumber;
    data['email'] = email;
    data['address'] = address;
    data['area'] = area;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['company_name'] = companyName;
    data['gsrn_number'] = gsrnNumber;
    data['gln_location_no'] = glnLocationNo;
    data['payment_type'] = paymentType;
    data['wallet_id_no'] = walletIdNo;
    data['dateTimeCreated'] = dateTimeCreated;
    data['user_id'] = userId;
    data['customer_id'] = customerId;
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

  TblSalesOrder(
      {this.id,
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
      this.sOTotalItemFreeAmount});

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
