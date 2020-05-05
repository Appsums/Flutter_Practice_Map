import 'dart:ui';

import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/material.dart';

class SliderScreen1 extends StatefulWidget {
  final updateSelectedPageIndex;
  SliderScreen1({Key key, this.updateSelectedPageIndex}) : super(key: key);

  @override
  _SliderScreen1State createState() =>
      _SliderScreen1State(this.updateSelectedPageIndex);
}

class _SliderScreen1State extends State<SliderScreen1> {
  String mName = "Hello ";
  var updateSelectedPageIndex;

  _SliderScreen1State(updateSelectedPageIndex) {
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
        //color: Colors.green,
        padding: EdgeInsets.only(
            left: AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 21),
            right: AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 21)),
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
                          AppValuesFilesLink().appValuesString.scanCaps,
                          style: TextStyle(
                              fontFamily: AppValuesFilesLink()
                                  .appValuesFonts
                                  .defaultFont,
                              fontWeight: FontWeight.w600,
                              fontSize: AppValuesFilesLink()
                                  .appValuesDimens
                                  .fontSize(value: 24),
                              fontStyle: FontStyle.italic,
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
                              "assets/images/slider_screen/onboarding3@3x.png"),
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
                              AppValuesFilesLink().appValuesString.sliderScreen1Text,
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
              //  padding: EdgeInsets.only(bottom: 30),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                    onTap: () {
                      updateSelectedPageIndex();
                    },
                    child: Image(
                      image: AssetImage(
                          "assets/images/slider_screen/arrow@3x.png"),
                      height: AppValuesFilesLink()
                          .appValuesDimens
                          .heightDynamic(value: 135),
                      width: AppValuesFilesLink()
                          .appValuesDimens
                          .widthDynamic(value: 135),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
