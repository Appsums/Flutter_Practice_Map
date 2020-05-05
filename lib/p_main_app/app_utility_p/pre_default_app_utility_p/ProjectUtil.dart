import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart'
    as timeago; //Add this dependancy  timeago: ^2.0.22
import 'package:url_launcher/url_launcher.dart';

class ProjectUtil {
  static var screenSize;
  static DateTime olddate;

  screenSizeValue(context) {
    screenSize = MediaQuery.of(context).size;
    return screenSize;
  }

  String initials(String givenName, String familyName) {
    return ((givenName?.isNotEmpty == true ? givenName[0] : "") +
        ((familyName?.isNotEmpty == true ? familyName[0] : "")).toUpperCase());
  }

  launchCaller(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  shareOnWhatsApp(String phone) async {
    String number = phone;
    String massage = 'Hello';
    var url = 'whatsapp://send?phone=$number&text=$massage';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String getCompareDateStr(String timestamp, String format, int index) {
    String formattedTime = "";
    try {
      if (index <= 0) {
        olddate = null;
      }
      int timee = int.parse(timestamp);
      DateTime date = new DateTime.fromMillisecondsSinceEpoch(timee);
      if (olddate == null) {
        olddate = date;
        formattedTime = new DateFormat(format).format(olddate);
      } else {
        String formattedTimeOld = "";
        String formattedTimeCurrent = "";
        formattedTimeOld = new DateFormat(format).format(olddate);
        formattedTimeCurrent = new DateFormat(format).format(date);
        if (formattedTimeOld == formattedTimeCurrent) {
          formattedTime = null;
        } else {
          olddate = date;
          formattedTime = new DateFormat(format).format(olddate);
        }
      }
      // DateTime date2 = new DateTime.fromMillisecondsSinceEpoch(timee2);

    } catch (e) {
      formattedTime = "";
    }
    return formattedTime;
  }

  /*================== Convert time from timestamp ===================*/
  String getTime(int timestamp, String format) {
    String formattedTime = "";
    try {
      formattedTime = DateFormat(format)
          .format(DateTime.fromMicrosecondsSinceEpoch(timestamp));
    } catch (e) {
      formattedTime = "";
      printP(null, 'error in formatting $e');
    }
    return formattedTime;
  }

  String getCountDownTimer(int timestamp, String format) {
    String formattedTime = "";
    try {
      formattedTime = DateFormat(format)
          .format(DateTime.fromMicrosecondsSinceEpoch(timestamp));
    } catch (e) {
      formattedTime = "";
      printP(null, 'error in formatting $e');
    }
    return formattedTime;
  }

/*
  String getTimeDiffrence(String firstDateTime, String secondDateTime) {
    String formattedTime = "";
    try {
      DateTime aprilFirst = DateTime.utc(firstDateTime);
      DateTime marchThirty = DateTime.utc(secondDateTime);
      formattedTime = DateFormat(format)
          .format(DateTime.fromMicrosecondsSinceEpoch(timestamp));
    } catch (e) {
      formattedTime = "";
      printP(null, 'error in formatting $e');
    }
    return formattedTime;
  }
*/



  String getTimeAgo({Key key, @required int timestamp, String format}) {
    //Note /*
    //
    //
    // Add this dependancy
    // timeago: ^2.0.22
    //
    // */
    String formattedTime = "";
    try {
      if (format != null) {
       // final fifteenAgo = DateTime.fromMillisecondsSinceEpoch(timestamp);
      } else {
        final fifteenAgo = DateTime.fromMillisecondsSinceEpoch(timestamp);
        formattedTime = timeago.format(fifteenAgo, locale: 'en');
      }
    } catch (e) {
      formattedTime = "";
      printP(null, 'error in formatting $e');
    }
    return formattedTime;
  }

  //Print message/response on logcat
   printP(String className, String body) {
    try {
      print("$className : $body");
    } catch (e) {
      print(e);
    }
  }
}
ProjectUtil projectUtil =  ProjectUtil();