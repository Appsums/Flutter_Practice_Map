import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Color mColorT;
bool isBgT;
double heightT = 60;
double widthT = 60;
int loaderTypeT = 0;

class WorkSpace extends StatelessWidget {
  WorkSpace({Key key, bool isBg, Color mcolor, double height, double widht}) {
    isBgT = isBg;
    mColorT = mcolor;
    if (height != null && height > 0) {
      heightT = height;
    }
    if (widht != null && widht > 0) {
      widthT = widht;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loaderTypeT == 1
        ? Container(
            alignment: Alignment(0, 0),
            child: Container(
              height: heightT,
              width: widthT,
              decoration: new BoxDecoration(
                color: isBgT
                    ? (mColorT != null
                        ? mColorT
                        : AppValuesFilesLink().appValuesColors.loaderBgColor)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: SpinKitFadingCircle(
                  color: mColorT != null
                      ? mColorT
                      : AppValuesFilesLink().appValuesColors.loaderColor[100]),
            ))
        :
        //Normal Loader
        Container(
            alignment: Alignment(0, 0),
            child: Container(
              height: heightT,
              width: widthT,
              decoration: new BoxDecoration(
                color: isBgT
                    ? (mColorT != null
                        ? mColorT
                        : AppValuesFilesLink().appValuesColors.loaderBgColor)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        AppValuesFilesLink().appValuesColors.loaderColor[300])),
              ),
            ));
  }
}
