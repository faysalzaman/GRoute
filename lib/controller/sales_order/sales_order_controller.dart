import 'package:g_route/constants/app_preferences.dart';
import 'package:g_route/constants/app_urls.dart';
import 'package:g_route/model/start_of_the_day/assigned_orders_model.dart';
import 'package:g_route/model/start_of_the_day/customers_profile_model.dart';
import 'package:g_route/model/start_of_the_day/goods_issue_model.dart';
import 'package:g_route/model/start_of_the_day/gtin_product_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SalesOrderController {
  static Future<List<AssignedOrdersModel>> getAssignedOrders() async {
    String? userId;
    await AppPreferences.getUserId().then((value) {
      userId = value!;
    });

    final url = Uri.parse(
        "${AppUrls.baseUrl}/api/v1/assignedOrder/getAssignedOrders?driverId=$userId");

    final headers = <String, String>{'Content-Type': 'application/json'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body) as List;
      List<AssignedOrdersModel> assignedOrdersModel =
          data.map((e) => AssignedOrdersModel.fromJson(e)).toList();
      return assignedOrdersModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(data['error']);
    }
  }

  static Future<List<GoodsIssueModel>> getGoodsIssueDetails(String id) async {
    final url = Uri.parse(
        "${AppUrls.baseUrl}/api/v1/goodsIssueDetails?tblGoodsIssueMasterId=$id");

    final headers = <String, String>{'Content-Type': 'application/json'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body) as List;
      List<GoodsIssueModel> assignedOrdersModel =
          data.map((e) => GoodsIssueModel.fromJson(e)).toList();
      return assignedOrdersModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(data['error']);
    }
  }

  // get customer profile
  static Future<CustomersProfileModel> getCustomerProfile(
      String gcpGlnId) async {
    final url = Uri.parse(
        "${AppUrls.baseUrl}/api/v1/customers/getCustomerProfiles?gcpGLNID=234553333542");

    final headers = <String, String>{'Content-Type': 'application/json'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return CustomersProfileModel.fromJson(data[0]);
    } else {
      var data = jsonDecode(response.body);
      throw Exception(data['error']);
    }
  }

  static Future<GtinProductModel> getGtinProductModel(String barcode) async {
    final url =
        Uri.parse("${AppUrls.gs1Url}/api/products?barcode=6287003071105");

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbklkIjoiY2x0aXowN2tlMDAwMTEza24xOHIwcHE3NyIsImVtYWlsIjoiYWJkdWxtYWppZDFtMkBnbWFpbC5jb20iLCJpc19zdXBlcl9hZG1pbiI6MSwidXNlcm5hbWUiOiJBYmR1bCBNYWppZCIsInBlcm1pc3Npb25zIjpbIm1lbWJlcnMiLCJicmFuZHMiLCJndGluX2JhcmNvZGUiLCJnbG5fbG9jYXRpb24iLCJzc2NjIiwiZm9yZWlnbl9ndGluIiwicGF5bWVudF9zbGlwc19mb3JlaWduX2d0aW4iLCJvbGRfaW5hY3RpdmVfbWVtYmVycyIsImhlbHBfZGVzayIsInN0YWZmX2hlbHBfZGVzayIsInByb2R1Y3RfcGFja2FnaW5nIiwib3RoZXJfcHJvZHVjdHMiLCJjcl9udW1iZXIiXSwicm9sZXMiOlsiTWFya2V0aW5nIFN0YWZmIl0sImlhdCI6MTcyNTE4OTg4NCwiZXhwIjoxNzMyOTY1ODg0fQ.prFc6KaZxuJ8WwQW7C9TwhFKCi-iAi0dBNXwf4F0DKQ'
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body) as List;
      return GtinProductModel.fromJson(data[0]);
    } else {
      var data = jsonDecode(response.body);
      throw Exception(data['error']);
    }
  }
}
