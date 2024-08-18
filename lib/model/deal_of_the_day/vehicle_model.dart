class VehicleModel {
  String? id;
  String? plateNumber;
  String? make;
  String? model;
  String? year;
  String? color;
  String? owner;
  String? vinNumber;
  String? glnIdNumber;
  String? giaiNumber;
  String? memberId;
  String? createdAt;
  String? updatedAt;

  VehicleModel({
    this.id,
    this.plateNumber,
    this.make,
    this.model,
    this.year,
    this.color,
    this.owner,
    this.vinNumber,
    this.glnIdNumber,
    this.giaiNumber,
    this.memberId,
    this.createdAt,
    this.updatedAt,
  });

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    plateNumber = json['plate_number'].toString();
    make = json['make'].toString();
    model = json['model'].toString();
    year = json['year'].toString();
    color = json['color'].toString();
    owner = json['owner'].toString();
    vinNumber = json['vin_number'].toString();
    glnIdNumber = json['gln_id_number'].toString();
    giaiNumber = json['giai_number'].toString();
    memberId = json['member_id'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plate_number'] = plateNumber;
    data['make'] = make;
    data['model'] = model;
    data['year'] = year;
    data['color'] = color;
    data['owner'] = owner;
    data['vin_number'] = vinNumber;
    data['gln_id_number'] = glnIdNumber;
    data['giai_number'] = giaiNumber;
    data['member_id'] = memberId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
