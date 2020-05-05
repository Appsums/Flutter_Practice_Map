import 'dart:convert';
import 'dart:io' as Io;
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_before_login_p/power_kick_login_p/otp_bean_p/verify_otp_bean.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/payment_info_p/bean/AddedCardInfoBean.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/payment_info_p/bean/add_payment_card_bean.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/notification_p/bean/NotificationBean.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/power_kick_rental_records_p/rental_record_bean/order_details.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/power_kick_rental_records_p/rental_record_bean/rental_record_list_bean.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_profile_p/user_info_bean/profile_bean.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_profile_p/user_info_bean/profile_image_bean.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_profile_p/user_info_bean/user_info_bean.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_stations_list/station_bean/station_detail_bean.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_stations_list/station_bean/station_list_bean.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/qr_p/order_bean/validate_order_bean.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/store_index_bean/store_index_bean.dart';
import 'package:baseapp/p_main_app/app_utility_p/pre_default_app_utility_p/ProjectUtil.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:flutter/material.dart';
import 'api_constant.dart';

abstract class ApiCall {
  //Get otp
  Future<dynamic> getOtp({Key key,String nationMobile,String nationCode});
  Future<dynamic> getStationList({Key key,double lat,double long});
  getUserInfo();
  getOrderList({Key key, int page,int size});
  Future<dynamic> verifyOtp({Key key,String nationMobile,String nationCode,String verifyCode,String deviceToken,String deviceType});
  Future<dynamic> orderPowerBank({Key key, String deviceSn});
  Future<dynamic> addPaymentCard({Key key, String birthNo,String cardNo,String cardPw,String expMonth,String expYear});
  Future<dynamic> searchStation({Key key, String searchText, String page, String lat, String long,});
  Future<dynamic> stationDetail({Key key, String storeInfoId});
  Future<dynamic> getOrderDetails({Key key, String orderSn});
  Future<dynamic> validateOrder();
  Future<dynamic> getStationIndex({Key key,double lat,double long}) ;
  Future<dynamic> updateProfilePicture({Key key,String imagePath}) ;
  Future<dynamic> updateProfileDetails({Key key, String email, String name}) ;
  Future<dynamic> getAddedCardInfo() ;
  Future<dynamic> getNotificationList({Key key,@required int page,@required int size}) ;
}
class ApiRequest implements ApiCall{
  String  authorization;

  //Get otp
  @override
  Future getOtp({Key key, String nationMobile, String nationCode}) async {
    // TODO: implement getOtp
    try
    {
      try
      {
        // authorization = await  SharedPreferencesFile().readStr(ACCESS_TOKEN);
      }
      catch (e) {
        print(e);
      }
      String url = getOtpC+"$nationCode/$nationMobile";
      var result = await  ApiRequestMain().apiRequestGetAuthorize(url, null, false, null);
      return result;
    }
    catch (e) {
      print(e);
      return null;
    }

  }

  //Verify OTP
  @override
  Future verifyOtp({Key key, String nationMobile, String nationCode, String verifyCode,String deviceToken,String deviceType}) async {
    // TODO: implement getOtp
    try
    {

      String url = verifyOtpC;
      var requestBody = {
        "username":nationMobile,
        "nationCode":nationCode,
        "code":verifyCode,
        "fcmToken":deviceToken,
        "deviceType":deviceType,
      };
      String data = json.encode(requestBody);
      VerifyOTPBean mVerifyOTPBean;
      var result = await  ApiRequestMain().apiRequestPostAuthorize(url, data, false,null);
      if (result.success && result.responseData != null) {
        //Hide Pop up
        projectUtil.printP("Login", result.responseData);
        try {
          mVerifyOTPBean = VerifyOTPBean.fromJson(json.decode(result.responseData));
          if (mVerifyOTPBean !=null) {
            return mVerifyOTPBean;
          }
        } catch (e) {
          print(e);
        }
      }
      else{

        return result;
      }

    }
    catch (e) {
      print(e);
      return null;
    }
  }

  @override
  getOrderList({Key key, int page,int size}) async {
    int currentPage = 0 , listSize = 10;
    try
    {
      try
      {
          authorization = await  SharedPreferencesFile().readStr(accessTokenC);
       // authorization = "70a6ba8d-5c6e-4d23-b9df-24d61613c744";
      }
      catch (e) {
        print(e);
      }
      String url = getOrderListC;
      if(page!=null){
        currentPage = page;
        url = url+ "page=$currentPage&";
      }
      if(size != null && size != 0){
        url = url+ "size=$listSize";
      }

      RentalRecordListBean mRentalRecordListBean;
      var result = await  ApiRequestMain().apiRequestGetAuthorize(url, null, false, authorization);
      if (result.success && result.responseData != null) {
        //Hide Pop up
        projectUtil.printP("Login", result.responseData);
        try {
          mRentalRecordListBean = RentalRecordListBean.fromJson(json.decode(result.responseData));
          if (mRentalRecordListBean !=null) {
            return mRentalRecordListBean;
          }
        } catch (e) {
          print(e);
        }
      }
      else{
        return result;
      }

    }
    catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future getUserInfo() async {
    try
    {
      try
      {
        authorization = await  SharedPreferencesFile().readStr(accessTokenC);
        //authorization = "70a6ba8d-5c6e-4d23-b9df-24d61613c744";
      }
      catch (e) {
        print(e);
      }
      String url = getUserInfoC;
      var result = await  ApiRequestMain().apiRequestGetAuthorize(url, null, false, authorization);
      UserInfoBean mUserInfoBean;
      if (result.success && result.responseData != null) {
        projectUtil.printP("scan code", result.responseData);
        try {
          mUserInfoBean = UserInfoBean.fromJson(json.decode(result.responseData));
          if (mUserInfoBean !=null) {
            return mUserInfoBean;
          }
        } catch (e) {
          print(e);
        }
      }
      else{
        return result;
      }

    }
    catch (e) {
      print(e);
      return null;
    }

  }

  @override
  Future getStationIndex({Key key,double lat,double long}) async {
    try
    {
      try
      {
        authorization = await  SharedPreferencesFile().readStr(accessTokenC);
        // authorization = "edeb4735-12b6-4ca9-b1ed-02bee7220806";
      }
      catch (e) {
        print(e);
      }
      String url = getStoreIndexC;

      if(long != null){
        url = url+ "$long/";
      }
      if(lat != null){
        url = url+ "$lat";
      }
      var result = await  ApiRequestMain().apiRequestGetAuthorize(url, null, false, authorization);
      StoreIndexBean mStoreIndexBean;
      if (result.success && result.responseData != null) {
        projectUtil.printP("scan code", result.responseData);
        try {
          mStoreIndexBean = StoreIndexBean.fromJson(json.decode(result.responseData));
          if (mStoreIndexBean !=null) {
            return mStoreIndexBean;
          }
        } catch (e) {
          print(e);
        }
      }
      else{
        return result;
      }
    }
    catch (e) {
      print(e);
      return null;
    }

  }

  @override
  Future getStationList({Key key,double lat,double long}) async {
    try
    {
      try
      {
        authorization = await  SharedPreferencesFile().readStr(accessTokenC);
       // //authorization = "70a6ba8d-5c6e-4d23-b9df-24d61613c744";
      }
      catch (e) {
        print(e);
      }
      String url = getStationListC;

      var requestBody = {
        "longitude":long.toString(),
        "latitude":lat.toString(),
      };
      StationList mStationList;
      var result = await  ApiRequestMain().apiRequestGetAuthorize(url, requestBody, false, authorization);
      if (result.success && result.responseData != null) {
        projectUtil.printP("scan code", result.responseData);
        try {
          mStationList = StationList.fromJson(json.decode(result.responseData));
          if (mStationList !=null) {
            return mStationList;
          }
        } catch (e) {
          print(e);
        }
      }
      else{
        return result;
      }

    }
    catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future orderPowerBank({Key key, String deviceSn}) async{
// TODO: implement orderPowerBank
    try
    {
      try
      {
        authorization = await SharedPreferencesFile().readStr(accessTokenC);
      }
      catch (e) {
        print(e);
      }
      String url = orderPowerBankC;
      var requestBody = {
        "deviceSn":deviceSn,
      };
      String data = json.encode(requestBody);
      VerifyOTPBean mVerifyOTPBean;
      var result = await ApiRequestMain().apiRequestPostAuthorize(url, data, false,authorization);
      if (result.success && result.responseData != null) {
        projectUtil.printP("scan code", result.responseData);
        try {
          mVerifyOTPBean = VerifyOTPBean.fromJson(json.decode(result.responseData));
          if (mVerifyOTPBean !=null) {
            return mVerifyOTPBean;
          }
        } catch (e) {
          print(e);
        }
      }
      else{
        return result;
      }
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future validateOrder() async{
// TODO: implement orderPowerBank
    try
    {
      try
      {
        authorization = await SharedPreferencesFile().readStr(accessTokenC);
      }
      catch (e) {
        print(e);
      }
      String url = validateOrderC;

      ValidateOrderBean mValidateOrderBean;
      var result = await ApiRequestMain().apiRequestGetAuthorize(url, null, false,authorization);
      if (result.success && result.responseData != null) {
        projectUtil.printP("scan code", result.responseData);
        try {
          mValidateOrderBean = ValidateOrderBean.fromJson(json.decode(result.responseData));
          if (mValidateOrderBean !=null) {
            return mValidateOrderBean;
          }
        } catch (e) {
          print(e);
        }
      }
      else{
        return result;
      }
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future searchStation({Key key, String searchText, String page, String lat, String long,}) async {
    try
    {
      try
      {
    authorization = await  SharedPreferencesFile().readStr(accessTokenC);
    projectUtil.printP("authorization", "$authorization");
        //authorization = "70a6ba8d-5c6e-4d23-b9df-24d61613c744";
      }
      catch (e) {
        print(e);
      }
      String url = searchStationC;
      var requestBody1 ={
        "latitude": lat,
        "longitude": long,
        "name": searchText,
        "page": page
      };

     String requestBody = json.encode(requestBody1);

      StationList mStationList;
      var result = await  ApiRequestMain().apiRequestPostAuthorize(url, requestBody, false, authorization);
      if (result.success && result.responseData != null) {
        projectUtil.printP("scan code", result.responseData);
        try {
          mStationList = StationList.fromJson(json.decode(result.responseData));
          if (mStationList !=null) {
            return mStationList;
          }
        } catch (e) {
          print(e);
        }
      }
      else{
        return result;
      }

    }
    catch (e) {
      print(e);
      return null;
    }
  }

  //Get station/store detail
  @override
  Future stationDetail({Key key, String storeInfoId}) async {
    try
    {
      try
      {
         authorization = await  SharedPreferencesFile().readStr(accessTokenC);
        //authorization = "70a6ba8d-5c6e-4d23-b9df-24d61613c744";
      }
      catch (e) {
        print(e);
      }
      String url = getStationDetailC;
      if(storeInfoId!=null){
        url = url + "storeInfoId=$storeInfoId";
      }
      StationDetailBean mStationDetailBean;
      var result = await  ApiRequestMain().apiRequestGetAuthorize(url, null, false, authorization);
      if (result.success && result.responseData != null) {
        projectUtil.printP("scan code", "${result.responseData}");
        try {
          mStationDetailBean = StationDetailBean.fromJson(json.decode(result.responseData));
          if (mStationDetailBean !=null) {
            return mStationDetailBean;
          }
        } catch (e) {
          print(e);
        }
      }
      else{
        return result;
      }

    }
    catch (e) {
      print(e);
      return null;
    }
  }

  //Get rental/order records list
  @override
  getOrderDetails({Key key, String orderSn}) async {
    try
    {
      try
      {
         authorization = await  SharedPreferencesFile().readStr(accessTokenC);
         projectUtil.printP("authorization", "$authorization");
        //authorization = "70a6ba8d-5c6e-4d23-b9df-24d61613c744";
      }
      catch (e) {
        print(e);
      }
      String url = orderDetailsC;
      if(orderSn!=null){
        url = url+ "orderSn=$orderSn";

      }
      else{
        return null;
      }
      OrderDetails mOrderDetails;
      var result = await  ApiRequestMain().apiRequestGetAuthorize(url, null, false, authorization);
      if (result.success && result.responseData != null) {
        //Hide Pop up
        projectUtil.printP("Login", result.responseData);
        try {
          mOrderDetails = OrderDetails.fromJson(json.decode(result.responseData));
          if (mOrderDetails !=null) {
            return mOrderDetails;
          }
        } catch (e) {
          print(e);
          return null;
        }
      }
      else{
        return result;
      }

    }
    catch (e) {
      print(e);
      return null;
    }
  }



  //Update profile picture
  @override
  Future updateProfilePicture({Key key, String imagePath}) async {
    try {
      try
          {


            try
            {
              authorization = await  SharedPreferencesFile().readStr(accessTokenC);
              //authorization = "70a6ba8d-5c6e-4d23-b9df-24d61613c744";
            }
            catch (e) {
              print(e);
            }
            String url = updateProfilePictureC;
            //Convert image into base 64
            final bytes1 = await Io.File(imagePath).readAsBytes();
           // String  base64Encode =  await base64.encode(bytes1);

            var requestBody1 ={
                "fileBase":("data:image/jpeg;base64,"+base64.encode(bytes1))
            };
            projectUtil.printP("Request data ", "$requestBody1");
            String requestBody = json.encode(requestBody1);
            ProfileImageBean mProfileImageBean;
            var result = await  ApiRequestMain().apiRequestPostAuthorize(url, requestBody, false, authorization);
            if (result.success && result.responseData != null) {
              projectUtil.printP("scan code", "${result.responseData}");
              try {
                mProfileImageBean = ProfileImageBean.fromJson(json.decode(result.responseData));
                if (mProfileImageBean !=null) {
                  return mProfileImageBean;
                }
              } catch (e) {
                print(e);
              }
            }
            else{
              return result;
            }

          }
          catch (e) {
            print(e);
            return null;
          }
    } catch (e) {
      print(e);
    }
  }


  //Update Profile Details
  @override
  Future updateProfileDetails({Key key, String email, String name}) async {
    try
    {
      try
      {
        authorization = await  SharedPreferencesFile().readStr(accessTokenC);
        //authorization = "70a6ba8d-5c6e-4d23-b9df-24d61613c744";
      }
      catch (e) {
        print(e);
      }
      String url = updateProfileDetailsC;
      var requestBody1 ={
          "email": email,
          "nickName": name,
      };

      String requestBody = json.encode(requestBody1);
      ProfileDetailsBean  mProfileDetailsBean;
      var result = await  ApiRequestMain().apiRequestPostAuthorize(url, requestBody, false, authorization);
      if (result.success && result.responseData != null) {
        projectUtil.printP("scan code", result.responseData);
        try {
          mProfileDetailsBean = ProfileDetailsBean.fromJson(json.decode(result.responseData));
          if (mProfileDetailsBean !=null) {
            return mProfileDetailsBean;
          }
         //return json.decode(result.responseData);
        } catch (e) {
          print(e);
          return null;
        }
      }
      else{
        return result;
      }

    }
    catch (e) {
      print(e);
      return null;
    }
  }


  @override
  Future addPaymentCard({Key key, String birthNo,
  String cardNo,
  String cardPw,
  String expMonth,
  String expYear }) async{
    String userId = "";
   // TODO: implement orderPowerBank
    try
    {
      try
      {
        userId = await SharedPreferencesFile().readStr(userIdC);
      }
      catch (e) {
        print(e);
      }
      try
      {
        authorization = await SharedPreferencesFile().readStr(accessTokenC);
      }
      catch (e)
      {
        print(e);
      }
      String url = addPaymentCardC;
      if((userId!=null && userId.trim().length>0) && authorization!=null && authorization.trim().length>0){
        var requestBody = {
          "birthNo" : "$birthNo",
          "cardNo" : "$cardNo",
          "cardPw" : "$cardPw",
          "expMonth" : "$expMonth",
          "expYear" : "$expYear",
          "userId" : "$userId",
        };
        String data = json.encode(requestBody);
        AddPaymentCardBean mAddPaymentCardBean;
        var result = await ApiRequestMain().apiRequestPostAuthorize(url, data, false,authorization);
        if (result.success && result.responseData != null) {
          projectUtil.printP("scan code", result.responseData);
          try {
            mAddPaymentCardBean = AddPaymentCardBean.fromJson(json.decode(result.responseData));
            if (mAddPaymentCardBean !=null) {
              return mAddPaymentCardBean;
            }
          } catch (e) {
            print(e);
          }
        }
        else{
          return result;
        }
      }
      else{
        return null;
      }

    }
    catch (e) {
      print(e);
      return null;
    }
  }


  //Get rental/order records list
  @override
  getAddedCardInfo() async {
    try
    {
      try
      {
        authorization = await  SharedPreferencesFile().readStr(accessTokenC);
        print("token $authorization");
        //authorization = "70a6ba8d-5c6e-4d23-b9df-24d61613c744";
      }
      catch (e) {
        print(e);
      }
      String url = getAddedCardInfoC;
      /*if(orderSn!=null){
        url = url+ "orderSn=$orderSn";

      }
      else{
        return null;
      }*/
      AddedCardInfoBean mAddedCardInfoBean;
      var result = await  ApiRequestMain().apiRequestGetAuthorize(url, null, false, authorization);
      if (result.success && result.responseData != null) {
        //Hide Pop up
        projectUtil.printP("Login", result.responseData);
        try {
          mAddedCardInfoBean = AddedCardInfoBean.fromJson(json.decode(result.responseData));
          if (mAddedCardInfoBean !=null) {
            return mAddedCardInfoBean;
          }
        } catch (e) {
          print(e);
          return null;
        }
      }
      else{
        return result;
      }

    }
    catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future getNotificationList({Key key,@required int page,@required int size}) async {
    try
    {
      String userId;
      try
      {
        authorization = await  SharedPreferencesFile().readStr(accessTokenC);
        //authorization = "70a6ba8d-5c6e-4d23-b9df-24d61613c744";
      }
      catch (e) {
        print(e);
      }

      try
      {
        userId = await SharedPreferencesFile().readStr(userIdC);
      }
      catch (e) {
        print(e);
      }
      String url = getNotificationC;
      if(page!=null && userId!=null){
        url = url+ "$userId?page=$page&size=$size";
      }
      else{
        return null;
      }

      NotificationBean mNotificationBean;
      var result = await  ApiRequestMain().apiRequestGetAuthorize(url, null, false, authorization);
      if (result.success && result.responseData != null) {
        projectUtil.printP("scan code", result.responseData);
        try {
          mNotificationBean = NotificationBean.fromJson(json.decode(result.responseData));
          if (mNotificationBean !=null) {
            return mNotificationBean;
          }
        } catch (e) {
          print(e);
        }
      }
      else{
        return result;
      }

    }
    catch (e) {
      print(e);
      return null;
    }
  }


}