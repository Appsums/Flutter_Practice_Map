import 'dart:convert';

import 'package:baseapp/p_main_app/z_main_files_p/AppUtilsFilesLink.dart';
import 'package:flutter/cupertino.dart';

import 'ProjectUtil.dart';

class AppScreensDataCache {
  NewsFeedScreensDataCache newsFeedScreensDataCache =
      new NewsFeedScreensDataCache();
  UserActivityScreensDataCache userActivityScreensDataCache =
      new UserActivityScreensDataCache();
}

class NewsFeedScreensDataCache {
  String newsFeedListCache = "news_feed_list_cache";
  String newsFeedPageCountListCache = "news_feed_page_count_cache";
  int listDataCount = 10;
  int pageFixed = 1;

  //Save news list
  Future<bool> saveNewsList(String value, int page) async {
    try {
      String newsFeedListCacheTemp = newsFeedListCache + "_$page";
      return await SharedPreferencesFile().saveStr(newsFeedListCacheTemp, value);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> getPageCount() async {
    try {
      int pageCount = await SharedPreferencesFile().readInt(newsFeedPageCountListCache);
      if (pageCount <= 0) {
        pageCount = pageFixed;
      }
      return pageCount;
    } catch (e) {
      print(e);
      return pageFixed;
    }
  }

  Future<bool> savePageCount(int value) async {
    try {
      return await SharedPreferencesFile().saveInt(newsFeedPageCountListCache, value);
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Delete old data
  Future<bool> deleteOldPost() async {
    try {
      int totalPage = await getPageCount();
      if (totalPage >= 1) {
        for (int page = 1; page <= totalPage; page++) {
          try {
            String newsFeedListCacheTemp = newsFeedListCache + "_$page";
            await SharedPreferencesFile().saveStr(newsFeedListCacheTemp, null);
          } catch (e) {
            print(e);
          }
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Delete old data
  Future<bool> getSavedNewsList() async {
    try {
      int totalPage = await getPageCount();

      if (totalPage >= 1) {
        List<String> savedDataList = new List();
        for (int page = 1; page <= totalPage; page++) {
          try {
            String newsFeedListCacheTemp = newsFeedListCache + "_$page";
            String value = await SharedPreferencesFile().readStr(newsFeedListCacheTemp);
            savedDataList.add(value);
          } catch (e) {
            print(e);
          }
        }
        projectUtil.printP("Result", '$savedDataList');
        projectUtil.printP("Result", '$savedDataList');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> parsing(String response, int page, mBean) async {
    try {
      // int tpageTemp = page + 1;
      int tpageTemp = page; //+ 1;

      var mNewsFeedBean = mBean.fromJson(json.decode(response));
      if (mNewsFeedBean != null &&
          mNewsFeedBean.success != null &&
          mNewsFeedBean.success.data != null &&
          mNewsFeedBean.success.data.feeds != null &&
          mNewsFeedBean.success.data.feeds.length > 0) {
        //Update page count
        savePageCount(tpageTemp);
        //Store First page data
        await saveNewsList(response, page);
        return mNewsFeedBean.success.data.feeds;
      } else {
        return null;
      }
      // projectUtil.printP("Login", "Data");
    } catch (e) {
      return null;
      //projectUtil.printP("NewsFeed ", e.toString());
    }
  }
  //Store News in local memory

  //Get news from local
  Future<dynamic> getNewsFeedList({Key key, int page, mBean}) async {
    try {
      page = page != null ? page : pageFixed;
      String newsFeedListCacheTemp = newsFeedListCache + "_$page";
      String response = await SharedPreferencesFile().readStr(newsFeedListCacheTemp);
      if (response != null) {
        List<dynamic> mFeedsList = new List();
        //NewsFeedBean mNewsFeedBean = new NewsFeedBean();
        var mNewsFeedBean = mBean.fromJson(json.decode(response));
        if (mNewsFeedBean != null &&
            mNewsFeedBean.success != null &&
            mNewsFeedBean.success.data != null &&
            mNewsFeedBean.success.data.feeds != null &&
            mNewsFeedBean.success.data.feeds.length > 0) {
          mFeedsList.addAll(mNewsFeedBean.success.data.feeds);
          projectUtil.printP("AppScreenData", "$mFeedsList");
          return mNewsFeedBean.success.data.feeds;
        } else {
          return null;
        }
      } else {
        return null;
      }
/*
      return await AppUtilsFilesLink()
          .appSharedPreferencesFile
          .readStr(newsFeedListCache);*/
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class UserActivityScreensDataCache {
  String newsFeedListCache1 = "user_news_feed_list_cache";
  String newsFeedPageCountListCache1 = "user_news_feed_page_count_cache";
  int listDataCount = 100;
  int pageFixed = 1;

  //Save news list
  Future<bool> saveNewsList(String value, int page) async {
    try {
      newsFeedListCache1 = newsFeedListCache1 + "_$page";
      return await SharedPreferencesFile().saveStr(newsFeedListCache1, value);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> getPageCount() async {
    try {
      int pageCount = await SharedPreferencesFile().readInt(newsFeedPageCountListCache1);
      if (pageCount <= 0) {
        pageCount = pageFixed;
      }
      return pageCount;
    } catch (e) {
      print(e);
      return pageFixed;
    }
  }

  Future<bool> savePageCount(int value) async {
    try {
      return await SharedPreferencesFile().saveInt(newsFeedPageCountListCache1, value);
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Delete old data
  Future<bool> deleteOldPost() async {
    try {
      int totalPage = await getPageCount();
      if (totalPage >= 1) {
        for (int page = 1; page <= totalPage; page++) {
          try {
            newsFeedListCache1 = newsFeedListCache1 + "_$page";
            await SharedPreferencesFile().saveStr(newsFeedListCache1, null);
          } catch (e) {
            print(e);
          }
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> parsing(String response, int page, mBean) async {
    try {
      int tpageTemp = page + 1;

      var mNewsFeedBean = mBean.fromJson(json.decode(response));
      if (mNewsFeedBean != null &&
          mNewsFeedBean.success != null &&
          mNewsFeedBean.success.data != null &&
          mNewsFeedBean.success.data.feeds != null &&
          mNewsFeedBean.success.data.feeds.length > 0) {
        //Update page count
        savePageCount(tpageTemp);
        //Store First page data
        await saveNewsList(response, page);
        return mNewsFeedBean.success.data.feeds;
      } else {
        return null;
      }
      // projectUtil.printP("Login", "Data");
    } catch (e) {
      return null;
      //projectUtil.printP("NewsFeed ", e.toString());
    }
  }
  //Store News in local memory

  //Get news from local
  Future<dynamic> getNewsFeedList({Key key, int page, mBean}) async {
    try {
      page = page != null ? page : pageFixed;
      newsFeedListCache1 = newsFeedListCache1 + "_$page";
      String response = await SharedPreferencesFile().readStr(newsFeedListCache1);
      if (response != null) {
        List<dynamic> mFeedsList = new List();
        //NewsFeedBean mNewsFeedBean = new NewsFeedBean();
        var mNewsFeedBean = mBean.fromJson(json.decode(response));
        if (mNewsFeedBean != null &&
            mNewsFeedBean.success != null &&
            mNewsFeedBean.success.data != null &&
            mNewsFeedBean.success.data.feeds != null &&
            mNewsFeedBean.success.data.feeds.length > 0) {
          mFeedsList.addAll(mNewsFeedBean.success.data.feeds);
          projectUtil.printP("AppScreenData", "$mFeedsList");
          return mNewsFeedBean.success.data.feeds;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
