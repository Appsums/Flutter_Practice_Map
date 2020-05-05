import 'dart:io';
import 'package:baseapp/p_main_app/api_calling_p/LocalConstant.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/progress_bar_p/ProgressBar.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import 'package:baseapp/p_main_app/app_utility_p/pre_default_app_utility_p/ProjectUtil.dart';
import 'package:baseapp/p_main_app/app_widgets_p/country_picker_p/phone_with_country_picker.dart';
import 'package:baseapp/p_main_app/app_widgets_p/pre_default_app_widgets_p/InputDoneView.dart';
import 'package:baseapp/p_main_app/app_widgets_p/pre_default_app_widgets_p/widget_p/NumberTextInputFormatter.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class LoginWithMobile extends StatefulWidget {
  @override
  _LoginWithMobileState createState() => _LoginWithMobileState();

}

class _LoginWithMobileState extends State<LoginWithMobile> {
  var screenSize, screenHeight, screenWidth;
  var overlayEntry;

  Map<String, TextEditingController> controllers = {
    'phone': new TextEditingController(),
  };


  Map<String, FocusNode> focusNodes = {
    'phone': new FocusNode(),
  };

  Map<String, String> errorMessages = {
    'phone': null,
  };

  bool _showError = false;

  String initialCountry = "+82";
  String countryCode="82";
  String mobile;
  bool    isAddCountryPrefix = true;
  String  countryPrefix = "10";
  String  prefixForCountry = "82";


  @override
  void initState() {
    focusNodes['phone'].addListener(_onFocusChange);
    controllers['phone'].text = "10";
    AppValuesFilesLink(context: context);

    if (Platform.isIOS) {
      KeyboardVisibilityNotification().addNewListener(onShow: () {

        showOverlay(context);
      }, onHide: () {

        removeOverlay();
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    controllers['phone'].dispose();
    focusNodes['phone'].dispose();
    super.dispose();
  }

  void _onFocusChange(){
    if(focusNodes['phone'].hasFocus){
      //appendPrefix("");
    }
    //debugPrint("Focus: "+focusNodes['phone'].hasFocus.toString());
  }

  void appendPrefix(value) {
    String number = value;
    if(isAddCountryPrefix && (countryPrefix!=null && countryPrefix.trim().length>0))
    {
      if(!number.startsWith(countryPrefix)){
        if(number!=null && number.trim().length<= (countryPrefix.trim().length)){
          if(number.trim().length==1){
            number = countryPrefix;
          }
          else{
            number = countryPrefix;
          }
        }
        else {
          number = countryPrefix + number;
        }
        controllers['phone'].text = number;
        int newPosition = number.length;
        controllers['phone'].selection = TextSelection(baseOffset: newPosition, extentOffset: newPosition);
      }
      else{
        /*if(number.startsWith(countryPrefix)){
          List<dynamic> enteredNumbers = number.split("");
          int i = 1;
          enteredNumbers.map((value){
            projectUtil.printP("Input ", "$value");
            if(i == countryPrefix.trim().length){
              projectUtil.printP("Input ", " length $value");

            }
            i++;

          }).toList();
        }*/
        controllers['phone'].text = number;
        int newPosition = number.length;
        controllers['phone'].selection = TextSelection(baseOffset: newPosition, extentOffset: newPosition);
      }
    }
    else{
      if(number.startsWith(countryPrefix)){
        number = number.substring(1,countryPrefix.length);
        controllers['phone'].text = number;
        int newPosition = number.length;
        controllers['phone'].selection = TextSelection(baseOffset: newPosition, extentOffset: newPosition);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Focus: "+focusNodes['phone'].hasFocus.toString());
    _mobileFieldView() {
      return Container(
        padding: EdgeInsets.all(AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppValuesFilesLink(context: context).appValuesString.welcome,
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w700,
                  fontSize:
                      AppValuesFilesLink().appValuesDimens.fontSize(value: 24),
                  color: AppValuesFilesLink().appValuesColors.textNormalColor[500]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: AppValuesFilesLink()
                      .appValuesDimens
                      .verticalMarginPadding(value: 8)),
              child: Text(
                AppValuesFilesLink(context: context).appValuesString.enterMobile,
                style: TextStyle(
                    fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                    fontWeight: FontWeight.w500,
                    fontSize: AppValuesFilesLink()
                        .appValuesDimens
                        .fontSize(value: 16),
                    color: AppValuesFilesLink()
                        .appValuesColors
                        .textNormalColor[500]),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: AppValuesFilesLink()
                        .appValuesDimens
                        .verticalMarginPadding(value: 13)),
                child: PhoneWithCountryPicker(
                  inputAction: AppValuesFilesLink().appValuesConst.next,
                  initialCountryCode: initialCountry,
                  focusNode: focusNodes['phone'],
                  maxLength: AppValuesFilesLink().appValuesConst.phoneInputMaxLenth,
                  focus: true,
                  hint:    AppValuesFilesLink(context: context).appValuesString.mobileHint,//"Mobile Number",
                  hintTextColor: AppValuesFilesLink()
                      .appValuesColors
                      .textNormalColor,
                  fontSize: 18.0,
                  keyboardType: AppValuesFilesLink().appValuesConst.numberInput,
                  readOnly: false,
                  textStyle: TextStyle(
                      fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                      fontWeight: FontWeight.w500,
                      fontSize: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 16),
                      color: AppValuesFilesLink()
                          .appValuesColors
                          .textNormalColor[200]),
                  controller: controllers['phone'],
                  countryChange: (countrycode) {
                    setState(() {
                      initialCountry = countrycode.toString();
                        projectUtil.printP("login", "initialCountry : $initialCountry");
                        countryCode = initialCountry.replaceFirst('+', '');

                        if((prefixForCountry!=null && countryCode!=null) && prefixForCountry.trim() == countryCode){
                          setState(() {
                            isAddCountryPrefix = true;
                           // appendPrefix("");
                          });
                        }
                        else{
                          setState(() {
                            isAddCountryPrefix = false;
                          });
                        }

                    });
                  },
                  fillColor:
                  AppValuesFilesLink().appValuesColors.editTextBgColor[100],
                  focusedBorderColor: AppValuesFilesLink()
                      .appValuesColors
                      .editTextFocusedBorderColor[100],
                  cursorColor:
                  AppValuesFilesLink().appValuesColors.editCursorColor[200],
                  error: errorMessages['mobile'],
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,((prefixForCountry!=null && countryCode!=null) && prefixForCountry.trim() == countryCode)?NumberTextInputFormatter(1):NumberTextInputFormatter(2)],
                  ontextChanged: (value) {
                    if (Validation().isNotEmpty(value)) {
                      //Add prefix
                      //appendPrefix(value);

                      if (value.length < 8) {
                        setState(() {
                          setState(() {
                            _showError = false;
                          });
                          errorMessages['phone'] =
                              AppValuesFilesLink(context: context)
                                  .appValuesString
                                  .validPhone;
                        });

                      }
                      else {
                        var startValue =  value.toString().substring(0,3);
                        projectUtil.printP("login", "startValue : $startValue");
                        if(countryCode!=null && countryCode=='82' && initialCountry=='+82' && startValue == countryPrefix){
                          setState(() {
                            mobile = value.toString().substring(countryPrefix.length+1,(value.toString().length));
                            if(mobile.length<8){
                              setState(() {
                                  _showError = false;
                                errorMessages['phone'] = AppValuesFilesLink(context: context)
                                        .appValuesString
                                        .validPhone;
                              });
                            }else{
                              setState(() {
                                _showError = false;
                                mobile = value.toString();
                                errorMessages['phone'] = null;
                              });
                            }
                            projectUtil.printP("login", "mobile : $mobile");
                          });
                        }else{
                          setState(() {
                            _showError = false;
                            mobile = value.toString();
                            errorMessages['phone'] = null;
                          });
                        }
                      }
                    }
                    else {
                      setState(() {
                        setState(() {
                          _showError = false;
                        });
                        errorMessages['phone'] =
                            AppValuesFilesLink(context: context)
                                .appValuesString
                                .phoneNotBlank;
                      });
                    }
                  },
                  onSubmit: (value) {
                    FocusScope.of(context)
                        .requestFocus(new FocusNode());
                  },
                )),
          _showError? Container(
                padding: EdgeInsets.only(
                    top: AppValuesFilesLink()
                        .appValuesDimens
                        .verticalMarginPadding(value: 5),
                    left: AppValuesFilesLink()
                        .appValuesDimens
                        .horizontalMarginPadding(value: 20),
                    right: AppValuesFilesLink()
                        .appValuesDimens
                        .horizontalMarginPadding(value: 20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    errorMessages['phone'] != null
                        ? Image(
                            image:
                                AssetImage("assets/images/login/error@3x.png"),
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
                            errorMessages['phone'] ?? "",
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
                )):Container()
          ],
        ),
      );
    }



    _bottomView() {
      return Positioned(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 150,
            padding: EdgeInsets.only(
                left: AppValuesFilesLink()
                    .appValuesDimens
                    .horizontalMarginPadding(value: 20)),
            //  color: Colors.green,
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 225,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                       AppValuesFilesLink(context: context).appValuesString.receiveSmsText,
                        style: TextStyle(
                            fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                            fontWeight: FontWeight.w400,
                            fontSize: AppValuesFilesLink()
                                .appValuesDimens
                                .fontSize(value: 13.5),
                            color: AppValuesFilesLink()
                                .appValuesColors
                                .textNormalColor[500]),
                      )),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (_validatePhoneField()) {
                          verifyMobileNumber(nationMobile:mobile.toString(),nationCode:countryCode);
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



    return Container(
        color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
    child:SafeArea(
    bottom: false,
      child: Scaffold(
        body: Container(
          color: AppValuesFilesLink().appValuesColors.appBgColor[500],
          margin: EdgeInsets.only(
              top: AppValuesFilesLink()
                  .appValuesDimens
                  .horizontalMarginPadding(value: 60)),
          child: Stack(
            children: <Widget>[_mobileFieldView(), _bottomView()],
          ),
        ),
      ),
    ));
  }

  //You'll receive an SMS confirmation \ncode to verify your phone number
  //Please enter the 6-digit code sent to you at 998645676444

  //for ios done button callback
  onPressCallback() {
    removeOverlay();
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_validatePhoneField()) {
      verifyMobileNumber(nationMobile:mobile.toString(),nationCode:countryCode);
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

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  bool _validatePhoneField() {
    if (errorMessages['phone'] != null ||
        controllers['phone'].text == null ||
        controllers['phone'].text == '' ) {
      setState(() {

        if (controllers['phone'].text == null || controllers['phone'].text == '') {
          errorMessages['phone'] = "Please enter mobile number";
        }
        _showError = true;
      });
      return false;
    } else {
      return true;
    }
  }

  Future<void> verifyMobileNumber({String nationMobile,String nationCode}) async {
    new ProgressBar().showLoader(context);
   var result = await ApiRequest().getOtp(nationMobile: nationMobile,nationCode: nationCode);

   Navigator.pop(context, true);
   if(result!=null){
     Navigator.push(
         context,
         SlideRightRoute(
             widget: LoginWithOtp(
                 mobile: nationMobile,nationCode:countryCode)));
   }
   else{

   }
  }
}

