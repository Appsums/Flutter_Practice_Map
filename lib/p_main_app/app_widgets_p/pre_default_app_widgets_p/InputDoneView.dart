import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class InputDoneView extends StatelessWidget {
  final onPressCallback, buttonSubmitType;
  InputDoneView(this.onPressCallback, this.buttonSubmitType);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xFFE0E0E0),
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: CupertinoButton(
            padding: EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
            onPressed: () {
              //FocusScope.of(context).requestFocus(new FocusNode());
              onPressCallback();
            },
            child: Text("Done",
                style: TextStyle(
                    color: AppValuesFilesLink().appValuesColors.primaryColor,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
