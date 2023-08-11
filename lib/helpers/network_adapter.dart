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
      'X-AUTH-TOKEN': '$token',
      'Authorization': 'Bearer $token'
    });

    dynamic body = {};
    try {
      body = json.decode(utf8.decode(response.bodyBytes))['data'];
    } catch (e) {
      body = {};
    }
    return {'statusCode': response.statusCode, 'body': body};
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
    return {
      'statusCode': response.statusCode,
      'body': json.decode(utf8.decode(response.bodyBytes))['data']
    };
  }

  Future<dynamic> put(
      {required String path,
      required Map<String, dynamic> params,
      String? accessToken}) async {
    final url = Uri.parse(baseURL + path);
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'X-AUTH-TOKEN': '$accessToken',
      },
      body: json.encode(params),
    );
    return {
      'statusCode': response.statusCode,
      'body': json.decode(utf8.decode(response.bodyBytes))['data']
    };
  }

  Future<dynamic> patch(
      {required String path,
      required Map<String, dynamic> params,
      String? accessToken}) async {
    final url = Uri.parse(baseURL + path);
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'X-AUTH-TOKEN': '$accessToken',
      },
      body: json.encode(params),
    );
    return {
      'statusCode': response.statusCode,
      'body': json.decode(utf8.decode(response.bodyBytes))['data']
    };
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
    return {
      'statusCode': response.statusCode,
      'body': json.decode(utf8.decode(response.bodyBytes))['data']
    };
  }
}
