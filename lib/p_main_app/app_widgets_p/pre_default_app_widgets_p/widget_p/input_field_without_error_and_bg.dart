import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputFieldWithoutError extends StatelessWidget {
  
  final int keyboardType;
  final int inputAction;
  final int maxLength;
  final bool readOnly;
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hint;
  final double fontSize;
  final    Color hintTextColor;
  final int maxLines;
  final     bool autoFocus;
  final  EdgeInsetsGeometry padding;
  final     TextAlign textAlign;
  final Color fillColor;
  final    Color borderColor;
  final  Color focusedBorderColor;
  final    Color enabledBorder;
  final Color cursorColor;
  final    Color textColor;
  final TextStyle textStyle;
  final suffixIcon;
  final Function(String) ontextChanged;
  final Function(String) onSubmit;

  TextInputFieldWithoutError({Key key,
  this. keyboardType,
  this.inputAction,
  this.maxLength,
  this.readOnly,
  this.focusNode,
  this.controller,
  this.hint,
  this.fontSize,
  this.hintTextColor,
  this.maxLines,
  this.autoFocus,
  this.padding,
  this.textAlign,
  this.fillColor,
  this.borderColor,
  this.focusedBorderColor,
  this.enabledBorder,
  this.cursorColor,
  this.textColor,
  this.textStyle,
  this.suffixIcon,
  this.ontextChanged,this. onSubmit});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return TextField(
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        autofocus: autoFocus ?? false,
        textAlignVertical: TextAlignVertical.center,
        //textAlign: textAlign!=null?textAlign:TextAlign.left,
        keyboardType: keyboardType == 1
            ? TextInputType.number
            : keyboardType == 2
            ? TextInputType.emailAddress
            : keyboardType == 3 ? TextInputType.text : TextInputType.text,
        textCapitalization: keyboardType == 3
            ? TextCapitalization.words
            : keyboardType == 3
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        textInputAction: inputAction == 1
            ? TextInputAction.done
            : inputAction == 2
            ? TextInputAction.next
            : inputAction == 3
            ? TextInputAction.newline
            : TextInputAction.done,
        inputFormatters: keyboardType == 1
            ? <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
            : <TextInputFormatter>[],
        maxLength: maxLength,
       maxLines: maxLines != null ? maxLines : 1,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 20),
          counterText: "",
          border: InputBorder.none,
          suffixIcon:suffixIcon,
          hintText: hint,
        ),
        onSubmitted: onSubmit,
        style: textStyle ??
            TextStyle(
              color: textColor ??
                  AppValuesFilesLink().appValuesColors.textNormalColor[400],
            ),
        onChanged: ontextChanged,
        cursorColor: cursorColor != null
            ? cursorColor
            : AppValuesFilesLink().appValuesColors.editCursorColor,
      );
  }
}