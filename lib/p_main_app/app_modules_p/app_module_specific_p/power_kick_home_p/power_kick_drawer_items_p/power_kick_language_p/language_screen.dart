import 'package:baseapp/main.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/api_constant.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../z_main_files_p/AppScreensFilesLink.dart';
import '../../../../../z_main_files_p/AppValuesFilesLink.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool isEnglishSelected = true;
  bool isKoreanSelected = false;

  String activeImage = "assets/images/home/laguage/radio_active@3x.png";
  String disableImage = "assets/images/home/laguage/radio@3x.png";

  Color activeColor = AppValuesFilesLink().appValuesColors.primaryColor;
  Color disableColor = AppValuesFilesLink().appValuesColors.white;

  _LanguageScreenState(){
    getLanguage();
  }

  getLanguage() {
    SharedPreferencesFile().readStr(selectedLanguageC).then((value){
      if(value!=null && value!=''){
        if(value == selectedLanguageEnglishC ){
          setState((){
            isEnglishSelected = true;
            isKoreanSelected = false;
          });
    }else if(value == selectedLanguageKoreanC ){
          setState((){
            isKoreanSelected = true;
            isEnglishSelected = false;
          });
    }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
        child:SafeArea(
            bottom: false,
            child:Scaffold(
        appBar: BackArrowAppBar().appBarBackArrow(
            AppValuesFilesLink(context: context).appValuesString.language,
            AppValuesFilesLink().appValuesColors.appBarTextColor[200],
            AppValuesFilesLink().appValuesColors.appBarLetIconColor[200],
            AppValuesFilesLink().appValuesColors.appBarBgColor[200],
            AppValuesFilesLink().appValuesDimens.widthDynamic(value: 22), () {
          Navigator.pop(context, true);
        }),
        body: Container(
          margin: EdgeInsets.only(
              top: AppValuesFilesLink()
                  .appValuesDimens
                  .verticalMarginPadding(value: 20)),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEnglishSelected = true;
                    isKoreanSelected = false;
                    Locale newLocale = Locale('en', 'US');
                    MyApp.setLocale(context, newLocale);
                    SharedPreferencesFile().saveStr(selectedLanguageC,selectedLanguageEnglishC);
                    Fluttertoast.showToast(msg: AppValuesFilesLink().appValuesString.languageChanged);

                  });
                },
                child: Card(
                  color: isEnglishSelected?activeColor:disableColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color:activeColor,
                          width: AppValuesFilesLink()
                              .appValuesDimens
                              .widthDynamic(value: 1.5))),
                  elevation: 0.5,
                  margin: EdgeInsets.only(
                      left: AppValuesFilesLink()
                          .appValuesDimens
                          .horizontalMarginPadding(value: 25),
                      right: AppValuesFilesLink()
                          .appValuesDimens
                          .horizontalMarginPadding(value: 25),
                      top: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 2)),
                  child: Container(

                    padding: EdgeInsets.fromLTRB(
                        AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 20),
                        AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 25),
                        AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 20),
                        AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                              isEnglishSelected ? activeImage : disableImage),
                          height: AppValuesFilesLink()
                              .appValuesDimens
                              .heightDynamic(value: 20),
                          width: AppValuesFilesLink()
                              .appValuesDimens
                              .widthDynamic(value: 20),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: AppValuesFilesLink()
                                  .appValuesDimens
                                  .horizontalMarginPadding(value: 20)),
                          child: Text(
                            AppValuesFilesLink(context: context).appValuesString.langEnglish,
                            style: TextStyle(
                                fontFamily: AppValuesFilesLink()
                                    .appValuesFonts
                                    .defaultFont,
                                fontWeight: FontWeight.w500,
                                fontSize: AppValuesFilesLink()
                                    .appValuesDimens
                                    .fontSize(value: 16),
                                color:isEnglishSelected?disableColor:activeColor,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 8)),
              child:   GestureDetector(
                onTap: () {
                  setState(() {
                    isEnglishSelected = false;
                    isKoreanSelected = true;
                    Locale newLocale = Locale('ko', 'KR');
                    MyApp.setLocale(context, newLocale);
                    SharedPreferencesFile().saveStr(selectedLanguageC,selectedLanguageKoreanC);
                    Fluttertoast.showToast(msg: AppValuesFilesLink().appValuesString.languageChanged);
                  });
                },
                child: Card(
                  color: isKoreanSelected?activeColor:disableColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color:activeColor,
                          width: AppValuesFilesLink()
                              .appValuesDimens
                              .widthDynamic(value: 1.5))),
                  elevation: 0.5,
                  margin: EdgeInsets.only(
                      left: AppValuesFilesLink()
                          .appValuesDimens
                          .horizontalMarginPadding(value: 25),
                      right: AppValuesFilesLink()
                          .appValuesDimens
                          .horizontalMarginPadding(value: 25),
                      top: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 2)),
                  child: Container(

                    padding: EdgeInsets.fromLTRB(
                      AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 20),
                      AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 25),
                      AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 20),
                      AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                              isKoreanSelected ? activeImage : disableImage),
                          height: AppValuesFilesLink()
                              .appValuesDimens
                              .heightDynamic(value: 20),
                          width: AppValuesFilesLink()
                              .appValuesDimens
                              .widthDynamic(value: 20),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: AppValuesFilesLink()
                                  .appValuesDimens
                                  .horizontalMarginPadding(value: 20)),
                          child: Text(
                            AppValuesFilesLink().appValuesString.langKorean,
                            style: TextStyle(
                              fontFamily: AppValuesFilesLink()
                                  .appValuesFonts
                                  .defaultFont,
                              fontWeight: FontWeight.w500,
                              fontSize: AppValuesFilesLink()
                                  .appValuesDimens
                                  .fontSize(value: 16),
                              color:isKoreanSelected?disableColor:activeColor,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
            ],
          ),
        ))));
  }
}
