import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:stockolio/helpers/definitions.dart';

class HttpHelper {
  static Future<http.Response> get(Uri requestPath, String token) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var response = await http
        .get(
          requestPath,
          headers: headers,
        )
        .timeout(
          const Duration(seconds: Definition.HTTP_REQUEST_TIMEOUT),
        );

    return response;
  }

  static Future<http.Response> anonymousGet(Uri requestPath) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    var response = await http
        .get(
          requestPath,
          headers: headers,
        )
        .timeout(
          const Duration(seconds: Definition.HTTP_REQUEST_TIMEOUT),
        );

    return response;
  }

  static Future<http.Response> post(
      Uri requestPath, String request, String token) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var response =
        await http.post(requestPath, headers: headers, body: request).timeout(
              const Duration(seconds: Definition.HTTP_REQUEST_TIMEOUT),
            );

    return response;
  }
}
