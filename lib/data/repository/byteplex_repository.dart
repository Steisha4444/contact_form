import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/request_model.dart';

class ByteplexRepo {
  static const _baseUrl = 'https://api.byteplex.info';
  static final http.Client client = http.Client();

  Future<int> sendRequest(RequestModel requestModel) async {
    const url = '$_baseUrl/api/test/contact/';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestModel.toJson()),
    );

    return response.statusCode;
  }
}
