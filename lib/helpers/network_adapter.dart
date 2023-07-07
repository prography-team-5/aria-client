import 'dart:async';
import 'dart:convert';
import 'package:aria_client/helpers/env.dart';
import 'package:http/http.dart' as http;

class NetworkAdapter {
  Env env = Env();
  String baseURL = Env.apiUrl;

  Future<dynamic> get(
      {required String path,
      required Map<String, dynamic> params,
      String? token}) async {
    String urlStr = this.baseURL + path;
    if (params != {}) {
      urlStr += "?";
      for (var key in params.keys) {
        urlStr += '$key=${params[key]}&';
      }
    }
    final url = Uri.parse(urlStr);
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-AUTH-TOKEN': '$token'
    });
    return response;
  }

  Future<dynamic> post(
      {required String path,
      required Map<String, dynamic> params,
      String? accessToken,
      String? refreshToken,
      String? socialAccessToken}) async {
    final url = Uri.parse(baseURL + path);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'X-AUTH-TOKEN': '$accessToken',
        'refreshToken': '$refreshToken',
        'accessToken': 'Bearer $socialAccessToken'
      },
      body: json.encode(params),
    );
    print('response: ${response.statusCode}');
    print('response: ${utf8.decode(response.bodyBytes)}');
    return response;
  }

  Future<dynamic> put(
      {required String path,
      required Map<String, dynamic> params,
      String? token}) async {
    final url = Uri.parse(baseURL + path);
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-AUTH-TOKEN': '$token'
      },
      body: json.encode(params),
    );
    return json.decode(response.body);
  }

  Future<dynamic> patch(
      {required String path,
      required Map<String, dynamic> params,
      String? token}) async {
    final url = Uri.parse(baseURL + path);
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-AUTH-TOKEN': '$token'
      },
      body: json.encode(params),
    );
    return json.decode(response.body);
  }

  Future<dynamic> delete(
      {required String path,
      required Map<String, dynamic> params,
      String? token}) async {
    String urlStr = this.baseURL + path;
    final url = Uri.parse(urlStr);
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-AUTH-TOKEN': '$token',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(params),
    );

    return json.decode(response.body);
  }
}
