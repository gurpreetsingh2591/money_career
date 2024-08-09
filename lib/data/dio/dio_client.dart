// ignore_for_file: avoid_print, constant_identifier_names, camel_case_types

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/User.dart';
import '../../utils/logger/logger_service.dart';
import '../api_response.dart';

class DioClient {
  factory DioClient() {
    if (_instance == null) {
      throw Exception('Use DioClient.init(...) before accessing it.');
    }
    return _instance!;
  }
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://mobile.moneycarer.org.uk/';

  DioClient.init() {
    if (_instance == null) {
      _client.options.contentType = ContentType.json.toString();
      _client.options.headers['Accept'] = ContentType.json.toString();
      _client.options.connectTimeout = 200000; //20s
      _client.options.receiveTimeout = 200000;
      _instance = this;
    }
  }

  static DioClient? _instance;
  late final Dio _client = Dio();

  void dispose() {
    _client.close();
  }

  Future<User?> getUser({required String fullName, required String dateOfBirth, required String detail}) async {
    User? user;
    try {
      Response userData = await _dio.post(_baseUrl + '/registration/');
      print('User Info: ${userData.data}');
      user = User.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return user;
  }

  Future<ApiResponse> download(String urlPath, String savePath) async {
    final Directory dir = await getApplicationSupportDirectory();
    try {
      final Response<dynamic> response = await _client.download(urlPath, '${dir.path}$savePath');
      return ApiResponse(response);
    } on DioError catch (e) {
      return Future<ApiResponse>.error(_getAndPrintHttpError(e));
    }
  }

  Future<ApiResponse?> httpCall(
    String path,
    HTTP_METHOD httpMethod, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    try {
      Response<Map<String, dynamic>> response;
      switch (httpMethod) {
        case HTTP_METHOD.GET:
          response = await _client.get(path, queryParameters: queryParameters);
          break;
        case HTTP_METHOD.POST:
          response = await _client.post(path, data: formData ?? data, queryParameters: queryParameters);
          break;
        case HTTP_METHOD.PATCH:
          response = await _client.patch(path, data: formData ?? data);
          break;
        case HTTP_METHOD.DELETE:
          response = await _client.delete(path, queryParameters: queryParameters);
          break;
        case HTTP_METHOD.PUT:
          response = await _client.put(path, queryParameters: queryParameters, data: formData ?? data);
          break;
      }
      _logResponse(response);
      return ApiResponse(response);
    } on DioError catch (e) {
      return Future<ApiResponse>.error(_getAndPrintHttpError(e));
    }
  }

  ApiError _getAndPrintHttpError(DioError e) {
    final ApiError ex = ApiError.fromDioError(e);
    Log().e(ex);
    return ex;
  }

  void _logResponse(Response<Map<String, dynamic>>? response) {
    Log().d('Response: ${response?.toString()}');
  }
}

enum HTTP_METHOD { GET, POST, PATCH, DELETE, PUT }
