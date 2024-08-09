import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:money_carer/model/LoginModel.dart';
import 'package:money_carer/screens/HomeScreen.dart';
import 'package:money_carer/utils/UnicodeHelper.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';

import '../../constant/constant.dart';
import '../../model/RegisterModel.dart';
import '../../screens/LoginScreen.dart';
import '../../screens/OTPVerifyScreen.dart';
import '../../utils/center_loader.dart';
import 'ApiConstants.dart';

class ApiService {
  Future<String?> getUsersRegister(String email, String password, BuildContext context) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrlSignUpSingIn + ApiConstants.usersSignUp + ApiConstants.authKey);

      var headers = {'Content-Type': 'text/plain'};
      var request = http.Request('POST', url);
      if (kDebugMode) {
        print(email + password);
      }
      request.body = jsonEncode({ApiConstants.email: email, ApiConstants.password: password, ApiConstants.returnSecureToken: true});

      if (kDebugMode) {
        print(request.body);
      }
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        //response= response.b ;
        var idToken = jsonDecode(response.body)['idToken'];
        var kind = jsonDecode(response.body)['kind'];
        var email = jsonDecode(response.body)['email'];
        var refreshToken = jsonDecode(response.body)['refreshToken'];
        var expiresIn = jsonDecode(response.body)['expiresIn'];
        var localId = jsonDecode(response.body)['localId'];

        //String l = idToken.map((o) => RegisterModel.fromJson(o)).toString();
        RegisterModel _model = RegisterModel(kind: kind, idToken: idToken, email: email, refreshToken: refreshToken, expiresIn: expiresIn, localId: localId);
        if (kDebugMode) {
          print(_model.email);
        }
        Fluttertoast.showToast(
            msg: "Registered Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);
        return response.body;
      } else {}
      Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(response.body));
      var errorMsg = data['error'];
      //ErrorHandlingModel errorHandlingModel = ErrorHandlingModel(error: data['error']);
      if (kDebugMode) {
        print(errorMsg["message"]);
      }
      Fluttertoast.showToast(
          msg: errorMsg["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kBaseLightColor,
          textColor: Colors.white);
      Navigator.of(context).pop();
      //  print(errorHandlingModel.error.message);
      return response.body;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> getUserLogin(String email, String password, BuildContext context) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrlSignUpSingIn + ApiConstants.signInWithPassword + ApiConstants.authKey);

      var headers = {'Content-Type': 'text/plain'};
      var request = http.Request('POST', url);
      if (kDebugMode) {
        print(email + password);
      }
      request.body = jsonEncode({ApiConstants.email: email, ApiConstants.password: password, ApiConstants.returnSecureToken: true});

      if (kDebugMode) {
        print(request.body);
      }
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        //response= response.b ;
        var idToken = jsonDecode(response.body)['idToken'];
        var kind = jsonDecode(response.body)['kind'];
        var email = jsonDecode(response.body)['email'];
        var refreshToken = jsonDecode(response.body)['refreshToken'];
        var expiresIn = jsonDecode(response.body)['expiresIn'];
        var localId = jsonDecode(response.body)['localId'];
        var displayName = jsonDecode(response.body)['displayName'];
        var registered = jsonDecode(response.body)['registered'];

        LoginModel loginModel = LoginModel(
            kind: kind,
            localId: localId,
            email: email,
            displayName: displayName,
            idToken: idToken,
            registered: registered,
            refreshToken: refreshToken,
            expiresIn: expiresIn);
        if (kDebugMode) {
          print(loginModel.email);
        }
        Fluttertoast.showToast(
            msg: "Login Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);
        return response.body;
      } else {
        Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(response.body));
        var errorMsg = data['error'];
        //ErrorHandlingModel errorHandlingModel = ErrorHandlingModel(error: data['error']);
        if (kDebugMode) {
          print(errorMsg["message"]);
        }
        Fluttertoast.showToast(
            msg: errorMsg["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);
        Navigator.of(context).pop();
        //  print(errorHandlingModel.error.message);
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> getChangePassword(String idToken, String password, BuildContext context) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrlSignUpSingIn + ApiConstants.usersChangePassword + ApiConstants.authKey);

      var headers = {'Content-Type': 'text/plain'};
      var request = http.Request('POST', url);
      request.body = jsonEncode({ApiConstants.idToken: idToken, ApiConstants.password: password, ApiConstants.returnSecureToken: true});
      if (kDebugMode) {
        print(idToken + password);
      }

      if (kDebugMode) {
        print(request.body);
      }
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }

        Fluttertoast.showToast(
            msg: "Change password successfully! you must be re-login",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);
        showAlertDialog("Change password successfully! you must be re-login", context);
        return response.body;
      } else {
        Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(response.body));
        var errorMsg = data['error'];
        //ErrorHandlingModel errorHandlingModel = ErrorHandlingModel(error: data['error']);
        if (kDebugMode) {
          print(errorMsg["message"]);
        }
        Fluttertoast.showToast(
            msg: errorMsg["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);
        Navigator.pop(context);
        SharedPrefs().setIsLogin(false);
        showErrorAlertDialog(errorMsg["message"] + ". If you want to change password please re-login ", context);

        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> getUserIDTokenRefresh(BuildContext context) async {
    DateTime datetime = DateTime.now();
    try {
      var url = Uri.parse(ApiConstants.baseUrlRefreshToken + ApiConstants.authKey);

      var headers = {'Content-Type': 'text/plain'};
      var request = http.Request('POST', url);

      request.body = jsonEncode({
        "grant_type": "refresh_token",
        "refresh_token": SharedPrefs().getRefreshTokenKey(),
      });

      if (kDebugMode) {
        print(request.body);
      }
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        //response= response.b ;
        var idToken = jsonDecode(response.body)['id_token'];

        var refreshToken = jsonDecode(response.body)['refresh_token'];
        SharedPrefs().setTokenTime(datetime.toString());
        SharedPrefs().setRefreshTokenKey(refreshToken);
        SharedPrefs().setTokenKey(idToken);
        return response.body;
      } else {
        Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(response.body));
        var errorMsg = data['error'];
        //ErrorHandlingModel errorHandlingModel = ErrorHandlingModel(error: data['error']);
        if (kDebugMode) {
          print(errorMsg["message"]);
        }

        SharedPrefs().setIsLogin(false);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => const LoginScreen(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );

        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> getSendOtpCode(String idToken) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrlSignUpSingIn + ApiConstants.sendOobCode + ApiConstants.authKey);

      var headers = {'Content-Type': 'text/plain'};
      var request = http.Request('POST', url);
      if (kDebugMode) {
        print(idToken);
      }
      request.body = jsonEncode({"requestType": "VERIFY_EMAIL", "idToken": idToken});

      if (kDebugMode) {
        print(request.body);
      }
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        //response= response.b ;

        return response.body;
      } else {
        if (kDebugMode) {
          print("error");
        }
        //  ErrorHandlingModel errorHandlingModel=response as ErrorHandlingModel;
        //print(errorHandlingModel.error.message);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //get account
  Future<List<dynamic>?>? getAccountList() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.accountList);

      var headers = {'Authorization': 'Bearer ' + SharedPrefs().getTokenKey().toString()};
      var request = http.Request('GET', url);

      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        List<dynamic> data = List<dynamic>.from(json.decode(response.body));
        if (kDebugMode) {
          //SharedPrefs().setIsUser2MFA(true);
          print(data);
        }
        return data;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //get register
  Future<dynamic> getRegister() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.registration);

      var headers = {'Authorization': 'Bearer ' + SharedPrefs().getTokenKey().toString()};
      var request = http.Request('GET', url);

      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        dynamic data = (json.decode(response.body));
        SharedPrefs().setIsUserRegister(true);
        SharedPrefs().setUserFullName(data['fullName']);
        SharedPrefs().setUserPhone(data['phoneNumber']);
        SharedPrefs().setUserDob(data['dateOfBirth']);
        if (kDebugMode) {
          print(await data);
        }
        return data;
      } else {
        SharedPrefs().setIsUserRegister(false);
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //request for  registration
  Future<dynamic> getRequestForRegistration(String name, String dateOfBirth, String phone, String detail, BuildContext context) async {
    try {
      showCenterLoader(context, MediaQuery.of(context).size, 'Please wait...');

      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.registration);

      var headers = {'Authorization': ApiConstants.bearer + SharedPrefs().getTokenKey().toString(), 'Content-Type': 'application/json'};

      if (kDebugMode) {
        print(headers);
      }
      var request = http.Request('POST', url);

      request.body =
          json.encode({ApiConstants.fullName: name, ApiConstants.dateOfBirth: dateOfBirth, ApiConstants.detail: detail, ApiConstants.phoneNumber: phone});

      if (kDebugMode) {
        print(request.body);
      }

      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        dynamic data = (json.decode(response.body));

        SharedPrefs().setIsUserRegister(true);

        SharedPrefs().setUserFullName(data['fullName']);
        SharedPrefs().setIsUserRegister(true);
        SharedPrefs().setUserPhone(data['phoneNumber']);
        SharedPrefs().setUserDob(data['dateOfBirth']);

        Fluttertoast.showToast(
            msg: "Registration successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);
        Navigator.pop(context);

        showAlertRegistrationDialog("Thanks for registering with Money Carer. You can now see the accounts you have access to", context, data['phoneNumber']);

        if (kDebugMode) {
          print(await data);
        }

        return data;
      } else {
        Fluttertoast.showToast(
            msg: "Registration failed. something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);
        Navigator.pop(context);
        SharedPrefs().setIsUserRegister(false);
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }

//get request list
  Future<List<dynamic>?>? getRequestList() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.requestList);

      var headers = {'Authorization': 'Bearer ' + SharedPrefs().getTokenKey().toString()};
      var request = http.Request('GET', url);

      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        List<dynamic> data = List<dynamic>.from(json.decode(response.body));
        await SharedPrefs().setIsUserRegisterAnAccount(true);
        if (kDebugMode) {
          print(data);
        }
        return data;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //get create  request
  //request for  registration
  Future<dynamic> getRequestCreate(String name, String dateOfBirth, String phone, String detail, BuildContext context) async {
    try {
      showCenterLoader(context, MediaQuery.of(context).size, 'Please wait...');

      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.requestCreate);

      var headers = {'Authorization': ApiConstants.bearer + SharedPrefs().getTokenKey().toString(), 'Content-Type': 'application/json'};
      if (kDebugMode) {
        print(headers);
      }
      var request = http.Request('POST', url);

      request.body =
          json.encode({ApiConstants.fullName: name, ApiConstants.dateOfBirth: dateOfBirth, ApiConstants.notes: detail, ApiConstants.phoneNumber: phone});

      if (kDebugMode) {
        print(request.body);
      }

      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        //dynamic data = (json.decode(response.body));

        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Register An account successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);

        showFundAlertDialog("Thanks for registering an account with Money Carer.", context);

        if (kDebugMode) {
          // print(await data);
        }
        return null;
      } else {
        Fluttertoast.showToast(
            msg: "Registration failed. something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);
        Navigator.pop(context);
        SharedPrefs().setIsUserRegister(false);
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //get transaction list
  Future<List<dynamic>?> getTransactionList(String clientId, String accId, int page, int pageSize) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.transactionsList);
      var headers = {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': ApiConstants.bearer + SharedPrefs().getTokenKey().toString()
      };
      if (kDebugMode) {
        print(headers);
      }

      var request = http.Request('POST', url);
      request.body = json.encode({ApiConstants.clientId: clientId, ApiConstants.accId: accId, ApiConstants.pageNo: page, ApiConstants.pageSize: pageSize});
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        List<dynamic> data = List<dynamic>.from(json.decode(response.body));
        if (kDebugMode) {
          print(data);
        }
        return data;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //get request list
  Future<dynamic> getFAQ() async {
    try {
      var url = Uri.parse(ApiConstants.GraphQLBaseUrl);

      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', url);
      request.body =
          '''{"query":"query MyQuery {feedItems {heroImage {url }title  postImageContent midContentImage {url  }  preImageContent  youTubeUrl  showToCarers  showToClients } faqItems { question answer }  term(where: {id: \\"cl3o42ieh9jdf0bmin0r6by2t\\"}) {   content title } privacy(where: {id: \\"cl3o44w329o400bmiq5bcho4b\\"}) { content   title }}","variables":{}}''';
      request.headers.addAll(headers);
      // http.StreamedResponse response = await request.send();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        String body = UnicodeHelper.cleanup(response.body);
        dynamic data = (json.decode(body));
        if (kDebugMode) {
          print(await data);
        }
        return data;
      } else {
        //print(response.reasonPhrase);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //request for  registration
  Future<Uint8List?> getStatement(String? clientId, String? accId, String? type, BuildContext context) async {
    Uint8List? _statementPdf;
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.accountStatement);

      var headers = {
        'Authorization': ApiConstants.bearer + SharedPrefs().getTokenKey().toString(),
        'Content-Type': 'application/json',
      };
      if (kDebugMode) {
        print(headers);
      }
      var request = http.Request('POST', url);

      request.body = json.encode({
        ApiConstants.clientId: clientId,
        ApiConstants.accId: accId,
        ApiConstants.type: type,
      });

      if (kDebugMode) {
        print(request.body);
      }

      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        // dynamic data = (json.decode(response.body));
        _statementPdf = response.bodyBytes;
        if (kDebugMode) {
          print(_statementPdf);
        }
        return _statementPdf;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        Navigator.of(context).pop();
        return _statementPdf;
      }
    } catch (e) {
      log(e.toString());
    }
    return _statementPdf;
  }

  //get Check MFA
  Future<dynamic> getCheckMFA(String deviceId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.mfaCheck + ApiConstants.device + "=" + deviceId);

      var headers = {'Authorization': ApiConstants.bearer + SharedPrefs().getTokenKey().toString(), 'Content-Type': 'application/json'};
      var request = http.Request('GET', url);

      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        dynamic data = (json.decode(response.body));
        if (kDebugMode) {
          print(await data);
        }
        return data;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //get detail MFA
  Future<dynamic> getDetailMFA() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.mfaDetail);

      var headers = {'Authorization': ApiConstants.bearer + SharedPrefs().getTokenKey().toString(), 'Content-Type': 'application/json'};
      var request = http.Request('GET', url);

      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        dynamic data = (json.decode(response.body));
        if (kDebugMode) {
          print(await data);
        }
        return data;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //get start MFA
  Future<dynamic> getStartMFA(String deiceId, String method) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.mfaStart);

      var headers = {'Authorization': ApiConstants.bearer + SharedPrefs().getTokenKey().toString(), 'Content-Type': 'application/json'};
      var request = http.Request('POST', url);
      request.body = json.encode({
        ApiConstants.device: deiceId,
        ApiConstants.method: method,
      });
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        dynamic data = (json.decode(response.body));
        if (kDebugMode) {
          print(await data);
        }
        return data;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //get Validate MFA
  Future<dynamic> getValidateMFA(String deviceId, String method, String code) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.mfaValidate);

      var headers = {'Authorization': ApiConstants.bearer + SharedPrefs().getTokenKey().toString(), 'Content-Type': 'application/json'};
      var request = http.Request('POST', url);
      request.body = json.encode({
        ApiConstants.device: deviceId,
        ApiConstants.method: method,
        ApiConstants.code: code,
      });
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        dynamic data = (json.decode(response.body));
        if (kDebugMode) {
          print(await data);
        }
        return data;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //get Post Images
  Future<dynamic> getPostImages(String clientId, String notes, List<File> file, BuildContext context) async {
    try {
      showCenterLoader(context, MediaQuery.of(context).size, 'Please wait...');
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.uploadPhotos);

      var headers = {'Authorization': ApiConstants.bearer + SharedPrefs().getTokenKey().toString()};
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({ApiConstants.clientId: clientId, ApiConstants.notes: notes});

      for (var i = 0; i < file.length; i++) {
        request.files.add(await http.MultipartFile.fromPath('files', file[i].path));
      }
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Receipt has been sent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);
        Navigator.of(context).pop();
        Navigator.pop(context);
        Navigator.pop(context);
        dynamic data = "success";
        if (kDebugMode) {
          print(await data);
        }
        return data;
      } else {
        if (kDebugMode) {
          Navigator.of(context).pop();
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Receipt has been not sent. something went wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: kBaseLightColor,
              textColor: Colors.white);
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //get Post videos
  Future<dynamic> getPostVideos(String clientId, String notes, List<PickedFile> file, BuildContext context) async {
    try {
      showCenterLoader(context, MediaQuery.of(context).size, 'Please wait...');
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.uploadVideo);

      var headers = {'Authorization': ApiConstants.bearer + SharedPrefs().getTokenKey().toString()};
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({ApiConstants.clientId: clientId, ApiConstants.notes: notes});

      for (var i = 0; i < file.length; i++) {
        request.files.add(await http.MultipartFile.fromPath('file', file[i].path));
      }
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Video has been sent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);
        Navigator.of(context).pop();
        Navigator.pop(context);
        Navigator.pop(context);

        dynamic data = (json.decode(response.body));
        if (kDebugMode) {
          print(await data);
        }
        return "success";
      } else {
        if (kDebugMode) {
          Navigator.of(context).pop();
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Receipt has been not sent. something went wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: kBaseLightColor,
              textColor: Colors.white);
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //get Request funds
  Future<dynamic> getRequestFunds(String clientId, String accId, String amount, String reason, BuildContext context) async {
    try {
      showCenterLoader(context, MediaQuery.of(context).size, 'Please wait...');
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.requestFund);

      var headers = {
        "Accept": "application/json",
        'Authorization': ApiConstants.bearer + SharedPrefs().getTokenKey().toString(),
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', url);
      request.body = json.encode({
        ApiConstants.clientId: clientId,
        ApiConstants.accId: accId,
        ApiConstants.amount: int.parse(amount),
        ApiConstants.reason: reason,
      });

      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Request Fund has been sent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kBaseLightColor,
            textColor: Colors.white);
        showFundAlertDialog("Request Fund has been sent", context);

        return "success";
      } else {
        // Navigator.of(context).pop();
        Navigator.pop(context);
        showFundAlertDialog("Fund Request has not been sent", context);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  showErrorAlertDialog(String msg, BuildContext context) {
    // set up the buttons

    Widget cancelButton = FlatButton(
      child: const Text(
        "Cancel",
        style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: kBaseColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = FlatButton(
      child: const Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: kBaseColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        SharedPrefs().setIsLogin(false);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => const LoginScreen(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        msg,
        style: const TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: kBaseColor),
      ),
      actions: [continueButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(String msg, BuildContext context) {
    // set up the buttons

    Widget continueButton = FlatButton(
      child: const Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: kBaseColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        SharedPrefs().setIsLogin(false);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => const LoginScreen(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        msg,
        style: const TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: kBaseColor),
      ),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showFundAlertDialog(String msg, BuildContext context) {
    // set up the buttons
    Widget continueButton = FlatButton(
      child: const Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: kBaseColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        msg,
        style: const TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: kBaseColor),
      ),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertRegistrationDialog(String msg, BuildContext context, String phone) {
    // set up the buttons

    Widget continueButton = FlatButton(
      child: const Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: kBaseColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => OTPVerifyScreen(
              phoneNo: phone,
              screen: "register",
            ),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        msg,
        style: const TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: kBaseColor),
      ),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
