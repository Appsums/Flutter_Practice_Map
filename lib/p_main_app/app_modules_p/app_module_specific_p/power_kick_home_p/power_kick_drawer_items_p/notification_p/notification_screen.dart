import 'dart:io';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/notification_p/bean/NotificationBean.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/progress_bar_p/ProgressBar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Result> notificationList=List();
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  int currentPage = 1;
  int currentPageDataSize = 100;
  GlobalKey globalKey = new GlobalKey();
  bool isDataReady = false;
  _NotificationScreenState(){
    /*notificationList =  List();
     notificationList.add(new Records(sn: "1234567812345678"));
     notificationList.add(new Records(sn: "1234567812345678"));
    isDataReady = true;*/
    getNotificationList();
  }


  /*Pul To refresh*/
  void _onRefresh() async {
    // monitor network fetch
    // if failed,use refreshFailed()
    /* getnotificationList().then((value){
      _refreshController.refreshCompleted();
    });*/
    notificationList =  List();
    getNotificationList();
    _refreshController.refreshCompleted();

  }

  void _onLoading() async {
    if (mounted) setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    AppValuesFilesLink().appValuesDimens.appDimensFind(context:context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));

    Widget rentRowView ({Result result}) {
      String image = "assets/images/home/notification/rent_complete.svg";
      String title="${result.body}",
      time="${result.createTime!=null?result.createTime:""}",
      amount="${result.rentDetails!=null?result.rentDetails.price:"0"}",
      orderId="${result.rentDetails!=null?result.rentDetails.orderId:"0"}";


      String amountStr = "-&#65510;${double.parse(amount).toInt()}";
      //orderId =  "OD200416102803148292374";
      return GestureDetector(onTap: (){
        Navigator.push(context, SlideRightRoute(widget: RentalStatusDetailScreen(orderSn:orderId)));

      },child: Container(
        margin: EdgeInsets.only(
            left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(
                value: 5),
            right: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(
                value: 5),
            bottom: AppValuesFilesLink().appValuesDimens
                .horizontalMarginPadding(value: 5)),
        padding: EdgeInsets.only(
            right: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(
                value: 10),
            left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(
                value: 10),
            top: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(
                value: 10),
            bottom: AppValuesFilesLink().appValuesDimens
                .horizontalMarginPadding(value: 10)),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(9)),
            color: AppValuesFilesLink().appValuesColors
                .listRowBgColor[200] //It is just a dummy image
        ),
        child:
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                      left: AppValuesFilesLink().appValuesDimens
                          .horizontalMarginPadding(value: 3),
                      right: AppValuesFilesLink().appValuesDimens
                          .horizontalMarginPadding(value: 3)),
                  child: SvgPicture.asset(
                      "$image",
                      width: AppValuesFilesLink().appValuesDimens
                          .verticalMarginPadding(value: 25),
                      height: AppValuesFilesLink().appValuesDimens
                          .verticalMarginPadding(value: 25),
                      fit: BoxFit.scaleDown)),
              Flexible(
                child: Container(
                    color: AppValuesFilesLink().appValuesColors
                        .appTransColor[700],
                    padding: EdgeInsets.only(
                        left: AppValuesFilesLink().appValuesDimens
                            .horizontalMarginPadding(value: 5),
                        top: AppValuesFilesLink().appValuesDimens
                            .verticalMarginPadding(value: 5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: AppValuesFilesLink().appValuesDimens
                                  .verticalMarginPadding(value: 5)),
                          child:
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    flex: 70,
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child:
                                        Text(
                                          "$title",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize:
                                              AppValuesFilesLink()
                                                  .appValuesDimens.fontSize(
                                                value: 14,
                                              ),
                                              fontFamily: AppValuesFilesLink()
                                                  .appValuesFonts.defaultFont,
                                              fontWeight: AppValuesFilesLink()
                                                  .appValuesFonts.semiBold600,
                                              color: AppValuesFilesLink()
                                                  .appValuesColors
                                                  .textSubHeadingColor[100]),),),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 30,
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child:
                                        Html(
                                          data: amountStr ?? '',

                                          customTextAlign: (node) {
                                            return TextAlign.right;
                                          },
                                          defaultTextStyle: TextStyle(

                                              fontFamily:
                                              AppValuesFilesLink()
                                                  .appValuesFonts.defaultFont,
                                              fontWeight: FontWeight.w600,
                                              fontSize: AppValuesFilesLink()
                                                  .appValuesDimens
                                                  .fontSize(value: 15),
                                              color: AppValuesFilesLink()
                                                  .appValuesColors
                                                  .textSubHeadingColor[300]),
                                        )
                                        /*Text("-W 8000",style: TextStyle(
                                          fontSize:
                                          AppValuesFilesLink().appValuesDimens.fontSize(
                                            value: 14,
                                          ),
                                          fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                                          fontWeight: AppValuesFilesLink().appValuesFonts.semiBold600,
                                          color: AppValuesFilesLink()
                                              .appValuesColors
                                              .textSubHeadingColor[300]))*/,),
                                    ),
                                  ),

                                ],
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: AppValuesFilesLink().appValuesDimens
                                  .verticalMarginPadding(value: 5)),
                          child:
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    flex: 50,
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            "$time", style: TextStyle(
                                            fontSize:
                                            AppValuesFilesLink().appValuesDimens
                                                .fontSize(
                                              value: 12,
                                            ),
                                            fontFamily: AppValuesFilesLink()
                                                .appValuesFonts.defaultFont,
                                            fontWeight: AppValuesFilesLink()
                                                .appValuesFonts.medium500,
                                            color: AppValuesFilesLink()
                                                .appValuesColors
                                                .chatTimeTextColor[200])),),
                                    ),
                                  ),
                                  /*Flexible(
                                  flex: 25,
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Image(
                                            image: AssetImage(
                                                "assets/images/agenda/seats@3x.png"),
                                            width: AppValuesFilesLink().appValuesDimens.widthDynamic(value: 16),
                                            height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 14),
                                          ),
                                          Text("$availableSheets",style: TextStyle(
                                              fontSize:
                                              AppValuesFilesLink().appValuesDimens.fontSize(
                                                value: 9,
                                              ),
                                              fontFamily: AppValuesFilesLink()
                                                  .appValuesFonts
                                                  .fontFamily,
                                              fontWeight: AppValuesFilesLink()
                                                  .appValuesFonts.light300,
                                              color: AppValuesFilesLink()
                                                  .appValuesColors
                                                  .textNormalColor),maxLines: 1,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),*/
                                ],
                              )),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),);
    }


    Widget pushBatteryRowView({Result result}){
      int notificationType = result.notificationFor;
      String image =notificationType==2?"assets/images/home/notification/pushedback_icon.svg":"assets/images/home/notification/pulled_out.svg";
      String title="${result.body}",
          time="${result.createTime!=null?result.createTime:""}";
      return (title!=null&&title.trim().length>0)?Container(
      margin: EdgeInsets.only(
          left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 5),
          right: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 5),
          bottom:  AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 5)),
      padding: EdgeInsets.only(right: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 10),
          left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 10),
          top: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 10),
          bottom: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 10)),
      decoration:BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(9)),
          color: AppValuesFilesLink().appValuesColors.listRowBgColor[200]//It is just a dummy image
      ) ,
      child:
      Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value:3),right: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value:3)),
                child:SvgPicture.asset(
                    "$image",
                    width: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 25),
                    height: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 25),fit: BoxFit.scaleDown)),
           
            Flexible(
              child:Container(
                  color: AppValuesFilesLink().appValuesColors.appTransColor[700],
                  padding: EdgeInsets.only(left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 5),top: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top:AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 5)),
                        child:
                        Align(
                            alignment: Alignment.centerLeft,
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child:
                                      Text("$title",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize:
                                            AppValuesFilesLink().appValuesDimens.fontSize(
                                              value: 14,
                                            ),
                                            fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                                            fontWeight: AppValuesFilesLink().appValuesFonts.semiBold600,
                                            color: AppValuesFilesLink()
                                                .appValuesColors
                                                .textSubHeadingColor[100]),), ),
                                  ),
                                ),
                                /*Flexible(
                                  flex: 30,
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child:Text("-W 8000",style: TextStyle(
                                          fontSize:
                                          AppValuesFilesLink().appValuesDimens.fontSize(
                                            value: 14,
                                          ),
                                          fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                                          fontWeight: AppValuesFilesLink().appValuesFonts.semiBold600,
                                          color: AppValuesFilesLink()
                                              .appValuesColors
                                              .textSubHeadingColor[300])), ),
                                  ),
                                ),
*/
                              ],
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 5)),
                        child:
                        Align(
                            alignment: Alignment.centerLeft,
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child:Text("$time",style: TextStyle(
                                          fontSize:
                                          AppValuesFilesLink().appValuesDimens.fontSize(
                                            value: 12,
                                          ),
                                          fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                                          fontWeight: AppValuesFilesLink().appValuesFonts.medium500,
                                          color: AppValuesFilesLink()
                                              .appValuesColors
                                              .chatTimeTextColor[200])), ),
                                  ),
                                ),
                                /*Flexible(
                                  flex: 25,
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Image(
                                            image: AssetImage(
                                                "assets/images/agenda/seats@3x.png"),
                                            width: AppValuesFilesLink().appValuesDimens.widthDynamic(value: 16),
                                            height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 14),
                                          ),
                                          Text("$availableSheets",style: TextStyle(
                                              fontSize:
                                              AppValuesFilesLink().appValuesDimens.fontSize(
                                                value: 9,
                                              ),
                                              fontFamily: AppValuesFilesLink()
                                                  .appValuesFonts
                                                  .fontFamily,
                                              fontWeight: AppValuesFilesLink()
                                                  .appValuesFonts.light300,
                                              color: AppValuesFilesLink()
                                                  .appValuesColors
                                                  .textNormalColor),maxLines: 1,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),*/
                              ],
                            )),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    ):Container();
    }


    //Pull to refresh
    Widget centerItemsViewPull =
    (notificationList!=null&&notificationList.length>0)?SmartRefresher(
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
              itemCount: notificationList!=null?notificationList.length:0,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctxt, int index) {

                Result mResult = notificationList[index];
                RentDetails rentDetils = mResult!=null?mResult.rentDetails:null;
                return
                  (mResult!=null)?
                  Align(
                    alignment: Alignment.topCenter,
                    child:
                    Container(
                      margin: EdgeInsets.only(
                        bottom: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 10),
                        left: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 5),
                        right: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 5),
                      ),
                      child: rentDetils!=null?rentRowView(result: mResult):pushBatteryRowView(result:mResult),
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
                    AppValuesFilesLink().appValuesString.notifications,
                    AppValuesFilesLink().appValuesColors.appBarTextColor[200],
                    AppValuesFilesLink().appValuesColors.appBarLetIconColor[200],
                    null,
                    AppValuesFilesLink().appValuesColors.appBarBgColor[200],
                    AppValuesFilesLink().appValuesDimens.widthDynamic(value: 22), (){
                  Navigator.pop(context,true);
                }),
                body: Container(
                  padding: EdgeInsets.only(top: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 10)),
                  color: AppValuesFilesLink().appValuesColors.appBgColor[600],
                  child: isDataReady?Stack(
                    children: <Widget>[
                      (notificationList!=null&&notificationList.length>0)?
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
                                label:AppValuesFilesLink().appValuesString.noNotifications,
                                image:'assets/images/home/payment_info/error.svg',
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
                    ],
                  ): Center(
                    child:   ProgressBar().showLoaderOnUi(false, AppValuesFilesLink().appValuesColors.loaderColor),
                  ),
                ))));
  }



  Future<void> getNotificationList() async {
    await ApiRequest().getNotificationList(page: currentPage,size: currentPageDataSize).then((result){
      if(result!=null){
        if(result.success && result.result!=null){

          setState(()  {
            isDataReady = true;
          });
          //Card added failed
          if(result.result!=null && result.result.length>0){
            setState(() {
              notificationList =new List();
              notificationList.addAll(result.result);
            });
          }
        }
        else{
          setState((){
            isDataReady = true;
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
