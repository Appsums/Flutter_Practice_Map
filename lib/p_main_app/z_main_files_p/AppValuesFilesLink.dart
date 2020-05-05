import 'package:baseapp/p_main_app/app_values_p/pre_default_app_values_p/AppColor.dart';
import 'package:baseapp/p_main_app/app_values_p/pre_default_app_values_p/AppDimens.dart';
import 'package:baseapp/p_main_app/app_values_p/pre_default_app_values_p/AppDimens1.dart';
import 'package:baseapp/p_main_app/app_values_p/pre_default_app_values_p/AppFonts.dart';
import 'package:baseapp/p_main_app/app_values_p/pre_default_app_values_p/AppInputConst.dart';
import 'package:baseapp/p_main_app/app_values_p/pre_default_app_values_p/AppString.dart';
import 'package:baseapp/p_main_app/app_values_p/pre_default_app_values_p/AppStyle.dart';
import 'package:flutter/material.dart';

class AppValuesFilesLink {
  static BuildContext context1;
  AppValuesFilesLink({BuildContext context}){
    if(context!=null){
      context1 = context;
    }
  }
  // Application main default files
  AppString appValuesString = new AppString(context1);
  AppColors appValuesColors = new AppColors();
  AppDimens appValuesDimens = new AppDimens();
  AppDimens1 appValuesDimens1 = new AppDimens1();
  AppStyle appValuesStyle = new AppStyle();
  AppFonts appValuesFonts = new AppFonts();
  AppInputConst appValuesConst = new AppInputConst();

  //Application specific module file
}
