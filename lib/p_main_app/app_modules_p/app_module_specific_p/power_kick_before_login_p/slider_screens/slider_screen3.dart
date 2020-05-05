import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/material.dart';

class SliderScreen3 extends StatefulWidget {
  final updateSelectedPageIndex;
  SliderScreen3({Key key, this.updateSelectedPageIndex}) : super(key: key);

  @override
  _SliderScreen3State createState() =>
      _SliderScreen3State(updateSelectedPageIndex);
}

class _SliderScreen3State extends State<SliderScreen3> {
  var updateSelectedPageIndex;

  _SliderScreen3State(updateSelectedPageIndex) {
    this.updateSelectedPageIndex = updateSelectedPageIndex;
  }
  @override
  void initState() {
    AppValuesFilesLink(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: Colors.yellow,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                            AppValuesFilesLink().appValuesString.returnCaps,
                          style: TextStyle(
                              fontFamily: AppValuesFilesLink()
                                  .appValuesFonts
                                  .defaultFont,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              fontSize: AppValuesFilesLink()
                                  .appValuesDimens
                                  .fontSize(value: 24),
                              color: AppValuesFilesLink()
                                  .appValuesColors
                                  .textNormalColor),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 15),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage(
                              "assets/images/slider_screen/onboarding1@3x.png"),
                          height: AppValuesFilesLink()
                              .appValuesDimens
                              .heightDynamic(value: 150),
                          width: AppValuesFilesLink()
                              .appValuesDimens
                              .widthDynamic(value: 150),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 40),
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                              AppValuesFilesLink().appValuesString.sliderScreen3Text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppValuesFilesLink()
                                    .appValuesFonts
                                    .defaultFont,
                                fontWeight: FontWeight.w400,
                                fontSize: AppValuesFilesLink()
                                    .appValuesDimens
                                    .fontSize(value: 18),
                                color: AppValuesFilesLink()
                                    .appValuesColors
                                    .textNormalColor,
                              ))),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 60),
                      height: AppValuesFilesLink()
                          .appValuesDimens
                          .heightDynamic(value: 45),
                      width: AppValuesFilesLink()
                          .appValuesDimens
                          .widthDynamic(value: 120),
                      child: AppWidgetFilesLink()
                          .appCustomUiWidget
                          .buttonRoundCornerWithFontWeightBg(
                              "Let's start",
                              AppValuesFilesLink().appValuesColors.white,
                              AppValuesFilesLink()
                                  .appValuesColors
                                  .buttonBgColor[100],
                              14.0,
                              AppValuesFilesLink()
                                  .appValuesDimens
                                  .heightDynamic(value: 23), (value) {
                        updateSelectedPageIndex();
                        /*Navigator.push(
                            context,
                            SlideRightRoute(
                                widget:
                                    LoginWithMobile()));*/
                      }),
                    ))),
          ],
        ),
      ),
    );
  }
}
