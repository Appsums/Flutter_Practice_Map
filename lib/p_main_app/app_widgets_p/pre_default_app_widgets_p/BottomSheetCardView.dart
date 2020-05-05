import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/material.dart';

int showHideTemp = 0;
var cardBodyViewTemp1;
var showHide;
var cardBodyView;
var sheetDismis;

class BottomSheetCardView extends StatefulWidget {
  BottomSheetCardView({Key key, showHide, cardBodyView, sheetDismis}) {
    showHideTemp = showHide;
    cardBodyViewTemp1 = cardBodyView;
    sheetDismis = sheetDismis;
    //controller.reverse();
  }

  @override
  _BottomSheetCardViewState createState() => _BottomSheetCardViewState(
      showHide: showHide,
      cardBodyViewTemp: cardBodyView,
      sheetDismis: sheetDismis);
}

class _BottomSheetCardViewState extends State<BottomSheetCardView>
    with SingleTickerProviderStateMixin {
  static AnimationController controller;
  Animation<Offset> offset;
  int showHide = 0;
  var cardBodyViewTemp;
  var sheetDismis;
  /* @override
  void didUpdateWidget(BottomSheetCardView oldWidget) {
    // TODO: implement didUpdateWidget
    if (mounted) {
      try {
        AppWidgetFilesLink().appCustomUiWidget.hideKeyboard(context);
      } catch (e) {
        ProjectUtil.printP("Bootmsheet", e.toString());
      }
    }
    super.didUpdateWidget(oldWidget);
  }*/

  @override
  void dispose() {
    // _menuController.dispose();
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  _BottomSheetCardViewState(
      {Key key, this.showHide, this.cardBodyViewTemp, this.sheetDismis}) {
    //setState(() {
    showHideTemp = showHide;
    cardBodyViewTemp1 = cardBodyViewTemp;
    sheetDismis = sheetDismis;
    //controller.reverse();
    //});
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    if (showHideTemp == 1) {
      controller.forward();
      setState(() {
        // cardBodyViewTemp = cardBodyViewTemp1;
        //controller.reverse();
      });
    } else {
      controller.reverse();
    }
    //Semi transparent view
    Widget _semiTransPopUpBg() => Container(
          child: Material(
            color: AppValuesFilesLink().appValuesColors.appTransColor[600],
            child: InkWell(
              onTap: () => setState(() {
                showHideTemp = 0;
                sheetDismis();
              }), // handle your onTap here
              child: Container(
                  height:
                      AppValuesFilesLink().appValuesDimens.heightFullScreen(),
                  width:
                      AppValuesFilesLink().appValuesDimens.widthFullScreen()),
            ),
          ),
        );

    Future<bool> onBackPress() {
      showHideTemp = 0;
      sheetDismis();
      return Future.value(false);
    }

    return SafeArea(
      child: WillPopScope(
        child: Stack(
          children: <Widget>[
            Container(
              child: showHideTemp == 1 ? _semiTransPopUpBg() : Container(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: offset,
                child: Padding(
                  padding: EdgeInsets.only(left: 0, right: 0, top: 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0)),
                    ),
                    elevation: 0.0,
                    margin: EdgeInsets.only(left: 0, right: 0, top: 0),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: AppValuesFilesLink()
                                  .appValuesDimens
                                  .horizontalMarginPadding(value: 8),
                              right: AppValuesFilesLink()
                                  .appValuesDimens
                                  .horizontalMarginPadding(value: 8),
                              top: 0,
                              bottom: 0),
                          //height: screenHeight/1.8,
                          child: Stack(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: GestureDetector(
                                      onTap: () => setState(() {
                                        showHideTemp = 0;
                                        sheetDismis();
                                      }),
                                      child: AppWidgetFilesLink()
                                          .appCustomUiWidget
                                          .divider(),
                                    ),
                                  ),
                                  cardBodyViewTemp1 == null
                                      ? Container()
                                      : cardBodyViewTemp1
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    //  isLoading?ProgressBar().showLoaderOnUi(true, AppValuesFilesLink().appValuesColors.loaderBgColor):Container(),
                  ),
                ),
              ),
            )
          ],
        ),
        onWillPop: onBackPress,
      ),
    );
  }

/*  static void showHideView(showHide){
    if(showHide==1){
      controller.forward();
    }
    else{
      controller.reverse();
    }

  }*/

}
