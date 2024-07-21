class LoginModel {
  String? id;
  String? memberId;
  String? email;
  String? name;
  String? gsrnIdNumber;
  String? mobileNumber;
  String? residenceIdNumber;
  String? nationalAddressQrcode;
  String? role;

  LoginModel({
    this.id,
    this.memberId,
    this.email,
    this.name,
    this.gsrnIdNumber,
    this.mobileNumber,
    this.residenceIdNumber,
    this.nationalAddressQrcode,
    this.role,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    email = json['email'];
    name = json['name'];
    gsrnIdNumber = json['gsrn_id_number'];
    mobileNumber = json['mobile_number'];
    residenceIdNumber = json['residence_id_number'];
    nationalAddressQrcode = json['national_address_qrcode'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member_id'] = memberId;
    data['email'] = email;
    data['name'] = name;
    data['gsrn_id_number'] = gsrnIdNumber;
    data['mobile_number'] = mobileNumber;
    data['residence_id_number'] = residenceIdNumber;
    data['national_address_qrcode'] = nationalAddressQrcode;
    data['role'] = role;
    return data;
  }
}
