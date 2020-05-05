import 'package:flutter/material.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
// Screens
const screenSplashScreen = 'SplashScreen Page';
const homeScreen = 'HomeScreen Page';

class ScreensRoutes {
  routes () {
  return <String, WidgetBuilder>{
       homeScreen: (context) => HomeScreen(),
      };
  }
}