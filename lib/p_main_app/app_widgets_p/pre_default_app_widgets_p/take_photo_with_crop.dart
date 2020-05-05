import 'dart:io';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppWidgetFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

var screenSize, screenHeight, screenWidth;
File croppedFile;
File imageFile;
var callBack;
var backPress;
var callBackIsCroupView;
int ratio;
bool lockAspectRatio = true;
bool isCropView = false;
bool isCroupViewShow = false;
int ttt = 1;

class TakePhotoWithCrop extends StatelessWidget {
  final BuildContext context;

  TakePhotoWithCrop({Key key, @required this.context}) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height; //Device Screen height
    screenWidth = screenSize.width;
    isCropView = false;
  }

  //BottomSheet for take media
  Future takeMediaBottomSheet(
      {Key key,
      int ratio,
      bool lockAspectRatio,
      isCroupViewShow,
      callBackIsCroupView,
      callBack,
      hardBackPress,
      backPress}) {
    lockAspectRatio = true;
    isCroupViewShow = false;
    callBack = callBack;
    callBackIsCroupView = callBackIsCroupView;
    ratio = ratio;
    lockAspectRatio = lockAspectRatio;
    backPress = backPress;
    hardBackPress = hardBackPress;

    //**********  Image cropping start *********** */
    getCropType() {
      /*original, = 0
  square,   = 1
  ratio3x2, = 2
  ratio5x3, = 3
  ratio4x3, = 4
  ratio5x4, = 5
  ratio7x5, = 6
  ratio16x9 = 7*/
      var cropTyp = CropAspectRatioPreset.original;

      if (ratio == 0) {
        cropTyp = CropAspectRatioPreset.original;
      }
      if (ratio == 1) {
        cropTyp = CropAspectRatioPreset.square;
      }
      if (ratio == 2) {
        cropTyp = CropAspectRatioPreset.ratio3x2;
      }
      if (ratio == 3) {
        cropTyp = CropAspectRatioPreset.ratio5x3;
      }
      if (ratio == 4) {
        cropTyp = CropAspectRatioPreset.ratio4x3;
      }
      if (ratio == 5) {
        cropTyp = CropAspectRatioPreset.ratio5x4;
      }
      if (ratio == 6) {
        cropTyp = CropAspectRatioPreset.ratio7x5;
      }
      if (ratio == 7) {
        cropTyp = CropAspectRatioPreset.ratio16x9;
      }
      return cropTyp;
    }

    Future<Null> _cropImage(image) async {

      var mCropType = getCropType();
      File croppedImage = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [mCropType],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppValuesFilesLink().appValuesColors.primaryColor,
              toolbarWidgetColor: Colors.white,
              showCropGrid: false,
              hideBottomControls: true,
              initAspectRatio: mCropType,
              lockAspectRatio: lockAspectRatio),
          compressQuality: 30,
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (croppedImage != null) {
        imageFile = croppedImage;
        callBack(imageFile, imageFile.path);
      } else {
        try {
          callBack(null, null);
        } catch (e) {
          print(e);
        }
      }
    }

    Future openCamera() async {
      Navigator.pop(context, true);
      imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
      if (imageFile != null) _cropImage(imageFile);
    }

    Future openGallery() async {
      //ttt = 0;
      // callBackIsCroupView();
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        _cropImage(imageFile);
        Navigator.pop(context, true);
      }
    }

    //Take photo view
    takePhotoView() {
      return WillPopScope(
          onWillPop: hardBackPress,
          child: Container(
            margin: EdgeInsets.only(
              top: AppValuesFilesLink()
                  .appValuesDimens
                  .verticalMarginPadding(value: 0),
              bottom: AppValuesFilesLink()
                  .appValuesDimens
                  .verticalMarginPadding(value: 20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      //top: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 15),
                      bottom: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 12)),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, true),
                      child: AppWidgetFilesLink().appCustomUiWidget.divider(),
                    ),
                  ),
                ),
                Container(
                    height: AppValuesFilesLink()
                        .appValuesDimens
                        .buttonHeight(value: 50),
                    margin: EdgeInsets.only(
                      top: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 20),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: AppWidgetFilesLink()
                            .appCustomUiWidget
                            .buttonRoundCornerWithBg(
                                "Choose from Library",
                                AppValuesFilesLink()
                                    .appValuesColors
                                    .textNormalColor[600],

                                //(isEmailOk && agree)?
                                AppValuesFilesLink()
                                    .appValuesColors
                                    .buttonBgColor[600],
                                AppValuesFilesLink()
                                    .appValuesDimens
                                    .buttonHeight(value: 20),
                                25, (value) {
                          openGallery();
                        }),
                      ),
                    )),
                Container(
                    height: AppValuesFilesLink()
                        .appValuesDimens
                        .buttonHeight(value: 50),
                    margin: EdgeInsets.only(
                        top: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 20)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: AppWidgetFilesLink()
                            .appCustomUiWidget
                            .buttonRoundCornerWithBg(
                                "Use Camera",
                                AppValuesFilesLink()
                                    .appValuesColors
                                    .buttonTextColor,
                                //(isEmailOk && agree)?
                                AppValuesFilesLink()
                                    .appValuesColors
                                    .buttonBgColor,
                                AppValuesFilesLink()
                                    .appValuesDimens
                                    .buttonHeight(value: 20),
                                25, (value) {
                          openCamera(); //
                        }),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(
                      top: AppValuesFilesLink()
                          .appValuesDimens
                          .verticalMarginPadding(value: 20)),
                  child: GestureDetector(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          AppValuesFilesLink().appValuesString.buttonCancel,
                          style: TextStyle(
                              fontFamily: AppValuesFilesLink()
                                  .appValuesFonts
                                  .defaultFont,
                              fontSize: screenWidth / 18,
//                            fontWeight: FontWeight.w400,
                              color: AppValuesFilesLink()
                                  .appValuesColors
                                  .textNormalColor[400]),
                        ),
                      ),
                      onTap: () => backPress()),
                )
              ],
            ),
          ));
    }

    //Crop photo view
    cropPhotoView() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: AppValuesFilesLink()
                    .appValuesDimens
                    .verticalMarginPadding(value: 15),
                bottom: AppValuesFilesLink()
                    .appValuesDimens
                    .verticalMarginPadding(value: 15)),
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => Navigator.pop(context, true),
                child: AppWidgetFilesLink().appCustomUiWidget.divider(),
              ),
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Upload Photo",
                style: TextStyle(
                    fontFamily: AppValuesFilesLink().appValuesFonts.defaultFont,
                    fontSize: screenWidth / 18,
//                                    fontWeight: FontWeight.w400,
                    color:
                        AppValuesFilesLink().appValuesColors.textHeadingColor),
              ),
            ),
            margin: EdgeInsets.only(bottom: screenHeight / 20),
          ),
          Container(
              padding: EdgeInsets.only(top: 0, bottom: screenHeight / 50),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: AppWidgetFilesLink()
                      .appCustomUiWidget
                      .buttonRoundCornerWithBg(
                          "Choose from Library",
                          AppValuesFilesLink()
                              .appValuesColors
                              .textNormalColor[400],
                          //(isEmailOk && agree)?
                          AppValuesFilesLink()
                              .appValuesColors
                              .buttonBgColor[300],
                          20.0,
                          2, (value) {
                    openGallery();
                  }),
                  height: screenHeight / 15,
                ),
              )),
          Container(
              padding: EdgeInsets.only(top: 0, bottom: screenHeight / 50),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: AppWidgetFilesLink()
                      .appCustomUiWidget
                      .buttonRoundCornerWithBg(
                          "Use Camera",
                          AppValuesFilesLink().appValuesColors.buttonTextColor,
                          //(isEmailOk && agree)?
                          AppValuesFilesLink().appValuesColors.buttonBgColor,
                          20.0,
                          2, (value) {
                    openCamera(); //
                  }),
                  height: screenHeight / 15,
                ),
              )),
          Container(
            child: GestureDetector(
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  AppValuesFilesLink().appValuesString.buttonCancel,
                  style: TextStyle(
                      fontFamily:
                          AppValuesFilesLink().appValuesFonts.defaultFont,
                      fontSize: screenWidth / 18,
//                            fontWeight: FontWeight.w400,
                      color: AppValuesFilesLink()
                          .appValuesColors
                          .textNormalColor[400]),
                ),
              ),
              onTap: () => Navigator.pop(context, true),
            ),
            margin: EdgeInsets.only(top: 0, bottom: screenHeight / 50),
          )
        ],
      );
    }

    /**********  Image cropping End *********** */
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (BuildContext bc) {
          return Container(
            // height: screenHeight/2,
            color: AppValuesFilesLink().appValuesColors.appTransColor[600],
            child: Padding(
              padding: EdgeInsets.only(left: 0, right: 0, top: 0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0)),
                ),
                elevation: 0.0,
                margin: EdgeInsets.only(left: 0, right: 0, top: 0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: AppValuesFilesLink()
                              .appValuesDimens
                              .verticalMarginPadding(value: 25),
                          right: AppValuesFilesLink()
                              .appValuesDimens
                              .verticalMarginPadding(value: 25),
                          top: 0,
                          bottom: 0),
                      //height: screenHeight/1.8,
                      child: Stack(
                        children: <Widget>[
                          isCropView ? cropPhotoView : takePhotoView(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
