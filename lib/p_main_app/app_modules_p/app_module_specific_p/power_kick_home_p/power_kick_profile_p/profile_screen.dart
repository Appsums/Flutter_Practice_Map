import 'dart:io';
import 'package:baseapp/p_main_app/api_calling_p/LocalConstant.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/api_constant.dart';
import 'package:baseapp/p_main_app/api_calling_p/pre_default_app_module_p/app_api_function.dart';
import 'package:baseapp/p_main_app/app_widgets_p/pre_default_app_widgets_p/take_photo_with_crop.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var screenSize, screenHeight, screenWidth;

  String _profileImage,userName,
      firstName = "",
      lastName = "",
      email = "",
      id = "",
      phone = "";

  bool isDataReady = true;
  bool isEdit = false;

  int showHideEditProfileSheet = 0;

  _ProfileScreenState(){
    getProfileData();
  }


  Map<String, TextEditingController> controllers = {
    'name': new TextEditingController(),
    'email': new TextEditingController(),
  };

  Map<String, FocusNode> focusNodes = {
    'name': new FocusNode(),
    'email': new FocusNode(),
  };

  Map<String, String> errorMessages = {
    'name': null,
    'email': null,
  };

 @override
  void dispose() {
   controllers['name'].dispose();
   controllers['email'].dispose();
   focusNodes['name'].dispose();
   focusNodes['email'].dispose();
    super.dispose();
  }

  void getProfileData() {
    SharedPreferencesFile().readStr(nameC).then((value){
      setState(() {
        firstName = value??"";
        if(firstName!=null && lastName!=null){
          setState(() {
            controllers['name'].text = '$firstName $lastName';
          });
        }else if(firstName!=null ){
          setState(() {
            controllers['name'].text = '$firstName';
          });
        }else if(lastName!=null ){
          setState(() {
            controllers['name'].text = '$lastName';
          });
        }else{
          setState(() {
            controllers['name'].text = '';
          });
        }
      });
    });
    SharedPreferencesFile().readStr(userProfileImageC).then((value){
      setState(() {
        _profileImage = ConstantC.baseImageUrl+value??"";
      });
    });

    SharedPreferencesFile().readStr(emailC).then((value){
      setState(() {
        controllers['email'].text = value??"";
      });
    });

    SharedPreferencesFile().readStr(userIdC).then((value){
      setState(() {
        id = value??"";
      });
    });

    SharedPreferencesFile().readStr(nationMobileC).then((value){
      setState(() {
        phone = value??"";
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size; //Screen height
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;

    Future<void> updateProfilePicture({String imagePath}) async {
      setState((){
        isDataReady = false;
      });
      var result = await ApiRequest().updateProfilePicture(imagePath: imagePath);

      if(result!=null){
        if(result.success && result.result!=null){
          setState(()  {
            isDataReady = true;
            isEdit = false;
            Fluttertoast.showToast(msg: AppValuesFilesLink().appValuesString.avatarUploaded);
            SharedPreferencesFile().saveStr(userProfileImageC, result.result);
          });
        }
        else
          {
          setState((){
            isDataReady = true;
          });
          AppWidgetFilesLink().appCustomUiWidget.errorDialog(context, true, AppValuesFilesLink().appValuesString.appName,
              result.msg, (context1) {
            Navigator.pop(context1);
            if (result.statusCode == -2000) {
              exit(0);
            }
          });
        }
      }
      else{
        setState((){
          isDataReady = true;
        });
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    }


    Future<void> updateProfileDetails({String name,String email}) async {
      setState((){
        isDataReady = false;
      });
      var result = await ApiRequest().updateProfileDetails(email: email,name: name);

      if(result!=null){
        if(result.success && result.result!=null){
          setState(()  {
            isDataReady = true;
              isEdit = false;

              Fluttertoast.showToast(msg: "${result.result}");
            SharedPreferencesFile().saveStr(nameC, name);

            SharedPreferencesFile().saveStr(emailC, email);
         getProfileData();

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
        setState((){
          isDataReady = true;
        });
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    }

    //Error message pop up
    _showErrorPopUp(errorMessage){
      AppWidgetFilesLink().appCustomUiWidget.errorDialog(context, false, AppValuesFilesLink().appValuesString.appName,          errorMessage, (context1){
        Navigator.pop(context1);
      });
    }

    //Check input fields
    bool _validateFields() {
      if(controllers['name'].text==null || controllers['name'].text=='' ){
        _showErrorPopUp(AppValuesFilesLink().appValuesString.nameNotBlank);
        return false;
      }else if(!Validation().restrictNumbersOnly(controllers['name'].text)){
        _showErrorPopUp(AppValuesFilesLink().appValuesString.validName);
        return false;
      }
      else if(controllers['email'].text==null || controllers['email'].text=='' ){
        _showErrorPopUp(AppValuesFilesLink().appValuesString.emailNotBlank);
        return false;
      }else if(!Validation().validateEmail(controllers['email'].text)){
        _showErrorPopUp(AppValuesFilesLink().appValuesString.validEmail);
        return false;
      }
      else{
        return true;
      }
    }

    //App bar right field
    List<Widget>  appBarRightIcons =  <Widget>[
      GestureDetector(
        onTap: (){
          if(isEdit){
            if (_validateFields()) {
              //  Fluttertoast.showToast(msg: "All fields true");
              updateProfileDetails(email: controllers['email'].text.toString().trim(),name: controllers['name'].text.toString().trim());
            }
          }
          else{

          }
          setState(() {
            isEdit = true;
          });
        },
        child:   Container(
            color:AppValuesFilesLink().appValuesColors.appTransColor[700],
            width: AppValuesFilesLink().appValuesDimens.widthDynamic(value: 60),
            height: AppValuesFilesLink().appValuesDimens.widthDynamic(value: 20),
            margin: EdgeInsets.only(right: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(value: 10)),
            child: Center(
              child:Text(
                isEdit?(!isDataReady?"":AppValuesFilesLink().appValuesString.save):AppValuesFilesLink().appValuesString.edit,
                style: TextStyle(
                    fontSize: AppValuesFilesLink().appValuesDimens.fontSize(value: 16),
                    fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                    color: AppValuesFilesLink().appValuesColors.textNormalColor[700]),),
            )
        ),
      )

    ];

    //Divider
    Widget divider = Padding(
        padding: EdgeInsets.only(
          left: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
          right: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
        ),
        child: Container(
          height:
          AppValuesFilesLink().appValuesDimens.heightDynamic(value: 0.3),
          decoration: BoxDecoration(
            color: AppValuesFilesLink().appValuesColors.drawerDividerColor[500],
            shape: BoxShape.rectangle,
          ),
        ));

    //User image view
    Widget userImageView = GestureDetector(
      onTap: (){

      },
        child:Container(
          height: screenHeight / 4.5,
          width: screenHeight / 5,
          child: Stack(children: <Widget>[
            Container(
              //color: Colors.red,
              height: screenHeight / 4.5,
              child: Center(
                child: AppWidgetFilesLink().appCustomUiWidget.circularImageView(
                    screenHeight / 6.5, screenHeight / 6.5, _profileImage),
              ),
            ),
            Positioned(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: (){
                      //open options bottom sheet
                      AppWidgetFilesLink().appCustomUiWidget.hideKeyboard(context);
                      TakePhotoWithCrop(context: context).takeMediaBottomSheet(
                          ratio: 1,
                          isCroupViewShow: isCroupViewShow,
                          callBackIsCroupView: () {
                            setState(() {
                              isCroupViewShow = true;
                            });
                          },
                          backPress: () {
                            Navigator.pop(context, true);
                          },
                          callBack: (imageFileTemp, imagePathTemp) {
                            showHideEditProfileSheet = 0;
                            if (imageFileTemp != null && imagePathTemp != null) {
                              setState(() {
                                imageFile = imageFileTemp;
                                _profileImage = imagePathTemp;
                                updateProfilePicture(imagePath:_profileImage??"" );
                              });
                            }
                          });
                    },
                    child:Container(
                      // color: Colors.amber,
                      width: screenHeight/12,
                      height: screenHeight/10,
                      padding: EdgeInsets.only(left: 15,top: 9),
                      margin: EdgeInsets.only(top: 20,),
                      alignment: Alignment.bottomRight,
                      child:
                      isEdit?
                      Icon(Icons.camera_alt,size:35 ,color: AppValuesFilesLink().appValuesColors.textNormalColor[200],):Container(),
                    ),
                  )
              ),
            )
          ],)
        )
    );

    //User name field
    Widget userNameField() {

      return Container(
        color: AppValuesFilesLink().appValuesColors.white,
        height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 55),
        padding: EdgeInsets.only(
          top: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 0),
          bottom: AppValuesFilesLink()
              .appValuesDimens
              .verticalMarginPadding(value: 0),
          left: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
          right: AppValuesFilesLink()
              .appValuesDimens
              .horizontalMarginPadding(value: 20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              AppValuesFilesLink().appValuesString.name,
              style: TextStyle(
                  fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                  fontWeight: FontWeight.w500,
                  fontSize:
                  AppValuesFilesLink().appValuesDimens.fontSize(value: 17),
                  color: AppValuesFilesLink().appValuesColors.textNormalColor),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: EdgeInsets.only(left:AppValuesFilesLink().appValuesDimens.fontSize(value: 17),right:0,top:AppValuesFilesLink().appValuesDimens.fontSize(value: 15)),
                    child: AppWidgetFilesLink().mTextInputFieldWithoutError(
                        keyboardType: TEXT_INPUT,
                        inputAction: NEXT,
                        maxLength: NAME_MAX_LENGTH,
                        maxLines: 1,
                        readOnly: !isEdit,
                        focusNode:  focusNodes['name'],
                        controller: controllers['name'],
                        cursorColor: AppValuesFilesLink().appValuesColors.textNormalColor[500],
                        textColor: AppValuesFilesLink().appValuesColors.textNormalColor[500],
                        hint: "",
                        fontSize: AppValuesFilesLink()
                            .appValuesDimens
                            .fontSize(value: 17),
                        suffixIcon:(isEdit && controllers['name'].text.toString().trim().length >0)
                            ? GestureDetector(
                          onTap: () {
                            setState(() {
                              controllers['name'].text = "";
                            });
                          },
                          child: Container(
                            width: 10,
                            padding: EdgeInsets.fromLTRB(
                              AppValuesFilesLink()
                                  .appValuesDimens
                                  .verticalMarginPadding(value: 5),
                              AppValuesFilesLink()
                                  .appValuesDimens
                                  .verticalMarginPadding(value: 5),
                              AppValuesFilesLink()
                                  .appValuesDimens
                                  .verticalMarginPadding(value: 0),
                              AppValuesFilesLink()
                                  .appValuesDimens
                                  .verticalMarginPadding(value: 17),
                            ),
                            child: Image(
                              image: AssetImage(
                                  'assets/images/home/cross@3x.png'),
                              width: 0,
                              height: 0,
                            ),
                          ),
                        )
                            : null,
                        ontextChanged: (value){
                          if(value!=null && value!=""){
                            setState((){
                            });
                          }else{
                            setState((){
                            });
                          }
                        },
                        onSubmit: (value){

                          setState(() {
                            controllers['name'].text = value;
                          });
                          FocusScope.of(context).requestFocus( focusNodes['email']);
                        })

                ),
              ),
            )
          ],
        ),
      );
    }

    //User email field
    Widget emailField = Container(
      height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 55),
      color: AppValuesFilesLink().appValuesColors.white,
      padding: EdgeInsets.only(
        top: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 0),
        bottom: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 0),
        left: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
        right: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            AppValuesFilesLink().appValuesString.email,
            style: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                fontWeight: FontWeight.w500,
                fontSize:
                AppValuesFilesLink().appValuesDimens.fontSize(value: 17),
                color: AppValuesFilesLink().appValuesColors.textNormalColor),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(left:AppValuesFilesLink().appValuesDimens.fontSize(value: 17),top:AppValuesFilesLink().appValuesDimens.fontSize(value: 15)),
                  child: AppWidgetFilesLink().mTextInputFieldWithoutError(
                      keyboardType: TEXT_INPUT,
                      inputAction: DONE,
                      maxLength: NAME_MAX_LENGTH,
                      maxLines: 1,
                      readOnly: !isEdit,
                      focusNode: focusNodes['email'],
                      controller: controllers['email'],
                      cursorColor: AppValuesFilesLink().appValuesColors.textNormalColor[500],
                      textColor: AppValuesFilesLink().appValuesColors.textNormalColor[500],
                      hint: "",
                      fontSize: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 17),
                      suffixIcon:(isEdit && controllers['email'].text.toString().trim().length >0)
                          ? GestureDetector(
                        onTap: () {
                          setState(() {
                            controllers['email'].text = "";
                          });

                        },
                        child: Container(
                          height: 0,
                          padding: EdgeInsets.fromLTRB(
                            AppValuesFilesLink()
                                .appValuesDimens
                                .verticalMarginPadding(value: 5),
                            AppValuesFilesLink()
                                .appValuesDimens
                                .verticalMarginPadding(value: 5),
                            AppValuesFilesLink()
                                .appValuesDimens
                                .verticalMarginPadding(value: 0),
                            AppValuesFilesLink()
                                .appValuesDimens
                                .verticalMarginPadding(value: 17),
                          ),
                          child: Image(
                            image: AssetImage(
                                'assets/images/home/cross@3x.png'),
                            width: 0,
                            height: 0,
                          ),
                        ),
                      )
                          : null,
                      ontextChanged: (value){
                        if(value!=null && value!=""){
                          setState((){
                          });
                        }else{
                          setState((){
                          });
                        }
                      },
                      onSubmit: (value){
                        FocusScope.of(context).requestFocus( new FocusNode());
                        setState(() {
                          controllers['email'].text = value;
                        });
                      })

              ),
            ),
          )
        ],
      ),
    );

    //User id field
    Widget idField = Container(
      color: AppValuesFilesLink().appValuesColors.white,
      padding: EdgeInsets.only(
        top: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 14),
        bottom: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 14),
        left: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
        right: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppValuesFilesLink().appValuesString.id,
            style: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                fontWeight: FontWeight.w500,
                fontSize:
                AppValuesFilesLink().appValuesDimens.fontSize(value: 17),
                color: AppValuesFilesLink().appValuesColors.textNormalColor),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  id??"",
                  style: TextStyle(
                      fontFamily:
                      AppValuesFilesLink().appValuesFonts.defaultFont,
                      fontWeight: FontWeight.w400,
                      fontSize: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 17),
                      color: AppValuesFilesLink()
                          .appValuesColors
                          .textNormalColor[500]),
                ),
              ),
            ),
          )
        ],
      ),
    );

    //User phone field
    Widget phoneField = Container(
      color: AppValuesFilesLink().appValuesColors.white,
      padding: EdgeInsets.only(
        top: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 14),
        bottom: AppValuesFilesLink()
            .appValuesDimens
            .verticalMarginPadding(value: 14),
        left: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
        right: AppValuesFilesLink()
            .appValuesDimens
            .horizontalMarginPadding(value: 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppValuesFilesLink().appValuesString.phone,
            style: TextStyle(
                fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                fontWeight: FontWeight.w500,
                fontSize:
                AppValuesFilesLink().appValuesDimens.fontSize(value: 17),
                color: AppValuesFilesLink().appValuesColors.textNormalColor),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  phone??'',
                  style: TextStyle(
                      fontFamily:
                      AppValuesFilesLink().appValuesFonts.defaultFont,
                      fontWeight: FontWeight.w400,
                      fontSize: AppValuesFilesLink()
                          .appValuesDimens
                          .fontSize(value: 17),
                      color: AppValuesFilesLink()
                          .appValuesColors
                          .textNormalColor[500]),
                ),
              ),
            ),
          )
        ],
      ),
    );

    //User detail view
    Widget userDetailView(){
      return  Container(
        color: AppValuesFilesLink().appValuesColors.white,
        child: Column(
          children: <Widget>[
            userNameField(),
            divider,
            emailField,
            divider,
            idField,
            divider,
            phoneField,
            divider,
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: (){
         Navigator.pop(context,true);
         return Future.value(false);
      },
      child: Container(
          color: AppValuesFilesLink().appValuesColors.appStatusBarColor[700],
          child:SafeArea(
              bottom: false,
              child:Scaffold(
                  appBar: BackArrowWithRightIcon().appBarBackArrowWithRightTittle(
                      AppValuesFilesLink().appValuesString.basicInfo,
                      AppValuesFilesLink().appValuesColors.appBarTextColor[200],
                      AppValuesFilesLink().appValuesColors.appBarLetIconColor[200],
                      appBarRightIcons,
                      AppValuesFilesLink().appValuesColors.appBarBgColor[200],
                      AppValuesFilesLink().appValuesDimens.widthDynamic(value: 22), (){
                    Navigator.pop(context,true);
                  }),
                  body: Container(
                      color: AppValuesFilesLink().appValuesColors.appBgColor[600],
                      child: isDataReady? ListView(
                        children: <Widget>[

                          Column(
                            children: <Widget>[
                              userImageView,
                              Container(
                                height: AppValuesFilesLink()
                                    .appValuesDimens
                                    .heightDynamic(value: 0.3),
                                decoration: BoxDecoration(
                                  color: AppValuesFilesLink()
                                      .appValuesColors
                                      .drawerDividerColor[500],
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                              userDetailView(),
                            ],
                          ),

                        /* isEdit?  Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 120),
                                    height: AppValuesFilesLink()
                                        .appValuesDimens
                                        .heightDynamic(value: 45),
                                    width: AppValuesFilesLink()
                                        .appValuesDimens
                                        .widthDynamic(value: 140),
                                    child: AppWidgetFilesLink()
                                        .appCustomUiWidget
                                        .buttonRoundCornerWithFontWeightBg(
                                        AppValuesFilesLink()
                                            .appValuesString
                                            .saveChanges,
                                        AppValuesFilesLink().appValuesColors.white,
                                        AppValuesFilesLink()
                                            .appValuesColors
                                            .buttonBgColor[100],
                                        15.0,
                                        AppValuesFilesLink()
                                            .appValuesDimens
                                            .heightDynamic(value: 26),
                                            (value) {
                                          if (_validateFields()) {
                                              //  Fluttertoast.showToast(msg: "All fields true");
                                            updateProfileDetails(email: controllers['email'].text.toString().trim(),name: controllers['name'].text.toString().trim());
                                          }
                                            }),
                                  )):Container(),*/
                        ],
                      ):Center(
                  child:   ProgressBar().showLoaderOnUi(false, AppValuesFilesLink().appValuesColors.loaderColor),
          ),))),
    ));



  }


}



