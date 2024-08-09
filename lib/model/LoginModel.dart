/// kind : "identitytoolkit#VerifyPasswordResponse"
/// localId : "mcbqwkoSnYVrxHNVIlOwq0TpcLt2"
/// email : "abc@test.uk.org"
/// displayName : ""
/// idToken : "eyJhbGciOiJSUzI1NiIsImtpZCI6ImVmMzAxNjFhOWMyZGI3ODA5ZjQ1MTNiYjRlZDA4NzNmNDczMmY3MjEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWNmLW1vYmlsZTIiLCJhdWQiOiJtY2YtbW9iaWxlMiIsImF1dGhfdGltZSI6MTY1MTc0OTA0NSwidXNlcl9pZCI6Im1jYnF3a29TbllWcnhITlZJbE93cTBUcGNMdDIiLCJzdWIiOiJtY2Jxd2tvU25ZVnJ4SE5WSWxPd3EwVHBjTHQyIiwiaWF0IjoxNjUxNzQ5MDQ1LCJleHAiOjE2NTE3NTI2NDUsImVtYWlsIjoiYWJjQHRlc3QuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImFiY0B0ZXN0LmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.QDjKnHS__b2elo7h1V1WF-snPue9lKHc6YKoW9SnQ2C91YYxTjlvsNuQWgI6i-Iv4wioCE1pyH_QzA6bHkShZbgCmAvrbRp23f7IZOPoQMLtcyaO4TUBzhSIPc6Kx44i9SpnuM8g-fRcuM0z7Q3hDU1lTPkGcOK6bk_AoXvhFvCcEwBaPDy9K0Ozo-CXKd9KyYgyBP9DuE7r0QmDCznORb-tgkdPTczBjrwT85IRwiNxKZ7BY8PZU8LF1Bng1iowptmhL68y363wZfVAJPx0-Euty5yIgoYx26iwF03ff5IqltqvhIpJMs11LM-r0eM5HzBNC40kHxkT7Rc1P9BMoQ"
/// registered : true
/// refreshToken : "AIwUaOl0dvyWrBMp1mfks_mHP_LdUa2EIfaR6pivRpX84HpeTgZxBA7HyQst7SqXZ031B_KLSPN3DYEWpHmj5tM72jrfu5Mgki3a9jDrM7togcUDa4frBdqN10Ls_t-CgW6BJo-qQ5IM3NTNk0ADLwRESWYuHiMqRwRyFh2weR87atI8KB4pFYfpsAT96gPZWPJuhCuQbgtd"
/// expiresIn : "3600"

class LoginModel {
  LoginModel({
    required String kind,
    required String localId,
    required String email,
    required String displayName,
    required String idToken,
    required bool registered,
    required String refreshToken,
    required String expiresIn,
  }) {
    _kind = kind;
    _localId = localId;
    _email = email;
    _displayName = displayName;
    _idToken = idToken;
    _registered = registered;
    _refreshToken = refreshToken;
    _expiresIn = expiresIn;
  }

  LoginModel.fromJson(dynamic json) {
    _kind = json['kind'];
    _localId = json['localId'];
    _email = json['email'];
    _displayName = json['displayName'];
    _idToken = json['idToken'];
    _registered = json['registered'];
    _refreshToken = json['refreshToken'];
    _expiresIn = json['expiresIn'];
  }
  String _kind = "";
  String _localId = "";
  String _email = "";
  String _displayName = "";
  String _idToken = "";
  bool _registered = false;
  String _refreshToken = "";
  String _expiresIn = "";
  LoginModel copyWith({
    required String kind,
    required String localId,
    required String email,
    required String displayName,
    required String idToken,
    required bool registered,
    required String refreshToken,
    required String expiresIn,
  }) =>
      LoginModel(
        kind: kind,
        localId: localId,
        email: email,
        displayName: displayName,
        idToken: idToken,
        registered: registered,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
      );
  String get kind => _kind;
  String get localId => _localId;
  String get email => _email;
  String get displayName => _displayName;
  String get idToken => _idToken;
  bool get registered => _registered;
  String get refreshToken => _refreshToken;
  String get expiresIn => _expiresIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kind'] = _kind;
    map['localId'] = _localId;
    map['email'] = _email;
    map['displayName'] = _displayName;
    map['idToken'] = _idToken;
    map['registered'] = _registered;
    map['refreshToken'] = _refreshToken;
    map['expiresIn'] = _expiresIn;
    return map;
  }
}
