import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackArrowWithRightIcon {
//App bar
  AppBar appBarBackArrowWithRightTittle(
      String appBarTitle,
      Color appBarTitleColor,
      Color appBarBackIconColor,
      List<Widget> appBarRightIcons,
      Color appBarBgColor,
      var screenSize,
      Function() onPressed) {
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
        centerTitle: true,
        title: new Text(appBarTitle,
            style: new TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: AppValuesFilesLink().appValuesFonts.mainFont,
              color: appBarTitleColor,
              fontSize: 19.5,
            ),
            textAlign: TextAlign.center),
        // leading: IconButton(icon:new Icon(Icons.arrow_back, size: screenSize.height / 20,color: AppValuesFilesLink().appValuesColors.lightBlack,),
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: IconButton(
            icon: new ImageIcon(
              new AssetImage("assets/images/back_arrow_appbar/back_arrow@3x.png"),
              color: appBarBackIconColor,
              size: screenSize,
            ),
            onPressed: () => onPressed(),
          ),
        ),
        actions: appBarRightIcons
        );
  }
}
