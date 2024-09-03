class CustomersProfileModel {
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
  String? gcpGLNID;

  CustomersProfileModel({
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
    this.gcpGLNID,
  });

  CustomersProfileModel.fromJson(Map<String, dynamic> json) {
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
    gcpGLNID = json['gcpGLNID'];
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
    data['gcpGLNID'] = gcpGLNID;
    return data;
  }
}
