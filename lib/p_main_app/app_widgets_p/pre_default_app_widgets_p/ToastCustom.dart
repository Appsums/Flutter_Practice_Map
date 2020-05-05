import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToastCustom {
  static final int lengthShortC = 1;
  static final int lengthLongC = 3;
  static final int bottomC = 0;
  static final int centerC = 1;
  static final int topC = 2;

  static void show(String msg,textColor,bgColor, BuildContext context,
      {int duration = 1,
        int gravity = 0,
        double backgroundRadius = 20,
        Border border}) {
    ToastView.dismiss();
    ToastView.createView(
        msg, context, duration, gravity, bgColor, textColor, backgroundRadius, border);
  }
}

class ToastView {
  static final ToastView _singleton = new ToastView._internal();

  factory ToastView() {
    return _singleton;
  }

  ToastView._internal();

  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static bool _isVisible = false;

  static void createView(String msg, BuildContext context, int duration, int gravity,
      Color background, Color textColor, double backgroundRadius, Border border) async {
    overlayState = Overlay.of(context);

    Paint paint = Paint();
    paint.strokeCap = StrokeCap.square;
    paint.color = background;

    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
          widget: Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Container(
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(backgroundRadius),
                      border: border,
                    ),
                     margin: EdgeInsets.symmetric(horizontal: 40),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child:
                    Align(
                      alignment: Alignment.center,
                      child:  Text(msg,style: TextStyle(fontSize: 16.5, color: textColor,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                    )
                )),
          ),
          gravity: gravity),
    );
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    await new Future.delayed(Duration(seconds: duration == null ? ToastCustom.lengthShortC : duration));
    dismiss();
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  ToastWidget({
    Key key,
    @required this.widget,
    @required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final int gravity;

  @override
  Widget build(BuildContext context) {
    return new Positioned(
        top: gravity == 3 ? 50 : null,
        bottom: gravity == 0 ? 60 : null,
        child: Material(
          color: Colors.transparent,
          child: widget,
        ));
  }
}
