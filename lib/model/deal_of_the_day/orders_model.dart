class OrdersModel {
  String? id;
  String? memberId;
  String? pickingRouteId;
  String? inventLocationId;
  String? transRefId;
  String? itemId;
  int? qty;
  String? expeditionStatus;
  String? configId;
  String? wmsLocationId;
  String? itemName;
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
  String? salesOrderID;
  String? createdAt;
  String? updatedAt;
  String? customerId;
  String? tblSalesOrderId;
  CustomerProfile? customerProfile;

  OrdersModel({
    this.id,
    this.memberId,
    this.pickingRouteId,
    this.inventLocationId,
    this.transRefId,
    this.itemId,
    this.qty,
    this.expeditionStatus,
    this.configId,
    this.wmsLocationId,
    this.itemName,
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
    this.salesOrderID,
    this.createdAt,
    this.updatedAt,
    this.customerId,
    this.tblSalesOrderId,
    this.customerProfile,
  });

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    memberId = json['member_id'].toString();
    pickingRouteId = json['pickingRouteId'].toString();
    inventLocationId = json['inventLocationId'].toString();
    transRefId = json['transRefId'].toString();
    itemId = json['itemId'].toString();
    qty = json['qty'];
    expeditionStatus = json['expeditionStatus'].toString();
    configId = json['configId'].toString();
    wmsLocationId = json['wmsLocationId'].toString();
    itemName = json['itemName'].toString();
    images = json['images'].toString();
    status = json['status'].toString();
    signature = json['signature'].toString();
    assignedTime = json['assignedTime'].toString();
    startJourneyTime = json['startJourneyTime'].toString();
    arrivalTime = json['arrivalTime'].toString();
    unloadingTime = json['unloadingTime'].toString();
    invoiceCreationTime = json['invoiceCreationTime'].toString();
    endJourneyTime = json['endJourneyTime'].toString();
    userAssignmentId = json['userAssignment_id'].toString();
    salesOrderID = json['salesOrderID'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
    customerId = json['customer_id'].toString();
    tblSalesOrderId = json['tblSalesOrderId'].toString();
    customerProfile = json['customerProfile'] != null
        ? CustomerProfile.fromJson(json['customerProfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member_id'] = memberId;
    data['pickingRouteId'] = pickingRouteId;
    data['inventLocationId'] = inventLocationId;
    data['transRefId'] = transRefId;
    data['itemId'] = itemId;
    data['qty'] = qty;
    data['expeditionStatus'] = expeditionStatus;
    data['configId'] = configId;
    data['wmsLocationId'] = wmsLocationId;
    data['itemName'] = itemName;
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
    data['salesOrderID'] = salesOrderID;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['customer_id'] = customerId;
    data['tblSalesOrderId'] = tblSalesOrderId;
    if (customerProfile != null) {
      data['customerProfile'] = customerProfile!.toJson();
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
    id = json['id'].toString();
    memberId = json['member_id'].toString();
    customerName = json['customer_name'].toString();
    contactPerson = json['contact_person'].toString();
    photo = json['photo'].toString();
    mobileNumber = json['mobile_number'].toString();
    email = json['email'].toString();
    address = json['address'].toString();
    area = json['area'].toString();
    city = json['city'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    companyName = json['company_name'].toString();
    gsrnNumber = json['gsrn_number'].toString();
    glnLocationNo = json['gln_location_no'].toString();
    paymentType = json['payment_type'].toString();
    walletIdNo = json['wallet_id_no'].toString();
    dateTimeCreated = json['dateTimeCreated'].toString();
    userId = json['user_id'].toString();
    customerId = json['customer_id'].toString();
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
