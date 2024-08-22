import 'package:g_route/constants/app_urls.dart';
import 'package:g_route/model/start_of_the_day/sales_order_detail_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SalesOrderDetailController {
  static Future<List<SalesOrderDetailModel>> getSalesOrderDetail(
      String sORefCodeNo) async {
    // REF001
    final url = Uri.parse(
        "${AppUrls.baseUrl}/api/v1/salesOrderDetails?SORefCodeNo=REF001");

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body) as List;
      List<SalesOrderDetailModel> salesOrderDetailModel =
          data.map((e) => SalesOrderDetailModel.fromJson(e)).toList();
      return salesOrderDetailModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(data['error']);
    }
  }
}
