import 'dart:convert';

import 'package:g_route/constants/app_preferences.dart';
import 'package:g_route/constants/app_urls.dart';
import 'package:g_route/model/start_of_the_day/delivery_assignment_model.dart';
import 'package:http/http.dart' as http;

class DeliveryController {
  static Future<DeliveryAssignmentModel> getdeliveryAssignmentInfo() async {
    String? userId;
    await AppPreferences.getUserId().then((value) {
      userId = value!;
    });

    final url = Uri.parse(
        "${AppUrls.baseUrl}/api/v1/delivery/deliveryAssignments?columns[]=id&columns[]=status&columns[]=subUser&columns[]=vehicle&columns[]=route&subUserId=$userId&columns[]=orders");

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body) as List;
      List<DeliveryAssignmentModel> deliveryAssignmentModel =
          data.map((e) => DeliveryAssignmentModel.fromJson(e)).toList();
      return deliveryAssignmentModel[0];
    } else {
      var data = jsonDecode(response.body);
      throw Exception(data['error']);
    }
  }
}
