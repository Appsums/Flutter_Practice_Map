import 'dart:io';
import 'dart:ui';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/progress_bar_p/ProgressBar.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/payment_info_p/bean/AddedCardInfoBean.dart';
import 'package:baseapp/p_main_app/app_widgets_p/pre_default_app_widgets_p/CustomUiWidget.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class PaymentInfo extends StatefulWidget {
  @override
  _PaymentInfoState createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  String barcode = "";
  String barcodeForImage = "Hello";

  List<Result> cardList=List();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  GlobalKey globalKey = new GlobalKey();
  bool cardAdded = false;

  bool isDataReady = false;
  _PaymentInfoState(){
    cardList =  List();
   /* cardList.add(new Result(sn: "1234567812345678"));
    isDataReady = true;
    cardAdded = true;*/
    getCardInfo();

  }


  /*Pul To refresh*/
  void _onRefresh() async {
    // monitor network fetch
    // if failed,use refreshFailed()
   /* getcardList().then((value){
      _refreshController.refreshCompleted();
    });*/
    cardList =  List();
    getCardInfo();
    _refreshController.refreshCompleted();

  }

  void _onLoading() async {
    if (mounted) setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    AppValuesFilesLink().appValuesDimens.appDimensFind(context:context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));

    //Pull to refresh
    Widget centerItemsViewPull =
    (cardList!=null&&cardList.length>0)?SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: null,
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,

      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: cardList!=null?cardList.length:0,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctxt, int index) {

                Result mResult = cardList[index];

                return
                  (mResult!=null && mResult.sn!=null && mResult.sn.trim().length>0)?
                  Align(
                    alignment: Alignment.topCenter,
                    child:
                    Container(
                      margin: EdgeInsets.only(
                        bottom: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 25),
                        left: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 20),
                        right: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 20),
                      ),
                      child: PaymentCard(cardNumber:"${mResult.sn.trim()}",height: (AppValuesFilesLink()
                          .appValuesDimens
                          .widthFullScreen()/1.8),width: (AppValuesFilesLink()
                          .appValuesDimens
                          .widthFullScreen()),borderRadius:10),
                    ),
                  ):Container();
              }),
        ],
      ),
    ):Container();

    return Container(
        color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
        child:SafeArea(
            bottom:false,
            child:Scaffold(
        appBar:  BackArrowWithRightIcon().appBarBackArrowWithRightTittle(
            AppValuesFilesLink().appValuesString.paymentInfo,
            AppValuesFilesLink().appValuesColors.appBarTextColor[200],
            AppValuesFilesLink().appValuesColors.appBarLetIconColor[200],
            cardAdded?null:null,
            AppValuesFilesLink().appValuesColors.appBarBgColor[200],
            AppValuesFilesLink().appValuesDimens.widthDynamic(value: 22), (){
          Navigator.pop(context,true);
        }),
        body: Container(
          color: AppValuesFilesLink().appValuesColors.appBgColor[600],
          child: isDataReady?Stack(
            children: <Widget>[
              cardAdded?
              centerItemsViewPull
                  :
              Positioned(
                child: Align(
                  alignment: Alignment.center,
                  child:
                  Container(
                    margin: EdgeInsets.only(
                      bottom: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 25),
                      left: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 20),
                      right: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 20),
                    ),

                    child: AppWidgetFilesLink()
                        .appCustomUiWidget
                        .noDataFoundWithImage(
                        label:AppValuesFilesLink().appValuesString.noCard,
                        image:'assets/images/home/payment_info/mid_card_icon.svg',
                        iconWidth:AppValuesFilesLink()
                            .appValuesDimens
                            .imageSquareAccordingScreen(
                            value: 100),
                        iconHeight:AppValuesFilesLink()
                            .appValuesDimens
                            .imageSquareAccordingScreen(
                            value: 100),
                        labelColor:AppValuesFilesLink()
                            .appValuesColors
                            .textSubHeadingColor[100],
                        //(isEmailOk && agree)?
                        bgColor:AppValuesFilesLink()
                            .appValuesColors
                            .appBgColor[200],
                        textSize:AppValuesFilesLink()
                            .appValuesDimens
                            .fontSizeButton(value: 16),
                        borderRadius:0,
                        onPressed: (value) {
                          //Navigator.push(context, SlideRightRoute(widget:ScanQRCode()));
                        }),
                  ),
                ),
              ),
              !cardAdded?Positioned(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:
                  Container(
                    margin: EdgeInsets.only(
                      bottom: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 25),
                      left: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 0),
                      right: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 0),
                    ),
                    height: AppValuesFilesLink()
                        .appValuesDimens
                        .heightDynamic(value: 45),
                    width: AppValuesFilesLink()
                        .appValuesDimens
                        .widthDynamic(value: 160),
                    child: AppWidgetFilesLink()
                        .appCustomUiWidget
                        .buttonRoundCornerWithBgAndLeftImage(
                        AppValuesFilesLink().appValuesString.addCard,
                        'assets/images/home/payment_info/plus.svg',
                        AppValuesFilesLink()
                            .appValuesDimens
                            .imageSquareAccordingScreen(
                            value: 20),
                        AppValuesFilesLink()
                            .appValuesDimens
                            .imageSquareAccordingScreen(
                            value: 20),
                        AppValuesFilesLink()
                            .appValuesColors
                            .white,
                        //(isEmailOk && agree)?
                        AppValuesFilesLink()
                            .appValuesColors
                            .buttonBgColor[100],
                        AppValuesFilesLink()
                            .appValuesDimens
                            .fontSizeButton(value: 16),
                        30,
                            (value) {
                              Navigator.push(context, SlideRightRoute(widget:AddCardScreen())).then((value){
                               if(value){
                                 getCardInfo();
                               }
                              });
                         /* Navigator.push(context, SlideRightRoute(widget:ScanQRCode()));*/
                        }),
                  ),
                ),
              ):Container()

            ],
          ): Center(
            child:   ProgressBar().showLoaderOnUi(false, AppValuesFilesLink().appValuesColors.loaderColor),
            ),
        ))));
  }



  Future<void> getCardInfo() async {
    await ApiRequest().getAddedCardInfo().then((result){
      if(result!=null){
        if(result.success && result.result!=null){

          setState(()  {
            isDataReady = true;
          });
          //Card added failed
          if(result.result!=null && result.result.length>0){

            setState(() {
              cardList =new List();
              cardList.addAll(result.result);
              cardAdded = true;
            });
          }
        }
        else{
          setState((){
            isDataReady = true;
            cardAdded = false;
          });
          AppWidgetFilesLink().appCustomUiWidget.errorDialog(
              context,
              true,
              AppValuesFilesLink().appValuesString.appName,
              result.msg, (context1) {
            Navigator.pop(context1);
            if (result.statusCode == -2000) {
              exit(0);
            }
          });
        }
      }
      else{
        setState((){
          isDataReady = true;
        });
        //Fluttertoast.showToast(msg: "Something went wrong");
      }
    });


  }
}

