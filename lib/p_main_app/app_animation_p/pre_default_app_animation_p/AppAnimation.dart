import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/Shimmer.dart';

class AppAnimation {
  ShimmerEffect mShimmerEffectClass = new ShimmerEffect();
}

class ShimmerEffect {
  Color shimmerBaseColor =    Colors.grey[300];
  Color shimmerHighlightColor =   Colors.grey[100];
  double height = 200;
  double width = 300;

  Widget shimmerEffect ({Key key,@required Color shimmerBaseColor, @required Color shimmerHighlightColor, double height, double width}) {
    Widget imageEffect =  Container(child:  SizedBox(
      height: height!=null?height:this.height,
      width: width!=null?width:this.width,

      child: Shimmer.fromColors(
        baseColor: shimmerBaseColor!=null?shimmerBaseColor:this.shimmerBaseColor,
        highlightColor: shimmerBaseColor!=null?shimmerHighlightColor:this.shimmerHighlightColor,
        enabled: true,
        child: Container(color: shimmerBaseColor!=null?shimmerBaseColor:this.shimmerBaseColor,height: height!=null?height:this.height,width: width!=null?width:this.width),
      ),
    ),);
    return imageEffect;
}
}