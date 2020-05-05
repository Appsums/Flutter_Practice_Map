import 'package:baseapp/p_main_app/app_utility_p/pre_default_app_utility_p/ProjectUtil.dart';
import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/material.dart';

import 'PopUpMenu.dart';

class PoupMenuWidgets extends StatefulWidget {
  final List<Choice> itemList;
  final selectedCallBack;
  final menuView;
  PoupMenuWidgets(
      {Key key,
      this.menuView,
      @required this.itemList,
      @required this.selectedCallBack});

  @override
  _PoupMenuWidgetsState createState() => _PoupMenuWidgetsState(
      menuView: this.menuView,
      itemList: this.itemList,
      selectedCallBack: this.selectedCallBack);
}

class _PoupMenuWidgetsState extends State<PoupMenuWidgets> {
  List<Choice> choices = <Choice>[
    Choice(title: 'Edit', icon: Icons.edit),
    Choice(title: 'Delete', icon: Icons.delete),
  ];

  List<Choice> academicYearChoices = <Choice>[
    Choice(title: '1930 - 1934'),
    Choice(title: '1940 - 1944'),
    Choice(title: '1945 - 1949'),
    Choice(title: '1950 - 1954'),
    Choice(title: '1955 - 1959'),
    Choice(title: '1960 - 1964'),
    Choice(title: '1965 - 1969'),
    Choice(title: '1970 - 1974'),
    Choice(title: '1975 - 1979'),
    Choice(title: '1980 - 1984'),
    Choice(title: '1985 - 1989'),
    Choice(title: '1990 - 1994'),
    Choice(title: '1994 - 1999'),
    Choice(title: '2000 - 2004'),
    Choice(title: '2005 - 2009'),
    Choice(title: '2010 - 2014'),
    Choice(title: '2015 - 2019')
  ];

  List<Choice> itemList;
  var selectedCallBack;
  var menuView;

  _PoupMenuWidgetsState(
      {Key key, menuView, List<Choice> itemList, selectedCallBack}) {
    this.itemList = itemList;
    this.selectedCallBack = selectedCallBack;
    this.menuView = menuView;
    //
    if (itemList != null) {
      choices = new List();
      choices.addAll(this.itemList);
    }
  }

  @override
  Widget build(BuildContext context) {
    void _select(Choice choice) {
      String _selectedChoice = choice.title;
      selectedCallBack(_selectedChoice);
      // Causes the app to rebuild with the new _selectedChoice.
      projectUtil.printP("hkjdf", _selectedChoice);
    }

    Widget popupMenuButton() {
      return PopupMenuButtons<Choice>(
        //padding: EdgeInsets.only(top: 500),
        //icon: Icon(Icons.settings),
        child: this.menuView != null
            ? menuView
            : Container(
                child: Align(
                child: Container(
                  child: Image.asset(
                    'assets/images/chat_view/dot@3x.png',
                  ),
                  height: AppValuesFilesLink()
                      .appValuesDimens
                      .imageSquareAccordingScreen(value: 18),
                  width: AppValuesFilesLink()
                      .appValuesDimens
                      .imageSquareAccordingScreen(value: 18),
                ),
                alignment: Alignment.topCenter,
              )),
        onSelected: _select,
        itemBuilder: (BuildContext context) {
          return choices.skip(0).map((Choice choice) {
            // choice.mChatGroups = mChatGroups;
            return PopupMenuItems<Choice>(
              value: choice,
              child: Text(choice.title),
            );
          }).toList();
        },
      );
    }

    return popupMenuButton();
  }
}

class Choice {
  Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}
