import 'package:baseapp/p_main_app/app_widgets_p/pre_default_app_widgets_p/widget_p/input_field_without_error_and_bg.dart';
import 'package:baseapp/p_main_app/app_widgets_p/pre_default_app_widgets_p/widget_p/input_payment_card_field_without_error_and_bg.dart';
import 'package:baseapp/p_main_app/app_widgets_p/pre_default_app_widgets_p/BottomSheetCardView.dart';

import 'package:baseapp/p_main_app/app_widgets_p/pre_default_app_widgets_p/CustomUiWidget.dart';
import 'package:flutter/material.dart';

class AppWidgetFilesLink {
  // Application main default files
  CustomUiWidget appCustomUiWidget = new CustomUiWidget();
  BottomSheetCardView appBottomSheetCardView(
          {Key key, showHide, cardBodyView, sheetDismis}) =>
      new BottomSheetCardView(
          showHide: showHide,
          cardBodyView: cardBodyView,
          sheetDismis: sheetDismis);


  TextInputFieldWithoutError mTextInputFieldWithoutError({Key key,
    @required int keyboardType,
    @required int inputAction,
    @required int maxLength,
    @required bool readOnly,
    @required FocusNode focusNode,
    @required TextEditingController controller,
    @required String hint,
    @required double fontSize,
    String error,
    double borderRadius,
    Color errorColor,
    Color hintTextColor,
    int maxLines,
    bool autoFocus,
    EdgeInsetsGeometry padding,
    TextAlign textAlign,
    Color fillColor,
    Color borderColor,
    Color focusedBorderColor,
    Color enabledBorder,
    Color cursorColor,
    Color textColor,
    TextStyle textStyle,
     suffixIcon,
    @required Function(String) ontextChanged,
    @required Function(String) onSubmit}) =>
      TextInputFieldWithoutError(
       keyboardType:keyboardType,
      inputAction:inputAction,
      maxLength: maxLength,
      readOnly: readOnly,
      focusNode: focusNode,
      controller:controller,
      hint:hint,
      fontSize: fontSize,
      hintTextColor: hintTextColor,
      maxLines: maxLines,
      autoFocus: autoFocus,
      padding: padding,
          suffixIcon: suffixIcon,
      textAlign: textAlign,
      fillColor: fillColor,
      borderColor: borderColor,
      enabledBorder:enabledBorder,
      cursorColor: cursorColor,
      textColor: textColor,
      textStyle: textStyle,
      ontextChanged: ontextChanged,
  onSubmit: onSubmit);
  //Application specific module file

  TextPaymentCardInputFieldWithoutError mCardInputFieldWithoutError({Key key,
    @required int keyboardType,
    @required int inputAction,
    @required int maxLength,
    @required bool readOnly,
    @required FocusNode focusNode,
    @required TextEditingController controller,
    @required String hint,
    @required double fontSize,
    String error,
    double borderRadius,
    Color errorColor,
    Color hintTextColor,
    int maxLines,
    bool autoFocus,
    EdgeInsetsGeometry padding,
    TextAlign textAlign,
    Color fillColor,
    Color borderColor,
    Color focusedBorderColor,
    Color enabledBorder,
    Color cursorColor,
    Color textColor,
    TextStyle textStyle,
     suffixIcon,
    @required Function(String) ontextChanged,
    @required Function(String) onSubmit,List<MaskedTextInputFormatter> cardInputFormat}) =>
      TextPaymentCardInputFieldWithoutError(
       keyboardType:keyboardType,
      inputAction:inputAction,
      maxLength: maxLength,
      readOnly: readOnly,
      focusNode: focusNode,
      controller:controller,
      hint:hint,
      fontSize: fontSize,
      hintTextColor: hintTextColor,
      maxLines: maxLines,
      autoFocus: autoFocus,
      padding: padding,
          suffixIcon: suffixIcon,
      textAlign: textAlign,
      fillColor: fillColor,
      borderColor: borderColor,
      enabledBorder:enabledBorder,
      cursorColor: cursorColor,
      textColor: textColor,
      textStyle: textStyle,
      ontextChanged: ontextChanged,
      onSubmit: onSubmit,cardInputFormat: cardInputFormat);
  //Application specific module file

}
