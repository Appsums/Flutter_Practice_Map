import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';

class PaymentCard extends StatelessWidget {
  final double borderRadius;
  final double width;
  final double height;
  final String image;
  final String cardNumber;
  final bgColor;

  PaymentCard({Key key, this.borderRadius, this.width, this.height, this.image, this.bgColor, this.cardNumber}) : super(key: key);

  @override
  Widget build(BuildContext context){

    String bankName ="BankName";
    String cardNUmber ="•••• ${(cardNumber!=null&&cardNumber.length>6)?cardNumber.substring(cardNumber.length - 4):cardNumber}";
    String bankImage ="assets/images/home/payment_info/bank_image.svg";

    //Main card view top
    Widget mainCardTopView  =   Container(
    padding: EdgeInsets.only(
    bottom: 28,),child: Container(
      padding: const EdgeInsets.all(8.0),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(borderRadius!=null?borderRadius:5)),
          gradient: new LinearGradient(
              colors: [
                Color(0xFF47187E),
                Color(0xFF9129A9),
              ],
              begin: const FractionalOffset(0.5, 1.0),
              end: const FractionalOffset(0.0, 0.75),
              stops: [0.0, 0.9],
              tileMode: TileMode.clamp)),
    child:  Align(
    alignment: Alignment.center,
    child:
    Container(
      padding: EdgeInsets.only(top: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 22),bottom: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 22),
        left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 22),right: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 22),),
      child: Stack(
      children: <Widget>[
        Positioned(
        child: Align(
          alignment: Alignment.topLeft,
          child:
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(

                child: SvgPicture.asset(
                    bankImage,
                  width: AppValuesFilesLink().appValuesDimens.widthDynamic(value: 25),
                  height: AppValuesFilesLink().appValuesDimens.widthDynamic(value: 25),fit: BoxFit.scaleDown),
              ),
                Container(
                  margin: EdgeInsets.only(left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 5)),
                  child: Text(
                    bankName,
                    style: TextStyle(
                        fontSize: AppValuesFilesLink().appValuesDimens.fontSize(value: 20),
                        fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                        fontWeight: FontWeight.w600,
                        color: AppValuesFilesLink().appValuesColors.textSubHeadingColor[200]),),
                )
            ],),
          ),
        ),
      ),
        Positioned(
        child: Align(
          alignment: Alignment.bottomCenter,
          child:
          Container(
            child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
            Text(
              cardNUmber,
                style: TextStyle(
                    fontSize: AppValuesFilesLink().appValuesDimens.fontSize(value: 20),
                    fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                    fontWeight: FontWeight.w600,
                    color: AppValuesFilesLink().appValuesColors.textSubHeadingColor[200]),),
            Container(child:
            Stack(children: <Widget>[
              Container(

                  width: 40.0,
                  height: 40.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppValuesFilesLink().appValuesColors.circleColor[300]
                  )),
              Container(
                  margin: EdgeInsets.only(left: 25),
                  width: 40.0,
                  height: 40.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppValuesFilesLink().appValuesColors.circleColor[300]
                  )),
              ],),),
            ],),)
        ),
      )]),)),

    ),);
    return Container(height: height!=null?height:0,width: width!=null?width:0,child:
    Align(
        alignment: Alignment.center,
        child:
        Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 0,right: 30,left: 30),child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(borderRadius!=null?borderRadius:5)),
                gradient: new LinearGradient(
                    colors: [
                      Color(0xFFA92929),
                      Color(0xFF7E1818),
                    ],
                    begin: const FractionalOffset(0.5, 1.0),
                    end: const FractionalOffset(0.0, 0.75),
                    stops: [0.0, 0.9],
                    tileMode: TileMode.clamp)),
            child:  Align(
                alignment: Alignment.center,
                child:
                Container()),
          ),),
          Container(
            padding: EdgeInsets.only(
              bottom: 12,left: 20,right: 20),child:Container(
            padding: const EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(borderRadius!=null?borderRadius:5)),
                gradient: new LinearGradient(
                    colors: [
                      Color(0xFF295EA9),
                      Color(0xFF18427E),
                    ],
                    begin: const FractionalOffset(0.5, 1.0),
                    end: const FractionalOffset(0.0, 0.75),
                    stops: [0.0, 0.9],
                    tileMode: TileMode.clamp)),
            child:  Align(
                alignment: Alignment.center,
                child:
                Container()),
          ),),
          mainCardTopView
        ],)),);
  }

}
