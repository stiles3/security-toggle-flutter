import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiEndpoints {
  static final _host = kIsWeb
      ? '127.0.0.1'
      : Platform.isAndroid
          ? '10.0.2.2'
          : '127.0.0.1';

  static const _port = 5011;
  static final _baseUrl = 'https://security-toggle-api.onrender.com/api/app';

  static String get toggle => '$_baseUrl/toggle';
  static String get status => '$_baseUrl/status';
}
