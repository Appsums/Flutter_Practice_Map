import 'dart:io';

import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/api_constant.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_stations_list/station_bean/station_list_bean.dart';
import 'package:baseapp/p_main_app/app_utility_p/cached_network_image_p/src/cached_image_widget.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppAnimationFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geolocator/geolocator.dart';

class PowerStationsList extends StatefulWidget {
  @override
  _PowerStationsListState createState() => _PowerStationsListState();
}

class _PowerStationsListState extends State<PowerStationsList> {
  String stationsCount="";

  List stationList;

  double stationImageHeight = AppValuesFilesLink().appValuesDimens.heightDynamic(value: 140),
      stationImageWidth = AppValuesFilesLink().appValuesDimens.heightDynamic(value: 100);

  TextEditingController  _searchController = new TextEditingController();

  String mSearchedInputvalue = "";

  RefreshController _refreshController =

  RefreshController(initialRefresh: false);

  bool isDataReady = false;

  double latitude, longitude;

  var page;

  /*Pul To refresh*/
  void _onRefresh() async {
    // monitor network fetch
    // if failed,use refreshFailed()
    getStationList().then((value){
      _refreshController.refreshCompleted();
    });

  }

  void _onLoading() async {
    if (mounted) setState(() {});
  }


  _PowerStationsListState(){
    getCurrentLocation().then((value){
      getStationList();
    });
  }

  getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

     latitude = position.latitude;
    longitude = position.longitude;
 /*   latitude = 37.509257088793646;
    longitude = 127.06178681578565;*/
  }

  //Get station list
  Future<void> getStationList() async {
    var result = await ApiRequest().searchStation(searchText: "",long: longitude.toString(),lat: latitude.toString(),page:"1");

    if(result!=null){
      //if(result.status && result.responseData!=null){
      if(result.success && result.result!=null){
        var data = result.result;

        setState((){
          isDataReady = true;
          stationsCount = "${data.total} Results found";
          page = data.pages;
          stationList = data.records;
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


  //Search station by info id
  Future<void> searchStation(String searchText) async {

    if (searchText!=null
        && longitude!=null
        && latitude!=null
        && page!=null) {
      setState(() {
            isDataReady = false;
          });
      //getStationDetailC
      var result = await ApiRequest().searchStation(searchText: searchText,long: longitude.toString(),lat: latitude.toString(),page:page.toString());

      if(result!=null){
        //if(result.status && result.responseData!=null){
        if(result.success && result.result!=null){
          var data = result.result;

          setState((){
            isDataReady = true;
            stationsCount = "${data.total} Results found";
            stationList = data.records;
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


  }

  @override
  Widget build(BuildContext context) {
    //String image = "https://www.itl.cat/pngfile/big/0-3450_3d-nature-wallpaper-hd-1080p-free-download-new.jpg";

    TextStyle rowDataTextStyle = TextStyle(
        fontFamily:
        AppValuesFilesLink()
            .appValuesFonts
            .defaultFont,
        fontSize: AppValuesFilesLink()
            .appValuesDimens
            .fontSize(value: 12),
        color: AppValuesFilesLink()
            .appValuesColors
            .textNormalColor[500],
        fontWeight: FontWeight.w500);

    Widget stationImageView(String storeImage){
      return CachedNetworkImage(
        imageUrl: storeImage,
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
            borderRadius: BorderRadius.all(Radius.circular(9)),
            image: DecorationImage(
              image: NetworkImage(
                storeImage,
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
            width: stationImageWidth,),
        ),
        errorWidget: (context, url, error) => Container(
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
      child: Icon(Icons.error)),
      );
    }

    //Divider
    Widget divider = Container(
      height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 15),
      width:AppValuesFilesLink().appValuesDimens.heightDynamic(value: 1),
      decoration: BoxDecoration(
        color: AppValuesFilesLink().appValuesColors.drawerDividerColor[500],
        shape: BoxShape.rectangle,
      ),
    );


    //
    Widget _viewWithBg(imageIcon,value){
      return Padding(
          padding: EdgeInsets.only(left: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 5),),
          child:Container(
            padding: EdgeInsets.all(AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 5),),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppValuesFilesLink().appValuesColors.cardBgColor[100],
                borderRadius: BorderRadius.all(
                    Radius.circular(
                        AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(
                            value: 15)))),
            child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage(imageIcon??''),
                  height: AppValuesFilesLink()
                      .appValuesDimens
                      .heightDynamic(value: 14),
                  width: AppValuesFilesLink()
                      .appValuesDimens
                      .widthDynamic(value: 14),
                ),
        Padding(
          padding: EdgeInsets.only(left: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 3),),
          child:Text(
                  value ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: rowDataTextStyle,))
              ],
            ),
          ));
    }

    Widget _buildStationRow(Records data) {
      String storeInfoId = data.id??"",
      storeImage = data.img!=null?(ConstantC.baseImageUrl+data.img):"",
          stationDistance = data.dis!=null?(("${data.dis/1000}km")):"",
          time = "${data.startTime??""} - ${data.endTime??""}",
          stationName =  data.name??"",
          stationAddress =  data.address??"",
          rentCount="${data.unUse??0}",returnCount = "${data.useNum??0}";

      return Container(
        child: GestureDetector(
          onTap: () {
            if(storeInfoId!=null && storeInfoId!=""){
      Navigator.push(context, SlideRightRoute(widget: PowerStationDetail(storeInfoId:storeInfoId,currentLatitude: latitude,currentLongitude: longitude,rentCount: rentCount,returnCount: returnCount,)));
      }

          },
          child: Card(
            margin: EdgeInsets.only(top:  AppValuesFilesLink()
                .appValuesDimens
                .verticalMarginPadding(value: 3),),
            elevation: 0.0,
            color: AppValuesFilesLink().appValuesColors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: AppValuesFilesLink().appValuesColors.editTextBgColor,
                  width: 0.0002),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Container(
                padding: EdgeInsets.fromLTRB(
                    AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 8),
                    AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 12),
                    AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 5),
                    AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 12)),

                height:  AppValuesFilesLink().appValuesDimens.heightDynamic(value: 162),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    stationImageView(storeImage),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 8),),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _viewWithBg("assets/images/home/power_station/location_gray@3x.png",stationDistance),
                                _viewWithBg("assets/images/home/power_station/watch@3x.png",time),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 2),
                                top: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 2),
                              ),
                              child: Text(
                                stationName??"",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: AppValuesFilesLink()
                                        .appValuesFonts
                                        .defaultFont,
                                    fontSize: AppValuesFilesLink()
                                        .appValuesDimens
                                        .fontSize(value: 18),
                                    color: AppValuesFilesLink()
                                        .appValuesColors
                                        .textNormalColor[500],
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 2),
                                top: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 2),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  stationAddress??"",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: AppValuesFilesLink()
                                          .appValuesFonts
                                          .defaultFont,
                                      fontSize: AppValuesFilesLink()
                                          .appValuesDimens
                                          .fontSize(value: 16),
                                      color: AppValuesFilesLink()
                                          .appValuesColors
                                          .textNormalColor[100],
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              height:  AppValuesFilesLink()
                                  .appValuesDimens.heightDynamic(value: 35),
                                margin: EdgeInsets.only(top:  AppValuesFilesLink()
                                    .appValuesDimens
                                    .verticalMarginPadding(
                                    value: 5),),
                                padding: EdgeInsets.fromLTRB(
                                    AppValuesFilesLink()
                                        .appValuesDimens
                                        .verticalMarginPadding(
                                        value: 10),
                                    AppValuesFilesLink()
                                        .appValuesDimens
                                        .verticalMarginPadding(
                                        value: 5),
                                    AppValuesFilesLink()
                                        .appValuesDimens
                                        .verticalMarginPadding(
                                        value: 10),
                                    AppValuesFilesLink()
                                        .appValuesDimens
                                        .verticalMarginPadding(
                                        value: 5)),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: AppValuesFilesLink()
                                        .appValuesColors
                                        .cardBgColor[100],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            AppValuesFilesLink()
                                                .appValuesDimens
                                                .horizontalMarginPadding(
                                                value: 15)))),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                            left:AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 6),
                                            right:AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 6),
                                            top:AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 3),
                                            bottom:AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 3),
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: AppValuesFilesLink()
                                                  .appValuesColors
                                                  .white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      AppValuesFilesLink()
                                                          .appValuesDimens
                                                          .horizontalMarginPadding(
                                                          value: 5)))),
                                          child: Text(rentCount??'',style: TextStyle(
                                              fontFamily:
                                              AppValuesFilesLink()
                                                  .appValuesFonts
                                                  .defaultFont,
                                              fontSize: AppValuesFilesLink()
                                                  .appValuesDimens
                                                  .fontSize(value: 13),
                                              color: AppValuesFilesLink()
                                                  .appValuesColors
                                                  .textNormalColor[200],
                                              fontWeight: FontWeight.w600),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left:  AppValuesFilesLink()
                                              .appValuesDimens
                                              .horizontalMarginPadding(value: 5),),
                                          child:  Text(
                                            AppValuesFilesLink().appValuesString.rentCaps,
                                            style: rowDataTextStyle,
                                          ),
                                        )
                                      ],
                                    ),
                                    divider,
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                            left:AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 6),
                                            right:AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 6),
                                            top:AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 3),
                                            bottom:AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 3),
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: AppValuesFilesLink()
                                                  .appValuesColors
                                                  .white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      AppValuesFilesLink()
                                                          .appValuesDimens
                                                          .horizontalMarginPadding(
                                                          value: 5)))),
                                          child: Text(returnCount??"",
                                            style: TextStyle(
                                                fontFamily:
                                                AppValuesFilesLink()
                                                    .appValuesFonts
                                                    .defaultFont,
                                                fontSize: AppValuesFilesLink()
                                                    .appValuesDimens
                                                    .fontSize(value: 13),
                                                color: AppValuesFilesLink()
                                                    .appValuesColors
                                                    .textNormalColor[200],
                                                fontWeight: FontWeight.w600),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left:  AppValuesFilesLink()
                                              .appValuesDimens
                                              .horizontalMarginPadding(value: 5),),
                                          child:  Text(
                                            AppValuesFilesLink().appValuesString.returnCaps,
                                            style: rowDataTextStyle,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                            )

                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      );
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
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 10),
              bottom: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 10),
            ),
            child:  Text(
              stationsCount,
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontSize:
                  AppValuesFilesLink().appValuesDimens.fontSize(value: 13),
                  color: AppValuesFilesLink()
                      .appValuesColors
                      .textNormalColor[500]),
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: stationList!=null?stationList.length:0,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctxt, int index) {
                return _buildStationRow(stationList[index]);
              }),
        ],
      ),
    );

    return  Container(
        color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
        child:Scaffold(
        appBar: SearchAppBar().searchAppBar(
            statusbarHeight:0,
            searchController:_searchController,
            inputValue: mSearchedInputvalue,
            backIconleftPadding:5,
            appBarBackIconColor:AppValuesFilesLink().appValuesColors.appBarLetIconColor[200],
            appBarBgColor:AppValuesFilesLink().appValuesColors.appBarBgColor[200],
            iconSize:AppValuesFilesLink().appValuesDimens.widthDynamic(value: 22),
            onBackPressed: () {
              Navigator.pop(context, true);
            },
            onSearchTextChange:(value){
              if(value!=null && value!='' && value.toString().length>0){
                setState(() {
                  mSearchedInputvalue = value;
                });
              }
              return null;
            },
            onSearchSubmit:(value){
              if(value!=null &&  value.toString().length>0){
                setState(() {
                  mSearchedInputvalue = value;
                  searchStation(mSearchedInputvalue);
                });
              }
              return null;
            },
            cancelButtonPress:(){
              setState((){
                _searchController.text = '';
                mSearchedInputvalue = '';
              });
            }

        ),
        body: SafeArea(
          bottom: false,
          child:Container(
            color: AppValuesFilesLink().appValuesColors.appBgColor[100],
            margin: EdgeInsets.only(
              left:  AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 8),
              right:  AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 8),),
            child:  isDataReady?
            ( (isDataReady && stationList!=null && stationList.length>0)?
            centerItemsViewPull
                :AppWidgetFilesLink().appCustomUiWidget.noDataFound(MediaQuery.of(context).size.height)):
            Center(
              child:   ProgressBar().showLoaderOnUi(false, AppValuesFilesLink().appValuesColors.loaderColor),
            )
        ),
      )));
  }
}
