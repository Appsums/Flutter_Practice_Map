import 'dart:io';
import 'dart:ui';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/progress_bar_p/ProgressBar.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/qr_p/BarcodeScanner.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';


class ScanQRCode extends StatefulWidget {
  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String barcode = "";
  String barcodeForImage = "";

  GlobalKey globalKey = new GlobalKey();

  bool isDataReady = false;
  _ScanQRCodeState(){
    validateOrder();
    //scan();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
    return Container(
        color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
        child:SafeArea(
            bottom:false,
            child:Scaffold(
        appBar: BackArrowAppBar().appBarBackArrow(
            AppValuesFilesLink(context: context).appValuesString.scanQRCode,
            AppValuesFilesLink().appValuesColors.appBarTextColor[200],
            AppValuesFilesLink().appValuesColors.appBarLetIconColor[200],
            AppValuesFilesLink().appValuesColors.appBarBgColor[200],
            AppValuesFilesLink().appValuesDimens.widthDynamic(value: 22), () {
          Navigator.pop(context, true);
        }),
        body: Container(
          color: AppValuesFilesLink().appValuesColors.appBgColor[300],
          child: isDataReady?Stack(
            children: <Widget>[
            Positioned(
                child: Align(
                  alignment: Alignment.center,
                  child:
                      Container(
                          child:
                      Column( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                        (barcodeForImage!=null&&barcodeForImage.trim()!="")?QrImage(
                          data: barcodeForImage,
                          version: 4,
                          size: 200,
                          gapless: false,
                          errorStateBuilder: (cxt, err) {
                            return Container(
                              child: Center(
                                child: Text(
                                  "",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ):Container(),
                        (barcodeForImage!=null&&barcodeForImage.trim()!="")?Container(
                            child: Text("$barcode",style: TextStyle(
                                color: AppValuesFilesLink().appValuesColors.white,
                                fontSize: AppValuesFilesLink().appValuesDimens.fontSize(value: 15),
                                fontWeight: FontWeight.w500,
                                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont
                            ),
                            )
                        ):Container(),

                      ],),padding: EdgeInsets.only(bottom: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 60)),)

                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:
                  (barcodeForImage!=null&&barcodeForImage.trim()!="")?Container(
                    height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 60),
                    color: AppValuesFilesLink().appValuesColors.buttonBgColor[100],
                    child: Center(
                      child: Text("500",style: TextStyle(
                        color: AppValuesFilesLink().appValuesColors.white,
                        fontSize: AppValuesFilesLink().appValuesDimens.fontSize(value: 20),
                        fontWeight: FontWeight.w500,
                        fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont
                      ),),
                    )
                  ):Container(),
                ),
              )
            ],
          ): Center(
            child:   ProgressBar().showLoaderOnUi(false, AppValuesFilesLink().appValuesColors.loaderColor),
            ),
        ))));
  }

  //Scan bar code
  Future scan() async {
    try {

      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcodeForImage = barcode;
        this.barcode = barcode.substring(barcode.lastIndexOf("/")+1,barcode.length);
        orderPowerBank(deviceSn: this.barcode);
      });

    }catch (e) {
      try {
        if (e.code == BarcodeScanner.CameraAccessDenied) {
                setState(() {
                  this.barcode = 'The user did not grant the camera permission!';
                });
              } else {

                setState(() => this.barcode = 'Unknown error: $e');

              }
      } catch (e) {
        print(e);
        Navigator.pop(context, true);
      }
    }/* on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }*/
  }

  Future<void> orderPowerBank({String deviceSn}) async {
    new ProgressBar().showLoader(context);
    var result = await ApiRequest().orderPowerBank(deviceSn: deviceSn);
    Navigator.pop(context, true);
    if(result!=null){
      //if(result.status && result.responseData!=null){
      if(result.success && result.result!=null){
        //var data = result.result;
        Navigator.push(context, SlideRightRoute(widget:RentalRecords(comefrom: 1,))).then((value){
          if(value){
            Navigator.pop(context);
          }
        });
      }
      else{
        setState(() {
        });
        AppWidgetFilesLink().appCustomUiWidget.errorDialog(
            context,
            true,
            AppValuesFilesLink().appValuesString.appName,
            result.msg, (context1) {
          setState(() {
          });
          Navigator.pop(context1);
          if (result.statusCode == -2000) {
            exit(0);
          }
        });
      }
    }
    else{
      setState(() {
      });
      Fluttertoast.showToast(msg: "Something went wrong");
    }


  }

  Future<void> validateOrder() async {
    var result = await ApiRequest().validateOrder();
    if(result!=null){
      if(result.success && result.result!=null){
        var data = result.result;
        setState(() {
          isDataReady = true;
        });
       if(data.status!=null && data.status==1){
         //Send for scan
         scan();
       }
       else  if(data.status!=null && data.status==2){
         //Add payment method
         AppWidgetFilesLink().appCustomUiWidget.errorDialog(
             context,
             true,
             AppValuesFilesLink().appValuesString.appName,
             AppValuesFilesLink().appValuesString.addPaymentMethod, (context1) {
           Navigator.pop(context1);
           Navigator.push(context, SlideRightRoute(widget:AddCardScreen(comefrom: 1,))).then((value){
             if(value){
               Navigator.pop(context);
             }
           });
         });
       }
       else if(data.status!=null && data.status==3){
         //Send to payment screen
        Fluttertoast.showToast(msg: "Send to payment screen");
       }
       else  if(data.status!=null && data.status==4){
         AppWidgetFilesLink().appCustomUiWidget.errorDialog(
             context,
             true,
             AppValuesFilesLink().appValuesString.appName,
             AppValuesFilesLink().appValuesString.batteryRentStarted, (context1) {
           Navigator.pop(context1);
           Navigator.pop(context1);

         });
         //Show device info
        // Fluttertoast.showToast(msg: "Show device info");
       }
       else{

       }
      }
      else{
        setState(() {
          isDataReady = true;
        });
        AppWidgetFilesLink().appCustomUiWidget.errorDialog(
            context,
            true,
            AppValuesFilesLink().appValuesString.appName,
            result.msg, (context1) {
          setState(() {
          });
          Navigator.pop(context1);
          if (result.statusCode == -2000) {
            exit(0);
          }
        });
      }
    }
    else{
      setState(() {
      });
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }
}

