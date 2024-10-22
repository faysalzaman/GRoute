import 'dart:convert';

import 'package:g_route/constants/app_urls.dart';
import 'package:g_route/model/auth/login_model.dart';
import 'package:http/http.dart' as http;

class AuthController {
  static Future<LoginModel> login(String email, String password) async {
    final url = Uri.parse("${AppUrls.baseUrl}/api/v1/auth/login");

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({"email": email, "password": password});

    final response = await http.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);

    print(data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginModel.fromJson(data['user']);
    } else {
      throw Exception(data['message']);
    }
  }
}
