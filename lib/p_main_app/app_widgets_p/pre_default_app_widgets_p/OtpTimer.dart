import 'package:flutter/material.dart';

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  final fontSize;
  final timeColor;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}' +
          "Sec";
    }
    // return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}'+" Sec";
    return '${(duration.inSeconds % 60).toString().padLeft(2, '0')}' + " Sec";
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return new Text(
            timerString,
            style: new TextStyle(
              fontSize: fontSize,
              color: timeColor,
            ),
          );
        });
  }
}
