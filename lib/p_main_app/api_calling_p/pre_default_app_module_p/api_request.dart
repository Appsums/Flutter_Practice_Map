import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:baseapp/p_main_app/app_utility_p/pre_default_app_utility_p/ProjectUtil.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';

import 'api_constant.dart';

//Response call back
class Response {
  final bool success;
  final String msg;
  final int statusCode;
  final String responseData;
  Response(this.success, this.msg, this.statusCode, this.responseData);

  Response.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        msg = json['msg'],
        statusCode = json['statusCode'],
        responseData = json['data'];

  Map<String, dynamic> toJson() => {
        'success': success,
        'msg': msg,
        'statusCode': statusCode,
        'responseData': responseData,
      };
}

//Basic parser new version
class ParserBasic {
  bool success;
  String msg;
  var data;
  ParserBasic({this.success, this.msg, this.data});
  ParserBasic.fromJson(Map<String, dynamic> json) {
    try {
      success = json['success'];
    }
    catch (e) {
      print(e);
    }
    try {
      //bool isError = json['error']==false?true:false;
    //  projectUtil.printP("$status", "$status");
      msg =  json['msg'];
    } catch (e) {
      print(e);
    }
    try {
      data = json.containsKey('result')
          ? (json['result'] != null)
          : null;
    } catch (e) {
      print(e);
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.success;
    data['msg'] = this.msg;
    data['success'] = this.data;
    return data;
  }
}

//Main API calling Class
class ApiRequestMain {
  int connectTimeout = 10;
  int writeTimeout = 10;
  int readTimeout = 60;

  String checkInternetMessage = 'Please check internet connection';
  String tryAgain = 'Something went wrong please try again';
  var headers = {
    "Content-Type": "application/json",
    "appType": "PHONE",
   };

  //Post type request function with input data
  Future<Response> apiRequestPost(
      {Key key,
      @required String url,
      @required bodyData,
      headersTemp,
      String authorization,
      bool isLoader}) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;

        if (authorization != null) {
          var headers1 = {"token": authorization};
          headers.addAll(headers1);
        }

        final response = await http
            .post(fullUrl, headers: headers, body: bodyData)
            .timeout(Duration(seconds: readTimeout));
        projectUtil.printP("API", "$response");
        //Check response is empty or not
        if (response != null) {
          //Check data body is in response
          if (response.body != null) {
            var responseBody = response.body;
            //Parse msg and data from response body
            ParserBasic mParserBasic =
                ParserBasic.fromJson(json.decode(responseBody));
            //Check Data is exist or not
            if (mParserBasic != null && mParserBasic.success == true) {
              var data = mParserBasic.data;
              //Check Data is exist or not
              if (data != null) {
                Response mResponse = new Response(true, mParserBasic.msg,
                    response.statusCode, responseBody.toString());
                return mResponse;
              } else {
                Response mResponse = new Response(
                    true, mParserBasic.msg, response.statusCode, null);
                return mResponse;
              }
            } else {
              Response mResponse = new Response(
                  false, mParserBasic.msg, response.statusCode, null);
              return mResponse;
            }
          } else {
            Response mResponse = new Response(
                false, "Please try again ", response.statusCode, null);
            return mResponse;
          }
        } else {
          Response mResponse =
              new Response(false, "Please try again ", 1000, null);
          return mResponse;
        }
      } catch (e) {
        try {
          if (e.runtimeType == SocketException ||
              e.runtimeType == TimeoutException) {
            projectUtil.printP(
                "api_request.dart", "Please check internet connection");
            Response mResponse =
                new Response(false, checkInternetMessage, -1000, null);
            return mResponse;
          } else {
            projectUtil.printP(
                "api_request.dart", "Error in requested api: " + e);
            Response mResponse = new Response(false, tryAgain, 1000, null);
            return mResponse;
          }
        } catch (e) {
          projectUtil.printP(
              "api_request.dart", "Error in requested api: " + e.toString());
          Response mResponse = new Response(false, tryAgain, 1000, null);
          return mResponse;
        }
      }
    } else {
      projectUtil.printP("api_request.dart",
          AppValuesFilesLink().appValuesString.noInternetConnection);
      Response mResponse = new Response(
          false,
          AppValuesFilesLink().appValuesString.noInternetConnection,
          -1000,
          null);
      return mResponse;
    }
  }

  //Post type request function with input data
  Future<Response> apiRequestPost1(String url, bodyData, bool isLoader) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;
        final response = await http
            .post(fullUrl, headers: headers, body: bodyData)
            .timeout(Duration(seconds: readTimeout));
        //Check response is empty or not
        if (response != null) {
          //Checking is api called successfully
          if (response.body != null) {
            var responseBody = response.body;
            //Parse msg and data from response body
            ParserBasic mParserBasic =
                ParserBasic.fromJson(json.decode(responseBody));
            //Check Data is exist or not
            if (mParserBasic != null && mParserBasic.success == true) {
              //Check Data is exist or not
              Response mResponse = new Response(true, mParserBasic.msg,
                  response.statusCode, responseBody.toString());
              return mResponse;
            } else {
              Response mResponse = new Response(
                  false, mParserBasic.msg, response.statusCode, null);
              return mResponse;
            }
          } else {
            Response mResponse = new Response(
                false, "Please try again ", response.statusCode, null);
            return mResponse;
          }
        } else {
          Response mResponse =
              new Response(false, "Please try again ", 1000, null);
          return mResponse;
        }
      } catch (e) {
        if (e.runtimeType == SocketException ||
            e.runtimeType == TimeoutException) {
          projectUtil.printP(
              "api_request.dart", "Please check internet connection");
          Response mResponse =
              new Response(false, checkInternetMessage, -1000, null);
          return mResponse;
        } else {
          projectUtil.printP(
              "api_request.dart", "Error in requested api: " + e);
          Response mResponse = new Response(false, tryAgain, 1000, null);
          return mResponse;
        }
      }
    } else {
      projectUtil.printP("api_request.dart",
          " AppValuesFilesLink().appValuesString.noInternetConnection");
      Response mResponse = new Response(
          false,
          AppValuesFilesLink().appValuesString.noInternetConnection,
          -2000,
          null);
      return mResponse;
    }
  }

  //Post type request function with input data
  Future<Response> apiRequestPostAuthorize(
      String url, bodyData, bool isLoader, String authorization) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;

        if (authorization != null) {
          var headers1 = {"token": authorization};
          headers.addAll(headers1);
        }
        final response = await http
            .post(fullUrl, headers: headers, body: bodyData)
            .timeout(Duration(seconds: readTimeout));
        //Check response is empty or not
        if (response != null) {
          //Check is response coming from server
          if (response.body != null) {
            var responseBody = response.body;
            //Parse message and data from response body
            projectUtil.printP("$responseBody", "$responseBody");
            ParserBasic mParserBasic;
            try {
               mParserBasic =
                              ParserBasic.fromJson(json.decode(responseBody));
            }
            catch (e) {
              print(e);
            }
            //Check Data is exist or not
            if (mParserBasic != null && mParserBasic.success == true) {
              var data = mParserBasic.data;
              //Check Data is exist or not
              if (data != null) {
                //var dataJson = json.encode(data);
                Response mResponse = new Response(true, mParserBasic.msg,
                    response.statusCode, responseBody.toString());
                return mResponse;
              } else {
                Response mResponse = new Response(
                    true, mParserBasic.msg, response.statusCode, null);
                return mResponse;
              }
            } else {
              Response mResponse = new Response(
                  false, mParserBasic.msg, response.statusCode, null);
              return mResponse;
            }
          } else {
            Response mResponse = new Response(
                false, "Please try again ", response.statusCode, null);
            return mResponse;
          }
        } else {
          Response mResponse =
              new Response(false, "Please try again ", 1000, null);
          return mResponse;
        }
      } catch (e) {
        if (e.runtimeType == SocketException ||
            e.runtimeType == TimeoutException) {
          projectUtil.printP(
              "api_request.dart", "Please check internet connection");
          checkInternetMessage = "Time out exception please try again";
          Response mResponse =
              new Response(false, checkInternetMessage, -1000, null);
          return mResponse;
        } else {
          projectUtil.printP(
              "api_request.dart", "Error in requested api: " + e);

          Response mResponse = new Response(false, tryAgain, 1000, null);
          return mResponse;
        }
      }
    }
    else {
      Response mResponse = new Response(
          false,
          AppValuesFilesLink().appValuesString.noInternetConnection,
          -2000,
          null);
      return mResponse;
    }
  }

  //Get type request function with input data
  Future<Response> apiRequestGet(String url, bodyData, bool isLoader) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;
        String values = "";
        if (bodyData != null) {
          int i = 0;
          for (var data in bodyData.entries) {
            String key = data.key;
            if (key != "") {
              String localValue = data.key + "=" + data.value;
              if (i == 0) {
                values = localValue;
              } else {
                values = values + "&&" + localValue;
              }
            } else {
              String localValue = data.value;
              if (i == 0) {
                values = "/" + localValue;
              } else {
                values = values + "/" + localValue;
              }
            }
            i++;
          }
        }

        fullUrl = fullUrl + values;
        final response = await http
            .get(fullUrl, headers: headers)
            .timeout(Duration(seconds: readTimeout));
        //Check response is empty or not
        if (response != null) {
          //Check is response coming from server
          if (response.body != null) {
            var responseBody = response.body;
            //Parse message and data from response body
            ParserBasic mParserBasic =
                ParserBasic.fromJson(json.decode(responseBody));
            //Check Data is exist or not
            if (mParserBasic != null && mParserBasic.success != null) {
              var data = mParserBasic;
              //Check Data is exist or not
              if (data != null) {
                Response mResponse = new Response(true, mParserBasic.msg,
                    response.statusCode, responseBody.toString());
                return mResponse;
              } else {
                Response mResponse = new Response(
                    true, mParserBasic.msg, response.statusCode, null);
                return mResponse;
              }
            } else {
              Response mResponse = new Response(
                  false, mParserBasic.msg, response.statusCode, null);
              return mResponse;
            }
          } else {
            Response mResponse = new Response(false,
                "Server Error Please try again", response.statusCode, null);
            return mResponse;
          }
        } else {
          Response mResponse =
              new Response(false, "Please try again", 1000, null);
          return mResponse;
        }
      } catch (e) {
        if (e.runtimeType == SocketException ||
            e.runtimeType == TimeoutException) {
          projectUtil.printP(
              "api_request.dart", "Please check internet connection");
          Response mResponse =
              new Response(false, checkInternetMessage, -1000, null);
          return mResponse;
        } else {
          projectUtil.printP(
              "api_request.dart", "Error in requested api: " + e);
          Response mResponse = new Response(false, tryAgain, 1000, null);
          return mResponse;
        }
      }
    } else {
      projectUtil.printP("api_request.dart",
          AppValuesFilesLink().appValuesString.noInternetConnection);
      Response mResponse = new Response(
          false,
          AppValuesFilesLink().appValuesString.noInternetConnection,
          -2000,
          null);
      return mResponse;
    }
  }

  //Get type request function with input data
  Future<Response> apiRequestGetAuthorize(String url,
      Map<String, String> bodyData, bool isLoader, String authorization) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;
        ProjectUtil().printP("",fullUrl);
        String values = "";
        if (bodyData != null) {
          int i = 0;
          for (var data in bodyData.entries) {
            String key = data.key;
            if (key != "") {
              String localValue = data.key + "=" + data.value;
              if (i == 0) {
                values = localValue;
              } else {
                values = values + "&&" + localValue;
              }
            } else {
              String localValue = data.value;
              if (i == 0) {
                values = "/" + localValue;
              } else {
                values = values + "/" + localValue;
              }
            }
            i++;
          }
        }

        fullUrl = fullUrl + values;
        if (authorization != null) {
          var headers1 = {"token": authorization};
          headers.addAll(headers1);
        }
        final response = await http
            .get(fullUrl, headers: headers)
            .timeout(Duration(seconds: readTimeout));
        //Check response is empty or not
        if (response != null) {
          //Check is response coming from server
          if (response.body != null) {
            var responseBody = response.body;
            projectUtil.printP("hjg","responseBody: $responseBody");
            //Parse message and data from response body
            ParserBasic mParserBasic =
                ParserBasic.fromJson(json.decode(responseBody));
            //Check Data is exist or not
            if (mParserBasic != null && mParserBasic.success != null) {
              var data = mParserBasic;
              //Check Data is exist or not
              if (data != null) {
                Response mResponse = new Response(true, mParserBasic.msg,
                    response.statusCode, responseBody.toString());
                return mResponse;
              } else {
                Response mResponse = new Response(
                    true, mParserBasic.msg, response.statusCode, null);
                return mResponse;
              }
            } else {
              Response mResponse = new Response(
                  false, mParserBasic.msg, response.statusCode, null);
              return mResponse;
            }
          } else {
            Response mResponse = new Response(false,
                "Server Error Please try again", response.statusCode, null);
            return mResponse;
          }
        } else {
          Response mResponse =
              new Response(false, "Please try again", 1000, null);
          return mResponse;
        }
      } catch (e) {
        if (e.runtimeType == SocketException ||
            e.runtimeType == TimeoutException) {
          projectUtil.printP(
              "api_request.dart", "Please check internet connection");
          Response mResponse =
              new Response(false, checkInternetMessage, -1000, null);
          return mResponse;
        } else {
          projectUtil.printP(
              "api_request.dart", "Error in requested api: " + e);
          Response mResponse = new Response(false, tryAgain, 1000, null);
          return mResponse;
        }
      }
    } else {
      projectUtil.printP("api_request.dart",
          AppValuesFilesLink().appValuesString.noInternetConnection);
      Response mResponse = new Response(
          false,
          AppValuesFilesLink().appValuesString.noInternetConnection,
          -1000,
          null);
      return mResponse;
    }
  }


  //Put type request function with input data
  Future<Response> apiRequestPut(String url, bodyData, bool isLoader) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;
        final response = await http
            .put(fullUrl, headers: headers, body: bodyData)
            .timeout(Duration(seconds: readTimeout));
        //Check response is empty or not
        if (response != null) {
          //Check is response coming from server
          if (response.body != null) {
            var responseBody = response.body;
            //Parse message and data from response body
            ParserBasic mParserBasic =
                ParserBasic.fromJson(json.decode(responseBody));
            //Check Data is exist or not
            if (mParserBasic != null && mParserBasic.success != null) {
              var data = mParserBasic.data;
              //Check Data is exist or not
              if (data != null) {
                Response mResponse = new Response(true, mParserBasic.msg,
                    response.statusCode, responseBody.toString());
                return mResponse;
              } else {
                Response mResponse = new Response(
                    true, mParserBasic.msg, response.statusCode, null);
                return mResponse;
              }
            } else {
              Response mResponse = new Response(
                  false, mParserBasic.msg, response.statusCode, null);
              return mResponse;
            }
          } else {
            Response mResponse = new Response(false,
                "Server Error Please try again", response.statusCode, null);
            return mResponse;
          }
        } else {
          Response mResponse =
              new Response(false, "Please try again", 1000, null);
          return mResponse;
        }
      } catch (e) {
        if (e.runtimeType == SocketException ||
            e.runtimeType == TimeoutException) {
          projectUtil.printP(
              "api_request.dart", "Please check internet connection");
          Response mResponse = new Response(
              false, "Please check internet connection", -1000, null);
          return mResponse;
        } else {
          projectUtil.printP(
              "api_request.dart", "Error in requested api: " + e);
          Response mResponse = new Response(false, e, 1000, null);
          return mResponse;
        }
      }
    } else {
      projectUtil.printP("api_request.dart",
          AppValuesFilesLink().appValuesString.noInternetConnection);
      Response mResponse = new Response(
          false,
          AppValuesFilesLink().appValuesString.noInternetConnection,
          -2000,
          null);
      return mResponse;
    }
  }

  //update profile image and other media files with text data
  Future<StreamedResponse> apiRequestMultipartAuthorizeWithBodyData(
      {Key key,
      String url,
      Map<String, String> bodyData,
      imageFile,
      bool isLoader,
      String authorization}) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;

        if (authorization != null) {
          var headers1 = {"token": authorization};
          headers.addAll(headers1);
        }

        // string to uri
        var uri = Uri.parse(fullUrl);
        // create multipart request
        var request = http.MultipartRequest("POST", uri);
        request.headers.addAll(headers);
        try {
          if (imageFile != null) {
            for (var data in imageFile.entries) {
              String key = data.key;
              if (key != "") {
                var localValue = data.value;
                // open a bytestream
                var stream = new http.ByteStream(
                    DelegatingStream.typed(localValue.openRead()));
                // get file length
                var length = await localValue.length();
                // multipart that takes file
                var multipartFile = new http.MultipartFile(
                    "testFile", stream, length,
                    filename: basename(localValue.path));
                // add file to multipart
                request.files.add(multipartFile);
              }
            }
          } else {
            projectUtil.printP("api_request.dart", 'image file not selected');
          }
        } catch (e) {
          projectUtil.printP(
              "api_request.dart", "Error in selected image: " + e);
        }

        //If no text data
        if (bodyData != null) {
          try {
            request.fields.addAll(bodyData);
          } catch (e) {
            print(e);
          }
        }
        final response = await request.send();
        return response;
      } catch (e) {
        projectUtil.printP("api_request.dart", "Error in requested api: " + e);
        return null;
      }
    } else {
      projectUtil.printP("api_request.dart",
          AppValuesFilesLink().appValuesString.noInternetConnection);
      // Response mResponse = new Response(false,  AppValuesFilesLink().appValuesString.noInternetConnection, -2000, null);
      return null;
    }
  }

  //
  Future<StreamedResponse> apiRequestMultipartAuthorizeWithBodyDataPatch(
      {Key key,
      String url,
      Map<String, String> bodyData,
      imageFile,
      bool isLoader,
      String authorization}) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;

        if (authorization != null) {
          var headers1 = {"token": authorization};
          headers.addAll(headers1);
        }

        // string to uri
        var uri = Uri.parse(fullUrl);
        // create multipart request
        var request = http.MultipartRequest("PATCH", uri);
        request.headers.addAll(headers);
        try {
          if (imageFile != null) {
            for (var data in imageFile.entries) {
              String key = data.key;
              if (key != "") {
                var localValue = data.value;
                // open a bytestream
                var stream = new http.ByteStream(
                    DelegatingStream.typed(localValue.openRead()));
                // get file length
                var length = await localValue.length();
                // multipart that takes file
                var multipartFile = new http.MultipartFile(
                    "testFile", stream, length,
                    filename: basename(localValue.path));
                // add file to multipart
                request.files.add(multipartFile);
              }
            }
          } else {
            projectUtil.printP("api_request.dart", 'image file not selected');
          }
        } catch (e) {
          projectUtil.printP(
              "api_request.dart", "Error in selected image: " + e);
        }

        //If no text data
        if (bodyData != null) {
          try {
            request.fields.addAll(bodyData);
          } catch (e) {
            print(e);
          }
        }
        final response = await request.send();
        return response;
      } catch (e) {
        projectUtil.printP("api_request.dart", "Error in requested api: " + e);

        return null;
      }
    } else {
      projectUtil.printP("api_request.dart",
          AppValuesFilesLink().appValuesString.noInternetConnection);
      // Response mResponse = new Response(false,  AppValuesFilesLink().appValuesString.noInternetConnection, -2000, null);
      return null;
    }
  }

  //Update single image
  Future<StreamedResponse> apiRequestMultipartAuthorizeWithoutBodyData(
      String url,
      imageKey,
      imageFile,
      bool isLoader,
      String authorization) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;
        if (authorization != null) {
          var headers1 = {"token": authorization};
          headers.addAll(headers1);
        }
        //String to uri
        var uri = Uri.parse(fullUrl);
        // create multipart request
        var request = http.MultipartRequest("POST", uri);
        request.headers.addAll(headers);
        try {
          if (imageFile != null) {
            // open a bytestream
            var stream = new http.ByteStream(
                DelegatingStream.typed(imageFile.openRead()));
            // get file length
            var length = await imageFile.length();
            // multipart that takes file
            var multipartFile = new http.MultipartFile(imageKey, stream, length,
                filename: basename(imageFile.path));
            // add file to multipart
            request.files.add(multipartFile);
          } else {
            projectUtil.printP("api_request.dart", 'image file not selected');
          }
        } catch (e) {
          projectUtil.printP(
              "api_request.dart", "Error in selected image: " + e);
        }
        final response = await request.send();
        return response;
      } catch (e) {
        projectUtil.printP("api_request.dart", "Error in requested api: " + e);
        return null;
      }
    } else {
      projectUtil.printP(
          "api_request.dart",AppValuesFilesLink().appValuesString.noInternetConnection);
      return null;
    }
  }

  //***************************************  patch   *******************************/
  //Post type request function with input data
  Future<Response> apiRequestpatch(
      {Key key,
      @required String url,
      @required bodyData,
      headersTemp,
      String authorization,
      bool isLoader}) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();

    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;

        if (authorization != null) {
          var headers1 = {"token": authorization};
          headers.addAll(headers1);
        }

        final response = await http
            .patch(fullUrl, headers: headers, body: bodyData)
            .timeout(Duration(seconds: readTimeout));
        projectUtil.printP("API", "$response");
        //Check response is empty or not
        if (response != null) {
          //Check data body is in response
          if (response.body != null) {
            var responseBody = response.body;
            //Parse message and data from response body
            ParserBasic mParserBasic =
                ParserBasic.fromJson(json.decode(responseBody));
            //Check Data is exist or not
            if (mParserBasic != null && mParserBasic.success == true) {
              var data = mParserBasic.data;
              //Check Data is exist or not
              if (data != null) {
                Response mResponse = new Response(true, mParserBasic.msg,
                    response.statusCode, responseBody.toString());
                return mResponse;
              } else {
                Response mResponse = new Response(
                    true, mParserBasic.msg, response.statusCode, null);
                return mResponse;
              }
            } else {
              Response mResponse = new Response(
                  false, mParserBasic.msg, response.statusCode, null);
              return mResponse;
            }
          } else {
            Response mResponse = new Response(
                false, "Please try again ", response.statusCode, null);
            return mResponse;
          }
        } else {
          Response mResponse =
              new Response(false, "Please try again ", 1000, null);
          return mResponse;
        }
      } catch (e) {
        try {
          if (e.runtimeType == SocketException ||
              e.runtimeType == TimeoutException) {
            projectUtil.printP(
                "api_request.dart", "Please check internet connection");
            Response mResponse =
                new Response(false, checkInternetMessage, -1000, null);
            return mResponse;
          } else {
            projectUtil.printP(
                "api_request.dart", "Error in requested api: " + e);
            Response mResponse = new Response(false, tryAgain, 1000, null);
            return mResponse;
          }
        } catch (e) {
          projectUtil.printP(
              "api_request.dart", "Error in requested api: " + e);
          Response mResponse = new Response(false, tryAgain, 1000, null);
          return mResponse;
        }
      }
    } else {
      projectUtil.printP("api_request.dart",
          AppValuesFilesLink().appValuesString.noInternetConnection);
      Response mResponse = new Response(
          false,
          AppValuesFilesLink().appValuesString.noInternetConnection,
          -1000,
          null);
      return mResponse;
    }
  }

  //Delete type request function with input data
  Future<Response> apiRequestDelete(
      {Key key,
      @required String url,
      String authorization,
      bool isLoader}) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;

        if (authorization != null) {
          var headers1 = {"token": authorization};
          headers.addAll(headers1);
        }

        final response = await http
            .delete(fullUrl, headers: headers)
            .timeout(Duration(seconds: readTimeout));
        projectUtil.printP("API", "$response");
        //Check response is empty or not
        if (response != null) {
          //Check data body is in response
          if (response.body != null) {
            var responseBody = response.body;
            //Parse message and data from response body
            ParserBasic mParserBasic =
                ParserBasic.fromJson(json.decode(responseBody));
            //Check Data is exist or not
            if (mParserBasic != null && mParserBasic.success == true) {
              // var data = mParserBasic.data;
              //Check Data is exist or not
              if (mParserBasic.success) {
                Response mResponse = new Response(true, mParserBasic.msg,
                    response.statusCode, responseBody.toString());
                return mResponse;
              } else {
                Response mResponse = new Response(
                    true, mParserBasic.msg, response.statusCode, null);
                return mResponse;
              }
            } else {
              Response mResponse = new Response(
                  false, mParserBasic.msg, response.statusCode, null);
              return mResponse;
            }
          } else {
            Response mResponse = new Response(
                false, "Please try again ", response.statusCode, null);
            return mResponse;
          }
        } else {
          Response mResponse =
              new Response(false, "Please try again ", 1000, null);
          return mResponse;
        }
      } catch (e) {
        try {
          if (e.runtimeType == SocketException ||
              e.runtimeType == TimeoutException) {
            projectUtil.printP(
                "api_request.dart", "Please check internet connection");
            Response mResponse =
                new Response(false, checkInternetMessage, -1000, null);
            return mResponse;
          } else {
            projectUtil.printP(
                "api_request.dart", "Error in requested api: " + e);
            Response mResponse = new Response(false, tryAgain, 1000, null);
            return mResponse;
          }
        } catch (e) {
          projectUtil.printP(
              "api_request.dart", "Error in requested api: " + e);
          Response mResponse = new Response(false, tryAgain, 1000, null);
          return mResponse;
        }
      }
    } else {
      projectUtil.printP("api_request.dart",
          AppValuesFilesLink().appValuesString.noInternetConnection);
      Response mResponse = new Response(
          false,
          AppValuesFilesLink().appValuesString.noInternetConnection,
          -1000,
          null);
      return mResponse;
    }
  }

  //Update single image
  Future<StreamedResponse> apiRequestMultipartAuthorizeWithoutBodyDataPatch(
      {Key key,
      String url,
      imageKey,
      imageFile,
      bool isLoader,
      String authorization}) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;
        if (authorization != null) {
          var headers1 = {"token": authorization};
          headers.addAll(headers1);
        }
        //String to uri
        var uri = Uri.parse(fullUrl);
        // create multipart request
        var request = http.MultipartRequest("PATCH", uri);
        request.headers.addAll(headers);
        try {
          if (imageFile != null) {
            // open a bytestream
            var stream = new http.ByteStream(
                DelegatingStream.typed(imageFile.openRead()));
            // get file length
            var length = await imageFile.length();
            // multipart that takes file
            var multipartFile = new http.MultipartFile(imageKey, stream, length,
                filename: basename(imageFile.path));
            // add file to multipart
            request.files.add(multipartFile);
          } else {
            projectUtil.printP("api_request.dart", 'image file not selected');
          }
        } catch (e) {
          projectUtil.printP(
              "api_request.dart", "Error in selected image: " + e);
        }
        final response = await request.send();
        return response;
      } catch (e) {
        projectUtil.printP("api_request.dart", "Error in requested api: " + e);
        return null;
      }
    } else {
      projectUtil.printP(
          "api_request.dart",AppValuesFilesLink().appValuesString.noInternetConnection);
      return null;
    }
  }

  //Convert multipart response
  Future<dynamic> convert(result) async {
    var response = await http.Response.fromStream(result);
    if (response != null) {
      if (response.statusCode == 200) {
        if (response.body != null) {
          var responseBody = response.body;
          ParserBasic mParserBasic =
              ParserBasic.fromJson(json.decode(responseBody));
          //Check Data is exist or not
          if (mParserBasic != null && mParserBasic.success != null) {
            var data = mParserBasic.data;
            //Check Data is exist or not
            if (data != null) {
              Response mResponse = new Response(true, mParserBasic.msg,
                  response.statusCode, responseBody.toString());
              return mResponse;
            }
            if (mParserBasic.success) {
              Response mResponse = new Response(true, mParserBasic.msg,
                  response.statusCode, responseBody.toString());
              return mResponse;
            } else {
              Response mResponse = new Response(
                  true, mParserBasic.msg, response.statusCode, null);
              return mResponse;
            }
          } else {
            Response mResponse = new Response(
                false, mParserBasic.msg, response.statusCode, null);
            return mResponse;
          }
        } else {
          Response mResponse = new Response(false,
              "Server Error Please try again", response.statusCode, null);
          return mResponse;
        }
      }
    }
  }

  //Function for check internet
  checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      projectUtil.printP("api_request.dart", "Connected to Mobile Network");
      Response mResponse =
          new Response(true, "Connected to Mobile Network", 1000, null);
      return mResponse;
      //return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      projectUtil.printP("api_request.dart", "Connected to WiFi");
      Response mResponse = new Response(true, "Connected to WiFi", 1000, null);
      return mResponse;
    } else {
      projectUtil.printP("api_request.dart",
          "Unable to connect. Please Check Internet Connection");
      Response mResponse =
          new Response(false, "Please check internet connection", 1000, null);
      return mResponse;
    }
  }

  Future<Response> apiRequestPostSendFCMNotification(
      {Key key,
      @required String url,
      @required bodyData,
      headersTemp,
      String authorization,
      bool isLoader}) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = "https://fcm.googleapis.com/fcm/send";
        authorization = 'key=${ConstantC.fcmAuthKey}';
        if (authorization != null) {
          // var headers1 = {"token": authorization};
          // headers.addAll(headers1);
          headers = {
            'content-type': 'application/json',
            'Authorization': authorization
          };
        }

        final response = await http
            .post(fullUrl,
                headers: headers,
                body: bodyData,
                encoding: Encoding.getByName('utf-8'))
            .timeout(Duration(seconds: readTimeout));
        projectUtil.printP("API", "$response");
        //Check response is empty or not
        if (response != null) {
          //Check data body is in response
          if (response.body != null) {
            var responseBody = response.body;
            //Parse message and data from response body
            ParserBasic mParserBasic =
                ParserBasic.fromJson(json.decode(responseBody));
            //Check Data is exist or not
            if (mParserBasic != null && mParserBasic.success == true) {
              var data = mParserBasic.data;
              //Check Data is exist or not
              if (data != null) {
                Response mResponse = new Response(true, mParserBasic.msg,
                    response.statusCode, responseBody.toString());
                return mResponse;
              } else {
                Response mResponse = new Response(
                    true, mParserBasic.msg, response.statusCode, null);
                return mResponse;
              }
            } else {
              Response mResponse = new Response(
                  false, mParserBasic.msg, response.statusCode, null);
              return mResponse;
            }
          } else {
            Response mResponse = new Response(
                false, "Please try again ", response.statusCode, null);
            return mResponse;
          }
        } else {
          Response mResponse =
              new Response(false, "Please try again ", 1000, null);
          return mResponse;
        }
      } catch (e) {
        try {
          if (e.runtimeType == SocketException ||
              e.runtimeType == TimeoutException) {
            projectUtil.printP(
                "api_request.dart", "Please check internet connection");
            Response mResponse =
                new Response(false, checkInternetMessage, -1000, null);
            return mResponse;
          } else {
            projectUtil.printP(
                "api_request.dart", "Error in requested api: " + e);
            Response mResponse = new Response(false, tryAgain, 1000, null);
            return mResponse;
          }
        } catch (e) {
          projectUtil.printP(
              "api_request.dart", "Error in requested api: " + e.toString());
          Response mResponse = new Response(false, tryAgain, 1000, null);
          return mResponse;
        }
      }
    } else {
      projectUtil.printP("api_request.dart",
          AppValuesFilesLink().appValuesString.noInternetConnection);
      Response mResponse = new Response(
          false,
          AppValuesFilesLink().appValuesString.noInternetConnection,
          -1000,
          null);
      return mResponse;
    }
  }

  Future<Response> apiRequestPostSendFCMNotificationOurServer(
      {Key key,
      @required String url,
      @required bodyData,
      headersTemp,
      String authorization,
      bool isLoader}) async {
    //Check Internet connection
    Response isInternetConnected = await checkInternetConnection();
    if (isInternetConnected != null && isInternetConnected.success) {
      try {
        String fullUrl = ConstantC.baseUrl + url;
        //authorization = 'key=${ConstantC.fcmAuthKey}';

        if (authorization != null) {
          var headers1 = {"token": authorization};
          headers.addAll(headers1);
        }
        //final response = await http.post(fullUrl, headers: headers,body:bodyData,encoding: Encoding.getByName('utf-8')).timeout(Duration(seconds: readTimeout));
        final response = await http
            .post(fullUrl, headers: headers, body: bodyData)
            .timeout(Duration(seconds: readTimeout));
        projectUtil.printP("API", "$response");
        //Check response is empty or not
        if (response != null) {
          //Check data body is in response
          if (response.body != null) {
            var responseBody = response.body;
            //Parse message and data from response body
            ParserBasic mParserBasic =
                ParserBasic.fromJson(json.decode(responseBody));
            //Check Data is exist or not
            if (mParserBasic != null && mParserBasic.success == true) {
              var data = mParserBasic.data;
              //Check Data is exist or not
              if (data != null) {
                Response mResponse = new Response(true, mParserBasic.msg,
                    response.statusCode, responseBody.toString());
                return mResponse;
              } else {
                Response mResponse = new Response(
                    true, mParserBasic.msg, response.statusCode, null);
                return mResponse;
              }
            } else {
              Response mResponse = new Response(
                  false, mParserBasic.msg, response.statusCode, null);
              return mResponse;
            }
          } else {
            Response mResponse = new Response(
                false, "Please try again ", response.statusCode, null);
            return mResponse;
          }
        } else {
          Response mResponse =
              new Response(false, "Please try again ", 1000, null);
          return mResponse;
        }
      } catch (e) {
        try {
          if (e.runtimeType == SocketException ||
              e.runtimeType == TimeoutException) {
            projectUtil.printP(
                "api_request.dart", "Please check internet connection");
            Response mResponse =
                new Response(false, checkInternetMessage, -1000, null);
            return mResponse;
          } else {
            projectUtil.printP(
                "api_request.dart", "Error in requested api: " + e);
            Response mResponse = new Response(false, tryAgain, 1000, null);
            return mResponse;
          }
        } catch (e) {
          projectUtil.printP(
              "api_request.dart", "Error in requested api: " + e.toString());
          Response mResponse = new Response(false, tryAgain, 1000, null);
          return mResponse;
        }
      }
    } else {
      projectUtil.printP("api_request.dart",
          AppValuesFilesLink().appValuesString.noInternetConnection);
      Response mResponse = new Response(
          false,
          AppValuesFilesLink().appValuesString.noInternetConnection,
          -1000,
          null);
      return mResponse;
    }
  }
}
