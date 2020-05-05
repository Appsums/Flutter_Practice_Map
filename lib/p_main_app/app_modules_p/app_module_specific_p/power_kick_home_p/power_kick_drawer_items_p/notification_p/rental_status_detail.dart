import 'dart:io';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/app_modules_p/app_module_specific_p/power_kick_home_p/power_kick_drawer_items_p/power_kick_rental_records_p/rental_record_bean/order_details.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RentalStatusDetailScreen extends StatefulWidget {
  final String orderSn;

  RentalStatusDetailScreen({Key key, this.orderSn}) : super(key: key);

  @override
  _RentalStatusDetailScreenState createState() => _RentalStatusDetailScreenState(orderSn: this.orderSn);
}

class _RentalStatusDetailScreenState extends State<RentalStatusDetailScreen> {
   Result mResult;
   String orderSn;
   bool isDataReady = false;
   _RentalStatusDetailScreenState({Key key, this.orderSn}){
    getOrderDetails(orderSn: orderSn);
  }

  @override
  Widget build(BuildContext context) {
    //Rental record row
    Widget _buildDetailRow(type, value,{valueColor,valueTextSize,fontWeight}) {
      return
        Container(
        color: AppValuesFilesLink().appValuesColors.white,
        padding: EdgeInsets.fromLTRB(
          AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 0),
          AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 10),
          AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 0),
          AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              type ?? "",
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w600,
                  fontSize:
                      AppValuesFilesLink().appValuesDimens.fontSize(value: 16),
                  color: AppValuesFilesLink().appValuesColors.textNormalColor[100]),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child:  Html(
                    data: value??'',

                    customTextAlign:  (node) {
                      return TextAlign.right;
                    },
                    defaultTextStyle:  TextStyle(

                        fontFamily:
                        AppValuesFilesLink().appValuesFonts.defaultFont,
                        fontWeight: fontWeight!=null?fontWeight:FontWeight.w600,
                        fontSize: AppValuesFilesLink()
                            .appValuesDimens
                            .fontSize(value: valueTextSize!=null?valueTextSize:14),
                        color: valueColor!=null?valueColor:AppValuesFilesLink()
                            .appValuesColors
                            .textSubHeadingColor[100]),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
 Widget _buildDetailRow1(type, value,{valueColor,valueTextSize,fontWeight}) {
      return
        Container(
        color: AppValuesFilesLink().appValuesColors.white,
        padding: EdgeInsets.fromLTRB(
          AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 0),
          AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 0),
          AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 0),
          AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              type ?? "",
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w600,
                  fontSize:
                      AppValuesFilesLink().appValuesDimens.fontSize(value: 16),
                  color: AppValuesFilesLink().appValuesColors.textNormalColor[100]),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child:  Html(
                    data: value??'',

                    customTextAlign:  (node) {
                      return TextAlign.right;
                    },
                    defaultTextStyle:  TextStyle(

                        fontFamily:
                        AppValuesFilesLink().appValuesFonts.defaultFont,
                        fontWeight: fontWeight!=null?fontWeight:FontWeight.w600,
                        fontSize: AppValuesFilesLink()
                            .appValuesDimens
                            .fontSize(value: valueTextSize!=null?valueTextSize:14),
                        color: valueColor!=null?valueColor:AppValuesFilesLink()
                            .appValuesColors
                            .textSubHeadingColor[100]),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }


    //Rental record row
    Widget _buildDetailRowNew(label,value,value2) {
      return
        Container(
          color: AppValuesFilesLink().appValuesColors.white,
          padding: EdgeInsets.fromLTRB(
            AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 0),
            AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 12),
            AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 0),
            AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Expanded(
            flex: 17,
          child:
          Text(
                label ?? "",
                style: TextStyle(
                    fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                    fontWeight: FontWeight.w600,
                    fontSize:
                    AppValuesFilesLink().appValuesDimens.fontSize(value: 15),
                    color: AppValuesFilesLink().appValuesColors.textNormalColor[100]),
              )),
              Expanded(
                flex: 83,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child:  Html(
                          data: value??'',

                          customTextAlign:  (node) {
                            return TextAlign.left;
                          },
                          defaultTextStyle:  TextStyle(
                              fontFamily:
                              AppValuesFilesLink().appValuesFonts.defaultFont,
                              fontWeight: FontWeight.w600,
                              fontSize: AppValuesFilesLink()
                                  .appValuesDimens
                                  .fontSize(value: 14),
                              color: AppValuesFilesLink()
                                  .appValuesColors
                                  .textSubHeadingColor[100]),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child:  Html(
                          data: value2??'',

                          customTextAlign:  (node) {
                            return TextAlign.left;
                          },
                          defaultTextStyle:  TextStyle(

                              fontFamily:
                              AppValuesFilesLink().appValuesFonts.defaultFont,
                              fontWeight: FontWeight.w600,
                              fontSize: AppValuesFilesLink()
                                  .appValuesDimens
                                  .fontSize(value: 14),
                              color: AppValuesFilesLink()
                                  .appValuesColors
                                  .textSubHeadingColor[100]),
                        ),
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        );
    }


    //Divider
    Widget divider = Container(
      margin: EdgeInsets.only(top: 10,bottom: 10),
      height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 0.3),
      decoration: BoxDecoration(
        color: AppValuesFilesLink().appValuesColors.drawerDividerColor[500],
        shape: BoxShape.rectangle,
      ),
    );

    //Rental  detail view
    Widget rentalDetailsView() {

      String orderStatus =  "${mResult.orderStatus}";
      orderStatus = orderStatus!=null?orderStatus:"";

      String
          usageTime = "${mResult.usingTime}m",
          rentalLocation = "${mResult.backAddress}",
          rent = "${mResult.rentTime}",
          returnText = "${mResult.backTime}",
          amountDue = orderStatus.toLowerCase()=="done"?"&#65510;0":"&#65510;${double.parse(mResult.money).toInt()}",
          amountPaid = orderStatus.toLowerCase()=="done"?"&#65510;${mResult.orderStoreSnapshot.price.toInt()}":"&#65510;0";

      return Container(
        color: AppValuesFilesLink().appValuesColors.white,
        padding: EdgeInsets.only(
          top: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
          left: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
          right: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
        ),
        child: Column(
          children: <Widget>[
            _buildDetailRowNew(
                AppValuesFilesLink().appValuesString.rent, rent,rentalLocation),

            _buildDetailRowNew(
                AppValuesFilesLink().appValuesString.returnText, returnText,rentalLocation),
            divider,

            _buildDetailRow(
                AppValuesFilesLink().appValuesString.timeDuration, usageTime),
            _buildDetailRow(
                AppValuesFilesLink().appValuesString.totalAmountDue, amountDue),

            _buildDetailRow(
                AppValuesFilesLink().appValuesString.discount, amountDue,valueColor: AppValuesFilesLink().appValuesColors.textSubHeadingColor[300]),

            _buildDetailRow1("", AppValuesFilesLink().appValuesString.couponUsed,valueTextSize: 14.0),

            divider,

            _buildDetailRow(
                AppValuesFilesLink().appValuesString.amountPaid, amountPaid,fontWeight: FontWeight.w700,valueTextSize: 18.0),

/*
            _buildDetailRow(
                AppValuesFilesLink().appValuesString.rentalType, rentalType),
            divider,
            _buildDetailRow(AppValuesFilesLink().appValuesString.paymentMethod,
                paymnetMethod),
            divider,
            *//*_buildDetailRow(
                AppValuesFilesLink().appValuesString.rentalType, rentalType),
            divider,*//*

            _buildDetailRow(AppValuesFilesLink().appValuesString.rentalLocation,
                rentalLocation),
            divider,
            _buildDetailRow(AppValuesFilesLink().appValuesString.rent, rent),
            divider,
            _buildDetailRow(
                AppValuesFilesLink().appValuesString.returnText, returnText),
            divider,

            _buildDetailRow(
                AppValuesFilesLink().appValuesString.amountPaid, amountPaid),*/
          ],
        ),
      );
    }


    return Container(
      color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
      child:SafeArea(
          bottom: false,
          child:Scaffold(
        appBar: BackArrowAppBar().appBarBackArrow(
            AppValuesFilesLink(context: context).appValuesString.orderComplete,
            AppValuesFilesLink().appValuesColors.appBarTextColor[200],
            AppValuesFilesLink().appValuesColors.appBarLetIconColor[200],
            AppValuesFilesLink().appValuesColors.appBarBgColor[200],
            AppValuesFilesLink().appValuesDimens.widthDynamic(value: 22), () {
          Navigator.pop(context, true);
        }),
        body: Container(
          color: AppValuesFilesLink().appValuesColors.appBgColor[100],
          child:
          (isDataReady&&mResult!=null)? ListView(
            children: <Widget>[

              rentalDetailsView(),
              //divider,
              //rentalCompleteText()
            ],
          ):
          !isDataReady?Center(child:ProgressBar().showLoaderOnUi(false, AppValuesFilesLink().appValuesColors.loaderColor),):AppWidgetFilesLink().appCustomUiWidget.noDataFound(MediaQuery.of(context).size.height)),
        )));
  }

  Future<void> getOrderDetails({String orderSn}) async {

    ApiRequest().getOrderDetails(orderSn:orderSn).then((result){
      if(result!=null){
        //if(result.status && result.responseData!=null){
        if(result.success && result.result!=null){
          try {
            setState(() {
              isDataReady = true;
              mResult = result.result;
            });
          }
          catch (e) {
            print(e);
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
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });


  }

}
