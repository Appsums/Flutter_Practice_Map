import 'dart:async';
import 'dart:io';
import 'package:baseapp/p_main_app/api_calling_p/LocalConstant.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/api_constant.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/progress_bar_p/ProgressBar.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import 'package:baseapp/p_main_app/app_utility_p/pre_default_app_utility_p/ProjectUtil.dart';
import 'package:baseapp/p_main_app/app_widgets_p/pre_default_app_widgets_p/InputDoneView.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:baseapp/p_main_app/app_utility_p/fcm/firebase_notification_handler.dart';
import '../../../ScreensRoutes.dart';

bool isTimerRunning = true;
String timerInitTime = "";

class LoginWithOtp extends StatefulWidget {
  final mobile, nationCode;

  LoginWithOtp({
    Key key,
    this.mobile,
    this.nationCode,
  }) : super(key: key);

  @override
  _LoginWithOtpState createState() => _LoginWithOtpState(mobile, nationCode);
}

class _LoginWithOtpState extends State<LoginWithOtp>
    with WidgetsBindingObserver {
  var screenSize, screenHeight, screenWidth;
  String mobileNumber;
  String otp = "";
  String mId = "";
  String mMobileNumber = "";
  String _errorMessage;
  Timer mTimer;
  int numberOfInputField = 6;
  double otpBoxBothSideMargin = 0;
  double otpBoxBottomTopMargin = 25;
  double otpBoxHeight = 0;
  double otpBoxWidth = 0;
  double otpBoxTexSize = 0;
  double timerTexSize = 0;
  double otpBoxRadius = 50.0;
  double otpBoxRingWidth = 1.0;
  Color otpSingleBoxBgColor;
  Color otpSingleBoxTextColor;
  Color otpBoxBgColor;
  Color screenBgColor;
  Color otpBoxColor;

  String inputValue = "";
  List<String> inputValueList = new List();
  int otPScreenFrom = 0; //From Log in screen
  //String _verficationCode;
  int timerInitTimeSecond = 30;

  bool hasError = false;
  TextEditingController controller = TextEditingController();

  String deviceToken, deviceType, deviceOsVersion, deviceId;

  var screenFrom = 0;

  var overlayEntry;

  FocusNode _focusOTP;
  String _mobile = "";
  String _nationCode = "";

  bool _showError = false;

  _LoginWithOtpState(String mobile, String nationCode) {
    Future.value().then((value){ timerDown(timerInitTimeSecond);});
    if (mobile != null) {
      this._mobile = mobile;
      this._nationCode = nationCode;
    }

    try {
      new FirebaseNotifications().setUpFirebase(context, null);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _focusOTP = new FocusNode();
    //  controller.addListener(_printLatestValue);
    WidgetsBinding.instance.addObserver(this);

    super.initState();
    if (Platform.isIOS) {
      _focusOTP.addListener(() {
        bool hasFocus = _focusOTP.hasFocus;
        if (hasFocus)
          showOverlay(context);
        else
          removeOverlay();
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    _focusOTP.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /*===============returns login screen view=================*/
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size; //Screen height
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    otpBoxBothSideMargin = 5;
    otpBoxBottomTopMargin = screenSize.width / 60;
    otpBoxHeight = (screenSize.width / 8.5);
    otpBoxWidth = (screenSize.width / 8.5);
    otpBoxTexSize = 25;
    timerTexSize = screenSize.width / 15;
    otpBoxRingWidth = 0;
    numberOfInputField = 6;
    otpBoxRadius = 5;

    otpSingleBoxBgColor = AppValuesFilesLink().appValuesColors.grey;
    otpBoxBgColor = Colors.transparent;
    otpSingleBoxTextColor =
        AppValuesFilesLink().appValuesColors.textNormalColor;
    screenBgColor = AppValuesFilesLink().appValuesColors.appBgColor[500];
    otpBoxColor = AppValuesFilesLink().appValuesColors.editTextBgColor;

    Widget upperPart = Padding(
      padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
      child: Text(
        AppValuesFilesLink().appValuesString.enter6digitOTP+" $_mobile",
        style: TextStyle(
            fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            fontSize: AppValuesFilesLink().appValuesDimens.fontSize(value: 17),
            color: AppValuesFilesLink().appValuesColors.textNormalColor[500]),
      ),
    );

    //////////////////////////  START OTP INPUT FIELD  ////////////////////////
    Widget errorText = Container(
        padding: EdgeInsets.only(
            top: AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 5),
            left: AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 20),
            right: AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 20)),
        child: _showError
            ? (Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _errorMessage != null
                ? Image(
              image: AssetImage("assets/images/login/error@3x.png"),
              width: AppValuesFilesLink()
                  .appValuesDimens
                  .widthDynamic(value: 14),
              height: AppValuesFilesLink()
                  .appValuesDimens
                  .widthDynamic(value: 14),
            )
                : Container(),
            Flexible(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: AppValuesFilesLink()
                          .appValuesDimens
                          .horizontalMarginPadding(value: 5)),
                  child: Text(
                    _errorMessage ?? "",
                    maxLines: 3,
                    style: TextStyle(
                        fontFamily: AppValuesFilesLink()
                            .appValuesFonts
                            .defaultFont,
                        fontWeight: FontWeight.w400,
                        fontSize: AppValuesFilesLink()
                            .appValuesDimens
                            .fontSize(value: 14),
                        color: AppValuesFilesLink()
                            .appValuesColors
                            .editTextErrorColor),
                  )),
            )
          ],
        ))
            : Container());
    //Check logic to get entered OTP
    Widget transParentOTPInput = Container(
        child: Align(
          alignment: Alignment.center,
          child: TextField(
            maxLength: numberOfInputField,
            controller: controller,
            focusNode: _focusOTP,
            autofocus: true,
            showCursor: false,
            enableInteractiveSelection: false,
            keyboardType: TextInputType.number,
            //  keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
            style: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.transparent,
                letterSpacing: 12.0),
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 2.0,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
            cursorColor: AppValuesFilesLink().appValuesColors.lightblack,
            onChanged: (text) {
              if (!isNumber(text)) {
                setState(() {
                  inputValue = "";
                  inputValueList = inputValue.split("");
                });
                controller.clear();
              } else {
                if (controller.text.length <= numberOfInputField) {
                  setState(() {
                    inputValue = text;
                    inputValueList = inputValue.split("");
                  });
                }
                if (controller.text.length == numberOfInputField) {
                  removeOverlay();
                  FocusScope.of(context).requestFocus(new FocusNode());
                  setState(() {
                    inputValue = text;
                    _errorMessage = null;
                    verifyOtp(
                        nationMobile: _mobile,
                        nationCode: _nationCode,
                        verifyCode: inputValue);
                  });
                } else {
                  setState(() {
                    _showError = false;
                    _errorMessage =
                        AppValuesFilesLink().appValuesString.otpNotBlank;
                  });
                }
              }
              projectUtil.printP(
                  "api_request.dart",'List $inputValueList');
            },
          ),
        ));

    //Single input view
    Widget singleField(value) => new Padding(
      padding: EdgeInsets.only(
          left: otpBoxBothSideMargin,
          right: otpBoxBothSideMargin,
          top: otpBoxBottomTopMargin,
          bottom: otpBoxBottomTopMargin),
      child: Container(
        height: otpBoxHeight,
        width: otpBoxWidth,
        child: Container(
          height: otpBoxHeight,
          width: otpBoxWidth,
          child: Align(
            child: new Text(value ?? "0",
                style: new TextStyle(
                    fontFamily:
                    AppValuesFilesLink().appValuesFonts.defaultFont,
                    color: otpSingleBoxTextColor,
                    fontWeight: FontWeight.w900,
                    fontSize: otpBoxTexSize)),
            alignment: Alignment.center,
          ),
          decoration: new BoxDecoration(
            borderRadius:
            new BorderRadius.all(new Radius.circular(otpBoxRadius)),
            color: otpBoxColor,
          ),
          padding: new EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        ),
        decoration: new BoxDecoration(
            borderRadius:
            new BorderRadius.all(new Radius.circular(otpBoxRadius)),
            color: otpSingleBoxBgColor),
        padding: new EdgeInsets.fromLTRB(otpBoxRingWidth, otpBoxRingWidth,
            otpBoxRingWidth, otpBoxRingWidth),
      ),
    );
    //Multi input filed according number off input field
    Widget otpFieldsR() {
      List<Widget> widgetList = new List();
      for (int i = 0; i < numberOfInputField; i++) {
        widgetList.add(
            singleField(inputValueList.length > i ? inputValueList[i] : ""));
      }
      return Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 0),
              alignment: Alignment.topCenter,
              width: screenSize.width,
              child: Container(
                width: screenSize.width,
                color: otpBoxBgColor,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: widgetList,
                  ),
                ),
              )),
          errorText
        ],
      );
    }

    Widget otpInputView =
    Stack(children: <Widget>[otpFieldsR(), transParentOTPInput]);

    /*=================center part=============================*/
    Widget centerPart = Container(
      margin: EdgeInsets.only(top: 0),
      width: screenSize.width,
      child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 0, right: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                otpInputView,
                //timerView
              ],
            ),
          )),
    );

    _bottomView() {
      return Positioned(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 150,
            padding: EdgeInsets.only(
                left: AppValuesFilesLink()
                    .appValuesDimens
                    .horizontalMarginPadding(value: 30)),
            //  color: Colors.green,
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 150,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: !isTimerRunning
                          ?GestureDetector(
                          onTap: (){
                            timerDown(timerInitTimeSecond);
                            setState(() {
                              //controllers['tmp_password'].text = '';
                              isTimerRunning = true;
                              verifyMobileNumber(nationMobile:_mobile.toString(),nationCode:_nationCode);
                            });
                          },
                          child: Text(
                        AppValuesFilesLink().appValuesString.resendCode,
                        style: TextStyle(
                            fontFamily:
                            AppValuesFilesLink().appValuesFonts.defaultFont,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                            fontSize: AppValuesFilesLink()
                                .appValuesDimens
                                .fontSize(value: 14),
                            color: AppValuesFilesLink()
                                .appValuesColors
                                .textNormalColor),
                      )):  Text(
                //'00:56',
                timerInitTime,
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                    fontWeight: FontWeight.w500,
                    fontSize:
                    AppValuesFilesLink().appValuesDimens.fontSize(value: 16),
                    color: AppValuesFilesLink().appValuesColors.textNormalColor[400]),
              )),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        //_errorMessage
                        setState(() {
                          _showError = true;
                        });
                        if (_errorMessage == null &&
                            _errorMessage != '' &&
                            controller.text != null &&
                            controller.text.length == numberOfInputField) {
                          verifyOtp(
                              nationMobile: _mobile,
                              nationCode: _nationCode,
                              verifyCode: inputValue);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            right: AppValuesFilesLink()
                                .appValuesDimens
                                .horizontalMarginPadding(value: 20)),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              //padding: EdgeInsets.only(right: 20),
                                height: AppValuesFilesLink()
                                    .appValuesDimens
                                    .heightDynamic(value: 60),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppValuesFilesLink()
                                      .appValuesColors
                                      .primaryColor
                                      .withOpacity(0.1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppValuesFilesLink()
                                          .appValuesColors
                                          .primaryColor
                                          .withOpacity(0.22),
                                      spreadRadius: 8,
                                      blurRadius: 8,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 0),
                                  child: Image.asset(
                                    "assets/images/login/big_arrow_without_shadow@3x.png",
                                    height: AppValuesFilesLink()
                                        .appValuesDimens
                                        .imageSquareAccordingScreen(value: 60),
                                    width: AppValuesFilesLink()
                                        .appValuesDimens
                                        .imageSquareAccordingScreen(value: 60),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child:Container(
          color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
          child:SafeArea(
              bottom: false,
              child:Scaffold(
        appBar: BackArrowAppBar().appBarBackArrow(
            "",
            AppValuesFilesLink().appValuesColors.appBarTextColor[100],
            AppValuesFilesLink().appValuesColors.appBarLetIconColor[200],
            AppValuesFilesLink().appValuesColors.appBarBgColor[200],
            AppValuesFilesLink().appValuesDimens.widthDynamic(value: 22), () {
          Navigator.pop(context, true);
        }),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            decoration: BoxDecoration(color: screenBgColor),
            width: screenSize.width,
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[upperPart, centerPart],
                ),
                _bottomView()
              ],
            ),
          ),
        ),
      ))),
    );
  }

  // Function to validate the number
  bool isNumber(String value) {
    projectUtil.printP(
        "api_request.dart","value $value");
    if (value == null) {
      return true;
    }
    final n = num.tryParse(value);
    return n != null;
  }

  //Timer for resend OTP option
  timerDown(timerInitTimeSecond) {
    int seconds1 = timerInitTimeSecond;
    int holdTime = 2;
    if (mTimer != null) {
      isTimerRunning = true;
      mTimer.cancel();
    }
    setState(() {
      isTimerRunning = true;
    });
    mTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds1 > -holdTime) {
        seconds1 = seconds1 - 1;
      }
      if (mounted) {
        setState(() {
                if (seconds1 >= 0) {
                  timerInitTime = "00:" + (seconds1).toString().padLeft(2, '0');
                } else {
                  timerInitTime = "00:00";
                }
                if (seconds1 <= -holdTime) {
                  timerInitTime = '';
                  isTimerRunning = false;
                }
              });
      }
      projectUtil.printP(
          "api_request.dart","$timerInitTime");
    });
  }

  //for ios done button callback
  onPressCallback() {
    removeOverlay();
    if (_errorMessage != null &&
        _errorMessage != '' &&
        controller.text == null &&
        controller.text.length != numberOfInputField) {
      setState(() {
        _showError = true;
      });
    }
  }

//for keyboard done button
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: InputDoneView(onPressCallback, DONE));
    });

    overlayState.insert(overlayEntry);
  }

  Future<void> verifyOtp(
      {String nationMobile, String nationCode, String verifyCode}) async {
    new ProgressBar().showLoader(context);

    await new FirebaseNotifications().getToken();

    String deviceToken = await SharedPreferencesFile().readStr(deviceTokenC);
    ProjectUtil().printP("Home","Token $deviceToken");

    String deviceType = "IOS";

    if (Platform.isAndroid) {
      deviceType = "ANDROID";
    }

    if(deviceToken!=null){

    }

    var result = await ApiRequest().verifyOtp(
        nationMobile: nationMobile,
        nationCode: nationCode,deviceToken: deviceToken,deviceType: deviceType,
        verifyCode: verifyCode);

    if (result != null) {
      //if(result.status && result.responseData!=null){
      if (result.success && result.result != null) {
        var data = result.result;

        await SharedPreferencesFile().saveStr(userIdC, data.userId);

        await SharedPreferencesFile().saveStr(mobileC, data.mobile);

        await SharedPreferencesFile().saveStr(nameC, data.name);

        await SharedPreferencesFile().saveStr(nationMobileC, data.nationMobile);

        await SharedPreferencesFile().saveStr(deviceTypeC, data.type);

        await SharedPreferencesFile().saveStr(emailC, data.email);

        await SharedPreferencesFile().saveStr(nationCodeC, data.nationCode);

        await SharedPreferencesFile().saveStr(userProfileImageC, data.avatar);

        await SharedPreferencesFile().saveStr(sessionIdC, data.sessionId);

        if (data.token != null && data.token != "") {
          await SharedPreferencesFile().saveStr(accessTokenC, data.token);

          getUserInfo().then((value){
            SharedPreferencesFile().saveBool(isUSerLoggedInC, true);
          });



        }
      } else {
        Navigator.pop(context, true);

        String message = result.msg;
        message= (message!=null && message.trim()!="")?message.trim():AppValuesFilesLink().appValuesString.incorrectOtp;
        AppWidgetFilesLink().appCustomUiWidget.errorDialog(context, true,
            AppValuesFilesLink().appValuesString.appName,"$message", (context1) {
              Navigator.pop(context1);
              if (result.statusCode == -2000) {
                exit(0);
              }
            });
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  //Get user info api
  Future<void> getUserInfo() async {

    var result = await ApiRequest().getUserInfo();

    if(result!=null){
      //if(result.status && result.responseData!=null){
      Navigator.pop(context, true);
      if(result.success && result.result!=null){
        var data = result.result;
        if (data!=null) {
          setState(()  {
            SharedPreferencesFile().saveStr(nameC, data.nickName??"");

            SharedPreferencesFile().saveStr(userProfileImageC, data.avatar??"");

            SharedPreferencesFile().saveStr(emailC, data.email??"");


            Navigator.pushAndRemoveUntil(
                context,
                SlideRightRoute(widget: HomeScreen()),
                ModalRoute.withName(homeScreen));
          });
        }
      }else{
        Navigator.pop(context, true);
        AppWidgetFilesLink().appCustomUiWidget.errorDialog(
            context,
            true,
            AppValuesFilesLink().appValuesString.appName,
            result.msg, (context1) {
          Navigator.pop(context1);
          if (result.statusCode == -2000) {
            exit(0);
          }
        });
      }
    }
    else{
      Fluttertoast.showToast(msg: "Something went wrong");
    }


  }

  Future<void> verifyMobileNumber({String nationMobile,String nationCode}) async {
    new ProgressBar().showLoader(context);
    var result = await ApiRequest().getOtp(nationMobile: nationMobile,nationCode: nationCode);
    Navigator.pop(context, true);
    if(result!=null){
      Fluttertoast.showToast(msg: "OTP resent successfully!!");
    }
    else{

    }
  }
  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }
}
