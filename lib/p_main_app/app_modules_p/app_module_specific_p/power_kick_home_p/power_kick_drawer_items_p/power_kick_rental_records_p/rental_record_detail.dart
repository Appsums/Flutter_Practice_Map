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

class RentalRecordDetail extends StatefulWidget {
  final String orderSn;

  RentalRecordDetail({Key key, this.orderSn}) : super(key: key);

  @override
  _RentalRecordDetailState createState() => _RentalRecordDetailState(orderSn: this.orderSn);
}

class _RentalRecordDetailState extends State<RentalRecordDetail> {
   Result mResult;
   String orderSn;
   bool isDataReady = false;
  _RentalRecordDetailState({Key key, this.orderSn}){
    getOrderDetails(orderSn: orderSn);
  }

  @override
  Widget build(BuildContext context) {
    //Rental record row
    Widget _buildDetailRow(type, value) {
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
            Text(
              type ?? "",
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w600,
                  fontSize:
                      AppValuesFilesLink().appValuesDimens.fontSize(value: 15),
                  color: AppValuesFilesLink().appValuesColors.textNormalColor),
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
                        fontWeight: FontWeight.w500,
                        fontSize: AppValuesFilesLink()
                            .appValuesDimens
                            .fontSize(value: 14),
                        color: AppValuesFilesLink()
                            .appValuesColors
                            .textNormalColor[100]),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    //Divider
    Widget divider = Container(
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

      String rentalType = "${mResult.deviceType.value}",
          paymnetMethod = "Debit Card ** 0024",
          usageTime = "${mResult.usingTime} hour",
          rentalLocation = "${mResult.backAddress}",
          rent = "${mResult.rentTime}",
          returnText = "${mResult.backTime}",
          amountDue = orderStatus.toLowerCase()=="done"?"&#65510; 0":"&#65510; ${mResult.money!=null?double.parse(mResult.money).toInt():0}",
          amountPaid = orderStatus.toLowerCase()=="done"?"&#65510; ${mResult.money!=null?double.parse(mResult.money).toInt():0}":"&#65510; 0";

      return Container(
        color: AppValuesFilesLink().appValuesColors.white,
        padding: EdgeInsets.only(
          left: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
          right: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
        ),
        child: Column(
          children: <Widget>[
            _buildDetailRow(
                AppValuesFilesLink().appValuesString.rentalType, rentalType),
            divider,
            _buildDetailRow(AppValuesFilesLink().appValuesString.paymentMethod,
                paymnetMethod),
            divider,
            /*_buildDetailRow(
                AppValuesFilesLink().appValuesString.rentalType, rentalType),
            divider,*/
            _buildDetailRow(
                AppValuesFilesLink().appValuesString.usageTime, usageTime),
            divider,
            _buildDetailRow(AppValuesFilesLink().appValuesString.rentalLocation,
                rentalLocation),
            divider,
            _buildDetailRow(AppValuesFilesLink().appValuesString.rent, rent),
            divider,
            _buildDetailRow(
                AppValuesFilesLink().appValuesString.returnText, returnText),
            divider,
            _buildDetailRow(
                AppValuesFilesLink().appValuesString.amountDue, amountDue),
            divider,
            _buildDetailRow(
                AppValuesFilesLink().appValuesString.amountPaid, amountPaid),
          ],
        ),
      );
    }

    Widget rentalDetailText() {
      return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(
            AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 20),
            AppValuesFilesLink()
                .appValuesDimens
                .verticalMarginPadding(value: 20),
            AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 20),
            AppValuesFilesLink()
                .appValuesDimens
                .verticalMarginPadding(value: 14),
          ),
          child: Text(
            AppValuesFilesLink().appValuesString.rentalDetails,
            style: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                fontWeight: FontWeight.w300,
                fontSize:
                    AppValuesFilesLink().appValuesDimens.fontSize(value: 16),
                color:
                    AppValuesFilesLink().appValuesColors.textNormalColor[500]),
          ));
    }

    Widget rentalCompleteText() {
      String orderStatus =  "${mResult.orderStatus}";
      orderStatus = orderStatus!=null?orderStatus:"";

      return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(
            AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 20),
            AppValuesFilesLink()
                .appValuesDimens
                .verticalMarginPadding(value: 30),
            AppValuesFilesLink()
                .appValuesDimens
                .horizontalMarginPadding(value: 20),
            AppValuesFilesLink()
                .appValuesDimens
                .verticalMarginPadding(value: 12),
          ),
          child: Text(
            orderStatus.toLowerCase()=="done"?AppValuesFilesLink().appValuesString.rentalCompleteText:AppValuesFilesLink().appValuesString.rentalWaitingText,
            style: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                fontWeight: FontWeight.w300,
                fontSize:
                    AppValuesFilesLink().appValuesDimens.fontSize(value: 13),
                color:
                    AppValuesFilesLink().appValuesColors.textNormalColor[500]),
          ));
    }

    return Container(
      color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
      child:SafeArea(
          bottom: false,
          child:Scaffold(
        appBar: BackArrowAppBar().appBarBackArrow(
            AppValuesFilesLink(context: context).appValuesString.rentalInfo,
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
              rentalDetailText(),
              divider,
              rentalDetailsView(),
              divider,
              rentalCompleteText()
            ],
          ):
          !isDataReady?Center(child:ProgressBar().showLoaderOnUi(false, AppValuesFilesLink().appValuesColors.loaderColor),):AppWidgetFilesLink().appCustomUiWidget.noDataFound(MediaQuery.of(context).size.height)),
        )));
  }

  Future<void> getOrderDetails({String orderSn}) async {

    var result = await ApiRequest().getOrderDetails(orderSn:orderSn);

    if(result!=null){
      //if(result.status && result.responseData!=null){
      if(result.success && result.result!=null){
        try {
          setState(() {
            mResult = result.result;
          });
        }
        catch (e) {
          print(e);
        }

        setState((){
          isDataReady = true;
        });
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
  }

}
