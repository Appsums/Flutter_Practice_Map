import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/material.dart';

class SliderScreen2 extends StatefulWidget {
  final updateSelectedPageIndex;
  SliderScreen2({Key key, this.updateSelectedPageIndex}) : super(key: key);
  @override
  _SliderScreen2State createState() =>
      _SliderScreen2State(updateSelectedPageIndex);
}

class _SliderScreen2State extends State<SliderScreen2> {
  var updateSelectedPageIndex;

  _SliderScreen2State(updateSelectedPageIndex) {
    this.updateSelectedPageIndex = updateSelectedPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            left: AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 20),
            right: AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 20)),
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
                          AppValuesFilesLink().appValuesString.chargeCaps,
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
                              "assets/images/slider_screen/onboarding2@3x.png"),
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
                              AppValuesFilesLink().appValuesString.sliderScreen2Text,
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
