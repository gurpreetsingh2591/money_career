import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(58, 76, 148, 1);
const kPrimaryColor2 = Color.fromRGBO(116, 128, 179, 1.0);
const kSecondaryColor = Color.fromRGBO(247, 245, 255, 1.0);
const kButtonColor = Color.fromRGBO(0, 102, 0, 1);
const kBlackColor = Color.fromRGBO(9, 9, 9, 1.0);
const kBlueColor = Color.fromRGBO(150, 181, 210, 1.0);
const kBaseColor = Color.fromRGBO(57, 19, 80, 1);
const kLightGray = Color.fromRGBO(196, 196, 196, 1.0);
const kTrans = Color.fromRGBO(255, 255, 255, 0.0);
const kBaseLightColor = Color.fromRGBO(173, 69, 154, 1);
const kTextColor = Color.fromRGBO(0, 122, 255, 1);

// Form Error
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$");

final RegExp phoneValidatorRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

const String kSupportMail = 'support@moneycarer.org.uk';
const String kSupportPhone = '+08000830626';
/*Validation Message*/
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter valid Email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password length should be more than Six\neg: 123456";
const String kNameNullError = "Please enter your name";
const String kStreetNullError = "Please enter your street";
const String kCityNullError = "Please enter your city";
const String kStateNullError = "Please enter your state";
const String kZipCodeNullError = "Please enter your zip code";
const String kCorrectCode = "Please enter 4-set code";
const String kEnterPassword = 'Enter Password';
const String kEnterEmail = 'Enter Email';
const String kNewPassword = 'New Password';
const String kConfirmNewPassword = 'Confirm New Password';
const String kEnterNewPassword = "Entre new password";
const String kEnterName = "Please enter name";
const String kEnterDob = "Please enter date of birth";
const String kEnterFullName = "Full Name";
const String kEnterPhone = 'Phone Number';

const kInventoryNameNullError = "Please enter first name";
const kLastNameNullError = "Please enter last name";
const String kItemDescriptionNullError = "Please enter description";
const String kItemHistoryNullError = "Please enter history";
const String kGiftNullError = "Please enter gift recipient";
const String kSignNullError = "Please enter signature";
const String kRelationshipNullError = "Please enter your relationship";

const String kSignUp = "Sign Up";
const String kSignIn = "Sign In";
const String kSetCode = 'Set code';
const String kBioMetrics = "Use Biometrics";
const String kYes = 'Yes';
const String kNo = 'No';
const String kCancel = "Cancel";
const String kOK = 'OK';
const String kSend = "Send";
const String kSubmit = 'Submit';
const String kAgree = 'Agree';
const String kMinus = '-';
const String kPlus = "+";
const String kPound = "£";
const String kThisMonth = "This Month";
const String kLastMonth = "Last Month";
const String kThisYear = "This Year";
const String kLastYear = "Last Year";
const String kLast12Month = "Last 12 Month";
const String kShareStatement = "Share Statement file";
const String kDownloadStatement = 'Download Statement';
const String kShare = 'Share Statement';
const String kStatementExport = "Statement export options";
const String kNote = 'Note';
const String kMoneyAccount = "Money Carer Account";
const String kRegisterAnAccount = "Register an account";

/*Navigation Title*/
const String kLogout = "Log out";
const String kDeleteAccountTitle = "Delete account";
const String kFAQ = "Frequently asked questions";
const String kNewsUpdate = "News & Updates";
const String kHome = "Home";

const String kPleaseWait = "Please wait...";
const String kWelcomeText = "Welcome to Money Carer";
const String kRegister = 'Register';
const String kExtraFund = 'Request Extra Funds';
const String kScanReceipt = 'Scan Receipt or Invoice';
const String kSendReceipt = 'Send Receipt or Invoice';
const String kSendVideo = 'Send Video';
const String kLatestNews = 'Latest News';
const String kChangePassword = 'Change Password';
const String kSignInText = "Sign in to Money Carer application";
const String kDoNotHaveAccountText = "Don’t have an account? Sign Up here";
const String kNotAccount = "There are not any accounts!";
const String kDeleteAccount = "Want to delete your account?";
const String kDeleteAccountInfo = "Please contact the office with either of the two methods below and we will assist you in deleting your account ";
const String kCallToMoneyCarerText = "Call us at Money Carer";
const String kEmailInfo = "Email us at Money Carer";
const String kAccountDeleteInfo = "You can email our support team at anytime for help deleting your Money Carer account";
const String kCallingInfo = "You can call us on the number below between 9:00am - 5:00pm for help with deleting your Money Carer account";
const String kSureToLogout = "Are you sure you want log out of your account?";
const String kLogoutInfo = "You have been logged out of your Money Carer account. You will need to log back in to access your account";
const String kFillDetailInfo = "Please fill in your full details below to register for the Money Carer application";
const String kVideoSendInfo = "Do you want to send these videos to the Money Carer admin?";
const String kVideoSizeInfo = 'your video size should be less than 50MB';

const String kSignUpText = "Sign up for a Money Carer account to help take the financial stress out of caring ";
const String kNewsText = "Scroll down to read the latest information and view videos about new developments at Money Carer.";
const String kFAQText = "Frequently Asked Questions and Answers about your account and features and functionality of this App.";
const String kChangePasswordText = "Please follow the instructions below to change and update your password.";
const String kNotificationText = 'I would like to receive regular updates about Money Carer as a service and about any new products that become available';
const String k2FactorSMS = "You will shortly receive a text message with a 4 digit security code. Please enter this below";
const String kBioAuthText = "Do you want to use your devices face id or fingerprint recognition to access your account in future?";
const String kLoremIpsum = "Lorem ipsum dolor sit amet, consecrated advising elite, sed do emus temper incident ut labor et door magna ";
const String kRegisterAnAccountIpsum =
    " You can now register the accounts of the people you care give for by selecting the button below and filling out the form";
List<String> tellUsAboutYourselfList = [
  'Tell us about yourself',
  'I’m a Client',
  'I’m a Carer',
  'I’m a Family Member',
  'I’m a Social Worker',
  'I’m a Solicitor',
  'I’m a Medical Professional'
];

BoxDecoration boxDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: ExactAssetImage('assets/onBoard/bridgeman_hp.png'),
      // image: Image.asset("/assets/onBoard/bridgeman_hp"),
    ),
  );
}

BoxDecoration boxUnion() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: ExactAssetImage('assets/onBoard/union.png'),
      // image: Image.asset("/assets/onBoard/bridgeman_hp"),
    ),
  );
}

BoxDecoration boxWaveWhite() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: ExactAssetImage('assets/news/vector_bg.png'),
      // image: Image.asset("/assets/onBoard/bridgeman_hp"),
    ),
  );
}

BoxDecoration boxBottom() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: ExactAssetImage('assets/onBoard/ellipse.png'),
    ),
  );
}

BoxDecoration boxBoardTwoBg() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: ExactAssetImage('assets/onBoard/bg_board_two.png'),
    ),
  );
}

BoxDecoration boxBoardThreeBg() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: ExactAssetImage('assets/onBoard/bg_board_three.png'),
    ),
  );
}

BoxDecoration boxLoginBg() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: ExactAssetImage('assets/login/ellipse_colored.png'),
    ),
  );
}

BoxDecoration boxOTPBg() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: ExactAssetImage('assets/otp/ellipse_bottom.png'),
    ),
  );
}

BoxDecoration boxSendRequestBg() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fitHeight,
      image: ExactAssetImage('assets/single_account/ellipse_small.png'),
    ),
  );
}

BoxDecoration boxDrawer() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: ExactAssetImage('assets/home/drawer_bg.png'),
    ),
  );
}

BoxDecoration boxUserDetail() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: ExactAssetImage('assets/home/rectangle_bg.png'),
    ),
  );
}

BoxDecoration boxUserAmountDetail() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: ExactAssetImage('assets/home/rectangle_bg_account.png'),
    ),
  );
}

LinearGradient gradient = const LinearGradient(colors: <Color>[
  kBaseColor,
  kBaseLightColor,
]);
final kInnerDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(10),
);

final kGradientBoxDecoration = BoxDecoration(
  gradient: const LinearGradient(colors: [kBaseLightColor, kBaseColor]),
  borderRadius: BorderRadius.circular(10),
);

const kGradientBackgroundBoxDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [kBaseLightColor, kBaseColor]),
  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
);

TextStyle textStyle() {
  return const TextStyle(fontSize: 13.5, color: kBaseColor, fontFamily: 'Raleway');
}

TextStyle hintStyle() {
  return const TextStyle(fontSize: 13, color: kBaseColor, fontFamily: 'Raleway');
}

InputBorder border() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: kBaseLightColor,
    ),
  );
}

InputBorder focusedBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      width: 1.5,
      color: kBaseLightColor,
    ),
  );
}

class AppMaterialTextSelectionControls extends MaterialTextSelectionControls {
  AppMaterialTextSelectionControls({
    required this.onPaste,
  });
  ValueChanged<TextSelectionDelegate> onPaste;
  @override
  Future<void> handlePaste(final TextSelectionDelegate delegate) {
    onPaste(delegate);
    return super.handlePaste(delegate);
  }
}
