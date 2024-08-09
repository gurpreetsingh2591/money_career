/// kind : "identitytoolkit#SignupNewUserResponse"
/// idToken : "eyJhbGciOiJSUzI1NiIsImtpZCI6ImVmMzAxNjFhOWMyZGI3ODA5ZjQ1MTNiYjRlZDA4NzNmNDczMmY3MjEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWNmLW1vYmlsZTIiLCJhdWQiOiJtY2YtbW9iaWxlMiIsImF1dGhfdGltZSI6MTY1MTY1OTc1MywidXNlcl9pZCI6ImI2NG9xZGczNVBZbUt1U0o3bE5BTE5RbE9PQzIiLCJzdWIiOiJiNjRvcWRnMzVQWW1LdVNKN2xOQUxOUWxPT0MyIiwiaWF0IjoxNjUxNjU5NzUzLCJleHAiOjE2NTE2NjMzNTMsImVtYWlsIjoibW9uZXljYXJlckB0ZXN0LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJtb25leWNhcmVyQHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.AhxK3_BJOBX37hxVIHDTnRC2UHOMN8zI7jdzDpbjm0ggXQ5LiypNVrX5_iD5BGfStV_m6fNwo7DXNfHNue-uzcNHXkYZKb6ThpySPnkbjTPCx5XioEUnoQQ_j1HDrRo6itm2DkwpBwEBxL7mm5qqRb3YdppMSYJOZjzxWqBXPIRBgBAv6BKO-Algqj17j30Nm-7_ZCqteGJ5NQ0WJGQ-hqexZKEtesCtBbWouJwAV5y8okzBNowaqQf6mAQGC0ly5iAx2qY-odF5__V-TwVZ3Zv4ji0LbUDEwTtG_ynzAKwtJ0VZO6cE7CujMF-4MhDmz190zgLYgarJ8pQQDhJxqw"
/// email : "moneycarer@test.uk.org"
/// refreshToken : "AIwUaOnBjNM5gwNhvtLyyhkkNC2s_6iBUFdpFqwseIo4PxExHerErGf8utGAjQYGKOrT32tiUTIW2XonwY5mtY2NOS5IpMlgbT9hK1V9jh9R9HpfbfVa5PNO2M3P6OgK2WJRmTdR9IK1dYc4FrO6DCJkOQvseU0qfA-dfIFw-bmEaM015neqyeZ250CLjcymehQ0-tKOovaG"
/// expiresIn : "3600"
/// localId : "b64oqdg35PYmKuSJ7lNALNQlOOC2"

class RegisterModel {
  RegisterModel({
    required String kind,
    required String idToken,
    required String email,
    required String refreshToken,
    required String expiresIn,
    required String localId,
  }) {
    _kind = kind;
    _idToken = idToken;
    _email = email;
    _refreshToken = refreshToken;
    _expiresIn = expiresIn;
    _localId = localId;
  }

  RegisterModel.fromJson(dynamic json) {
    _kind = json['kind'];
    _idToken = json['idToken'];
    _email = json['email'];
    _refreshToken = json['refreshToken'];
    _expiresIn = json['expiresIn'];
    _localId = json['localId'];
  }
  String _kind = "";
  String _idToken = "";
  String _email = "";
  String _refreshToken = "";
  String _expiresIn = "";
  String _localId = "";
  RegisterModel copyWith({
    required String kind,
    required String idToken,
    required String email,
    required String refreshToken,
    required String expiresIn,
    required String localId,
  }) =>
      RegisterModel(
        kind: kind,
        idToken: idToken,
        email: email,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
        localId: localId,
      );
  String get kind => _kind;
  String get idToken => _idToken;
  String get email => _email;
  String get refreshToken => _refreshToken;
  String get expiresIn => _expiresIn;
  String get localId => _localId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kind'] = _kind;
    map['idToken'] = _idToken;
    map['email'] = _email;
    map['refreshToken'] = _refreshToken;
    map['expiresIn'] = _expiresIn;
    map['localId'] = _localId;
    return map;
  }
}
