import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'p_main_app/api_calling_p/LocalConstant.dart';
import 'p_main_app/api_calling_p/pre_default_app_module_p/api_constant.dart';
import 'p_main_app/app_utility_p/multilingual/app_localizations.dart';
import 'p_main_app/app_utility_p/pre_default_app_utility_p/ProjectUtil.dart';
import 'p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'p_main_app/z_main_files_p/AppUtilsFilesLink.dart';

void main() async {
  // if you are using await in main function then add this line
  WidgetsFlutterBinding.ensureInitialized();

  // Restrict for portrait mode only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.changeLanguage(newLocale);

  }


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isCheckedLang = false;
  Locale _locale = Locale('en', 'US');

  _MyAppState(){
    getLanguage();
  }

  var supportedLocales1 = [
    Locale('en', 'US'),
    Locale('ko', 'KR'),
  ];

  changeLanguage(Locale locale)  {
    setState(() {
      _locale = locale;
      String languageCode = locale.languageCode;
      String countryCode = locale.countryCode;
      var localDetails = {"languageCode":languageCode,"countryCode": countryCode};

      String localDetailsStr = jsonEncode(localDetails);
      SharedPreferencesFile().saveStr(languageCodeC, localDetailsStr);
    });
  }

  getLanguage() async {

    SharedPreferencesFile().readBool(isNotFirstTime).then((value){
      if(value!=null && value==false){
        setState((){
            _locale =  ui.window.locale;
          changeLanguage(_locale);
          SharedPreferencesFile().saveBool(isNotFirstTime, true);

          if(_locale.languageCode!=null &&  _locale.languageCode == "ko"){
            SharedPreferencesFile().saveStr(selectedLanguageC,selectedLanguageKoreanC);
          }else if(_locale.languageCode!=null &&  _locale.languageCode == "en"){
            SharedPreferencesFile().saveStr(selectedLanguageC,selectedLanguageEnglishC);
          }
        });
      }else{
        String languageCode,countryCode;
        SharedPreferencesFile().readStr(languageCodeC).then((value){
          if(value!=null && value!=''){
            setState((){
              Map localDetails =  json.decode(value);
              languageCode = localDetails["languageCode"];
              countryCode = localDetails["countryCode"];
              if (languageCode != null && languageCode != '' && countryCode != null && countryCode != '') {
                setState(() {
                  _locale = Locale(languageCode, countryCode);
                });
              }
              else{
                setState(() {
                  _locale = Locale("en", "US");
                });
              }
            });
          }
        });
        //projectUtil.printP("main","language code2: $languageCode $countryCode");
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    if (Platform.isAndroid) {
      try {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark)); //top bar icons));
      } catch (e) {
        print(e);
      }
    }
    else{
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark) // Or Brightness.dark
      );
    }

    return  MaterialApp(
      title: 'Power Kick',
      // List all of the app's supported locales here
      supportedLocales: supportedLocales1,
      locale:_locale ,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primaryColor: Colors.red,
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),


      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],

      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales1) {
          try {
            if (supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
                        return supportedLocale;
                      }
          } catch (e) {
            projectUtil.printP("main",e.toString());
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      home: FutureBuilder(
        future: SharedPreferencesFile()
            .readBool(isUSerLoggedInC),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
           // projectUtil.printP("main", "language code1:  ");
            var value = snapshot.data;
            return value ? HomeScreen() : SliderScreens();
            //return SliderScreens(index: 0)();
          }
            else{
            return Container(color:Colors.white);
          }
         // return Container(color:Colors.white); // noop, this builder is called again when the future completes
        },
      ),
      routes: ScreensRoutes().routes(),
    );
  }
}



