import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/material.dart';

class SearchAppBar {
//App bar
  Widget searchAppBar({
    Key key,
    double statusbarHeight,
    double backIconleftPadding,
    String inputValue,
    Color appBarBackIconColor,
    double iconSize,
    Color appBarBgColor,
    @required searchController,
    @required Function() cancelButtonPress,
    @required Function() onSearchTextChange(value),
    @required Function() onSearchSubmit(value),
    @required Function() onBackPressed,
  }) {
    return PreferredSize(
        preferredSize: Size(
            AppValuesFilesLink().appValuesDimens.widthFullScreen(),
            AppValuesFilesLink().appValuesDimens.heightDynamic(
                  value: 75,
                )),
        child: Container(
          color: appBarBgColor,
          padding: EdgeInsets.only(
            top: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(
                  value: 41,
                ),
            bottom: AppValuesFilesLink().appValuesDimens.verticalMarginPadding(
                  value: 5,
                ),
            left: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(
                  value: backIconleftPadding ?? 20,
                ),
            right: AppValuesFilesLink().appValuesDimens.horizontalMarginPadding(
                  value: 20,
                ),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: IconButton(
                  icon: new ImageIcon(
                    new AssetImage(
                        "assets/images/back_arrow_appbar/back_arrow@3x.png"),
                    color: appBarBackIconColor,
                    size: iconSize,
                  ),
                  onPressed: ()=>onBackPressed(),
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(
                      left: AppValuesFilesLink()
                          .appValuesDimens
                          .horizontalMarginPadding(value: 5)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: AppValuesFilesLink()
                          .appValuesColors
                          .cardBgColor[100]),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 20),
                        top: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 5),
                        bottom: AppValuesFilesLink()
                            .appValuesDimens
                            .verticalMarginPadding(value: 5),
                        right: AppValuesFilesLink()
                            .appValuesDimens
                            .horizontalMarginPadding(value: 5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/images/home/search@3x.png'),
                          width: AppValuesFilesLink()
                              .appValuesDimens
                              .widthDynamic(value: 18),
                          height: AppValuesFilesLink()
                              .appValuesDimens
                              .heightDynamic(value: 18),
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: AppValuesFilesLink()
                                      .appValuesDimens
                                      .verticalMarginPadding(value: 20),
                                  top: AppValuesFilesLink()
                                      .appValuesDimens
                                      .verticalMarginPadding(value: 5)),
                              child: TextField(
                                  controller: searchController,
                                  style: TextStyle(
                                    fontSize: AppValuesFilesLink()
                                        .appValuesDimens
                                        .fontSize(value: 17),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: AppValuesFilesLink()
    .appValuesString
    .search,
                                    hintStyle: TextStyle(
                                        fontSize: AppValuesFilesLink()
                                            .appValuesDimens
                                            .fontSize(value: 17),
                                        color: AppValuesFilesLink()
                                            .appValuesColors
                                            .editTextColor[400],
                                        fontWeight: FontWeight.w500),
                                    suffixIcon: (inputValue != null &&
                                            inputValue
                                                    .toString()
                                                    .trim()
                                                    .length >
                                                0)
                                        ? GestureDetector(
                                            onTap: cancelButtonPress,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                AppValuesFilesLink()
                                                    .appValuesDimens
                                                    .verticalMarginPadding(
                                                        value: 11),
                                                AppValuesFilesLink()
                                                    .appValuesDimens
                                                    .verticalMarginPadding(
                                                        value: 11),
                                                AppValuesFilesLink()
                                                    .appValuesDimens
                                                    .verticalMarginPadding(
                                                        value: 11),
                                                AppValuesFilesLink()
                                                    .appValuesDimens
                                                    .verticalMarginPadding(
                                                        value: 11),
                                              ),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/images/home/cross@3x.png'),
                                                width: 0,
                                                height: 0,
                                              ),
                                            ),
                                          )
                                        : Container(height: 0,width: 0,),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  cursorColor: Colors.transparent,
                                  onChanged: onSearchTextChange,
                                  onSubmitted: onSearchSubmit)),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
