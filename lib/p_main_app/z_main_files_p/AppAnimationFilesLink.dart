
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/AppAnimation.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/SlideRightRoute.dart';
import 'package:baseapp/p_main_app/app_animation_p/pre_default_app_animation_p/FadeIn.dart';

class AppAnimationFilesLink{
   // Application main default files
   appSlideRightRoute (widget)=> new SlideRightRoute(widget:widget);
   AppAnimation appAnimation = new AppAnimation();
   FadeIn fadeIn(delay,child) => new FadeIn(delay,child);

  //Application specific module file
}