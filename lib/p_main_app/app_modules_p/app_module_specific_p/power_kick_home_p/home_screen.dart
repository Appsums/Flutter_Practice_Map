import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:baseapp/p_main_app/api_calling_p/LocalConstant.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/api_constant.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import 'package:baseapp/p_main_app/app_modules_p/ScreensRoutes.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/store_index_bean/store_index_bean.dart';
import 'package:baseapp/p_main_app/app_utility_p/fcm/firebase_notification_handler.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var screenSize, screenHeight, screenWidth;
  List<MoreItemsList> drawerList = new List();
  MoreItemsList obj;
  DateTime currentBackPressTime;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  final Set<Marker> _markers = new Set<Marker>();
  MapType _currentMapType = MapType.normal;
  double pinPillPosition = -100;
  Uint8List markerIcon;
  bool isDataReady = false;

  _onMapCreated(GoogleMapController controller) {
     _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
  }

  //Editing controller for search bar
  TextEditingController searchController = TextEditingController();
  FocusNode search;

  String _profileImage, userName, firstName = "", lastName = "";

  String mSearchedInputvalue;
  double latitude, longitude;
  double currentLatitude, currentLongitude;

  getCurrentPosition(lat,long){
   return LatLng(lat, long);
  }


  _HomeScreenState(){

    SharedPreferencesFile().readStr(nameC).then((value){
      setState(() {
        firstName = value??"";
      });
    });
    SharedPreferencesFile().readStr(userProfileImageC).then((value){
      setState(() {
        _profileImage = ConstantC.baseImageUrl+value??"";
      });
    });
    getCurrentLocation().then((value){
      getStationIndexes();
    });

    try {
      new FirebaseNotifications().setUpFirebase(context, updateNotificationIcon);
    } catch (e) {
      print(e);
    }
  }

  updateNotificationIcon() {
   SharedPreferencesFile()
        .readBool(anyNewNotificationC)
        .then((value) {

    });
  }

  //Recenter my location
  recenterMyLocation() {
    getCurrentLocation().then((value){
      if(value!=null && value){
        setState(() {
          searchController.text = '';
          mSearchedInputvalue = '';
          moveCameraToFirstStore(currentLatitude,currentLongitude,zoom:15.0);
        });
      getStationIndexes();
      }
    });
  }

  getCurrentLocation() async {
    bool isCurrentLocation = false;
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    await Future.value().then((value){
      setState((){
        latitude = position.latitude;
        longitude = position.longitude;
        currentLatitude = position.latitude;
        currentLongitude = position.longitude;
        isCurrentLocation = true;


   /*   latitude = 37.509257088793646;
      longitude = 127.06178681578565;*/
      });
    });

    return isCurrentLocation;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }


  //Get station list
  Future<void> getStationIndexes() async {
    try {
      markerIcon = await getBytesFromAsset('assets/images/home/map_icon.png', 100);
    } catch (e) {
      print(e);
    }

    var result = await ApiRequest().getStationIndex(long: longitude,lat: latitude);

    if(result!=null){
      if(result.success && result.result!=null){
        List<Result> data = result.result;
        Set<Marker> _markersTemp = new Set<Marker>();
        for(int i=0; i< data.length;i++){
          _markersTemp.add(Marker(markerId: MarkerId("$i"),position:LatLng(data[i].latitude,data[i].longitude),
              icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(title: "${data[i].storeName}",
                //snippet: "${data[i].address}",
                onTap: (){
                      Navigator.push(context, SlideRightRoute(widget: PowerStationDetail(storeInfoId:data[i].storeInfoId,
                      currentLatitude: data[i].latitude,
                      currentLongitude: data[i].longitude),));

                }),
            onTap: (){
              mapController.showMarkerInfoWindow(MarkerId("$i"));
            },
            ));
        }

        setState((){
          _markers.addAll(_markersTemp);
          isDataReady = true;
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

    /* Set<Marker> _markersTemp = new Set<Marker>();
    _markersTemp.add(Marker(markerId: MarkerId("100"),position:LatLng(currentLatitude,currentLongitude),
      icon: await BitmapDescriptor.fromBytes(markerIcon),
      infoWindow: InfoWindow(title: "Okk",
          snippet: "Indore",
          onTap: (){
            Navigator.push(context, SlideRightRoute(widget: PowerStationDetail(storeInfoId:"101",
                currentLatitude: currentLatitude,
                currentLongitude: currentLongitude),));

          }),
      onTap: (){
        mapController.showMarkerInfoWindow(MarkerId("100"));
      },
    ));
    setState((){
      _markers.addAll(_markersTemp);
      isDataReady = true;
    });*/

  }



  //Search station
  Future<void> searchStation(String searchStationName) async {
    var result = await ApiRequest().searchStation(searchText: searchStationName,long: longitude.toString(),lat: latitude.toString(),page:"1");

    if(result!=null){
      //if(result.status && result.responseData!=null){
      if(result.success && result.result!=null){
        var data = result.result.records;
        Set<Marker> _markersTemp = new Set<Marker>();
        for(int i=0; i< data.length;i++){
          _markersTemp.add(Marker(markerId: MarkerId("$i"),position:LatLng(data[i].latitude,data[i].longitude),
              icon: await BitmapDescriptor.fromAssetImage(
                  ImageConfiguration(devicePixelRatio: 2.5),
                  'assets/images/home/map_icon.png'),
            infoWindow: InfoWindow(title: "${data[i].name}",
                snippet: "${data[i].address}",
                onTap: (){
              Navigator.push(context, SlideRightRoute(widget: PowerStationDetail(storeInfoId:data[i].id,
                  currentLatitude: data[i].latitude,
                  currentLongitude: data[i].longitude),));

            }),
            onTap: (){
              mapController.showMarkerInfoWindow(MarkerId("$i"));
            },
          ));
        }
        setState(() {
          _markers.clear();
          _markers.addAll(_markersTemp);
        moveCameraToFirstStore(data[0].latitude,data[0].longitude);
          isDataReady = true;
        });
        //mapController.moveCamera(CameraUpdate.newLatLngZoom(data[0].latitude,data[0].longitude));

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
  void initState() {
    AppValuesFilesLink(context: context);
    drawerList.clear();
    search = new FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;

    //Add items in drawer
    addDrawerItems() {
      setState(() {
        obj = new MoreItemsList(
            "assets/images/home/side_drawer/drawer_info.svg",
            AppValuesFilesLink(context: context).appValuesString.basicInfo);
        drawerList.add(obj);

        obj = new MoreItemsList(
            "assets/images/home/side_drawer/notification.svg",
            AppValuesFilesLink(context: context).appValuesString.notifications);
        drawerList.add(obj);

        obj = new MoreItemsList(
            "assets/images/home/side_drawer/drawer_payment_info.svg",
            AppValuesFilesLink(context: context).appValuesString.paymentInfo);
        drawerList.add(obj);

        obj = new MoreItemsList(
            "assets/images/home/side_drawer/drawer_menu.svg",
            AppValuesFilesLink(context: context).appValuesString.rentalRecords);
        drawerList.add(obj);

        obj = new MoreItemsList(
            'assets/images/home/side_drawer/drawer_language.svg',
            AppValuesFilesLink(context: context).appValuesString.language);
        drawerList.add(obj);

        obj = new MoreItemsList(
            'assets/images/home/side_drawer/drawer_about.svg',
            AppValuesFilesLink(context: context).appValuesString.aboutUs);
        drawerList.add(obj);
        //AppLocalizations.of(context).translate('first_string'),

        obj = new MoreItemsList(
            'assets/images/home/side_drawer/drawer_agreement.svg',
            AppValuesFilesLink(context: context).appValuesString.termsAndCondition);
        drawerList.add(obj);
      });
    }

    drawerList.clear();
    addDrawerItems();

    //Drawer items click
    void drawerItemClick(int index) {
      switch (index) {
        case 0:
          {
            Navigator.push(
                context,
                SlideRightRoute(
                    widget: ProfileScreen())).then((value){
              SharedPreferencesFile().readStr(nameC).then((value){
                setState(() {
                  firstName = value??"";
                });
              });
              SharedPreferencesFile().readStr(userProfileImageC).then((value){
                setState(() {
                  _profileImage = ConstantC.baseImageUrl+value??"";
                });
              });

            });
            break;
          }
        case 1:
          {
            Navigator.push(context, SlideRightRoute(widget: NotificationScreen()));
            break;
          }
        case 2:
          {
            Navigator.push(context, SlideRightRoute(widget: PaymentInfo()));
            break;
          }
        case 3:
          {
            Navigator.push(context, SlideRightRoute(widget: RentalRecords()));
            break;
          }
        case 4:
          {
            Navigator.push(context, SlideRightRoute(widget: LanguageScreen()))
                .then((value) {
              drawerList.clear();
              addDrawerItems();
            });
            break;
          }
        case 5:
          {
            Navigator.push(context, SlideRightRoute(widget: AboutUsScreen()));
            break;
          }
        case 6:
          {
            Navigator.push(context, SlideRightRoute(widget: InfoScreens(index: 2)));
            break;
          }
      }
    }

    //Double back press for close app
    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: "Press back again to leave");
        return Future.value(false);
      }
      return Future.value(true);
    }

    //Drawer user image
    Widget drawerUserImage = GestureDetector(
      onTap: () {
        Navigator.push(context, SlideRightRoute(widget: ProfileScreen())).then((value){
          SharedPreferencesFile().readStr(nameC).then((value){
            setState(() {
              firstName = value??"";
            });
          });
          SharedPreferencesFile().readStr(userProfileImageC).then((value){
            setState(() {
              _profileImage = ConstantC.baseImageUrl+value??"";
            });
          });
        });},
      child: Container(
          height: screenHeight / 5,
          padding: EdgeInsets.only(
              top: AppValuesFilesLink()
                  .appValuesDimens
                  .verticalMarginPadding(value: 20)),
          color: AppValuesFilesLink().appValuesColors.primaryColor,
          child: Padding(
              padding: EdgeInsets.only(
                left: 0,
              ),
              child: Center(
                child: Container(
                  height: screenWidth / 3.8,
                  width: screenWidth / 3.8,
                  decoration: BoxDecoration(
                    color: AppValuesFilesLink().appValuesColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AppWidgetFilesLink()
                        .appCustomUiWidget
                        .circularImageView(
                        screenWidth / 4, screenWidth / 4, _profileImage),
                  ),
                ),
              ))),
    );

    //Drawer user name view
    Widget drawerUserNameView() {
      if (firstName != null && lastName != null) {
        userName = '$firstName $lastName';
      } else if (firstName != null) {
        userName = '$firstName';
      } else if (lastName != null) {
        userName = '$lastName';
      } else {
        userName = "";
      }

      return Padding(
          padding: EdgeInsets.only(
            top: AppValuesFilesLink()
                .appValuesDimens
                .verticalMarginPadding(value: 0),
          ),
          child: Center(
            child: Text(
              '$userName',
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w500,
                  fontSize:
                  AppValuesFilesLink().appValuesDimens.fontSize(value: 22),
                  color: AppValuesFilesLink().appValuesColors.white),
            ),
          ));
    }

    //Divider
    Widget divider = Container(
      height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 1),
      decoration: BoxDecoration(
        color: AppValuesFilesLink().appValuesColors.drawerDividerColor[200],
        shape: BoxShape.rectangle,
      ),
    );

    //Drawer menus
    Widget drawerMenus = Container(
        padding: EdgeInsets.only(
            top: AppValuesFilesLink()
                .appValuesDimens
                .verticalMarginPadding(value: 15)),
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: drawerList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return GestureDetector(
                onTap: () {
                  if (_scaffoldKey.currentState.isDrawerOpen) {
                    //Scaffold.of(context).openEndDrawer(),

                    _scaffoldKey.currentState.openEndDrawer();
                  }
                  AppWidgetFilesLink().appCustomUiWidget.hideKeyboard(context);
                  drawerItemClick(index);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: AppValuesFilesLink()
                              .appValuesDimens
                              .verticalMarginPadding(value: 0)),
                      color: AppValuesFilesLink().appValuesColors.appTransColor[700],
                      height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 50),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: AppValuesFilesLink()
                                .appValuesDimens
                                .verticalMarginPadding(value: 0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(margin: EdgeInsets.only(
                                right: AppValuesFilesLink()
                                    .appValuesDimens
                                    .horizontalMarginPadding(value: 18),
                                left: AppValuesFilesLink()
                                    .appValuesDimens
                                    .verticalMarginPadding(value: 18)),height: 25,width: 25,child: SvgPicture.asset(
              drawerList[index].image,
              width: AppValuesFilesLink()
                  .appValuesDimens
                  .widthDynamic(value: 22),
              height: AppValuesFilesLink()
                  .appValuesDimens
                  .widthDynamic(value: 22))),
                            Text(
                              (drawerList[index].title) ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: AppValuesFilesLink()
                                      .appValuesDimens
                                      .fontSize(value: 18),
                                  color: AppValuesFilesLink()
                                      .appValuesColors
                                      .white,
                                  fontFamily: AppValuesFilesLink()
                                      .appValuesFonts
                                      .defaultFont,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    (index == 1 || index == (drawerList.length - 1))
                        ? divider
                        : Container()
                  ],
                ),
              );
            }));

    //Drawer view
    _drawerView() {
      return Container(
        width: MediaQuery.of(context).size.width / 1.35,
        child: Drawer(
          child: Container(
              color: AppValuesFilesLink().appValuesColors.primaryColor,
              height: screenSize.height,
              child: Stack(
                children: <Widget>[
                  ListView(
                    padding: EdgeInsets.only(
                        top: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 20),
                        left: screenWidth / 52,
                        right: screenWidth / 52),
                    children: <Widget>[
                      drawerUserImage,
                      drawerUserNameView(),
                      drawerMenus,
                    ],
                  ),
                  Positioned(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: AppValuesFilesLink()
                                  .appValuesDimens
                                  .horizontalMarginPadding(value: 35),
                              left: AppValuesFilesLink()
                                  .appValuesDimens
                                  .verticalMarginPadding(value: 15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              divider,
                              GestureDetector(
                                  onTap: () {
                                    AppWidgetFilesLink()
                                        .appCustomUiWidget
                                        .confimationDialog(
                                        context,
                                        AppValuesFilesLink().appValuesString.appName,
                                        AppValuesFilesLink().appValuesString.logoutConfirmation,
                                            () {
                                          Navigator.pop(context);
                                          SharedPreferencesFile().clearAll();
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              SlideRightRoute(
                                                  widget: LoginWithMobile()),
                                              ModalRoute.withName(homeScreen));
                                        });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: AppValuesFilesLink()
                                          .appValuesDimens
                                          .horizontalMarginPadding(value: 5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: AppValuesFilesLink()
                                                  .appValuesDimens
                                                  .horizontalMarginPadding(
                                                  value: 18),
                                              left: AppValuesFilesLink()
                                                  .appValuesDimens
                                                  .verticalMarginPadding(
                                                  value: 15)),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/home/side_drawer/drawer_logout@3x.png'),
                                            width: AppValuesFilesLink()
                                                .appValuesDimens
                                                .widthDynamic(value: 30),
                                            height: AppValuesFilesLink()
                                                .appValuesDimens
                                                .widthDynamic(value: 32),
                                          ),
                                        ),
                                        Text(
                                          AppValuesFilesLink(context: context)
                                              .appValuesString
                                              .signOut,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: AppValuesFilesLink()
                                                  .appValuesDimens
                                                  .fontSize(value: 18),
                                              color: AppValuesFilesLink()
                                                  .appValuesColors
                                                  .white,
                                              fontFamily: AppValuesFilesLink()
                                                  .appValuesFonts
                                                  .defaultFont,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        )),
                  )
                ],
              )),
        ),
      );
    }

    _searchBar() {
      return Container(
        margin: EdgeInsets.only(
            left: AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 15),
            right: AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 15),
            bottom: AppValuesFilesLink()
                .appValuesDimens
                .verticalMarginPadding(value: 15)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: AppValuesFilesLink().appValuesColors.white),
        child: Padding(
          padding: EdgeInsets.only(
              left: AppValuesFilesLink()
                  .appValuesDimens
                  .horizontalMarginPadding(value: 20),
              top: AppValuesFilesLink()
                  .appValuesDimens
                  .verticalMarginPadding(value: 0),
              bottom: AppValuesFilesLink()
                  .appValuesDimens
                  .verticalMarginPadding(value: 0),
              right: AppValuesFilesLink()
                  .appValuesDimens
                  .horizontalMarginPadding(value: 5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 0)),
                  child: Image(
                    image: AssetImage('assets/images/home/search@3x.png'),
                    width: AppValuesFilesLink()
                        .appValuesDimens
                        .widthDynamic(value: 18),
                    height: AppValuesFilesLink()
                        .appValuesDimens
                        .heightDynamic(value: 18),
                  )),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 15),
                        top: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 5)),
                    child: TextField(
                        controller: searchController,
                        autofocus: false,
                        focusNode:search ,
                        style: TextStyle(
                          fontSize: AppValuesFilesLink()
                              .appValuesDimens
                              .fontSize(value: 17),
                        ),
                        decoration: InputDecoration(
                          hintText: AppValuesFilesLink(context: context)
          .appValuesString
          .search,
                          hintStyle: TextStyle(
                              color: AppValuesFilesLink().appValuesColors.textNormalColor[100],
                              fontSize: AppValuesFilesLink()
                                  .appValuesDimens
                                  .fontSize(value: 17),
                              fontWeight: FontWeight.w500),
                          suffixIcon:(mSearchedInputvalue!=null && mSearchedInputvalue.toString().trim().length >0)
                              ? GestureDetector(
                            onTap: () {
                              setState(() {
                                searchController.text = '';
                                mSearchedInputvalue = '';
                                moveCameraToFirstStore(currentLatitude,currentLongitude);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                AppValuesFilesLink()
                                    .appValuesDimens
                                    .verticalMarginPadding(value: 14),
                                AppValuesFilesLink()
                                    .appValuesDimens
                                    .verticalMarginPadding(value: 14),
                                AppValuesFilesLink()
                                    .appValuesDimens
                                    .verticalMarginPadding(value: 14),
                                AppValuesFilesLink()
                                    .appValuesDimens
                                    .verticalMarginPadding(value: 14),
                              ),
                              child: Image(
                                image: AssetImage(
                                    'assets/images/home/cross@3x.png'),
                                width: 0,
                                height: 0,
                              ),
                            ),
                          )
                              : Container(height: 0,width:0),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        cursorColor: Colors.transparent,
                        onChanged: (value) {
                          setState(() {
                            mSearchedInputvalue = value;
                          });
                        },
                        onSubmitted: (value) {
                          if(value!=null && value!=''){
                            searchStation(value);
                          }else{
                            moveCameraToFirstStore(currentLatitude,currentLongitude);
                          }
                        })),
              )
            ],
          ),
        ),
      );
    }

    Widget _topView() {
      return Container(
        padding: EdgeInsets.only(
          top: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 40),
          left: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 20),
          right: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 20),
          bottom: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(
                      top: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 12)),
                  child: Image(
                    image: AssetImage("assets/images/home/menu@3x.png"),
                    height: AppValuesFilesLink()
                        .appValuesDimens
                        .heightDynamic(value: 24),
                    width: AppValuesFilesLink()
                        .appValuesDimens
                        .widthDynamic(value: 24),
                  ),
                ),
                onTap: () {
                  // AppWidgetFilesLink().appCustomUiWidget.hideKeyboard(context);
                  if (_scaffoldKey.currentState.isDrawerOpen) {
                    //Scaffold.of(context).openEndDrawer(),

                    _scaffoldKey.currentState.openEndDrawer();

                  }
                  else if (!_scaffoldKey.currentState.isDrawerOpen) {
                    //Scaffold.of(context).openDrawer(),
                    search.unfocus();
                    AppWidgetFilesLink().appCustomUiWidget.hideKeyboard(context);
                    _scaffoldKey.currentState.openDrawer();
                    //  ProjectLogs.LogsE("Home","Open")
                  }
                },
              ),
            ),
            Flexible(
              //flex: 3,
              child: Align(alignment: Alignment.topCenter, child: _searchBar()),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(
                      top: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 0)),
                  height: AppValuesFilesLink()
                      .appValuesDimens
                      .heightDynamic(value: 45),
                  width: AppValuesFilesLink()
                      .appValuesDimens
                      .widthDynamic(value: 45),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22.5)),
                    color: AppValuesFilesLink().appValuesColors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppValuesFilesLink()
                        .appValuesDimens
                        .verticalMarginPadding(value: 11)),
                    child: Image(
                      image:
                      AssetImage("assets/images/home/location_yellow@3x.png"),
                      height: AppValuesFilesLink()
                          .appValuesDimens
                          .heightDynamic(value: 24),
                      width: AppValuesFilesLink()
                          .appValuesDimens
                          .widthDynamic(value: 24),
                    ),
                  ),
                ),
                onTap: () {
                  try {
                    AppWidgetFilesLink().appCustomUiWidget.hideKeyboard(context);
                    Navigator.push(context,
                        SlideRightRoute(
                            widget: PowerStationsList()));
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            )
          ],
        ),
      );
    }

    //Map view
    mapView(){
      return  GoogleMap(
      myLocationEnabled: true,
      compassEnabled: false,
      circles: Set.from([Circle(
      circleId: CircleId("1"),
      center: LatLng(latitude, longitude),
      radius: 100,
      strokeWidth: 1,
      strokeColor: Colors.blue
      )]),
      myLocationButtonEnabled: false,

      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
      // target: _center,
      target: getCurrentPosition(latitude,longitude),
      zoom: 12.0,
      ),
      mapType: _currentMapType,
      markers: _markers,
      onCameraMove: _onCameraMove,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Screen',
      home: WillPopScope(
          onWillPop: onWillPop,
          child: Container(
              color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
              child:Scaffold(
                key: _scaffoldKey,
                // appBar: PreferredSize(child: Container(color: ,), preferredSize: null),
                body: Container(
                   /* decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/home/map@3x.png"),
                          fit: BoxFit.cover),
                    ),*/
                    child: Container(

                      child: Stack(
                        children: <Widget>[
                          isDataReady?mapView():Container(),
                          Positioned(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: AppValuesFilesLink()
                                      .appValuesDimens
                                      .verticalMarginPadding(value: 20),
                                  right: AppValuesFilesLink()
                                      .appValuesDimens
                                      .verticalMarginPadding(value: 20),
                                  bottom: AppValuesFilesLink()
                                      .appValuesDimens
                                      .verticalMarginPadding(value: 15),
                                ),
                                height: AppValuesFilesLink()
                                    .appValuesDimens
                                    .heightDynamic(value: 80),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      //color: Colors.yellow,
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(onTap:()=> recenterMyLocation(),
                                       child: Image(
                                        image: AssetImage(
                                            "assets/images/home/white_location@3x.png"),
                                        height: AppValuesFilesLink()
                                            .appValuesDimens
                                            .heightDynamic(value: 80),
                                        width: AppValuesFilesLink()
                                            .appValuesDimens
                                            .widthDynamic(value: 70),
                                      ),)
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
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
                                        height: AppValuesFilesLink()
                                            .appValuesDimens
                                            .heightDynamic(value: 45),
                                        width: AppValuesFilesLink()
                                            .appValuesDimens
                                            .widthDynamic(value: 140),
                                        child: AppWidgetFilesLink()
                                            .appCustomUiWidget
                                            .buttonRoundCornerWithBgAndLeftImage(
                                            AppValuesFilesLink(context: context).appValuesString.scan,
                                            'assets/images/home/scan@3x.png',
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
                                              Navigator.push(context, SlideRightRoute(widget:ScanQRCode()));
                                              //Navigator.push(context, SlideRightRoute(widget:AddCardScreen()));
                                            }),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                          onTap:() async {
                                            Navigator.push(context,SlideRightRoute(widget: AboutUsScreen()));
                                           // await new FirebaseNotifications().getToken();

                                            //Get device details
                                            //String deviceToken = await SharedPreferencesFile().readStr(deviceTokenC);
                                           // ProjectUtil().printP("Home","Token $deviceToken");
                                            },
                                          child: Container(
                                            //  color: Colors.yellow,
                                              alignment: Alignment.centerRight,
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/images/home/white_info@3x.png"),
                                                height: AppValuesFilesLink()
                                                    .appValuesDimens
                                                    .heightDynamic(value: 100),
                                                width: AppValuesFilesLink()
                                                    .appValuesDimens
                                                    .widthDynamic(value: 60),
                                              ))
                                      )
                                      ,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Align(
                                alignment: Alignment.topCenter, child: _topView()),
                          ),
                        ],
                      ),
                    )),
                drawer: _drawerView(),
              ))),
    );
  }

  Future<void> moveCameraToFirstStore(lat,long,{zoom}) async {
    mapController = await _controller.future;
    LatLng latLng = new LatLng(lat,long);
    mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, zoom!=null?zoom:10));
  }

}

/*======================================*/
class MoreItemsList {
  String title;
  String image;

  MoreItemsList(String image, String title) {
    this.image = image;
    this.title = title;
  }
}
