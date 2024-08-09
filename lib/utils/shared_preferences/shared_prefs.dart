import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  factory SharedPrefs() {
    if (_prefs == null) {
      throw Exception('Call SharedPrefs.init() before accessing it');
    }
    return _singleton;
  }

  SharedPrefs._internal();

  static void init(SharedPreferences sharedPreferences) => _prefs ??= sharedPreferences;

  static final SharedPrefs _singleton = SharedPrefs._internal();

  static SharedPreferences? _prefs;

  static const String _tokenKey = '_tokenKey',
      _refreshTokenKey = '_refreshTokenKey',
      _userEmail = '_userEmail',
      _onBoardingCompleted = '_onBoardingCompleted',
      _isLogin = '_isLogin',
      _isBio = '_isBio',
      _isSignUp = '_isSignUp',
      _isUserRegister = '_isUserRegister',
      _isUserRegisterAnAccount = '_isUserRegisterAnAccount',
      _isUser2MFA = '_isUser2MFA',
      _isUser2MFAEnabled = '_isUser2MFAEnabled',
      _userFullName = '_userFullName',
      _userDOB = '_userDOB',
      _userPhone = '_userPhone',
      _isBioAuth = '_isBioAuth',
      _isBioAuthTime = '_isBioAuthTime',
      _isTokenTime = '_isTokenTime',
      _deviceId = '_deviceId',
      _initValue = '_initValue';

  Future<bool> setIsOnBoardingCompleted([bool isCompleted = false]) => _prefs!.setBool(_onBoardingCompleted, isCompleted);

  bool isOnBoardingCompleted() => _prefs!.getBool(_onBoardingCompleted) ?? false;

  Future<bool> setIsLogin([bool isLogin = false]) => _prefs!.setBool(_isLogin, isLogin);

  bool isLogin() => _prefs!.getBool(_isLogin) ?? false;

  Future<bool> setIsBio([bool isBio = false]) => _prefs!.setBool(_isBio, isBio);

  bool isBio() => _prefs!.getBool(_isBio) ?? false;

  Future<bool> setIsBioAuth([bool isBioAuth = false]) => _prefs!.setBool(_isBioAuth, isBioAuth);

  bool isBioAuth() => _prefs!.getBool(_isBioAuth) ?? false;

  Future<bool> setIsSignUp([bool isSignUp = false]) => _prefs!.setBool(_isSignUp, isSignUp);

  bool isSignUp() => _prefs!.getBool(_isSignUp) ?? false;

  Future<bool> setIsUserRegister([bool isUserRegister = false]) => _prefs!.setBool(_isUserRegister, isUserRegister);

  bool isUserRegister() => _prefs!.getBool(_isUserRegister) ?? false;

  Future<bool> setIsUserRegisterAnAccount([bool isUserRegisterAnAccount = false]) => _prefs!.setBool(_isUserRegisterAnAccount, isUserRegisterAnAccount);

  bool isUserRegisterAnAccount() => _prefs!.getBool(_isUserRegisterAnAccount) ?? false;

  Future<bool> setIsUser2MFA([bool isUser2MFA = false]) => _prefs!.setBool(_isUser2MFA, isUser2MFA);

  bool isUser2MFA() => _prefs!.getBool(_isUser2MFA) ?? false;

  Future<bool> setIsUser2MFAEnabled([bool isUser2MFAEnabled = false]) => _prefs!.setBool(_isUser2MFAEnabled, isUser2MFAEnabled);

  bool isUser2MFAEnabled() => _prefs!.getBool(_isUser2MFAEnabled) ?? false;

  Future<bool> setTokenKey(String token) => _prefs!.setString(_tokenKey, token);

  Future<bool> removeTokenKey() => _prefs!.remove(_tokenKey);

  String? getTokenKey() => _prefs!.getString(_tokenKey);

  Future<bool> setBioAuthTime(String bioAuthTime) => _prefs!.setString(_isBioAuthTime, bioAuthTime);

  Future<bool> removeToBioAuthTime() => _prefs!.remove(_isBioAuthTime);

  String? getBioAuthTime() => _prefs!.getString(_isBioAuthTime);

  Future<bool> setTokenTime(String tokenTime) => _prefs!.setString(_isTokenTime, tokenTime);

  Future<bool> removeTokenTime() => _prefs!.remove(_isTokenTime);

  String? getTokenTime() => _prefs!.getString(_isTokenTime);

  Future<bool> setDeviceId(String deviceId) => _prefs!.setString(_deviceId, deviceId);

  String? getDeviceId() => _prefs!.getString(_deviceId);

  Future<bool> setInitValue(int initValue) => _prefs!.setInt(_initValue, initValue);

  int? getInitValue() => _prefs!.getInt(_initValue);

  Future<bool> setRefreshTokenKey(String refreshToken) => _prefs!.setString(_refreshTokenKey, refreshToken);

  Future<bool> removeRefreshTokenKey() => _prefs!.remove(_refreshTokenKey);

  String? getRefreshTokenKey() => _prefs!.getString(_refreshTokenKey);

  Future<bool> setUserEmail(String email) => _prefs!.setString(_userEmail, email);

  Future<bool> removeUserEmail() => _prefs!.remove(_userEmail);

  String? getUserEmail() => _prefs!.getString(_userEmail);

  Future<bool> setUserFullName(String userFullName) => _prefs!.setString(_userFullName, userFullName);

  Future<bool> removeUserFullName() => _prefs!.remove(_userFullName);

  String? getUserFullName() => _prefs!.getString(_userFullName);

  Future<bool> setUserDob(String userDOB) => _prefs!.setString(_userDOB, userDOB);

  Future<bool> removeUserDob() => _prefs!.remove(_userDOB);

  String? getUserDob() => _prefs!.getString(_userDOB);

  Future<bool> setUserPhone(String userPhone) => _prefs!.setString(_userPhone, userPhone);

  Future<bool> removeUserPhone() => _prefs!.remove(_userPhone);

  String? getUserPhone() => _prefs!.getString(_userPhone);

  Future reset() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
