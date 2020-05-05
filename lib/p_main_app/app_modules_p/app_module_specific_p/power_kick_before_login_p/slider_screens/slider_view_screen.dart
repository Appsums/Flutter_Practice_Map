import 'package:baseapp/p_main_app/app_widgets_p/carousel.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppScreensFilesLink.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import '../../../ScreensRoutes.dart';

class SliderScreens extends StatefulWidget {
  final index;
  SliderScreens({Key key, this.index}) : super(key: key);

  @override
  _SliderScreensState createState() => _SliderScreensState();
}

class _SliderScreensState extends State<SliderScreens> {
  int selectedIndex = 0;
  List<Widget> sliderScreens = new List() ;


  var updateSelectedPageIndex;


  @override
  Widget build(BuildContext context) {
    if(sliderScreens.length<=0){
      setState(() {
        sliderScreens.add(SliderScreen1(updateSelectedPageIndex:(){
          setState(() {
            selectedIndex = 1;
          });
        }));

        sliderScreens.add(SliderScreen2(updateSelectedPageIndex:(){
          setState(() {
            selectedIndex = 2;
          });
        }));
        sliderScreens.add(SliderScreen3(updateSelectedPageIndex:(){
          setState(() {
            selectedIndex = 3;
            Navigator.pushAndRemoveUntil(
                context,
                SlideRightRoute(
                    widget:
                    LoginWithMobile()), ModalRoute.withName(homeScreen));
          });
        }));
      });

    }


    return Scaffold(
      body: Carousel(
        items: sliderScreens,
        currentIndex: selectedIndex,
        autoplay: false,
        dotBgColor: Colors.transparent,
        dotColor: Colors.grey,
        dotIncreasedColor: AppValuesFilesLink().appValuesColors.textNormalColor,
        dotIncreaseSize: 1.2,
      ),
    );
  }
}
