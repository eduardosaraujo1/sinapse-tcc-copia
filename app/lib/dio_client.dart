import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  DioClient._internal();

  final Dio _dio = Dio(
    BaseOptions(
      validateStatus: (status) => true, // Accept all status codes
      responseType: ResponseType.plain, // Get response as string
    ),
  );

  /// Converts a Dio Response to an http.Response
  http.Response _toHttpResponse(Response<dynamic> dioResponse) {
    final body = dioResponse.data?.toString() ?? '';
    final headers = <String, String>{};
    dioResponse.headers.forEach((name, values) {
      headers[name] = values.join(',');
    });

    return http.Response(
      body,
      dioResponse.statusCode ?? 500,
      headers: headers,
      request: http.Request(
        dioResponse.requestOptions.method,
        dioResponse.requestOptions.uri,
      ),
    );
  }

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final response = await _dio.getUri(url, options: Options(headers: headers));
    return _toHttpResponse(response);
  }

  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final response = await _dio.postUri(
      url,
      data: body,
      options: Options(headers: headers),
    );
    return _toHttpResponse(response);
  }

  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final response = await _dio.putUri(
      url,
      data: body,
      options: Options(headers: headers),
    );
    return _toHttpResponse(response);
  }
}

// Top-level functions that mirror http package API
final _client = DioClient();

Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
  return _client.get(url, headers: headers);
}

Future<http.Response> post(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) {
  return _client.post(url, headers: headers, body: body, encoding: encoding);
}

Future<http.Response> put(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) {
  return _client.put(url, headers: headers, body: body, encoding: encoding);
}
