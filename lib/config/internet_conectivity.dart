import 'dart:io';

import 'package:flutter/foundation.dart';

import 'Helper.dart';

class InternetConnectivityCheck {
  static final _sharedInstance = InternetConnectivityCheck._internal();

  InternetConnectivityCheck._internal();

  static InternetConnectivityCheck getInstance() {
    return _sharedInstance;
  }

  Future<bool?> chkInternetConnectivity() async {
    bool? internet;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet = true;
        return internet;
      }
    } on SocketException catch (_) {
      if (kDebugMode) {
        print('not connected');
      }
      internet = false;
      return internet;
    }

    return internet;
  }

  Future<void> chkInternetConnectivity1() async {
    bool? internet;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet = true;
      }
    } on SocketException catch (_) {
      if (kDebugMode) {
        print('not connected');
      }
      internet = false;
    }
    if (internet != true) {
      Helper.getToastMsg("No internet connection");
      return;
    }
  }
}
