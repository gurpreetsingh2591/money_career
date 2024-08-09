/// error : {"code":400,"message":"WEAK_PASSWORD : Password should be at least 6 characters","errors":[{"message":"WEAK_PASSWORD : Password should be at least 6 characters","domain":"global","reason":"invalid"}]}

class ErrorHandlingModel {
  ErrorHandlingModel({
    Error? error,
  }) {
    _error = error;
  }

  ErrorHandlingModel.fromJson(dynamic json) {
    _error = (json['error'] != null ? Error.fromJson(json['error']) : null)!;
  }
  Error? _error;
  ErrorHandlingModel copyWith({
    Error? error,
  }) =>
      ErrorHandlingModel(
        error: error,
      );
  Error? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error?.toJson();
    return map;
  }
}

/// code : 400
/// message : "WEAK_PASSWORD : Password should be at least 6 characters"
/// errors : [{"message":"WEAK_PASSWORD : Password should be at least 6 characters","domain":"global","reason":"invalid"}]

class Error {
  Error({
    int? code,
    String? message,
    List<Errors>? errors,
  }) {
    _code = code!;
    _message = message!;
    _errors = errors!;
  }

  Error.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['errors'] != null) {
      _errors = [];
      json['errors'].forEach((v) {
        _errors?.add(Errors.fromJson(v));
      });
    }
  }
  int? _code;
  String? _message;
  List<Errors>? _errors;
  Error? copyWith({
    int? code,
    String? message,
    List<Errors>? errors,
  }) =>
      Error(
        code: code,
        message: message,
        errors: errors,
      );
  int? get code => _code;
  String? get message => _message;
  List<Errors>? get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    map['errors'] = _errors?.map((v) => v.toJson()).toList();
    return map;
  }
}

/// message : "WEAK_PASSWORD : Password should be at least 6 characters"
/// domain : "global"
/// reason : "invalid"

class Errors {
  Errors({
    required String message,
    required String domain,
    required String reason,
  }) {
    _message = message;
    _domain = domain;
    _reason = reason;
  }

  Errors.fromJson(dynamic json) {
    _message = json['message'];
    _domain = json['domain'];
    _reason = json['reason'];
  }
  String _message = "";
  String _domain = "";
  String _reason = "";
  Errors copyWith({
    required String message,
    required String domain,
    required String reason,
  }) =>
      Errors(
        message: message,
        domain: domain,
        reason: reason,
      );
  String get message => _message;
  String get domain => _domain;
  String get reason => _reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['domain'] = _domain;
    map['reason'] = _reason;
    return map;
  }
}
