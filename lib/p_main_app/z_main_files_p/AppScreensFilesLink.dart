export 'package:baseapp/p_main_app/app_modules_p/ScreensRoutes.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_before_login_p/power_kick_login_p/login_with_mobile.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_before_login_p/power_kick_login_p/login_with_otp.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_before_login_p/slider_screens/slider_screen1.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_before_login_p/slider_screens/slider_screen2.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_before_login_p/slider_screens/slider_screen3.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_before_login_p/slider_screens/slider_view_screen.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/home_screen.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/payment_info_p/payment_info.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/payment_info_p/manage_cards.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/payment_info_p/add_card_screen.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/power_kick_about_us_p/about_us_screen.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/power_kick_info_p/info_screen.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/power_kick_language_p/language_screen.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/power_kick_rental_records_p/rental_record_detail.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/power_kick_rental_records_p/rental_records.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_profile_p/profile_screen.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_stations_list/power_station_detail.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_stations_list/power_stations_list.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/qr_p/scan_QR_code.dart';
export 'package:baseapp/p_main_app/app_modules_p/pre_default_app_module_p/back_arrow_appbar_m_p/BackArrowAppBar.dart';
export 'package:baseapp/p_main_app/app_modules_p/pre_default_app_module_p/back_arrow_with_center_and_right_icon_p/BackArrowWithRightIcon.dart';
export 'package:baseapp/p_main_app/app_modules_p/pre_default_app_module_p/home_appbar_m_p/HomeCenterTitleAppBar.dart';
export 'package:baseapp/p_main_app/app_modules_p/pre_default_app_module_p/only_right_title_appbar/RightTitleAppBar.dart';
export 'package:baseapp/p_main_app/app_modules_p/pre_default_app_module_p/search_app_bar/search_app_bar.dart';
export 'package:flutter/widgets.dart';
export '../app_modules_p/pre_default_app_module_p/side_drawer_m_p/ScreenSideDrawer.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/notification_p/notification_screen.dart';
export 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/notification_p/rental_status_detail.dart';

/*

class AppScreensFilesLink {
  mScreenRoutes() => new ScreensRoutes().routes();
  mScreenSideDrawer(_scaffoldKey, onUpdate) =>
      new ScreenSideDrawer(_scaffoldKey, onUpdate);

  //app bar
  HomeCenterTitleAppBar mHomeAppBar = new HomeCenterTitleAppBar();
  SearchAppBar mSearchAppBar = new SearchAppBar();
  BackArrowAppBar mBackArrowAppBar = new BackArrowAppBar();
  BackArrowWithRightIcon mBackArrowWithRightAppBar =
      new BackArrowWithRightIcon();
  RightTitleAppBar mAppBarWithRightTitleOnly = new RightTitleAppBar();




  //Slider Screen
  mSliderScreens({Key key, int index}) => new SliderScreens(index: index);
  mSliderScreen1({Key key, updateSelectedPageIndex}) =>
      new SliderScreen1(updateSelectedPageIndex: updateSelectedPageIndex);
  mSliderScreen2({Key key, updateSelectedPageIndex}) => new SliderScreen2(updateSelectedPageIndex: updateSelectedPageIndex);
  mSliderScreen3({Key key, updateSelectedPageIndex}) => new SliderScreen3(updateSelectedPageIndex: updateSelectedPageIndex);

  //Login Screen
  mLoginWithMobile() => new LoginWithMobile();
  mLoginWithOtp({Key key, String mobile, String nationCode}) => new LoginWithOtp(mobile: mobile,nationCode: nationCode);

  //Home Screen
  mHomeScreen() => new HomeScreen();
  mProfileScreen() => new ProfileScreen();
  mInfoScreens({Key key, int index}) => new InfoScreens(index: index);
  mLanguageScreen() => new LanguageScreen();
  mAboutUsScreen() => new AboutUsScreen();
  mRentalRecords() => new RentalRecords();
  mRentalRecordDetail({@required orderSn}) => new RentalRecordDetail(orderSn:orderSn);
  mPowerStationsList() => new PowerStationsList();
  mScanQRCode() => new ScanQRCode();
  mPaymentInfo() => new PaymentInfo();
  mPowerStationDetail({Key key, String storeInfoId,double currentLatitude,double currentLongitude}) => new PowerStationDetail(storeInfoId:storeInfoId,currentLatitude:currentLatitude , currentLongitude: currentLongitude,);

//Application specific module file
}
*/
