import 'dart:async';
import 'dart:convert';

import 'package:shoes_app/model/host_model.dart';
import 'package:http/http.dart' as http;

class HostService {
  String baseUrl = 'http://127.0.0.1:5000';

  Future<HostModel> login({
    String? ip_add,
    String? username,
    String? password,
  }) async {
    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'ip_address': ip_add.toString(),
      'username': username.toString(),
      'password': password.toString(),
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      HostModel host = HostModel.fromJson(data['host']);
      // ignore: prefer_interpolation_to_compose_strings
      host.ticket = 'Bearer ' + data['ticket'];

      return host;
    } else {
      throw Exception('Gagal Login');
    }
  }
}
