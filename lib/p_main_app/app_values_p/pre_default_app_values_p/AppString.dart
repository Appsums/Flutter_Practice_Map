import 'package:baseapp/p_main_app/app_utility_p/multilingual/app_localizations.dart';
import 'package:flutter/material.dart';

class AppString {

  static BuildContext context;

  AppString(context1){
    if(context1!=null){
      context = context1;
      try {
        var  appLocalizations = AppLocalizations.of(context);
        langEnglish1 = appLocalizations.translate('first_string');
        basicInfo = appLocalizations.translate('basicInfo');
        rentalRecords = appLocalizations.translate('rentalRecords');
        paymentInfo = appLocalizations.translate('paymentInfo');
        language = appLocalizations.translate('language');
        aboutUs = appLocalizations.translate('aboutUs');
        signOut = appLocalizations.translate('signOut');
        phoneNotBlank = appLocalizations.translate('phoneNotBlank');
        validPhone = appLocalizations.translate('validPhone');
        otpNotBlank = appLocalizations.translate('otpNotBlank');
        validName = appLocalizations.translate('validName');
        businessHours = appLocalizations.translate('businessHours');
        outletType = appLocalizations.translate('outletType');
        serviceLine = appLocalizations.translate('serviceLine');
        borrorTotal = appLocalizations.translate('borrorTotal');
        rentalType = appLocalizations.translate('rentalType');
        save = appLocalizations.translate('save');
        name = appLocalizations.translate('name');
        phone = appLocalizations.translate('phone');
        edit = appLocalizations.translate('edit');
        scanQRCode = appLocalizations.translate('scanQRCode');
        rentalInfo = appLocalizations.translate('rentalInfo');
        termsAndCondition = appLocalizations.translate('termsAndCondition');
        paymentMethod = appLocalizations.translate('paymentMethod');
        rentCaps = appLocalizations.translate('rentCaps');
        returnCaps = appLocalizations.translate('returnCaps');
        rentalLocation = appLocalizations.translate('rentalLocation');
        rent = appLocalizations.translate('rent');
        returnText = appLocalizations.translate('returnText');
        rentalCompleteText = appLocalizations.translate('rentalCompleteText');
        rentalWaitingText = appLocalizations.translate('rentalWaitingText');
        rentalDetails = appLocalizations.translate('rentalDetails');
        saveChanges = appLocalizations.translate('saveChanges');
        languageChanged = appLocalizations.translate('languageChanged');
        avatarUploaded = appLocalizations.translate('avatarUploaded');
        privacyPolicy = appLocalizations.translate('privacyPolicy');
        scan = appLocalizations.translate('scan');
        welcome = appLocalizations.translate('welcome');
        enterMobile = appLocalizations.translate('enterMobile');
        receiveSmsText = appLocalizations.translate('receiveSmsText');
        mobileHint = appLocalizations.translate('mobileHint');
        resendCode = appLocalizations.translate('resendCode');
        enter6digitOTP = appLocalizations.translate('enter6digitOTP');
        getDirections = appLocalizations.translate('getDirections');
        usageTime = appLocalizations.translate('usageTime');
        outletDetails = appLocalizations.translate('outletDetails');
        logoutConfirmation = appLocalizations.translate('logoutConfirmation');
        nameNotBlank = appLocalizations.translate('nameNotBlank');
        emailNotBlank = appLocalizations.translate('emailNotBlank');
        sliderScreen1Text = appLocalizations.translate('sliderScreen1Text');
        sliderScreen2Text = appLocalizations.translate('sliderScreen2Text');
        sliderScreen3Text = appLocalizations.translate('sliderScreen3Text');
        scanCaps = appLocalizations.translate('scanCaps');
        chargeCaps = appLocalizations.translate('chargeCaps');
        search = appLocalizations.translate('search');
        deviceID = appLocalizations.translate('deviceID');
        dateTime = appLocalizations.translate('dateTime');
        location = appLocalizations.translate('location');
        addPaymentMethod = appLocalizations.translate('addPaymentMethod');
        addCard = appLocalizations.translate('addCard');
        cardNumber = appLocalizations.translate('cardNumber');
        expirationDate = appLocalizations.translate('expirationDate');
        dateOfBirth = appLocalizations.translate('dateOfBirth');
        pw = appLocalizations.translate('pw');
        addCartScreenText = appLocalizations.translate('addCartScreenText');
        enterCardInfo = appLocalizations.translate('enterCardInfo');
        agreeCardTerms = appLocalizations.translate('agreeCardTerms');
        confirm = appLocalizations.translate('confirm');
        addCardTitle = appLocalizations.translate('addCardTitle');
        cardSuccess = appLocalizations.translate('cardSuccess');
        acceptTerms = appLocalizations.translate('acceptTerms');
        incorrectOtp = appLocalizations.translate('incorrectOtp');
        notifications = appLocalizations.translate('notifications');
        orderComplete = appLocalizations.translate('orderComplete');

        discount       = appLocalizations.translate('discount');
        totalAmountDue = appLocalizations.translate('totalAmountDue');
        timeDuration   = appLocalizations.translate('timeDuration');
        couponUsed     = appLocalizations.translate('couponUsed');
        noNotifications     = appLocalizations.translate('noNotifications');
        noCard     = appLocalizations.translate('noCard');




      }
      catch (e) {
        print(e);
      }
    }
    else{

    }

  }

  String appName = 'POWER KICK';
  String tryAgain = 'Something went wrong please try again';
  String submitText = 'Submit';
  String locationDetailsText = 'location details';

  //Date format in whole application
  String dateFormat = 'MM/dd/yyyy';
  String timeFormat = 'hh:mm a';

  //Alert message
  String noInternetConnection =
      "No internet connection available. Please check your network!";
  String buttonCancel = "Cancel";

  //App Strings
  String basicInfo = "";
  String addPaymentMethod = "";
  String batteryRentStarted = "You have taken battey on rent";
  String scanCaps = "";
  String rentalRecords = "";
  String paymentInfo = "";
  String notifications = "Notification";
  String noNotifications = "You have no pending notifications";
  String orderComplete = "Order Complete";
  String rentalInfo = "";
  String language = "Language";
  String incorrectOtp = "Incorrect OTP";
  String scanQRCode = "";
  String aboutUs = "";
  String location = "";
  String privacyPolicy = "";
  String pw = "";
  String welcome = "";
  String confirm = "";
  String cardSuccess = "";
  String sliderScreen1Text = "";
  String sliderScreen2Text = "";
  String sliderScreen3Text = "";
  String search = "";
  String mobileHint = "";
  String scan = "Scan";
  String addCard = "";
  String noCard = "You have no cards";
  String termsAndCondition = "";
  String save = "";
  String resendCode = "";
  String enter6digitOTP = "";
  String edit = "";
  String chargeCaps = "";
  String signOut = "";
  String name = "";
  String cardNumber = "";
  String businessHours = "";
  String outletType = "";
  String serviceLine = "";
  String receiveSmsText = "";
  String logoutConfirmation = "";
  String borrorTotal = "";
  String outletDetails = "";
  String rentalType = "";
  String paymentMethod = "";
  String usageTime = "";
  String getDirections = "";
  String rentCaps = "";
  String returnCaps = "";
  String totalAmountDue = "";
  String timeDuration = "";
  String couponUsed = "";
  String dateTime = "";
  String deviceID = "";
  String rentalLocation = "";
  String rent = "";
  String enterMobile = "";
  String returnText = "";
  String amountDue = "Amount Due";
  String discount = "Discount";
  String amountPaid = "Amount Paid";
  String rentalCompleteText = "";
  String rentalWaitingText = "";
  String rentalDetails = "";
  String email = "Email";
  String expirationDate = "";
  String id = "ID";
  String dateOfBirth = "";
  String phone = "";
  String saveChanges = "";
  String langEnglish = "English";
  String powerKickCorporation = "POWER KICK CORPORATION";
  String version = "Version : ";
  String langEnglish1 = "";
  String langKorean = "한국어";
  String avatarUploaded = "";
  String addCartScreenText ="";
  String enterCardInfo ="";
  String agreeCardTerms ="";
  String addCardTitle ="";


  //App messages
  String languageChanged = "";

  //error messages
  String phoneNotBlank = "please enter phone number";
  String validPhone = "please enter valid phone number";
  String otpNotBlank = "please enter OTP";
  String incorrectOTP = "Please enter correct otp";
  String nameNotBlank = "";
  String emailNotBlank = "";
  String acceptTerms = "";
  String validEmail = "Please enter valid email!";
  String validName = "Please enter valid name!";
  String cardNotBlank = "Please enter card number!";
  String validCardNumber = "Please enter valid card number!";
  String expiryDateNotBlank = "Please enter card expiry date!";
  String validExpiryNumber = "Please enter valid date!";
  String dobNotBlank = "Please enter date of birth!";
  String validDob = "Please enter valid date of birth!";
  String pwNotBlank = "Please enter PW!";

  String aboutUsTime = "10:00 AM - 6:00 PM";
  String aboutUsPhone = "02 555 1633";
  String aboutUsEmail = "help@powerkick.co.kr";
  String aboutUsCopyright = "&#169; POWER KICK CORP. ALL RIGHTS RESERVED";
  String aboutUsTermsAndCondition = "이용약관 ";
  String aboutUsUserAgreement = " 개인정보처리방침 ";
  String aboutUsPrivacyPolicyContent =
      "\n\n 주식회사 파워킥 대표자명: CHANG PILHO COLIN\n사업자등록번호: 651-81-01432 | 고객센터: 02-555-1633\n주소: 서울시 강남구 봉은사로 466, 402호";
}
