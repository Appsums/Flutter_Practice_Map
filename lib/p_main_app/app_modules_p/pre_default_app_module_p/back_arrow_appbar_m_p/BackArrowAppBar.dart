import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackArrowAppBar {
  //App bar
  AppBar appBarBackArrow(
      String appBarTitle,
      Color appBarTitleColor,
      Color appBarBackIconColor,
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
            fontWeight: FontWeight.w600,
            fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
            color: appBarTitleColor,
            fontSize: AppValuesFilesLink().appValuesDimens.fontSize(value: 20),
          ),
          textAlign: TextAlign.center),
      /*  leading: Padding(
              padding: EdgeInsets.only(left: 10),
             child:IconButton(icon:new Icon(Icons.arrow_back_ios, size: 22,color: appBarBackIconColor,),*/
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
      actions: <Widget>[
      ],
    );
  }

//App bar
  Widget appBarWithBackArrow(
      {Key key,
      double statusbarHeight,
      @required String title,
      Color titleColor,
      double titleFontSize,
      @required String profileUrl,
      double profileSize,
      String rightIcon,
      String notificationCount,
      double rightIconSize,
      double leftIconSize,
      double marginLeft,
      double marginRight,
      Color appBarBgColor,
      Color appBarBackIconColor,
      Function() onPressed,
      Function() onNotificationPressed}) {
    return PreferredSize(
        preferredSize: Size(
            AppValuesFilesLink().appValuesDimens.widthFullScreen(),
            AppValuesFilesLink().appValuesDimens.heightDynamic(
                  value: 77 - statusbarHeight,
                )),
        child: Container(
          // color:Colors.red,
          padding: EdgeInsets.only(
            top: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(
                  value: 50 - statusbarHeight,
                ),
          ),
          //color: appBarBgColor,
          child: Stack(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Left icon
              Align(
                child: GestureDetector(
                  child: Container(
                    color:
                        AppValuesFilesLink().appValuesColors.appTransColor[700],
                    height: AppValuesFilesLink().appValuesDimens.heightDynamic(
                          value: 35,
                        ),
                    // color: Colors.red,
                    padding: EdgeInsets.only(
                        left: marginLeft ??
                            AppValuesFilesLink()
                                .appValuesDimens
                                .horizontalMarginPadding(
                                  value: 20,
                                ),
                        right: marginLeft ??
                            AppValuesFilesLink()
                                .appValuesDimens
                                .horizontalMarginPadding(
                                  value: 20,
                                )),
                    child: Image(
                      image: AssetImage(
                          "assets/images/back_arrow_appbar/Back1.png"),
                      color: appBarBackIconColor ??
                          AppValuesFilesLink()
                              .appValuesColors
                              .appBarLetIconColor[200],
                      width: leftIconSize ??
                          AppValuesFilesLink()
                              .appValuesDimens
                              .imageSquareAccordingScreen(value: 20),
                      height: leftIconSize ??
                          AppValuesFilesLink()
                              .appValuesDimens
                              .imageSquareAccordingScreen(value: 20),
                    ),
                  ),
                  onTap: () => onPressed(),
                ),
                alignment: Alignment.centerLeft,
              ),

              Align(
                child: Container(
                  width: AppValuesFilesLink().appValuesDimens.widthFullScreen(),
                  //margin: EdgeInsets.only(left: 70),
                  child: Center(
                      child: Text(title != null ? title : "",
                          style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily:
                                AppValuesFilesLink().appValuesFonts.defaultFont,
                            color: titleColor,
                            fontSize: titleFontSize != null
                                ? titleFontSize
                                : AppValuesFilesLink()
                                    .appValuesDimens
                                    .fontSize(value: 5),
                          ))),
                  alignment: Alignment.center,
                ),
              )
            ],
          ),
        ));
  }
}
