import 'dart:io';

import 'package:baseapp/p_main_app/app_utility_p/pre_default_app_utility_p/ProjectUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../z_main_files_p/AppValuesFilesLink.dart';
import 'ToastCustom.dart';
export 'package:baseapp/p_main_app/app_widgets_p/app_module_specific_widgets_p/payment_card.dart';
export 'package:baseapp/p_main_app/app_widgets_p/app_module_specific_widgets_p/masked_textInput_formatter.dart';

class CustomUiWidget {
  static BuildContext mContext;


  /*============hide keyboard==========*/
  hideKeyboard(ctx) {
    FocusScope.of(ctx).requestFocus(new FocusNode());
  }

  RaisedButton buttonRoundCornerWithBgAndLeftImage(
      String label,
      String image,
      double iconSize,
      screenSize,
      Color labelColor,
      Color bgColor,
      double textSize,
      double borderRadius,
      Function(String) onPressed) {
    return RaisedButton(
      elevation: 0.0,
      child:
      Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  image!=null?(image.contains(".svg")?SvgPicture.asset(
                      image,
                      width: iconSize,
                      height: iconSize,fit: BoxFit.scaleDown):Image(
                    image: new AssetImage(image),
                    width: iconSize,
                    height: iconSize,
                    // color: iconColor != null? iconColor: AppValuesFilesLink().appValuesColors.appTransColor,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  )):Container(),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily:
                            AppValuesFilesLink().appValuesFonts.defaultFont,
                            color: labelColor,
                            fontSize: textSize,
                            fontWeight: FontWeight.w400),
                      ))
                ],
              ))
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onPressed: () => onPressed(label),
      color: bgColor,
    );
  }

  RaisedButton noDataFoundWithImage(
  {String label,
    String image,
    double iconWidth,
    double iconHeight,
    Color labelColor,
    Color bgColor,
    double textSize,
    double borderRadius,
    Function(String) onPressed}) {
    return RaisedButton(
      elevation: 0.0,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  image!=null?(image.contains(".svg")?SvgPicture.asset(
                      image,
                      width: iconWidth!=null?iconWidth:5,
                      height: iconHeight,fit: BoxFit.scaleDown):Image(
                    image: new AssetImage(image),
                    width:  iconWidth!=null?iconWidth:5,
                    height: iconHeight!=null?iconHeight:5,
                    // color: iconColor != null? iconColor: AppValuesFilesLink().appValuesColors.appTransColor,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  )):Container(),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 0,
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily:
                            AppValuesFilesLink().appValuesFonts.defaultFont,
                            color: labelColor,
                            fontSize: textSize,
                            fontWeight: FontWeight.w400),
                      ))
                ],
              ))
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onPressed: () => onPressed(label),
      color: bgColor,
    );
  }



  RaisedButton buttonRoundCornerWithBgAndBorder(
      String label,
      String image,
      double iconSize,
      screenSize,
      Color labelColor,
      Color bgColor,
      Color borderColor,
      double textSize,
      double borderRadius,
      Function(String) onPressed) {
    return RaisedButton(
      elevation: 0.0,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: new AssetImage(image),
                    width: iconSize,
                    height: iconSize,
                    // color: iconColor != null? iconColor: AppValuesFilesLink().appValuesColors.appTransColor,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily:
                            AppValuesFilesLink().appValuesFonts.defaultFont,
                            color: labelColor,
                            fontSize: textSize,
                            fontWeight: FontWeight.w400),
                      ))
                ],
              ))
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(color:borderColor??Colors.yellow,width: 1.5)),
      onPressed: () => onPressed(label),
      color: bgColor,
    );
  }

  RaisedButton buttonRoundCornerWithFontWeightBg(
      String label,
      Color labelColor,
      Color bgColor,
      double textSize,
      double borderRadius,
      Function(String) onPressed) {
    return RaisedButton(
      elevation: 0.0,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                    fontFamily:
                        AppValuesFilesLink().appValuesFonts.semiBoldFont,
                    color: labelColor,
                    fontSize: textSize,
                    fontWeight: FontWeight.w500),
              ))
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onPressed: () {
        return onPressed(label);
      },
      color: bgColor,
    );
  }

/*============exit alert dialog============*/
  Future<bool> confimationDialog(
      BuildContext context, String title, String message, callBackYes) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: new Text(title,
                  style: new TextStyle(
                      color: AppValuesFilesLink().appValuesColors.black,
                      fontSize: 20.0)),
              content: new Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes", style: new TextStyle(fontSize: 18.0)),
                  onPressed: () => callBackYes(),
                ),
                FlatButton(
                  child: Text("No", style: new TextStyle(fontSize: 18.0)),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                )
              ],
            ));
  }

  /*============exit alert dialog============*/
  Future<bool> errorDialog(BuildContext context1, bool isItForInternet,
      String alertTitle, String message, callBackYes) {
    return showDialog(
        context: context1,
        barrierDismissible: !isItForInternet,
        builder: (context1) {
          mContext = context1;
          return AlertDialog(
            title: new Text(alertTitle,
                style: new TextStyle(
                    color: AppValuesFilesLink().appValuesColors.lightBlack,
                    fontSize: 20.0)),
            content: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text("OK", style: new TextStyle(fontSize: 18.0)),
                onPressed: () => callBackYes(context1),
              )
            ],
          );
        });
  }



  /*===============================*/
  //{Key key, @required this.currentUserId}
  TextField inputFields(
      {Key key,
      @required int keyboardType,
      @required int inputAction,
      @required int maxLength,
      @required bool readOnly,
      @required FocusNode focusNode,
      @required TextEditingController controller,
      @required String hint,
      @required double fontSize,
      String error,
      double focusedBorderWidth,
      double borderRadius,
      Color errorColor,
      Color hintTextColor,
      int maxLines,
      bool autoFocus,
      EdgeInsetsGeometry padding,
      TextAlign textAlign,
      Color fillColor,
      Color borderColor,
      Color focusedBorderColor,
      Color enabledBorder,
      Color cursorColor,
      Color textColor,
      TextStyle textStyle,
      @required Function(String) ontextChanged,
      @required Function(String) onSubmit}) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      autofocus: autoFocus ?? false,
      textAlignVertical: TextAlignVertical.center,
      //textAlign: textAlign!=null?textAlign:TextAlign.left,
      keyboardType: keyboardType == 1
          ? TextInputType.number
          : keyboardType == 2
              ? TextInputType.emailAddress
              : keyboardType == 3 ? TextInputType.text : TextInputType.text,
      textCapitalization: keyboardType == 3
          ? TextCapitalization.words
          : keyboardType == 3
              ? TextCapitalization.sentences
              : TextCapitalization.none,
      textInputAction: inputAction == 1
          ? TextInputAction.done
          : inputAction == 2
              ? TextInputAction.next
              : inputAction == 3
                  ? TextInputAction.newline
                  : TextInputAction.done,
      inputFormatters: keyboardType == 1
          ? <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
          : <TextInputFormatter>[],
      maxLength: maxLength,
      maxLines: maxLines != null ? maxLines : 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor != null
            ? fillColor
            : AppValuesFilesLink().appValuesColors.editTextBgColor,
        hintText: hint != null ? hint : '',
        contentPadding: padding != null ? padding : EdgeInsets.all(0),
        //counterText: inputAction == 3 ? (controller != null ? controller.text.length.toString() : '') : "",
        counterText: "",
        hintStyle: TextStyle(
            fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
            color: hintTextColor != null ? hintTextColor : Colors.black87,
            fontSize: fontSize,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(borderRadius != null ? borderRadius : 0)),
            borderSide: BorderSide(
              color: borderColor != null
                  ? borderColor
                  : AppValuesFilesLink().appValuesColors.appDisabledColor[400],
              style: BorderStyle.none,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(borderRadius != null ? borderRadius : 0)),
            borderSide: BorderSide(
                color: focusedBorderColor != null
                    ? focusedBorderColor
                    : AppValuesFilesLink()
                        .appValuesColors
                        .editTextEnabledBorderColor,
                style: BorderStyle.none,
                width: focusedBorderWidth != null ? focusedBorderWidth : 0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(borderRadius != null ? borderRadius : 0)),
            borderSide: BorderSide(
                color: focusedBorderColor != null
                    ? focusedBorderColor
                    : AppValuesFilesLink()
                        .appValuesColors
                        .editTextEnabledBorderColor,
                style: BorderStyle.none,
                width: focusedBorderWidth != null ? focusedBorderWidth : 0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: errorColor != null
                    ? errorColor
                    : AppValuesFilesLink().appValuesColors.appErrorTextColor,
                style: BorderStyle.solid)),
        errorText: error,
      ),
      onSubmitted: onSubmit,
      style: textStyle ??
          TextStyle(
            color: textColor ??
                AppValuesFilesLink().appValuesColors.textNormalColor[400],
          ),
      onChanged: ontextChanged,
      cursorColor: cursorColor != null
          ? cursorColor
          : AppValuesFilesLink().appValuesColors.editCursorColor,
    );
  }

  /*===============================*/
  TextField passwordInputFields(
      int keyboardType,
      int inputAction,
      int maxLength,
      bool readOnly,
      FocusNode focusNode,
      TextEditingController controller,
      String hint,
      double fontSize,
      bool passwordVisible,
      IconButton iconButton,
      String error,
      Function(String) ontextChanged,
      Function(String) onSubmit) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      obscureText: passwordVisible,
      textInputAction: inputAction == 1
          ? TextInputAction.done
          : inputAction == 2 ? TextInputAction.next : TextInputAction.done,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.all(17),
        counterText: keyboardType == 4
            ? (controller != null ? controller.text.length.toString() : '')
            : "",
        hintStyle: TextStyle(
            color: AppValuesFilesLink().appValuesColors.editTextHintColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w300),
        suffixIcon: iconButton,
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppValuesFilesLink()
                    .appValuesColors
                    .appDisabledColor[400])),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppValuesFilesLink()
                    .appValuesColors
                    .editTextFocusedBorderColor,
                style: BorderStyle.solid,
                width: 1.5)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppValuesFilesLink().appValuesColors.editTextErrorColor,
                style: BorderStyle.solid)),
        errorText: error,
      ),
      onSubmitted: onSubmit,
      onChanged: ontextChanged,
      cursorColor: AppValuesFilesLink().appValuesColors.editTextColor,
    );
  }

  String getTimeByMilliseconds(int timestamp, String formate) {
    String formattedTime = "";
    try {
      DateTime date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
      var format = new DateFormat(formate);
      formattedTime = format.format(date);
    } catch (e) {
      formattedTime = "";
      projectUtil.printP("CustomerUi", 'error in formatting $e');
    }
    return formattedTime;
  }

  /* Buttons */
  RaisedButton buttonRoundCornerWithBg(
      String label,
      Color labelColor,
      Color bgColor,
      double textSize,
      double borderRadius,
      Function(String) onPressed) {
    return RaisedButton(
      elevation: 0.0,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.semiBoldFont,
                  color: labelColor,
                  fontSize: textSize,
                  //fontWeight: FontWeight.w400
                ),
              ))
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onPressed: () => onPressed(label),
      color: bgColor,
    );
  }

  /*====================no data found===================*/
  Widget noDataFound(double height) {
    return Container(
      height: height,
      child: Center(
        child: Text("No Data Found"),
      ),
    );
  }

/*=====================toast==================*/
  showToast(String msg, bool isError, context) {
    return ToastCustom.show(
      msg,
      AppValuesFilesLink().appValuesColors.white,
      isError
          ? AppValuesFilesLink().appValuesColors.primaryColor
          : AppValuesFilesLink().appValuesColors.activeAmountColor,
      context,
      duration: ToastCustom.lengthLongC,
      gravity: ToastCustom.bottomC,
    );
  }

/*====================circular image view==============*/
  circularImageView(double height, double width, String image) {
    return Center(
        child: new Container(
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
            ),
            height: height,
            width: width,
            child: (image != null && image != '')
                ? (image.contains('http')
                    ? ((image.contains('png') ||
                            image.contains('jpg') ||
                            image.contains('jpeg'))
                        ? new CircleAvatar(
                            radius: height / 2,
                            backgroundImage: NetworkImage(image),
                            backgroundColor: Colors.transparent,
                          )
                        : new CircleAvatar(
                            radius: height / 2,
                            backgroundImage: AssetImage(
                                "assets/images/home/side_drawer/dummy_profile.png"),
                          ))
                    : image.contains('assets')
                        ? new CircleAvatar(
                            radius: height / 2,
                            backgroundImage: AssetImage(image),
                          )
                        : new CircleAvatar(
                            radius: height / 2,
                            backgroundImage: FileImage(File(image)),
                          ))
                : new CircleAvatar(
                    radius: height / 2,
                    backgroundImage: AssetImage(
                        "assets/images/home/side_drawer/dummy_profile.png"),
                  )));
  }

  circleTextView(double height, double width, double fontSize, int count,
      Color circleTextColor, Color circleBgColor) {
    return Center(
        child: new Container(
            decoration:
                new BoxDecoration(shape: BoxShape.circle, color: circleBgColor),
            height: height,
            width: width,
            child: Center(
              child: Text(count == 1 ? '1' : "+$count",
                  style: TextStyle(
                      fontFamily:
                          AppValuesFilesLink().appValuesFonts.defaultFont,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      color: circleTextColor)),
            )));
  }

  /*New Design like Vapp*/
  circularProfileImageView(double height, double width, String image) {
    return Center(
        child: new Container(
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
            ),
            height: height,
            width: width,
            child: image.contains('http')
                ? new CircleAvatar(
                    radius: height / 2,
                    backgroundImage: NetworkImage(image),
                    backgroundColor: Colors.transparent,
                  )
                : new CircleAvatar(
                    radius: height / 2,
                    backgroundImage: /*image.contains('http')?Image.network(image)*/ AssetImage(
                        image),
                  )));
  }

  Widget divider() {
    return Container(
      color: AppValuesFilesLink().appValuesColors.appTransColor[700],
      padding: EdgeInsets.only(
          top: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 22),
          bottom: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 13),
          left: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 0),
          right: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 0)),
      width: AppValuesFilesLink().appValuesDimens.widthDynamic(value: 120),
      child: Container(
        height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 4),
        decoration: BoxDecoration(
          color: AppValuesFilesLink().appValuesColors.appDividerColor[600],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }

   alertPopUp(context,success,msg,callback){
    return showDialog(
        context: context,
        builder: (context1) {
          mContext = context1;
          return AlertDialog(

            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this r
            content:GestureDetector(
              onTap:() => callback(context1),
              child:  Container(
                padding: const EdgeInsets.all(8.0),
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                    gradient: new LinearGradient(
                        colors: AppValuesFilesLink().appValuesColors.gredientColor,
                        begin: const FractionalOffset(0.2, 1.0),
                        end: const FractionalOffset(0.0, 0.75),
                        stops: [0.0, 0.9],
                        tileMode: TileMode.clamp)),
                child:ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 40),
                            bottom: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 0)),
                        child:Align(
                          alignment: Alignment.center,
                          child:  SvgPicture.asset(
                              success?"assets/images/home/payment_info/success_right.svg":"assets/images/home/payment_info/error.svg",
                              width: AppValuesFilesLink().appValuesDimens.widthDynamic(value: 87),
                              height:AppValuesFilesLink().appValuesDimens.widthDynamic(value: 87),fit: BoxFit.scaleDown),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 25),
                            left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 15),
                            right: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 15),
                            bottom: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 40)),
                        child:Align(
                            alignment: Alignment.center,
                            child: Text(
                              msg??"",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily:
                                  AppValuesFilesLink().appValuesFonts.defaultFont,
                                  color: AppValuesFilesLink().appValuesColors.textSubHeadingColor[100],
                                  fontSize: AppValuesFilesLink().appValuesDimens.fontSize(value: 20),
                                  fontWeight: FontWeight.w600),
                            )))
                  ],
                ),

              ),
            ),
            contentPadding: EdgeInsets.all(0.0),
          );
          // }
        });
  }
}
