import 'dart:convert';
import 'dart:io';

import 'package:baseapp/p_main_app/api_calling_p/LocalConstant.dart';
import 'package:baseapp/p_main_app/app_utility_p/pre_default_app_utility_p/SharedPreferencesFile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static BuildContext mContext;
  var updateIcon;
  var messageType = 0;
  var messageTypeID = 0;
  var appInKillState = 1;
  var appInForeground = 2;
  var appInBackground = 3;

  void setUpFirebase(BuildContext context, var updateNotificationIcon) {
    firebaseCloudMessagingListeners();
    mContext = context;
    updateIcon = updateNotificationIcon;
  }

  Future<void> getToken() async {
    _firebaseMessaging.requestNotificationPermissions();
    firebaseCloudMessagingListeners();
    var token = await _firebaseMessaging.getToken();
    if (token != null) {
      await SharedPreferencesFile().saveStr(deviceTokenC, token);
    }
  }

  redirectToScreen(notificationData, appStatus) {
    print('on message $notificationData');
    //var response=  notificationData['data'];
    var response = notificationData;
    if (Platform.isAndroid) {
      response = notificationData['data'];
    }

    var parsingBeanData;
    var title = "";
    var message = "";
    try {
      title = notificationData['notification']['title'];
      print('on message  title $title');
    } catch (e) {
      print(e);
    }
    try {
      message = notificationData['notification']['body'];
      response=null;
      print('on message  Message $Message');
    } catch (e) {
      print(e);
    }

    if (response != null) {

      try {
        title = response['title'];
        print('on message  title $title');
      } catch (e) {
        print(e);
      }
      String notificationData = response[
          'data']; // Just get string data from notification data key for parsing
      Map<String, dynamic> notificationDataTemp = json.decode(
          notificationData); // Just get string data from notification data key for parsing
      print("$notificationDataTemp");
      String notiFor = notificationDataTemp['noti_for'].toString();
      try {
        //In case of follow un-follow
        if (notiFor != null && notiFor == '1') {
          /*parsingBeanData = NotificationFollowResponse.fromJson(
              json.decode(notificationData));*/
        }
        //In case of new news activity
       /* if (notiFor != null && notiFor == '2') {
          parsingBeanData = NotificationResponseDataBean.fromJson(
              json.decode(notificationData));
        }
        //In case of one to one chat
        if (notiFor != null && (notiFor == '3' || notiFor == '5')) {
          if (currentSelectedMenu != null && currentSelectedMenu != 3) {
            parsingBeanData = NotificationResponseChatDataBean.fromJson(
                json.decode(notificationData));
          }
        } //In case of group chat
        if (notiFor != null &&
            (notiFor == '4' || notiFor == '6' || notiFor == '7')) {
          if (currentSelectedMenu != null && currentSelectedMenu != 3) {
            parsingBeanData = NotificationResponseChatDataBean.fromJson(
                json.decode(notificationData));
          }
        }*/
        //notiFor = parsingBeanData.notiFor.toString();
      } catch (e) {
        print("$e");
      }

      if (appStatus == appInForeground) {
        /*if (currentSelectedMenu != null && currentSelectedMenu != 3) {
          // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
          // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
          var initializationSettingsAndroid =
              new AndroidInitializationSettings('@mipmap/ic_launcher');
          var initializationSettingsIOS = new IOSInitializationSettings();
          var initializationSettings = new InitializationSettings(
              initializationSettingsAndroid, initializationSettingsIOS);
          flutterLocalNotificationsPlugin =
              new FlutterLocalNotificationsPlugin();
          flutterLocalNotificationsPlugin.initialize(initializationSettings,
              onSelectNotification: (String payload) async {
            //In case of follow un-follow
            if (notiFor != null && notiFor == '1') {
              if (parsingBeanData != null) {
                try {
                  followBy = parsingBeanData.notiData.followBy;
                } catch (e) {
                  print("$e");
                }
              }
              try {
                if (mContext != null) {
                  AppUtilsFilesLink()
                      .appSharedPreferencesFile
                      .saveBool(anyNewNotificationC, false);
                  updateIcon();
                  Navigator.push(
                      mContext,
                      SlideRightRoute(
                          widget: AppScreensFilesLink().mProfileScreen(
                              chatUid: null,
                              userId: followBy,
                              name: null,
                              peerAvatar: null)));
                }
              } catch (e) {
                print("$e");
              }
            }
            //In case of new news activity
            if (notiFor != null && notiFor == '2') {
              if (parsingBeanData != null) {
                try {
                  userId = parsingBeanData.notiData.userId;
                } catch (e) {
                  print("$e");
                }
              }
              try {
                if (mContext != null) {
                  AppUtilsFilesLink()
                      .appSharedPreferencesFile
                      .saveBool(anyNewNotificationC, false);
                  updateIcon();
                  Navigator.push(
                      mContext,
                      SlideRightRoute(
                          widget: AppScreensFilesLink().mUserNewsFeedScreen(
                              isNewsPostRefresh: false, userId: userId)));
                }
              } catch (e) {
                print("$e");
              }
            }

            //In case of One to one chat
            if (notiFor != null && (notiFor == '3' || notiFor == '5')) {
              if (parsingBeanData != null) {
                try {
                  userId = parsingBeanData.notiData.uid;
                } catch (e) {
                  print("$e");
                }
              }
              try {
                if (mContext != null) {
                  Navigator.push(
                      mContext,
                      SlideRightRoute(
                          widget: AppScreensFilesLink().mOnetoOneChatScreen(
                        peerId: userId,
                        name: alumniName != null ? alumniName : "",
                        peerAvatar: profileImage,
                        isGroupChat: false,
                      )));
                }
              } catch (e) {
                print("$e");
              }
            }
            //In case of  Group chat
            if (notiFor != null &&
                (notiFor == '4' || notiFor == '6' || notiFor == '7')) {
              if (parsingBeanData != null) {
                try {
                  userId = parsingBeanData.notiData.uid;
                } catch (e) {
                  print("$e");
                }
              }
              try {
                if (mContext != null) {
                  if(notiFor == '7'){
                    Map<String ,dynamic> groupInfo = new Map() ;
                    groupInfo['groupType'] = 1;
                    groupInfo['timestamp'] = null;
                    groupInfo['image']= profileImage;
                    groupInfo['description'] = null;
                    groupInfo['gId'] = userId ;
                   *//* Navigator.push(
                        mContext,
                        SlideRightRoute(
                            widget: AppScreensFilesLink().mGroupChannelInformation(
                                groupInfo: groupInfo,
                                isJoinedGroup: false,
                                isGroupCreated: false)));*//*
                  }
                  else{
                    *//*Navigator.push(
                        mContext,
                        SlideRightRoute(
                            widget: AppScreensFilesLink().mChatScreen(
                                peerId: userId,
                                name: alumniName != null ? alumniName : "",
                                peerAvatar: profileImage,
                                isGroupChat: true,
                                isGroupCreated: false)));*//*
                  }

                }
              } catch (e) {
                print("$e");
              }
            }
          });
          _showNotificationWithDefaultSound(title, description);
        }*/
      }
      else if (appStatus == appInBackground) {
        Fluttertoast.showToast(msg: "Background");
        onSelectNotificationBackground(parsingBeanData, notiFor);
      } else if (appStatus == appInKillState) {
        onSelectNotificationBackground(parsingBeanData, notiFor);
      }
    }
    else{
      if(message!=null&& message.trim().length>0 && title!=null&& title.trim().length>0){
        if (appStatus == appInForeground) {
          var initializationSettingsAndroid =
          new AndroidInitializationSettings('@mipmap/ic_launcher');
          var initializationSettingsIOS = new IOSInitializationSettings();
          var initializationSettings = new InitializationSettings(
              initializationSettingsAndroid, initializationSettingsIOS);
          flutterLocalNotificationsPlugin =
          new FlutterLocalNotificationsPlugin();
          flutterLocalNotificationsPlugin.initialize(initializationSettings,
              onSelectNotification: (String payload) async {

              });
          _showNotificationWithDefaultSound("$title","$message");
        }

      }

    }
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        if (message != null) {
          SharedPreferencesFile().saveBool(anyNewNotificationC, true);
          updateIcon();
          redirectToScreen(message, appInForeground);
        }
      },
      onResume: (Map<String, dynamic> message) async {
        if (message != null) {
          redirectToScreen(message, appInBackground);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        if (message != null) {
          redirectToScreen(message, appInKillState);
        }
      },
    );
  }

  void iOSPermission() {
   /*_firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));*/
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.onIosSettingsRegistered.listen((data) {
      // save the token  OR subscribe to a topic here
    });

    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings());
  }

  // Method 2
  Future _showNotificationWithDefaultSound(title, description) async {
    //title = "Emmi event";
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      description,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  Future onSelectNotificationBackground(
      var mNotificationFollowResponse, String notiFor) async {
    //In case of follow un-follow
    if (notiFor != null && notiFor == '1') {
      String followBy;
      if (mNotificationFollowResponse != null) {
        try {
          followBy = mNotificationFollowResponse.notiData.followBy;
        } catch (e) {
          print("$e");
        }
      }
      try {
        if (followBy != null && mContext != null) {
          SharedPreferencesFile().saveBool(anyNewNotificationC, false);
          /*Navigator.push(
              mContext,
              SlideRightRoute(
                  widget: AppScreensFilesLink().mProfileScreen(
                      chatUid: null,
                      userId: followBy,
                      name: null,
                      peerAvatar: null)));*/
        }
      } catch (e) {
        print("$e");
      }
    }
    //In case of new news activity
    if (notiFor != null && notiFor == '2') {
      String userId;
      if (mNotificationFollowResponse != null) {
        try {
          print("jdfgb");
          userId = mNotificationFollowResponse.notiData.userId;
        } catch (e) {
          print("$e");
        }
      }
      try {
        if (userId != null && mContext != null) {
          SharedPreferencesFile().saveBool(anyNewNotificationC, false);
          /*Navigator.push(
              mContext,
              SlideRightRoute(
                  widget: AppScreensFilesLink().mUserNewsFeedScreen(
                      isNewsPostRefresh: false, userId: userId)));*/
        }
      } catch (e) {
        print("$e");
      }
    }

    //For One to One chat
    if (notiFor != null && (notiFor == '3' || notiFor == '5')) {
      String userId;
      if (mNotificationFollowResponse != null) {
        try {
          userId = mNotificationFollowResponse.notiData.uid;
        } catch (e) {
          print("$e");
        }
      }
      try {
        if (userId != null && mContext != null) {
          SharedPreferencesFile().saveBool(anyNewNotificationC, false);
          /*Navigator.push(
              mContext,
              SlideRightRoute(
                  widget: AppScreensFilesLink().mOnetoOneChatScreen(
                peerId: userId,
                name: alumniName != null ? alumniName : "",
                peerAvatar: profileImage,
                isGroupChat: false,
              )));*/
        }
      } catch (e) {
        print("$e");
      }
    }
    //For Group chat
    if (notiFor != null &&
        (notiFor == '4' || notiFor == '6' || notiFor == '7')) {
      String userId;
      String profileImage;

      if (mNotificationFollowResponse != null) {
        try {
         // userId = mNotificationFollowResponse.notiData.uid;
          userId = mNotificationFollowResponse.notiData.uid;
        } catch (e) {
          print("$e");
        }
      }
      try {
        if (userId != null && mContext != null) {
          SharedPreferencesFile().saveBool(anyNewNotificationC, false);

          if(notiFor == '7'){
            Map<String ,dynamic> groupInfo = new Map() ;
            groupInfo['groupType'] = 1;
            groupInfo['timestamp'] = null;
            groupInfo['image']= profileImage;
            groupInfo['description'] = null;
            groupInfo['gId'] = userId ;
            /*Navigator.push(
                mContext,
                SlideRightRoute(
                    widget: AppScreensFilesLink().mGroupChannelInformation(
                        groupInfo: groupInfo,
                        isJoinedGroup: false,
                        isGroupCreated: false)));*/
          }
          else {
            /*Navigator.push(
                mContext,
                SlideRightRoute(
                    widget: AppScreensFilesLink().mChatScreen(
                        peerId: userId,
                        name: alumniName != null ? alumniName : "",
                        peerAvatar: profileImage,
                        isGroupChat: true,
                        isGroupCreated: false)));*/
          }
        }
      } catch (e) {
        print("$e");
      }
    }
  }
}
