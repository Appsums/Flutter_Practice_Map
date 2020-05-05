import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


//Fade Transaction
class SlideRightRoute extends CupertinoPageRoute {
  final Widget widget;
  SlideRightRoute({this.widget}) : super(builder: (BuildContext context) => widget);
  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: widget);

  }
}


