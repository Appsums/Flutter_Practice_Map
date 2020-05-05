import 'dart:convert';

import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;



class InfoScreens extends StatefulWidget {
  final index;
  InfoScreens({Key key,  this.index}) : super(key: key);

  @override
  _InfoScreensState createState() => _InfoScreensState(index);
}

class _InfoScreensState extends State<InfoScreens> {
  var screenSize, screenHeight, screenWidth;
  var value;

  String title = '';

  String filePath = "" ;

  @override
  void initState() {
    super.initState();
  }


  _InfoScreensState(value) {
    this.value = value;

    switch (value) {
      case 1:{
//        title = AppValuesFilesLink().appValuesString.privacyPolicy;
        title = AppValuesFilesLink().appValuesString.privacyPolicy;
        filePath = 'assets/agreement/privacy_policy.html';
        break;
       }

        case 2:{
//          title = AppValuesFilesLink().appValuesString.userAgreement;
          title = AppValuesFilesLink().appValuesString.termsAndCondition;

          filePath = 'assets/agreement/terms_and_conditions.html';
          break;
        }
    }
  }

  WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
        child:SafeArea(
            bottom: false,
            child:Scaffold(
      appBar: BackArrowAppBar().appBarBackArrow(
        title,
        AppValuesFilesLink().appValuesColors.appBarTextColor[200],
        AppValuesFilesLink().appValuesColors.appBarLetIconColor[200],
        AppValuesFilesLink().appValuesColors.appBarBgColor[200],
        AppValuesFilesLink().appValuesDimens.widthDynamic(value: 22), () {
      Navigator.pop(context, true);
    }),
      backgroundColor: AppValuesFilesLink().appValuesColors.appBgColor,
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          _loadHtmlFromAssets();
        },
      ),
    )));
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString(filePath);
    _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
