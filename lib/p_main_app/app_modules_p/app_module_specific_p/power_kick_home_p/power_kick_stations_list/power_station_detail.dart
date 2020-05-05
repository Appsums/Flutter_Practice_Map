import 'dart:io';

import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/api_constant.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import 'package:baseapp/p_main_app/app_utility_p/cached_network_image_p/src/cached_image_widget.dart';
import 'package:baseapp/p_main_app/app_utility_p/pre_default_app_utility_p/ProjectUtil.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppAnimationFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'station_bean/station_detail_bean.dart';

class PowerStationDetail extends StatefulWidget {
  final storeInfoId;
  final currentLatitude;
  final currentLongitude;
  final rentCount;
  final returnCount;

  PowerStationDetail({
    Key key,
    this.storeInfoId,
    this.currentLatitude,
    this.currentLongitude,
    this.rentCount,
    this.returnCount,
  }) : super(key: key);

  @override
  _PowerStationDetailState createState() => _PowerStationDetailState(this.storeInfoId, this.currentLatitude,
      this.currentLongitude,this.rentCount,
    this.returnCount);
}

class _PowerStationDetailState extends State<PowerStationDetail> {
  var screenSize, screenHeight, screenWidth;

  String image =
      "https://www.itl.cat/pngfile/big/0-3450_3d-nature-wallpaper-hd-1080p-free-download-new.jpg";

  bool isDataReady = false;

  StoreInfoDto stationDeatil;
  String storeID;
  String rentCount   ="0";
  String returnCount = "0";
  double currentLatitude, currentLongitude;
  double destinationLatitude = 22.7177, destinationLongitude = 75.8545;

  String redirectTo1 = "https://www.google.com/maps/dir/?api=1&origin=43.7967876,-79.5331616&destination=43.5184049,-79.8473993&waypoints=43.1941283,-79.59179|43.7991083,-79.5339667|43.8387033,-79.3453417|43.836424,-79.3024487&travelmode=driving&dir_action=navigate";

  String redirectTo2 = "https://www.google.com/maps/dir/?api=1&origin=43.7967876,77.4376&destination=43.5184049,-79.8473993&waypoints=43.1941283,77.4376|43.7991083,-79.5339667|43.8387033,-79.3453417|43.836424,-79.3024487&travelmode=driving&dir_action=navigate";


  String redirectTo = "https://www.google.com/maps/dir/?api=1&origin=43.7967876,-79.5331616&destination=43.5184049,-79.8473993&travelmode=driving&dir_action=navigate";

  /*"https://www.google.com/maps/dir/?api=1&origin=43.7967876,-79.5331616&destination=43.5184049,-79.8473993&waypoints=43.1941283,-79.59179|43.7991083,-79.5339667|43.8387033,-79.3453417|43.836424,-79.3024487&travelmode=driving&dir_action=navigate";*/

  _PowerStationDetailState(storeInfoId, currentLatitude,
      currentLongitude,rentCount,
      returnCount){
    this.storeID = storeInfoId;
    this.currentLatitude = currentLatitude;
    this.currentLongitude = currentLongitude;
    redirectTo1 = "https://www.google.com/maps/dir/?api=1&origin=$currentLatitude,$currentLongitude&destination="
        "$destinationLatitude,$destinationLongitude&travelmode=driving&dir_action=navigate";
    stationDetail(storeInfoid:storeID);

    if(rentCount!=null){
      this.rentCount = rentCount;
    }
    if(returnCount!=null){
      this.returnCount = returnCount;
    }
  }


  //Search station by info id
  Future<void> stationDetail({Key key, String storeInfoid}) async {

    //getStationDetailC
    var result = await ApiRequest().stationDetail(storeInfoId: storeInfoid);

    if(result!=null){
      //if(result.status && result.responseData!=null){
      if(result.success && result.result!=null){
        var data = result.result.storeInfoDto;

        setState((){
          isDataReady = true;
          stationDeatil = data;
          if(stationDeatil!=null && stationDeatil.platformAdvImg!=null&& stationDeatil.platformAdvImg.trim().length>0){
            image = ConstantC.baseImageUrl+stationDeatil.platformAdvImg;
          }

          try {
            destinationLatitude = stationDeatil.latitude;
            destinationLongitude = stationDeatil.longitude;

            redirectTo = "https://www.google.com/maps/dir/?api=1&origin=$currentLatitude,$currentLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving&dir_action=navigate";
            print(redirectTo);
          } catch (e) {
            print(e);
          }
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


  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;

    var stationImageHeight = screenHeight / 2;
    var stationImageWidth = screenWidth;

    //Top view
    Widget _topView() {
      String stationName = stationDeatil.storeName??"",
          stationAddress = stationDeatil.address??"";
      return Container(
        height: stationImageHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )
        ),
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: image,
              imageBuilder: (context, imageProvider) => Container(
                margin: EdgeInsets.only(
                  top: AppValuesFilesLink()
                      .appValuesDimens
                      .horizontalMarginPadding(value: 0),
                ),
                height: stationImageHeight,
                width: stationImageWidth,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(
                      image,
                    ),
                    fit: BoxFit.cover,
                  ), //It is just a dummy image
                ),
              ),
              placeholder: (context, url) => Container(
                margin: EdgeInsets.only(
                  top: AppValuesFilesLink()
                      .appValuesDimens
                      .horizontalMarginPadding(value: 0),
                ),
                height: stationImageHeight,
                width: stationImageWidth,

                //border radius according to number of images
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  //It is just a dummy image
                ),
                child: AppAnimationFilesLink()
                    .appAnimation
                    .mShimmerEffectClass
                    .shimmerEffect(
                  shimmerBaseColor: null,
                  shimmerHighlightColor: null,
                  height: stationImageHeight,
                  width: stationImageWidth,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
              height: stationImageHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: AppValuesFilesLink()
                      .appValuesColors
                      .appListDividerColor[600]
              ),),
            Positioned(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: AppValuesFilesLink()
                        .appValuesDimens
                        .heightDynamic(value: 70),
                    decoration: BoxDecoration(
                      // color: AppValuesFilesLink().appValuesColors.appListDividerColor[600]
                    ),
                    padding: EdgeInsets.only(
                      top: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child:   Container(
                              child: IconButton(
                                icon: new ImageIcon(
                                  new AssetImage(
                                      "assets/images/back_arrow_appbar/back_arrow@3x.png"),
                                  color:
                                  AppValuesFilesLink().appValuesColors.white,
                                  size: AppValuesFilesLink()
                                      .appValuesDimens
                                      .widthDynamic(value: 22),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )),
                        ),
                        Flexible(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: AppValuesFilesLink()
                                      .appValuesDimens
                                      .horizontalMarginPadding(value: 10),
                                  right: AppValuesFilesLink()
                                      .appValuesDimens
                                      .horizontalMarginPadding(value: 35)),
                              child: Text(AppValuesFilesLink().appValuesString.outletDetails,
                                  style: new TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppValuesFilesLink()
                                        .appValuesFonts
                                        .defaultFont,
                                    color: AppValuesFilesLink()
                                        .appValuesColors
                                        .white,
                                    fontSize: AppValuesFilesLink()
                                        .appValuesDimens
                                        .fontSize(value: 20),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Positioned(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 100)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          stationName ?? '',
                          style: TextStyle(
                              fontFamily: AppValuesFilesLink()
                                  .appValuesFonts
                                  .defaultFont,
                              fontSize: AppValuesFilesLink()
                                  .appValuesDimens
                                  .fontSize(value: 18),
                              color: AppValuesFilesLink().appValuesColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 4)),
                          child: Text(
                            stationAddress ?? '',
                            style: TextStyle(
                                fontFamily: AppValuesFilesLink()
                                    .appValuesFonts
                                    .defaultFont,
                                fontSize: AppValuesFilesLink()
                                    .appValuesDimens
                                    .fontSize(value: 15),
                                color: AppValuesFilesLink().appValuesColors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      );
    }

    //Center view
    Widget _centerButtonView() {
      return Container(
        padding: EdgeInsets.only(bottom: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value:   42.5)),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            //margin: EdgeInsets.only(bottom: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 15)),
            height:
            AppValuesFilesLink().appValuesDimens.heightDynamic(value: 45),
            width:
            AppValuesFilesLink().appValuesDimens.widthDynamic(value: 185),
            child: AppWidgetFilesLink()
                .appCustomUiWidget
                .buttonRoundCornerWithBgAndBorder(
                AppValuesFilesLink().appValuesString.getDirections,
                'assets/images/home/power_station/direction@3x.png',
                AppValuesFilesLink()
                    .appValuesDimens
                    .imageSquareAccordingScreen(value: 20),
                AppValuesFilesLink()
                    .appValuesDimens
                    .imageSquareAccordingScreen(value: 20),
                AppValuesFilesLink().appValuesColors.white,
                //(isEmailOk && agree)?
                AppValuesFilesLink().appValuesColors.buttonBgColor[100],
                AppValuesFilesLink().appValuesColors.yellow,
                AppValuesFilesLink()
                    .appValuesDimens
                    .fontSizeButton(value: 16),
                30,
                    (value) {

                  try {
                    String url = redirectTo;
                    projectUtil.launchCaller(url);
                  } catch (e) {
                    print(e);
                  }
                }),
          ),
        ),
      );
    }

    Widget _bottomViewRows(type,value) {
      return Container(
        margin: EdgeInsets.only(
          top: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 10),
          bottom: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              type ?? "",
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w600,
                  fontSize:
                  AppValuesFilesLink().appValuesDimens.fontSize(value: 16),
                  color: AppValuesFilesLink().appValuesColors.white),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    value ?? "",
                    style: TextStyle(
                        fontFamily:
                        AppValuesFilesLink().appValuesFonts.defaultFont,
                        fontWeight: FontWeight.w500,
                        fontSize: AppValuesFilesLink()
                            .appValuesDimens
                            .fontSize(value: 16),
                        color: AppValuesFilesLink()
                            .appValuesColors
                            .white),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    //Bottom view
    Widget _bottomView() {
      String businessHours="${stationDeatil.beginTime} - ${stationDeatil.endTime}",
          outletType=stationDeatil.siteType??"", serviceLine=stationDeatil.siteId??"", borrorTotal ="$rentCount/$returnCount";
      return Positioned(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: screenHeight /2,
            color: AppValuesFilesLink().appValuesColors.appBgColor[400],
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: AppValuesFilesLink()
                        .appValuesDimens
                        .verticalMarginPadding(value: 20),
                    right: AppValuesFilesLink()
                        .appValuesDimens
                        .verticalMarginPadding(value: 20),
                    bottom: AppValuesFilesLink()
                        .appValuesDimens
                        .verticalMarginPadding(value: 25),top: AppValuesFilesLink()
                      .appValuesDimens
                      .verticalMarginPadding(value: 5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _bottomViewRows(AppValuesFilesLink().appValuesString.businessHours, businessHours),
                      _bottomViewRows(AppValuesFilesLink().appValuesString.outletType, outletType),
                      _bottomViewRows(AppValuesFilesLink().appValuesString.serviceLine, serviceLine),
                      _bottomViewRows(AppValuesFilesLink().appValuesString.borrorTotal, borrorTotal),
                    ],
                  ),
                ),
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 20),
                      ),
                      height: AppValuesFilesLink()
                          .appValuesDimens
                          .heightDynamic(value: 45),
                      width: AppValuesFilesLink()
                          .appValuesDimens
                          .widthDynamic(value: 130),
                      child: AppWidgetFilesLink()
                          .appCustomUiWidget
                          .buttonRoundCornerWithBgAndLeftImage(
                          AppValuesFilesLink().appValuesString.scan,
                          'assets/images/home/scan_blue@3x.png',
                          AppValuesFilesLink()
                              .appValuesDimens
                              .imageSquareAccordingScreen(value: 16),
                          AppValuesFilesLink()
                              .appValuesDimens
                              .imageSquareAccordingScreen(value: 16),
                          AppValuesFilesLink()
                              .appValuesColors
                              .textNormalColor[200],
                          //(isEmailOk && agree)?
                          AppValuesFilesLink().appValuesColors.yellow,
                          AppValuesFilesLink()
                              .appValuesDimens
                              .fontSizeButton(value: 16),
                          30,
                              (value) {
                            Navigator.push(context, SlideRightRoute(widget:ScanQRCode()));
                          }),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Container(
        color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
        child:SafeArea(
            bottom: false,
            child:Scaffold(
              body: Container(
                color: isDataReady?AppValuesFilesLink().appValuesColors.appBgColor[400]:AppValuesFilesLink().appValuesColors.appBgColor[100],
                child: isDataReady?
                ( (isDataReady && stationDeatil!=null)? Stack(
                  children: <Widget>[
                    _topView(),
                    _bottomView(),
                    _centerButtonView(),
                  ],
                ):AppWidgetFilesLink().appCustomUiWidget.noDataFound(MediaQuery.of(context).size.height)):
                Center(
                  child:   ProgressBar().showLoaderOnUi(false, AppValuesFilesLink().appValuesColors.loaderColor),
                )
                ,
              ),
            )));
  }
}