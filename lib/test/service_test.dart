import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shoes_app/pages/host/host_info_page.dart';

class ServiceTest {
  static final _client = http.Client();

  static final _loginUrl = Uri.parse('http://127.0.0.1:5000/login');

  // static final _registerUrl =
  //     Uri.parse('https://flaskflutterlogin.herokuapp.com/register');

  static login(ip_add, username, password, context) async {
    http.Response response = await _client.post(_loginUrl, body: {
      "ip_address": ip_add,
      "username": username,
      "password": password,
    });

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (json[0] == 'success') {
        await EasyLoading.showSuccess(json[0]);
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HostInfoPage()));
      } else {
        EasyLoading.showError(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  // static register(email, password, context) async {
  //   http.Response response = await _client.post(_registerUrl, body: {
  //     "email": email,
  //     "password": password,
  //   });
  //   if (response.statusCode == 200) {
  //     var json = jsonDecode(response.body);
  //     if (json[0] == 'username already exist') {
  //       await EasyLoading.showError(json[0]);
  //     } else {
  //       await EasyLoading.showSuccess(json[0]);
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => Dashboard()));
  //     }
  //   } else {
  //     await EasyLoading.showError(
  //         "Error Code : ${response.statusCode.toString()}");
  //   }
  // }
}
