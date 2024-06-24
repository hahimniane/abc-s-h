import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TokenService {
  sendTokenForNotification(
      {required String email, required String token}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://abcbul.com/api/auth/savetoken'));
    request.body = json.encode({"email": email, "token": token});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(await response.stream.bytesToString());
      }
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }
}
