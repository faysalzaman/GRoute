class SubUserModel {
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
  String? createdAt;
  String? updatedAt;

  SubUserModel({
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
    this.createdAt,
    this.updatedAt,
  });

  SubUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    memberId = json['memberId'].toString();
    email = json['email'].toString();
    password = json['password'].toString();
    name = json['name'].toString();
    gsrnIdNumber = json['gsrnIdNumber'].toString();
    mobileNumber = json['mobileNumber'].toString();
    residenceIdNumber = json['residenceIdNumber'].toString();
    nationalAddressQRCode = json['nationalAddressQRCode'].toString();
    role = json['role'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
