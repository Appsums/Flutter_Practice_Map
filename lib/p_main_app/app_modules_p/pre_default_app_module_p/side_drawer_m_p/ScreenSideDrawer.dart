import 'package:baseapp/p_main_app/app_utility_p/pre_default_app_utility_p/ProjectUtil.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenSideDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final onUpdate;
  ScreenSideDrawer(this.scaffoldKey, this.onUpdate);
  @override
  _SideDrawer createState() => _SideDrawer(this.scaffoldKey, this.onUpdate);
}

class _SideDrawer extends State<ScreenSideDrawer> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  var onUpdate;
  var screenSize, screenHeight, screenWidth;

  var catItems, name = '';
  int productDataLength = 0;
  List<String> drawerList = new List();

  _SideDrawer(GlobalKey<ScaffoldState> mScaffoldKey, onUpdate) {
    this.onUpdate = onUpdate;
    _scaffoldKey = mScaffoldKey;
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    //simple list creation
    List<String> drawerItems() {
      drawerList.add("Account");
      drawerList.add("Security");
      drawerList.add("Help");
      drawerList.add("About Us");
      drawerList.add("Privecy Policy");
      drawerList.add("Sign Out");
      return drawerList;
    }

    if (drawerList.length == 0) {
      drawerItems();
    }
    /*=================drawerItemClick====================*/
    void drawerItemClick(int itemName) {
      switch (itemName) {
        //case "Rules":
        case 0:
          {
            projectUtil.printP("ScreenSideDrawer", "Account");
            /*Navigator.push(
                context, SlideRightRoute(widget: ScreenHistory()));*/
          }
          break;
        case 1:
          {
            projectUtil.printP("ScreenSideDrawer", "Security");
            // Navigator.push(context, SlideRightRoute(widget: ScreenSecurity()));
            if (_scaffoldKey.currentState.isDrawerOpen) {
              _scaffoldKey.currentState.openEndDrawer();
            }
          }
          break;
        case 2: //"Terms of service":
          {
            projectUtil.printP("ScreenSideDrawer", "Help");
          }
          break;

        case 3: //"FAQ":
          {
            projectUtil.printP("ScreenSideDrawer", "About DocCredit");
          }
          break;
        case 4: //"About Price Ninja":
          {
            projectUtil.printP("ScreenSideDrawer", "Privecy Policy");
            if (_scaffoldKey.currentState.isDrawerOpen) {
              _scaffoldKey.currentState.openEndDrawer();
            }
            /*Navigator.push(
            context, SlideRightRoute(widget: ScreenAboutNinja()));*/
          }
          break;

        case 5: //"Transaction History":
          {
            projectUtil.printP("ScreenSideDrawer", "Sign Out");
            if (_scaffoldKey.currentState.isDrawerOpen) {
              _scaffoldKey.currentState.openEndDrawer();
            }
            try {
              AppWidgetFilesLink().appCustomUiWidget.confimationDialog(
                  context, '', AppValuesFilesLink().appValuesString.logoutConfirmation, (mcontext) {
                SharedPreferencesFile().clearAll();
                Navigator.pop(mcontext, true);
                projectUtil.printP(
                    "ScreenSideDrawer", "pop up sure button clicked");
                //exit(0)
              });
            } catch (e) {
              projectUtil.printP("ScreenSideDrawer", e.toString());
            }
            /*Navigator.push(
                context, SlideRightRoute(widget: ScreenHistory()));*/
          }
          break;

        default:
          {
            projectUtil.printP("ScreenSideDrawer", "Invalid choice");
          }
          break;
      }
    }

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Drawer(
          child: Container(
            color: AppValuesFilesLink().appValuesColors.drawerBgColor,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.only(
                  left: screenWidth / 30, right: screenWidth / 30),
              children: <Widget>[
                Container(
                  height: screenSize.height,
                  decoration: BoxDecoration(
                    color: AppValuesFilesLink().appValuesColors.drawerBgColor,
                  ),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight / (105)),
                        child: Row(
                          children: <Widget>[
                            /*Align(
                              alignment: Alignment.topLeft,
//                              child: Image(image: AssetImage("assets/images/home_module_images/Close.png"),color: AppColors.white,height: 18,width: 18,),
                              child: IconButton(
                                icon: new ImageIcon(
                                    new AssetImage(
                                        "assets/images/drawer/setting.png"),
                                    color: AppValuesFilesLink().appValuesColors.drawerLetIconColor),
                                iconSize: 18,
                                onPressed: () => {
                                  if (_scaffoldKey
                                      .currentState.isDrawerOpen)
                                    {
                                      _scaffoldKey.currentState
                                          .openEndDrawer()
                                    }
                                },
                              ),
                            ),*/
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                //  child: IconButton(icon: AssetImage("assets/images/home_module_images/Setting.png"),color: AppColors.white,height: 20,width: 20,),
                                child: IconButton(
                                  icon: new ImageIcon(
                                      new AssetImage(
                                          "assets/images/drawer/setting.png"),
                                      color: AppValuesFilesLink()
                                          .appValuesColors
                                          .black),
                                  iconSize: 20,
                                  onPressed: () {
                                    /*Navigator.push(
                                            context,
                                            SlideRightRoute(
                                                widget: ScreenSetting())),*/
                                    if (_scaffoldKey
                                        .currentState.isDrawerOpen) {
                                      _scaffoldKey.currentState.openEndDrawer();
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_scaffoldKey.currentState.isDrawerOpen) {
                            _scaffoldKey.currentState.openEndDrawer();
                          }
                          // Navigator.push(context,SlideRightRoute(widget: ScreenUserProfile()),),
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage(
                                  "assets/images/drawer/profile_man.png"),
                              height: screenHeight / 8,
                              width: screenWidth / 3.5,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            if (_scaffoldKey.currentState.isDrawerOpen) {
                              _scaffoldKey.currentState.openEndDrawer();
                            }
                            //Navigator.push(context,SlideRightRoute(widget: ScreenUserProfile()),),
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: screenHeight / 90),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Hi, $name",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 22,
                                  color: AppValuesFilesLink()
                                      .appValuesColors
                                      .drawerTextColor,
                                  fontFamily: AppValuesFilesLink()
                                      .appValuesFonts
                                      .mainFont,
                                ),
                              ),
                            ),
                          )),
                      Container(
                        height: 1.2,
                        color: AppValuesFilesLink()
                            .appValuesColors
                            .drawerTextColor,
                        margin: const EdgeInsets.only(top: 15),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Container(
                          height: screenHeight / 2,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: drawerList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(top: screenHeight / 40),
                                child: GestureDetector(
                                  onTap: () {
                                    drawerItemClick(index);
                                  },
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          drawerList[index],
                                          style: AppValuesFilesLink()
                                              .appValuesStyle
                                              .drawerItems(),
                                        ),
                                        /*Expanded(
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/home_module_images/Arrow(right).png"),
                                              height: 18,
                                              width: 18,
                                              color: AppValuesFilesLink().appValuesColors.drawerLetIconColor,
                                            )
                                          */ /*Icon(Icons.arrow_forward_ios,color: AppColors.white),*/ /*
                                        ),
                                      )*/
                                      ],
                                    ),
                                    color: Colors.transparent,
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
