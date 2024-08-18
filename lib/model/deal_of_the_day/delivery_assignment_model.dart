// ignore_for_file: file_names

import 'package:g_route/model/deal_of_the_day/orders_model.dart';
import 'package:g_route/model/deal_of_the_day/route_model.dart';
import 'package:g_route/model/deal_of_the_day/sub_user_model.dart';
import 'package:g_route/model/deal_of_the_day/vehicle_model.dart';

class DeliveryAssignmentModel {
  String? id;
  String? status;
  SubUserModel? subUser;
  VehicleModel? vehicle;
  RouteModel? route;
  List<OrdersModel>? orders;

  DeliveryAssignmentModel({
    this.id,
    this.status,
    this.subUser,
    this.vehicle,
    this.route,
    this.orders,
  });

  DeliveryAssignmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    subUser =
        json['subUser'] != null ? SubUserModel.fromJson(json['subUser']) : null;
    vehicle =
        json['vehicle'] != null ? VehicleModel.fromJson(json['vehicle']) : null;
    route = json['route'] != null ? RouteModel.fromJson(json['route']) : null;
    if (json['orders'] != null) {
      orders = <OrdersModel>[];
      json['orders'].forEach((v) {
        orders!.add(OrdersModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    if (subUser != null) {
      data['subUser'] = subUser!.toJson();
    }
    if (vehicle != null) {
      data['vehicle'] = vehicle!.toJson();
    }
    if (route != null) {
      data['route'] = route!.toJson();
    }
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
