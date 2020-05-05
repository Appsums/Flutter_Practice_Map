import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RightTitleAppBar {
//App bar
  AppBar rightTitleAppBar(List<Widget> appBarRightIcons, Color appBarBgColor) {
    return AppBar(
        backgroundColor: appBarBgColor,
        elevation: 0.0,
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
        automaticallyImplyLeading: true,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        // leading: IconButton(icon:new Icon(Icons.arrow_back, size: screenSize.height / 20,color: AppValuesFilesLink().appValuesColors.lightBlack,),
        actions: appBarRightIcons);
  }
}
