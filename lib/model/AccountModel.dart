/// id : "11111111-2222-3333-4444-555555555555"
/// name : "CASHPLUS CLIENT BUDGET ACCOUNT"
/// clientId : "99999999-8888-7777-6666-555555555555"
/// clientName : "DORRIS CLIENT"
/// sortCode : "300002"
/// accountNo : "01234567"
/// balance : 127.89
/// balanceDate : "2022-03-25"
/// allowanceLeft : 20
/// access : {"showBalance":true,"showTransactions":true,"statements":true,"sendImages":true,"sendVideos":true,"requestDiscretionary":true}

class AccountModel {
  AccountModel({
    String? id,
    String? name,
    String? clientId,
    String? clientName,
    String? sortCode,
    String? accountNo,
    double? balance,
    String? balanceDate,
    int? allowanceLeft,
    Access? access,
  }) {
    _id = id!;
    _name = name!;
    _clientId = clientId!;
    _clientName = clientName!;
    _sortCode = sortCode!;
    _accountNo = accountNo!;
    _balance = balance!;
    _balanceDate = balanceDate!;
    _allowanceLeft = allowanceLeft!;
    _access = access!;
  }

  AccountModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _clientId = json['clientId'];
    _clientName = json['clientName'];
    _sortCode = json['sortCode'];
    _accountNo = json['accountNo'];
    _balance = json['balance'];
    _balanceDate = json['balanceDate'];
    _allowanceLeft = json['allowanceLeft'];
    _access = (json['access'] != null ? Access.fromJson(json['access']) : null)!;
  }
  String? _id;
  String? _name;
  String? _clientId;
  String? _clientName;
  String? _sortCode;
  String? _accountNo;
  double? _balance;
  String? _balanceDate;
  int? _allowanceLeft;
  Access? _access;
  AccountModel copyWith({
    String? id,
    String? name,
    String? clientId,
    String? clientName,
    String? sortCode,
    String? accountNo,
    double? balance,
    String? balanceDate,
    int? allowanceLeft,
    Access? access,
  }) =>
      AccountModel(
        id: id ?? _id,
        name: name ?? _name,
        clientId: clientId ?? _clientId,
        clientName: clientName ?? _clientName,
        sortCode: sortCode ?? _sortCode,
        accountNo: accountNo ?? _accountNo,
        balance: balance ?? _balance,
        balanceDate: balanceDate ?? _balanceDate,
        allowanceLeft: allowanceLeft ?? _allowanceLeft,
        access: access ?? _access,
      );
  String? get id => _id;
  String? get name => _name;
  String? get clientId => _clientId;
  String? get clientName => _clientName;
  String? get sortCode => _sortCode;
  String? get accountNo => _accountNo;
  double? get balance => _balance;
  String? get balanceDate => _balanceDate;
  int? get allowanceLeft => _allowanceLeft;
  Access? get access => _access;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['clientId'] = _clientId;
    map['clientName'] = _clientName;
    map['sortCode'] = _sortCode;
    map['accountNo'] = _accountNo;
    map['balance'] = _balance;
    map['balanceDate'] = _balanceDate;
    map['allowanceLeft'] = _allowanceLeft;
    if (_access != null) {
      map['access'] = _access!.toJson();
    }
    return map;
  }
}

/// showBalance : true
/// showTransactions : true
/// statements : true
/// sendImages : true
/// sendVideos : true
/// requestDiscretionary : true

class Access {
  Access({
    bool? showBalance,
    bool? showTransactions,
    bool? statements,
    bool? sendImages,
    bool? sendVideos,
    bool? requestDiscretionary,
  }) {
    _showBalance = showBalance!;
    _showTransactions = showTransactions!;
    _statements = statements!;
    _sendImages = sendImages!;
    _sendVideos = sendVideos!;
    _requestDiscretionary = requestDiscretionary!;
  }

  Access.fromJson(dynamic json) {
    _showBalance = json['showBalance'];
    _showTransactions = json['showTransactions'];
    _statements = json['statements'];
    _sendImages = json['sendImages'];
    _sendVideos = json['sendVideos'];
    _requestDiscretionary = json['requestDiscretionary'];
  }
  bool? _showBalance;
  bool? _showTransactions;
  bool? _statements;
  bool? _sendImages;
  bool? _sendVideos;
  bool? _requestDiscretionary;
  Access copyWith({
    bool? showBalance,
    bool? showTransactions,
    bool? statements,
    bool? sendImages,
    bool? sendVideos,
    bool? requestDiscretionary,
  }) =>
      Access(
        showBalance: showBalance ?? _showBalance,
        showTransactions: showTransactions ?? _showTransactions,
        statements: statements ?? _statements,
        sendImages: sendImages ?? _sendImages,
        sendVideos: sendVideos ?? _sendVideos,
        requestDiscretionary: requestDiscretionary ?? _requestDiscretionary,
      );
  bool? get showBalance => _showBalance;
  bool? get showTransactions => _showTransactions;
  bool? get statements => _statements;
  bool? get sendImages => _sendImages;
  bool? get sendVideos => _sendVideos;
  bool? get requestDiscretionary => _requestDiscretionary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['showBalance'] = _showBalance;
    map['showTransactions'] = _showTransactions;
    map['statements'] = _statements;
    map['sendImages'] = _sendImages;
    map['sendVideos'] = _sendVideos;
    map['requestDiscretionary'] = _requestDiscretionary;
    return map;
  }
}
