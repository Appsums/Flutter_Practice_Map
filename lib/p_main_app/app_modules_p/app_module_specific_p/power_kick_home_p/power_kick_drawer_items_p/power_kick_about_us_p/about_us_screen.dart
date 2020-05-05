import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import 'package:baseapp/p_main_app/app_utility_p/pre_default_app_utility_p/ProjectUtil.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get_version/get_version.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUsScreen> {
  String _appVersion = "";

  double iconsSize = 18;
  String copyRight = "&#169;";

  String time = AppValuesFilesLink().appValuesString.aboutUsTime,
      phone = AppValuesFilesLink().appValuesString.aboutUsPhone,
      email = AppValuesFilesLink().appValuesString.aboutUsEmail,
      copyright = AppValuesFilesLink().appValuesString.aboutUsCopyright;
  String termsAndCondition = AppValuesFilesLink().appValuesString.aboutUsTermsAndCondition;
  String userAgreement = AppValuesFilesLink().appValuesString.aboutUsUserAgreement;
  String privacyPolicyContent =AppValuesFilesLink().appValuesString.aboutUsUserAgreement;

  getVersionName() async {
    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } catch (e) {
      projectVersion = '';
      print('$e');
    }
    return projectVersion;
  }

  _AboutUsState() {
    getVersionName().then((value) {
      if (value != null) {
        setState(() {
          _appVersion =
              AppValuesFilesLink().appValuesString.version + " " + value;
          projectUtil.printP("About us",
              'projectVersionName=====================## $_appVersion');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    time = AppValuesFilesLink().appValuesString.aboutUsTime;
    phone = AppValuesFilesLink().appValuesString.aboutUsPhone;
    email = AppValuesFilesLink().appValuesString.aboutUsEmail;
    copyright = AppValuesFilesLink().appValuesString.aboutUsCopyright;
    String termsAndCondition = AppValuesFilesLink().appValuesString.aboutUsTermsAndCondition;
    String userAgreement = AppValuesFilesLink().appValuesString.aboutUsUserAgreement;
    String privacyPolicyContent = AppValuesFilesLink().appValuesString.aboutUsPrivacyPolicyContent;




    Widget _appLogoView = Container(
      margin: EdgeInsets.only(
        top: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 75),
      ),
      child: Image(
        image: AssetImage("assets/images/home/about_us/about_logo@3x.png"),
        height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 120),
        width: AppValuesFilesLink().appValuesDimens.widthDynamic(value: 120),
      ),
    );

    Widget _appVersionView = Container(
      margin: EdgeInsets.only(
        top: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            AppValuesFilesLink().appValuesString.powerKickCorporation,
            style: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                fontWeight: FontWeight.w700,
                fontSize:
                    AppValuesFilesLink().appValuesDimens.fontSize(value: 16.5),
                color:
                    AppValuesFilesLink().appValuesColors.textNormalColor[500]),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: AppValuesFilesLink()
                  .appValuesDimens
                  .verticalMarginPadding(value: 3),
            ),
            child: Text(
              _appVersion,
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w500,
                  fontSize:
                      AppValuesFilesLink().appValuesDimens.fontSize(value: 15),
                  color: AppValuesFilesLink()
                      .appValuesColors
                      .textNormalColor[500]),
            ),
          )
        ],
      ),
    );

    Widget _appDetailsView = Container(
        margin: EdgeInsets.only(
          top: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage(
                          "assets/images/home/about_us/watch_blue@3x.png"),
                      height: AppValuesFilesLink()
                          .appValuesDimens
                          .heightDynamic(value: iconsSize),
                      width: AppValuesFilesLink()
                          .appValuesDimens
                          .widthDynamic(value: iconsSize),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          left: AppValuesFilesLink()
                              .appValuesDimens
                              .horizontalMarginPadding(value: 8),
                        ),
                        child: Text(
                          time ?? '',
                          style: TextStyle(
                              fontFamily: AppValuesFilesLink()
                                  .appValuesFonts
                                  .defaultFont,
                              fontWeight: FontWeight.w500,
                              fontSize: AppValuesFilesLink()
                                  .appValuesDimens
                                  .fontSize(value: 15),
                              color: AppValuesFilesLink()
                                  .appValuesColors
                                  .textNormalColor[500]),
                        ))
                  ],
                ),
                GestureDetector(
                    onTap: () {

                      try {
                        String url="";
                        List phoneVar = phone.split(" ");
                        for(int i = 0; i<phoneVar.length ;i++){
                          url = url+phoneVar[i];
                        }
                         url = "tel:"+url;
                      projectUtil.launchCaller(url);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Padding(
                        padding: EdgeInsets.only(
                          top: AppValuesFilesLink()
                              .appValuesDimens
                              .verticalMarginPadding(value: 8),
                        ),
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage(
                                  "assets/images/home/about_us/phone_blue@3x.png"),
                              height: AppValuesFilesLink()
                                  .appValuesDimens
                                  .heightDynamic(value: iconsSize),
                              width: AppValuesFilesLink()
                                  .appValuesDimens
                                  .widthDynamic(value: iconsSize),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                  left: AppValuesFilesLink()
                                      .appValuesDimens
                                      .horizontalMarginPadding(value: 8),
                                ),
                                child: Text(
                                  phone ?? "",
                                  style: TextStyle(
                                      fontFamily: AppValuesFilesLink()
                                          .appValuesFonts
                                          .defaultFont,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppValuesFilesLink()
                                          .appValuesDimens
                                          .fontSize(value: 15),
                                      color: AppValuesFilesLink()
                                          .appValuesColors
                                          .textNormalColor[500]),
                                ))
                          ],
                        ))),
                GestureDetector(
                  onTap: () {
                    launch("mailto:" + email);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(
                        top: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 8),
                      ),
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage(
                                "assets/images/home/about_us/email@3x.png"),
                            height: AppValuesFilesLink()
                                .appValuesDimens
                                .heightDynamic(value: iconsSize),
                            width: AppValuesFilesLink()
                                .appValuesDimens
                                .widthDynamic(value: iconsSize),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                left: AppValuesFilesLink()
                                    .appValuesDimens
                                    .horizontalMarginPadding(value: 8),
                              ),
                              child: Text(
                                email ?? '',
                                style: TextStyle(
                                    fontFamily: AppValuesFilesLink()
                                        .appValuesFonts
                                        .defaultFont,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppValuesFilesLink()
                                        .appValuesDimens
                                        .fontSize(value: 15),
                                    color: AppValuesFilesLink()
                                        .appValuesColors
                                        .textNormalColor[500]),
                              ))
                        ],
                      )),
                )
              ],
            ),
          ],
        ));

    Widget _appPrivacyPloicyView = Padding(
        padding: EdgeInsets.only(
          top: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 10),
          bottom: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    // Fluttertoast.showToast(msg: "Terms and condition clicked");
                    Navigator.push(
                        context,
                        SlideRightRoute(
                            widget: InfoScreens(index: 2)));
                  },
                  child: Text(
                    termsAndCondition ?? '',
                    style: TextStyle(
                        fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                        fontWeight: FontWeight.w500,
                        fontSize:
                        AppValuesFilesLink().appValuesDimens.fontSize(value: 12),
                        color: AppValuesFilesLink()
                            .appValuesColors
                            .textNormalColor[100]),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 30),
                  width: AppValuesFilesLink().appValuesDimens.widthDynamic(value: 1),
                  margin: EdgeInsets.only(left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 5),right: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 5)),
                  child: Divider(
                     color:AppValuesFilesLink()
        .appValuesColors
        .appDividerColor[100] ,
                    height: 30,
                    thickness: 10,
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    // Fluttertoast.showToast(msg: "Terms and condition clicked");
                    Navigator.push(
                        context,
                        SlideRightRoute(
                            widget: InfoScreens(index: 1)));
                  },
                  child: Text(
                    userAgreement ?? '',
                    style: TextStyle(
                        fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                        fontWeight: FontWeight.w500,
                        fontSize:
                        AppValuesFilesLink().appValuesDimens.fontSize(value: 12),
                        color: AppValuesFilesLink()
                            .appValuesColors
                            .textNormalColor[100]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Text(
              privacyPolicyContent ?? '',
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w500,
                  fontSize:
                      AppValuesFilesLink().appValuesDimens.fontSize(value: 12),
                  color: AppValuesFilesLink()
                      .appValuesColors
                      .textNormalColor[100]),
              textAlign: TextAlign.center,
            ),
          /*  Text(
              copyright ?? '',
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w500,
                  fontSize:
                      AppValuesFilesLink().appValuesDimens.fontSize(value: 12),
                  color: AppValuesFilesLink()
                      .appValuesColors
                      .textNormalColor[100]),
              textAlign: TextAlign.center,
            ),*/
            Html(
              customTextAlign:  (node) {
                return TextAlign.center;
              },
              data: copyright??'',
              defaultTextStyle: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
        fontWeight: FontWeight.w500,
        fontSize:
        AppValuesFilesLink().appValuesDimens.fontSize(value: 12),
        color: AppValuesFilesLink()
            .appValuesColors
            .textNormalColor[100]),
    ),
          ],
        ));


    return Container(
      color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
      child:SafeArea(
          bottom: false,
          child: Scaffold(
        appBar:  BackArrowAppBar().appBarBackArrow(
            AppValuesFilesLink().appValuesString.aboutUs,
            AppValuesFilesLink().appValuesColors.appBarTextColor[200],
            AppValuesFilesLink().appValuesColors.appBarLetIconColor[200],
            AppValuesFilesLink().appValuesColors.appBarBgColor[200],
            AppValuesFilesLink().appValuesDimens.widthDynamic(value: 22), () {
          Navigator.pop(context, true);
        }),
        body: Container(
            color: AppValuesFilesLink().appValuesColors.appBgColor[100],
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _appLogoView,
                    _appVersionView,
                    _appDetailsView,
                  ],
                ),
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _appPrivacyPloicyView,
                  ),
                )
              ],
            )),
      )),
    );
  }
}
