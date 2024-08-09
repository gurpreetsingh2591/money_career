import 'dart:io';

import 'package:dio/dio.dart';

class ApiResponse {
  ApiResponse(Response<dynamic> r)
      : _data = r.data,
        _request = r.requestOptions;

  final dynamic _data;
  final RequestOptions _request;

  bool get hasDataList => dataList?.isNotEmpty ?? false;

  bool get hasDataMap => dataMap?.isNotEmpty ?? false;

  List<dynamic>? get dataList => _data is List ? _data : null;

  Map<String, dynamic>? get dataMap => _data is Map ? _data : null;

  bool get hasError => dataMap != null ? dataMap!['error'] != null : false;

  String? get errorMsg => hasError ? dataMap!['error']['message'] : null;

  Map<String, dynamic>? get error => hasError ? dataMap!['error'] : null;

  @override
  String toString() {
    return 'ApiResponse{request: ${_requestInfo()}\ndata: $_data}';
  }

  String _requestInfo() {
    return '${_request.method} ${_request.uri},\nRequestBody: ${_request.data}';
  }
}

class ApiError extends DioError {
  ApiError.fromDioError(DioError dioError)
      : super(
          requestOptions: dioError.requestOptions,
          response: dioError.response,
          type: dioError.type,
          error: dioError.error,
        );

  bool get isTimedOut => error is SocketException;

  @override
  String toString() {
    return 'ApiError{\nRequest: ${_requestInfo()},\n${super.toString()}}';
  }

  String _requestInfo() {
    return '${requestOptions.method} ${requestOptions.uri},\nRequestBody: ${requestOptions.data}';
  }
}
