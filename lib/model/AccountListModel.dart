/// id : "11111111-2222-3333-4444-555555555555"
/// name : "CASHPLUS CLIENT BUDGET ACCOUNT"
/// clientId : "99999999-8888-7777-6666-555555555555"
/// clientName : "DORRIS CLIENT"
/// sortCode : "300002"
/// accountNo : "01234567"
/// balance : 127.89
/// balanceDate : "2022-03-25"
/// allowanceLeft : 20
/// access : 7

class AccountListModel {
  AccountListModel({
    String? id,
    String? name,
    String? clientId,
    String? clientName,
    String? sortCode,
    String? accountNo,
    double? balance,
    String? balanceDate,
    int? allowanceLeft,
    int? access,
  }) {
    _id = id;
    _name = name;
    _clientId = clientId;
    _clientName = clientName;
    _sortCode = sortCode;
    _accountNo = accountNo;
    _balance = balance;
    _balanceDate = balanceDate;
    _allowanceLeft = allowanceLeft;
    _access = access;
  }

  AccountListModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _clientId = json['clientId'];
    _clientName = json['clientName'];
    _sortCode = json['sortCode'];
    _accountNo = json['accountNo'];
    _balance = json['balance'];
    _balanceDate = json['balanceDate'];
    _allowanceLeft = json['allowanceLeft'];
    _access = json['access'];
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
  int? _access;

  AccountListModel? copyWith({
    String? id,
    String? name,
    String? clientId,
    String? clientName,
    String? sortCode,
    String? accountNo,
    double? balance,
    String? balanceDate,
    int? allowanceLeft,
    int? access,
  }) =>
      AccountListModel(
        id: id,
        name: name,
        clientId: clientId,
        clientName: clientName,
        sortCode: sortCode,
        accountNo: accountNo,
        balance: balance,
        balanceDate: balanceDate,
        allowanceLeft: allowanceLeft,
        access: access,
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

  int? get access => _access;

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
    map['access'] = _access;
    return map;
  }
}
