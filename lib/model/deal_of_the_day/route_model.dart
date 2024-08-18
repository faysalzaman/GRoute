class RouteModel {
  String? id;
  String? memberId;
  String? routeName;
  String? glnIdNumber;
  double? startLatitude;
  double? startLongitude;
  double? endLatitude;
  double? endLongitude;
  String? routeFullAddress;
  String? routeCity;
  String? routeStreet;
  String? createdAt;
  String? updatedAt;
  String? routeAreaId;
  RouteArea? routeArea;

  RouteModel({
    this.id,
    this.memberId,
    this.routeName,
    this.glnIdNumber,
    this.startLatitude,
    this.startLongitude,
    this.endLatitude,
    this.endLongitude,
    this.routeFullAddress,
    this.routeCity,
    this.routeStreet,
    this.createdAt,
    this.updatedAt,
    this.routeAreaId,
    this.routeArea,
  });

  RouteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    memberId = json['member_id'].toString();
    routeName = json['route_name'].toString();
    glnIdNumber = json['gln_id_number'].toString();
    startLatitude = json['start_latitude'];
    startLongitude = json['start_longitude'];
    endLatitude = json['end_latitude'];
    endLongitude = json['end_longitude'];
    routeFullAddress = json['route_full_address'].toString();
    routeCity = json['route_city'].toString();
    routeStreet = json['route_street'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
    routeAreaId = json['routeAreaId'].toString();
    routeArea = json['RouteArea'] != null
        ? RouteArea.fromJson(json['RouteArea'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member_id'] = memberId;
    data['route_name'] = routeName;
    data['gln_id_number'] = glnIdNumber;
    data['start_latitude'] = startLatitude;
    data['start_longitude'] = startLongitude;
    data['end_latitude'] = endLatitude;
    data['end_longitude'] = endLongitude;
    data['route_full_address'] = routeFullAddress;
    data['route_city'] = routeCity;
    data['route_street'] = routeStreet;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['routeAreaId'] = routeAreaId;
    if (routeArea != null) {
      data['RouteArea'] = routeArea!.toJson();
    }
    return data;
  }
}

class RouteArea {
  String? id;
  String? areaName;
  String? memberId;
  String? regionPolygon;
  String? createdAt;
  String? updatedAt;

  RouteArea({
    this.id,
    this.areaName,
    this.memberId,
    this.regionPolygon,
    this.createdAt,
    this.updatedAt,
  });

  RouteArea.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    areaName = json['area_name'].toString();
    memberId = json['member_id'].toString();
    regionPolygon = json['region_polygon'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['area_name'] = areaName;
    data['member_id'] = memberId;
    data['region_polygon'] = regionPolygon;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
