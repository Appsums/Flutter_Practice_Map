import 'dart:io';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/app_widgets_p/pre_default_app_widgets_p/CustomUiWidget.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:baseapp/p_main_app/api_calling_p/LocalConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/progress_bar_p/ProgressBar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCardScreen extends StatefulWidget {
  final comefrom;

  AddCardScreen({Key key, this.comefrom,}) : super(key: key);
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  bool isDataReady = true;

  Map<String, TextEditingController> controllers = {
    'card_number': new TextEditingController(),
    'expiry_date': new TextEditingController(),
    'dob': new TextEditingController(),
    'pw': new TextEditingController(),
  };

  /*Map<String, TextEditingController> controllers1 = {
    'card_number1': new TextEditingController()
  };*/

  Map<String, FocusNode> focusNodes = {
    'card_number': new FocusNode(),
    'expiry_date': new FocusNode(),
    'dob': new FocusNode(),
    'pw': new FocusNode(),
  };

  Map<String, String> errorMessages = {
    'card_number': null,
    'expiry_date': null,
    'dob': null,
    'pw': null,
  };

  bool agree = false;

  @override
  void dispose() {
    controllers['card_number'].dispose();
    controllers['expiry_date'].dispose();
    controllers['dob'].dispose();
    controllers['pw'].dispose();
    focusNodes['card_number'].dispose();
    focusNodes['expiry_date'].dispose();
    focusNodes['dob'].dispose();
    focusNodes['pw'].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Error message pop up
    _showErrorPopUp(errorMessage) {
      AppWidgetFilesLink().appCustomUiWidget.errorDialog(
          context,
          false,
          AppValuesFilesLink().appValuesString.appName,
          errorMessage, (context1) {
        Navigator.pop(context1);
      });
    }

    //Check input fields
    bool _validateFields() {
      if (controllers['card_number'].text == null ||
          controllers['card_number'].text == '') {
        if (controllers['card_number'].text != null &&
            controllers['card_number'].text.length != 16) {
          _showErrorPopUp(AppValuesFilesLink().appValuesString.validCardNumber);
          return false;
        } else {
          _showErrorPopUp(AppValuesFilesLink().appValuesString.cardNotBlank);
        }
        return false;
      } else if (controllers['expiry_date'].text == null ||
          controllers['expiry_date'].text == '') {
        if (controllers['expiry_date'].text != null &&
            controllers['expiry_date'].text.length != 4) {
          _showErrorPopUp(
              AppValuesFilesLink().appValuesString.validExpiryNumber);
          return false;
        } else {
          _showErrorPopUp(AppValuesFilesLink().appValuesString..dobNotBlank);
        }
        return false;
      } else if (controllers['dob'].text == null ||
          controllers['dob'].text == '') {
        if (controllers['dob'].text != null &&
            controllers['dob'].text.length != 6) {
          _showErrorPopUp(AppValuesFilesLink().appValuesString.validDob);
          return false;
        } else {
          _showErrorPopUp(AppValuesFilesLink().appValuesString.dobNotBlank);
        }
        return false;
      } else if (controllers['pw'].text == null ||
          controllers['pw'].text == '') {
        _showErrorPopUp(AppValuesFilesLink().appValuesString.emailNotBlank);
        return false;
      } else if (!agree) {
        _showErrorPopUp(AppValuesFilesLink().appValuesString.acceptTerms);
        return false;
      } else {
        return true;
      }
    }

    //Divider
    Widget divider = Padding(
        padding: EdgeInsets.only(
          left: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
          right: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
        ),
        child: Container(
          height:
          AppValuesFilesLink().appValuesDimens.heightDynamic(value: 0.3),
          decoration: BoxDecoration(
            color: AppValuesFilesLink().appValuesColors.drawerDividerColor[500],
            shape: BoxShape.rectangle,
          ),
        ));

    //User name field
    Widget cardNumberField() {
      return Container(
        color: AppValuesFilesLink().appValuesColors.white,
        height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 55),
        padding: EdgeInsets.only(
          top: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 0),
          bottom: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 0),
          left: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
          right: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              AppValuesFilesLink().appValuesString.cardNumber,
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w500,
                  fontSize:
                  AppValuesFilesLink().appValuesDimens.fontSize(value: 17),
                  color: AppValuesFilesLink().appValuesColors.textNormalColor),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: AppValuesFilesLink()
                            .appValuesDimens
                            .fontSize(value: 17),
                        right: 0,
                        top: AppValuesFilesLink()
                            .appValuesDimens
                            .fontSize(value: 15)),
                    child: AppWidgetFilesLink().mCardInputFieldWithoutError(
                        keyboardType: NUMBER_INPUT,
                        inputAction: NEXT,
                        maxLength: 16,
                        maxLines: 1,
                        readOnly: false,
                        focusNode: focusNodes['card_number'],
                        controller: controllers['card_number'],
                        cursorColor: AppValuesFilesLink()
                            .appValuesColors
                            .textNormalColor[500],
                        textColor: AppValuesFilesLink()
                            .appValuesColors
                            .textNormalColor[500],
                        cardInputFormat: [
                          MaskedTextInputFormatter(
                            mask: 'XXXX XXXX XXXX XXXX',
                            separator: ' ',
                          ),
                        ],
                        hint: "XXXX XXXX XXXX XXXX",
                        fontSize: AppValuesFilesLink()
                            .appValuesDimens
                            .fontSize(value: 17),
                        ontextChanged: (value) {
                          if (value != null && value != "") {
                            setState(() {});
                          } else {
                            setState(() {});
                          }
                        },
                        onSubmit: (value) {
                          setState(() {
                            controllers['card_number'].text = value;
                          });
                          FocusScope.of(context)
                              .requestFocus(focusNodes['expiry_date']);
                        })),
              ),
            )
          ],
        ),
      );
    }

    //User email field
    Widget expiryDateField = Container(
      height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 55),
      color: AppValuesFilesLink().appValuesColors.white,
      padding: EdgeInsets.only(
        top: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 0),
        bottom: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 0),
        left: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
        right: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            AppValuesFilesLink().appValuesString.expirationDate,
            style: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                fontWeight: FontWeight.w500,
                fontSize:
                AppValuesFilesLink().appValuesDimens.fontSize(value: 17),
                color: AppValuesFilesLink().appValuesColors.textNormalColor),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 17),
                      top: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 15)),
                  child: AppWidgetFilesLink().mCardInputFieldWithoutError(
                      keyboardType: NUMBER_INPUT,
                      inputAction: DONE,
                      maxLength: 4,
                      maxLines: 1,
                      readOnly: false,
                      focusNode: focusNodes['expiry_date'],
                      controller: controllers['expiry_date'],
                      cursorColor: AppValuesFilesLink()
                          .appValuesColors
                          .textNormalColor[500],
                      textColor: AppValuesFilesLink()
                          .appValuesColors
                          .textNormalColor[500],
                      cardInputFormat: [
                        MaskedTextInputFormatter(
                          mask: 'MM/YY',
                          separator: '/',
                        ),
                      ],
                      hint: "MM/YY",
                      fontSize: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 17),

                      ontextChanged: (value) {
                        if (value != null && value != "") {
                          setState(() {});
                        } else {
                          setState(() {});
                        }
                      },
                      onSubmit: (value) {
                        FocusScope.of(context).requestFocus(focusNodes['dob']);
                        setState(() {
                          controllers['expiry_date'].text = value;
                        });
                      })),
            ),
          )
        ],
      ),
    ); //User email field

    Widget dobField = Container(
      height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 55),
      color: AppValuesFilesLink().appValuesColors.white,
      padding: EdgeInsets.only(
        top: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 0),
        bottom: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 0),
        left: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
        right: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            AppValuesFilesLink().appValuesString.dateOfBirth,
            style: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                fontWeight: FontWeight.w500,
                fontSize:
                AppValuesFilesLink().appValuesDimens.fontSize(value: 17),
                color: AppValuesFilesLink().appValuesColors.textNormalColor),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 17),
                      top: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 15)),
                  child: AppWidgetFilesLink().mCardInputFieldWithoutError(
                      keyboardType: NUMBER_INPUT,
                      inputAction: DONE,
                      maxLength: 6,
                      maxLines: 1,
                      readOnly: false,
                      focusNode: focusNodes['dob'],
                      controller: controllers['dob'],
                      cursorColor: AppValuesFilesLink()
                          .appValuesColors
                          .textNormalColor[500],
                      textColor: AppValuesFilesLink()
                          .appValuesColors
                          .textNormalColor[500],
                      cardInputFormat: [
                        MaskedTextInputFormatter(
                          mask: 'YY/MM/DD',
                          separator: '/',
                        ),
                      ],
                      hint: "YY/MM/DD",
                      fontSize: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 17),
                      /* suffixIcon:
                          (controllers['dob'].text.toString().trim().length >
                                  0)
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      controllers['dob'].text = "";
                                    });
                                  },
                                  child: Container(
                                    height: 0,
                                    padding: EdgeInsets.fromLTRB(
                                      AppValuesFilesLink()
                                          .appValuesDimens
                                          .verticalMarginPadding(value: 5),
                                      AppValuesFilesLink()
                                          .appValuesDimens
                                          .verticalMarginPadding(value: 5),
                                      AppValuesFilesLink()
                                          .appValuesDimens
                                          .verticalMarginPadding(value: 0),
                                      AppValuesFilesLink()
                                          .appValuesDimens
                                          .verticalMarginPadding(value: 17),
                                    ),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/home/cross@3x.png'),
                                      width: 0,
                                      height: 0,
                                    ),
                                  ),
                                )
                              : null,*/
                      ontextChanged: (value) {
                        if (value != null && value != "") {
                          setState(() {});
                        } else {
                          setState(() {});
                        }
                      },
                      onSubmit: (value) {
                        FocusScope.of(context).requestFocus(
                          focusNodes['pw'],
                        );
                        setState(() {
                          controllers['dob'].text = value;
                        });
                      })),
            ),
          )
        ],
      ),
    ); //User email field

    Widget pwField = Container(
      height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 55),
      color: AppValuesFilesLink().appValuesColors.white,
      padding: EdgeInsets.only(
        top: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 0),
        bottom: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 0),
        left: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
        right: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            AppValuesFilesLink().appValuesString.pw,
            style: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                fontWeight: FontWeight.w500,
                fontSize:
                AppValuesFilesLink().appValuesDimens.fontSize(value: 17),
                color: AppValuesFilesLink().appValuesColors.textNormalColor),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 17),
                      top: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 15)),
                  child: AppWidgetFilesLink().mCardInputFieldWithoutError(
                      keyboardType: NUMBER_INPUT,
                      inputAction: DONE,
                      maxLength: 2,
                      maxLines: 1,
                      readOnly: false,
                      focusNode: focusNodes['pw'],
                      controller: controllers['pw'],
                      cursorColor: AppValuesFilesLink()
                          .appValuesColors
                          .textNormalColor[500],
                      textColor: AppValuesFilesLink()
                          .appValuesColors
                          .textNormalColor[500],
                      cardInputFormat: [
                        MaskedTextInputFormatter(
                          mask: 'XX',
                          separator: '',
                        ),
                      ],
                      hint: "XX",
                      fontSize: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 17),
                      /*   suffixIcon:
                          (controllers['pw'].text.toString().trim().length >
                                  0)
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      controllers['pw'].text = "";
                                    });
                                  },
                                  child: Container(
                                    height: 0,
                                    padding: EdgeInsets.fromLTRB(
                                      AppValuesFilesLink()
                                          .appValuesDimens
                                          .verticalMarginPadding(value: 5),
                                      AppValuesFilesLink()
                                          .appValuesDimens
                                          .verticalMarginPadding(value: 5),
                                      AppValuesFilesLink()
                                          .appValuesDimens
                                          .verticalMarginPadding(value: 0),
                                      AppValuesFilesLink()
                                          .appValuesDimens
                                          .verticalMarginPadding(value: 17),
                                    ),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/home/cross@3x.png'),
                                      width: 0,
                                      height: 0,
                                    ),
                                  ),
                                )
                              : null,*/
                      ontextChanged: (value) {
                        if (value != null && value != "") {
                          setState(() {});
                        } else {
                          setState(() {});
                        }
                      },
                      onSubmit: (value) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          controllers['pw'].text = value;
                        });
                      })),
            ),
          )
        ],
      ),
    );

    //Card detail view
    Widget cardDetailView() {
      return Container(
        color: AppValuesFilesLink().appValuesColors.white,
        child: Column(
          children: <Widget>[
            cardNumberField(),
            divider,
            expiryDateField,
            divider,
            dobField,
            divider,
            pwField,
            divider,
          ],
        ),
      );
    }

    //Card terms view
    Widget cardTerms() {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
          AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 32),
          AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
          AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 10),
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Align(
          alignment: Alignment.center,
          child: Container(child: Text(
            AppValuesFilesLink().appValuesString.addCartScreenText.substring(0,AppValuesFilesLink().appValuesString.addCartScreenText.lastIndexOf("\n")),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                fontWeight: FontWeight.w500,
                fontSize:
                AppValuesFilesLink().appValuesDimens.fontSize(value: 14),
                fontStyle: FontStyle.normal,
                color: AppValuesFilesLink()
                    .appValuesColors
                    .textSubHeadingColor[100]),
          ),),
        ),
          Align(
          alignment: Alignment.center,
          child: Container(child: Wrap(
            direction: Axis.horizontal,
            children: [Text(
              AppValuesFilesLink().appValuesString.addCartScreenText.substring(AppValuesFilesLink().appValuesString.addCartScreenText.lastIndexOf("\n")+1,AppValuesFilesLink().appValuesString.addCartScreenText.length),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w500,
                  fontSize:
                  AppValuesFilesLink().appValuesDimens.fontSize(value: 14),
                  fontStyle: FontStyle.normal,
                  color: AppValuesFilesLink()
                      .appValuesColors
                      .textSubHeadingColor[100]),
            )],
          ),),
        )
        ],),
      );
    }

    //Card terms view
    Widget acceptCardTerms() {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 20),
          AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 40),
          AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 20),
          AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 10),
        ),
        child:  Align(
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        agree = !agree;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: AppValuesFilesLink()
                              .appValuesColors
                              .appTransColor[700],
                          width: AppValuesFilesLink()
                              .appValuesDimens
                              .widthDynamic(value: 20),
                          height: AppValuesFilesLink()
                              .appValuesDimens
                              .widthDynamic(value: 20),
                          child: SvgPicture.asset(
                              agree
                                  ? "assets/images/home/payment_info/check.svg"
                                  : "assets/images/home/payment_info/uncheck.svg",
                              width: AppValuesFilesLink()
                                  .appValuesDimens
                                  .widthDynamic(value: 20),
                              height: AppValuesFilesLink()
                                  .appValuesDimens
                                  .widthDynamic(value: 20),
                              fit: BoxFit.scaleDown),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppValuesFilesLink()
                                  .appValuesDimens
                                  .horizontalMarginPadding(value: 10)),
                          child: Text(
                            AppValuesFilesLink().appValuesString.agreeCardTerms,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: AppValuesFilesLink()
                                    .appValuesFonts
                                    .defaultFont,
                                fontWeight: FontWeight.w500,
                                fontSize: AppValuesFilesLink()
                                    .appValuesDimens
                                    .fontSize(value: 14),
                                fontStyle: FontStyle.normal,
                                color: AppValuesFilesLink()
                                    .appValuesColors
                                    .textSubHeadingColor[100]),
                          ),
                        ),
                      ],
                    )))
      );
    }

    return WillPopScope(
        onWillPop: () {
          if(widget.comefrom==1){
            Navigator.pop(context, true);
          }else{
            Navigator.pop(context);
          }

          return Future.value(false);
        },
        child: Container(
            color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
            child: SafeArea(
                bottom: false,
                child: Scaffold(
                    appBar: BackArrowAppBar().appBarBackArrow(
                      //addCardTitle
                        AppValuesFilesLink().appValuesString.addCardTitle,
                        AppValuesFilesLink()
                            .appValuesColors
                            .appBarTextColor[200],
                        AppValuesFilesLink()
                            .appValuesColors
                            .appBarLetIconColor[200],
                        AppValuesFilesLink().appValuesColors.appBarBgColor[200],
                        AppValuesFilesLink()
                            .appValuesDimens
                            .widthDynamic(value: 22), () {
                      Navigator.pop(context, true);
                    }),
                    body: Container(
                        color: AppValuesFilesLink().appValuesColors.white,
                        child: ListView(children: <Widget>[
                            Container(
                              height: AppValuesFilesLink()
                                  .appValuesDimens
                                  .heightDynamic(value: 10),
                              decoration: BoxDecoration(
                                color: AppValuesFilesLink()
                                    .appValuesColors
                                    .appBgColor[600],
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                AppValuesFilesLink()
                                    .appValuesDimens
                                    .horizontalMarginPadding(value: 20),
                                AppValuesFilesLink()
                                    .appValuesDimens
                                    .verticalMarginPadding(value: 10),
                                AppValuesFilesLink()
                                    .appValuesDimens
                                    .horizontalMarginPadding(value: 20),
                                AppValuesFilesLink()
                                    .appValuesDimens
                                    .verticalMarginPadding(value: 10),
                              ),
                              child: Text(
                                      AppValuesFilesLink()
                                          .appValuesString
                                          .enterCardInfo,
                                      style: TextStyle(
                                          fontFamily: AppValuesFilesLink()
                                              .appValuesFonts
                                              .defaultFont,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w300,
                                          fontSize: AppValuesFilesLink()
                                              .appValuesDimens
                                              .fontSize(value: 15),
                                          fontStyle: FontStyle.normal,
                                          color: AppValuesFilesLink()
                                              .appValuesColors
                                              .textSubHeadingColor[100]),
                                    ),
                            ),
                            Container(
                              height: AppValuesFilesLink()
                                  .appValuesDimens
                                  .heightDynamic(value: 0.35),
                              decoration: BoxDecoration(
                                color: AppValuesFilesLink()
                                    .appValuesColors
                                    .drawerDividerColor[500],
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            cardDetailView(),
                            cardTerms(),
                            acceptCardTerms(),
                            Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                      top: AppValuesFilesLink()
                                          .appValuesDimens
                                          .verticalMarginPadding(value: 70),
                                      bottom: AppValuesFilesLink()
                                          .appValuesDimens
                                          .verticalMarginPadding(value: 30),
                                    ),
                                    height: AppValuesFilesLink()
                                        .appValuesDimens
                                        .heightDynamic(value: 45),
                                    width: AppValuesFilesLink()
                                        .appValuesDimens
                                        .widthDynamic(value: 140),
                                    child: AppWidgetFilesLink()
                                        .appCustomUiWidget
                                        .buttonRoundCornerWithFontWeightBg(
                                        AppValuesFilesLink()
                                            .appValuesString
                                            .confirm,
                                        AppValuesFilesLink()
                                            .appValuesColors
                                            .white,
                                        AppValuesFilesLink()
                                            .appValuesColors
                                            .buttonBgColor[100],
                                        15.0,
                                        AppValuesFilesLink()
                                            .appValuesDimens
                                            .heightDynamic(value: 26), (value) {
                                      if (_validateFields()) {
                                       // Fluttertoast.showToast(msg: "All fields true");
                                        submitCardDetails();
                                        /* AppWidgetFilesLink()
                                        .appCustomUiWidget
                                        .alertPopUp(
                                            context,
                                            true,
                                            AppValuesFilesLink()
                                                .appValuesString
                                                .cardSuccess);*/
                                        //Navigator.push(context, SlideRightRoute(widget: ManageCards()));
                                      }
                                    }))
                              ],
                            )
                          ])
                        )))));
  }


  Future<void> submitCardDetails() async {
    String birthNo,cardNo,cardPw,expMonth,expYear;
    String expiryDate ;
    cardNo = controllers['card_number'].text.toString().trim();

    try {
      cardNo = cardNo.split(" ").join("");
    } catch (e) {
      print(e);
    }

    expiryDate = controllers['expiry_date'].text.toString().trim();
    birthNo = controllers['dob'].text.toString().trim();
    cardPw = controllers['pw'].text.toString().trim();

    try {
      birthNo = birthNo.split("/").join("");
    } catch (e) {
      print(e);
    }

    if(expiryDate!=null && expiryDate.contains("/")){
      List expiryDateList = expiryDate.split("/");
      if(expiryDateList!=null && expiryDateList.length>1){
        expMonth = expiryDateList[0];
        expYear = expiryDateList[1];
      }
    }

    setState((){
      isDataReady = false;
    });
    new ProgressBar().showLoader(context);
    var result = await ApiRequest().addPaymentCard(birthNo: birthNo,cardNo: cardNo,cardPw:cardPw,expMonth:expMonth,expYear:expYear);
    Navigator.pop(context, true);
    if(result!=null){
      if(result.success && result.result!=null){

        setState(()  {
          isDataReady = true;
        });
        String message = "";
        //Card added failed
        if(result.result.success!=null && result.result.success==false){
          message = result.result.msg!=null?result.result.msg:"";
          AppWidgetFilesLink()
              .appCustomUiWidget
              .alertPopUp(
              context,
              false,
              "$message",(context1){
            Navigator.pop(context1);
          });

          message = result.result.msg!=null?result.result.msg:"";

        }
        //Card added successfully
        else{
          message = result.result.msg!=null?result.result.msg:"";
          AppWidgetFilesLink()
              .appCustomUiWidget
              .alertPopUp(
              context,
              true,
              "$message",(context1){
            Navigator.pop(context1);
            Navigator.pop(context,true);
          });
        }
      }
      else{
        setState((){
          isDataReady = true;
        });
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
      setState((){
        isDataReady = true;
      });
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }
}
