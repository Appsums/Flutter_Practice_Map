
import 'dart:io';

import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/power_kick_rental_records_p/rental_record_bean/rental_record_list_bean.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RentalRecords extends StatefulWidget {
  final comefrom;

  RentalRecords({Key key, this.comefrom,}) : super(key: key);
  @override
  _RentalRecordsState createState() => _RentalRecordsState();
}

class _RentalRecordsState extends State<RentalRecords> {
  String currencySymbol = "&#65510";

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  ScrollController _controller;

  List<Records> recordsList = new List<Records>();
  List<Records> recordsListDataNextPage = new List<Records>();
  int currentPage = 1;
  int nextPage = 2;  //next upcoming page count
  bool isLastPage = false;

  bool isDataReady = false;

  /*Pul To refresh*/
  void _onRefresh() async {
    // monitor network fetch
    // if failed,use refreshFailed()
    currentPage = 1;
    nextPage = 2;
    recordsList.clear();
    getOrderList(page: currentPage,size: size).then((value){
      _refreshController.refreshCompleted();
    });

  }

  void _onLoading() async {
    if (mounted) setState(() {});
  }

  int size = 10;


  //List Scroll Controller
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      /* setState(() {
        showLoader = true;
      });*/
      if(!isLastPage){
        currentPage =  currentPage + 1;
        nextPage =  nextPage + 1;
        //announcementApi(currentPage,(){});
        getOrderListNextPage(page: nextPage,size: size);
      }
      else
      {
      }
    }

    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      //
    }
    if (_controller.offset >= _controller.position.minScrollExtent && _controller.offset <= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      //
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    // myScroll();
  }


  _RentalRecordsState(){
    getOrderList(page: currentPage,size: size);
  }
  /*======================pages api=====================*/

  Future<void> getOrderList({int page,int size}) async {

    var result = await ApiRequest().getOrderList(page:page,size:size);

    if(result!=null){
      //if(result.status && result.responseData!=null){
      if(result.success && result.result!=null){
        var data = result.result;

        setState((){
         isDataReady = true;
         recordsList.addAll(data.records);
        });


      }else{
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
      Fluttertoast.showToast(msg: "Something went wrong");
    }
    getOrderListNextPage(page: nextPage,size: size);

  }


  Future<void> getOrderListNextPage({int page,int size}) async {

    var result = await ApiRequest().getOrderList(page:page,size:size);

    if(result!=null){
      //if(result.status && result.responseData!=null){
      if(result.success && result.result!=null){
        var data = result.result;

        setState((){
          recordsList.addAll(data.records);
        });


      }else{
        setState((){
          isDataReady = true;
          isLastPage = true;
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
      Fluttertoast.showToast(msg: "Something went wrong");
    }


  }

  @override
  Widget build(BuildContext context) {
    Widget _recordRow(Records data) {
      String status = data.status;
      Color statusColor = AppValuesFilesLink().appValuesColors.cardBgColor[300];
      Color statusTextColor = AppValuesFilesLink().appValuesColors.textNormalColor[300];
      if(status == "DONE"){
        status = "Complete";
        statusColor = AppValuesFilesLink().appValuesColors.cardBgColor[400];
        statusTextColor = AppValuesFilesLink().appValuesColors.textNormalColor[400];
      }else if(status == "WAITING_PAID"){
        status = "In Progress";
        statusColor = AppValuesFilesLink().appValuesColors.cardBgColor[300];
        statusTextColor = AppValuesFilesLink().appValuesColors.textNormalColor[300];
      }
      String deviceId = data.deviceSn,
          orderId = data.sn,
          dateTime = data.createTime,
          location = data.storeName,time =  (data.usingTime!=null)?'${data.usingTime} hour':"",
          //time =  (data.completeTime!=null && data.createTime!=null)?'${data.completeTime - data.createTime} min':"",
          amount= "&#65510; ${data.money!=null?double.parse(data.money).toInt():0}" ,
          amountPerday= "&#65510; ${data.price.toInt()}/hour; &#65510; ${24*(data.price.toInt())}/day";

      /*  String status = "In progress";
      Color statusColor = AppValuesFilesLink().appValuesColors.cardBgColor[300];
      Color statusTextColor = AppValuesFilesLink().appValuesColors.textNormalColor[300];
      String deviceId = "LVDA061909000002",
          orderId = "OD20021911190207956123",
          dateTime = "2020-02-24 02:03:19",
          location = "Location ABC station",
          powerStationNo = "520",
          time = "83 min",
          amount = "&#65510;1.00",
          amountPerday = "(&#65510;1/hour;&#65510;24/day)";*/

      return GestureDetector(
          onTap: () {
            Navigator.push(context, SlideRightRoute(widget: RentalRecordDetail(orderSn:orderId)));
          },
          child: Container(
            padding: EdgeInsets.only(top: 3),
            child: Card(
              elevation: 0.2,
              color: AppValuesFilesLink().appValuesColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    padding: EdgeInsets.fromLTRB(
                      AppValuesFilesLink()
                          .appValuesDimens
                          .horizontalMarginPadding(value: 20),
                      AppValuesFilesLink()
                          .appValuesDimens
                          .horizontalMarginPadding(value: 10),
                      AppValuesFilesLink()
                          .appValuesDimens
                          .horizontalMarginPadding(value: 20),
                      AppValuesFilesLink()
                          .appValuesDimens
                          .horizontalMarginPadding(value: 10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            orderId ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: AppValuesFilesLink()
                                    .appValuesFonts
                                    .defaultFont,
                                fontWeight: FontWeight.w500,
                                fontSize: AppValuesFilesLink()
                                    .appValuesDimens
                                    .fontSize(value: 15),
                                color: statusTextColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppValuesFilesLink()
                                  .appValuesDimens
                                  .horizontalMarginPadding(value: 5)),
                          child: Text(
                            status ?? '',
                            style: TextStyle(
                                fontFamily: AppValuesFilesLink()
                                    .appValuesFonts
                                    .defaultFont,
                                fontWeight: FontWeight.w500,
                                fontSize: AppValuesFilesLink()
                                    .appValuesDimens
                                    .fontSize(value: 15),
                                color: statusTextColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 20),
                        top: AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 10),
                        right: AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              AppValuesFilesLink().appValuesString.deviceID,
                              style: TextStyle(
                                  fontFamily: AppValuesFilesLink()
                                      .appValuesFonts
                                      .defaultFont,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppValuesFilesLink()
                                      .appValuesDimens
                                      .fontSize(value: 15),
                                  color: AppValuesFilesLink()
                                      .appValuesColors
                                      .textNormalColor[100]),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: AppValuesFilesLink()
                                        .appValuesDimens
                                        .horizontalMarginPadding(value: 8)),
                                child: Text(
                                  deviceId ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: AppValuesFilesLink()
                                  .appValuesDimens
                                  .verticalMarginPadding(value: 4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppValuesFilesLink().appValuesString.dateTime,
                                style: TextStyle(
                                    fontFamily: AppValuesFilesLink()
                                        .appValuesFonts
                                        .defaultFont,
                                    fontWeight: FontWeight.w400,
                                    fontSize: AppValuesFilesLink()
                                        .appValuesDimens
                                        .fontSize(value: 15),
                                    color: AppValuesFilesLink()
                                        .appValuesColors
                                        .textNormalColor[100]),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: AppValuesFilesLink()
                                          .appValuesDimens
                                          .horizontalMarginPadding(value: 8)),
                                  child: Text(
                                    dateTime ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: AppValuesFilesLink()
                                  .appValuesDimens
                                  .verticalMarginPadding(value: 4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppValuesFilesLink().appValuesString.location,
                                style: TextStyle(
                                    fontFamily: AppValuesFilesLink()
                                        .appValuesFonts
                                        .defaultFont,
                                    fontWeight: FontWeight.w400,
                                    fontSize: AppValuesFilesLink()
                                        .appValuesDimens
                                        .fontSize(value: 15),
                                    color: AppValuesFilesLink()
                                        .appValuesColors
                                        .textNormalColor[100]),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: AppValuesFilesLink()
                                          .appValuesDimens
                                          .horizontalMarginPadding(value: 8)),
                                  child: Text(
                                    location ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: AppValuesFilesLink()
                                            .appValuesFonts
                                            .defaultFont,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppValuesFilesLink()
                                            .appValuesDimens
                                            .fontSize(value: 16),
                                        color: AppValuesFilesLink()
                                            .appValuesColors
                                            .textNormalColor[500]),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 20),
                        AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 15),
                        AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 20),
                        AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                      left: AppValuesFilesLink()
                                          .appValuesDimens
                                          .horizontalMarginPadding(value: 0),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        /*Image(
                                          image: AssetImage(
                                              "assets/images/home/rental_records/logo@3x.png"),
                                          height: AppValuesFilesLink()
                                              .appValuesDimens
                                              .heightDynamic(value: 35),
                                          width: AppValuesFilesLink()
                                              .appValuesDimens
                                              .widthDynamic(value: 35),
                                        ),
                                        Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: AppValuesFilesLink()
                                                    .appValuesDimens
                                                    .horizontalMarginPadding(value: 5),
                                              ),
                                              child: Text(powerStationNo ?? '',
                                                  style: TextStyle(
                                                      fontFamily: AppValuesFilesLink()
                                                          .appValuesFonts
                                                          .defaultFont,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: AppValuesFilesLink()
                                                          .appValuesDimens
                                                          .fontSize(value: 24),
                                                      color: AppValuesFilesLink()
                                                          .appValuesColors
                                                          .textNormalColor[500])),
                                            ))*/
                                      ],
                                    )),
                              )),
                          Flexible(
                              child: Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                      padding: EdgeInsets.fromLTRB(
                                        AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 6),
                                        AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 4),
                                        AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 6),
                                        AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 4),
                                      ),
                                      decoration: BoxDecoration(
                                          color: AppValuesFilesLink().appValuesColors.appBgColor[600],
                                          borderRadius: BorderRadius.all(Radius.circular(4))
                                      ),
                                      child: Text(
                                        time ?? '',
                                        textAlign: TextAlign.start,
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
                                      )))),
                          Flexible(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child:Padding(
                                    padding: EdgeInsets.only(
                                      left: AppValuesFilesLink()
                                          .appValuesDimens
                                          .horizontalMarginPadding(value: 2),
                                    ),
                                    child:  Html(
                                      customTextAlign:  (node) {
                                        return TextAlign.right;
                                      },
                                      data: amount??'',
                                      defaultTextStyle:   TextStyle(
                                          fontFamily: AppValuesFilesLink()
                                              .appValuesFonts
                                              .defaultFont,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AppValuesFilesLink()
                                              .appValuesDimens
                                              .fontSize(value: 25),
                                          color: AppValuesFilesLink()
                                              .appValuesColors
                                              .textNormalColor[500]),
                                    ),
                                  ))),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 20),
                        AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 0),
                        AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 20),
                        AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 10),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child:  Html(
                          data: amountPerday??'',

                          customTextAlign:  (node) {
                            return TextAlign.right;
                          },
                          defaultTextStyle:  TextStyle(

                              fontFamily:
                              AppValuesFilesLink().appValuesFonts.defaultFont,
                              fontWeight: FontWeight.w500,
                              fontSize: AppValuesFilesLink()
                                  .appValuesDimens
                                  .fontSize(value: 14),
                              color: AppValuesFilesLink()
                                  .appValuesColors
                                  .textNormalColor[100]),
                        ),
                        //scrollable: true,
                      )
                  ),

                ],
              ),
            ),
          ));
    }

    //Pull to refresh
    Widget centerItemsViewPull = SmartRefresher(
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
          controller: _controller,
          children: <Widget>[
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: recordsList!=null?recordsList.length:0,
                itemBuilder: (BuildContext ctxt, int index) {
                  return _recordRow(recordsList[index]);
                }),
          ],
        )
    );

    return WillPopScope(
      onWillPop: () {
        if(widget.comefrom==1){
          Navigator.pop(context, true);
        }else{
          Navigator.pop(context);
        }

        return Future.value(false);
      },
    child:  Container(
    color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
    child:SafeArea(
    bottom: false,
    child:Scaffold(
    appBar: BackArrowAppBar().appBarBackArrow(
    AppValuesFilesLink(context: context).appValuesString.rentalRecords,
    AppValuesFilesLink().appValuesColors.appBarTextColor[200],
    AppValuesFilesLink().appValuesColors.appBarLetIconColor[200],
    AppValuesFilesLink().appValuesColors.appBarBgColor[200],
    AppValuesFilesLink().appValuesDimens.widthDynamic(value: 22), () {
      if(widget.comefrom==1){
        Navigator.pop(context, true);
      }else{
        Navigator.pop(context);
      }
    }),
    body: Container(
    color: AppValuesFilesLink().appValuesColors.appBgColor[200],
    padding: EdgeInsets.fromLTRB(
    AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 5),
    AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 10),
    AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 5),
    AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 10),
    ),
    child:  isDataReady?
    ( (isDataReady && recordsList!=null && recordsList.length>0)?
    centerItemsViewPull:AppWidgetFilesLink().appCustomUiWidget.noDataFound(MediaQuery.of(context).size.height)):
    Center(
    child:   ProgressBar().showLoaderOnUi(false, AppValuesFilesLink().appValuesColors.loaderColor),
    )
    )))),
    );
  }
}


