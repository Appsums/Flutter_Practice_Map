import 'dart:ui';
import 'package:flutter/material.dart';
import '../../z_main_files_p/AppValuesFilesLink.dart';

class AppStyle {

  //headline text style
  normalHeadlineText()=> TextStyle(
  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
  fontWeight: FontWeight.w300,
  fontSize: 20,
  color: AppValuesFilesLink().appValuesColors.white,
  );

  //headline text style
  heading ()=> TextStyle(
  fontFamily: AppValuesFilesLink().appValuesFonts.mainFont,
  fontWeight: FontWeight.w300,
  fontSize: 25,
  color: AppValuesFilesLink().appValuesColors.white,
  );


  //headline text style
  nextTextStyle()=> TextStyle(
  fontFamily: AppValuesFilesLink().appValuesFonts.mainFont,
  fontSize: 25,
  fontWeight: FontWeight.w300,
  color: AppValuesFilesLink().appValuesColors.white,
  );


  //normal text field style
  normalTextField ()=> TextStyle(
  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
  fontWeight: FontWeight.w600,
  fontSize: 15.0,
  color: AppValuesFilesLink().appValuesColors.lightBlack,
  );

  //button text style
  buttonText ()=> TextStyle(
  fontFamily: AppValuesFilesLink().appValuesFonts.mainFont,
  fontWeight: FontWeight.w300,
  fontSize: 20.0,
  color: AppValuesFilesLink().appValuesColors.white,
  );

  //disable text field style
  disableTextField ()=> TextStyle(
  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
  fontWeight: FontWeight.w300,
  fontSize: 18.0,
  color: AppValuesFilesLink().appValuesColors.whiteUnSelected,
  );

  //error msg
  errorMsgStyle ()=> TextStyle(
  fontFamily: AppValuesFilesLink().appValuesFonts.mainFont,
  color: AppValuesFilesLink().appValuesColors.yellow,
  fontWeight: FontWeight.w500,
  fontSize: 12.0);

  //drawer items style
  drawerItems ()=> TextStyle(fontFamily: AppValuesFilesLink().appValuesFonts.mainFont,color: AppValuesFilesLink().appValuesColors.drawerTextColor,fontSize: 19,fontWeight: FontWeight.w300);


  //card heading style
  cardheadingStyle()=> TextStyle(
      fontFamily: AppValuesFilesLink()
          .appValuesFonts
          .defaultFont,
      fontSize: AppValuesFilesLink().appValuesDimens.fontSize(value: 6.5),
//                             fontWeight: FontWeight.w400,
      color: AppValuesFilesLink()
          .appValuesColors
          .textHeadingColor
  );

}