class ApiConstants {
  //Firebase
  static String baseUrlSignUpSingIn = 'https://identitytoolkit.googleapis.com/v1/accounts:';
  static String baseUrlRefreshToken = 'https://securetoken.googleapis.com/v1/token';

  static String usersSignUp = 'signUp';
  static String usersChangePassword = 'update';
  static String signInWithPassword = 'signInWithPassword';
  static String sendOobCode = 'sendOobCode';
  static String authKey = '?key=AIzaSyCdXvpJmyOkYMxBAgpidsS85KLPEWh4hcQ';

  //Server url
  //static String baseUrl = 'https://stoplight.io/mocks/mcf/mobile2/46167989/';
  static String GraphQLBaseUrl = 'https://api-eu-west-2.graphcms.com/v2/cl3ihgbnh6s4q01z4b0wdbd1r/master';
  // static String baseUrl = 'https://test-mobile.moneymanagement.org.uk/api/';
  static String baseUrl = 'https://mobile.moneycarer.org.uk/api/';
  //static String accountList = 'account/list';

  // url end point
  static String accountList = 'Account/list';
  static String registration = 'Registration';
  static String requestList = 'Request/list';
  static String requestCreate = 'Request/create';
  static String transactionsList = 'Account/transactions';
  static String accountStatement = 'Account/statement';
  static String mfaCheck = 'MFA/check?';
  static String mfaDetail = 'MFA/detail';
  static String mfaStart = 'MFA/start';
  static String mfaValidate = 'MFA/validate';
  static String uploadPhotos = 'Media/uploadphotos';
  static String uploadVideo = 'Media/uploadvideo';
  static String requestFund = 'Account/takeallowance';

  //constant parameters
  static String email = 'email';
  static String password = 'password';
  static String returnSecureToken = 'returnSecureToken';
  static String idToken = 'idToken';
  static String bearer = 'Bearer ';
  static String authorization = 'Authorization ';
  static String fullName = 'fullName';
  static String dateOfBirth = 'dateOfBirth';
  static String detail = 'detail';
  static String phoneNumber = 'phoneNumber';
  static String clientId = 'clientId';
  static String accId = 'accId';
  static String pageNo = 'pageNo';
  static String pageSize = 'pageSize';
  static String type = 'type';
  static String device = 'device';
  static String method = 'method';
  static String code = 'code';
  static String notes = 'notes';
  static String amount = 'amount';
  static String reason = 'reason';
}
