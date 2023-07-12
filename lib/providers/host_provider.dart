import 'package:flutter/material.dart';
import 'package:shoes_app/model/host_model.dart';
import 'package:shoes_app/services/host_service.dart';

class HostProvider with ChangeNotifier {
  late HostModel _host;

  HostModel get host => _host;

  set host(HostModel host) {
    _host = host;
    notifyListeners();
  }

  Future<bool> login({
    String? ip_add,
    String? username,
    String? password,
  }) async {
    try {
      HostModel host = await HostService().login(
        ip_add: ip_add,
        username: username,
        password: password,
      );

      _host = host;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
