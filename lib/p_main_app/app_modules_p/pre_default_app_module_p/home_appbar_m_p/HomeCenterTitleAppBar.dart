import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
class HomeCenterTitleAppBar {
  //App bar
   appBarHomeCenterTitleIco(
      String appBarTitle,Color appBarTitleColor,
      Color appBarBgColor,
      var screenSize,
      List<Widget> appBarWidgets,mElevation,bool automaticallyImplyLeading) {
    return AppBar(
      backgroundColor: appBarBgColor,
      elevation: mElevation,
      centerTitle: true,
      //For card view
      flexibleSpace: Container(
        // Add box decoration
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.6, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Color(0xFFFFF),
              Color(0xFFFFF),
              Color(0xFFFFF),
            ],
          ),
        ),
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      //`true` if you want Flutter to automatically add Back Button when needed,
      //or `false` if you want to force your own back button every where
      title: new Text(appBarTitle!=null?appBarTitle:"", style: new TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
          color: appBarTitleColor,
          fontSize: 19
      ),textAlign: TextAlign.center,),

      actions: appBarWidgets,
    );
  }




}

