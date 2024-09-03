import 'package:g_route/constants/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class OrderService {
  final Logger _logger = Logger();

  Future<void> updateOrderStatus({
    required String orderId,
    required String currentDate,
    required OrderAction action,
  }) async {
    final url = Uri.parse(
        "${AppUrls.baseUrl}/api/v1/assignedOrder/updateAssignedOrder/$orderId");

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body;

    switch (action) {
      case OrderAction.startJourney:
        body = {"startJourneyTime": currentDate};
        break;
      case OrderAction.arrivalTime:
        body = {"arrivalTime": currentDate};
        break;
      case OrderAction.unloadingTime:
        body = {"unloadingTime": currentDate};
        break;
      case OrderAction.endJourneyTime:
        body = {"endJourneyTime": currentDate};
        break;
      case OrderAction.invoiceCreationTime:
        body = {"invoiceCreationTime": currentDate};
        break;
      case OrderAction.completed:
        body = {"status": "completed"};
        break;
      default:
        body = {"loadingTime": currentDate};
    }

    final response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      _logger.i('Data updated successfully');
    } else {
      var data = jsonDecode(response.body);
      throw Exception(data['error']);
    }
  }
}

enum OrderAction {
  startJourney,
  arrivalTime,
  unloadingTime,
  endJourneyTime,
  invoiceCreationTime,
  loadingTime,
  completed,
}
