/// fullName : "Dave Smith"
/// dateOfBirth : "1975-11-24"
/// detail : "Carer"
/// phoneNumber : "0161123456"

class RegisterAccountModel {
  RegisterAccountModel({
    String? fullName,
    String? dateOfBirth,
    String? detail,
    String? phoneNumber,
  }) {
    _fullName = fullName;
    _dateOfBirth = dateOfBirth;
    _detail = detail;
    _phoneNumber = phoneNumber;
  }

  RegisterAccountModel.fromJson(dynamic json) {
    _fullName = json['fullName'];
    _dateOfBirth = json['dateOfBirth'];
    _detail = json['detail'];
    _phoneNumber = json['phoneNumber'];
  }
  String? _fullName;
  String? _dateOfBirth;
  String? _detail;
  String? _phoneNumber;
  RegisterAccountModel copyWith({
    String? fullName,
    String? dateOfBirth,
    String? detail,
    String? phoneNumber,
  }) =>
      RegisterAccountModel(
        fullName: fullName ?? _fullName,
        dateOfBirth: dateOfBirth ?? _dateOfBirth,
        detail: detail ?? _detail,
        phoneNumber: phoneNumber ?? _phoneNumber,
      );
  String? get fullName => _fullName;
  String? get dateOfBirth => _dateOfBirth;
  String? get detail => _detail;
  String? get phoneNumber => _phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = _fullName;
    map['dateOfBirth'] = _dateOfBirth;
    map['detail'] = _detail;
    map['phoneNumber'] = _phoneNumber;
    return map;
  }
}
