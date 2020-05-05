import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'country_codes.dart';

class PhoneWithCountryPicker extends StatelessWidget {
  final keyboardType,
      initialCountryCode,
      inputAction,
      maxLength,
      readOnly,
      focusNode,
      focus,
      controller,
      hint,
      fontSize,
      error,
      focusedBorderWidth,
      borderRadius,
      errorColor,
      hintTextColor,
      maxLines,
      padding,
      textAlign,
      fillColor,
      borderColor,
      focusedBorderColor,
      enabledBorder,
      cursorColor,
      ontextChanged,
      countryChange,
      textStyle,
      onSubmit,inputFormatters;
  PhoneWithCountryPicker(
      {Key key,
        @required this.keyboardType,
        @required this.initialCountryCode,
        @required this.inputAction,
        @required this.maxLength,
        @required this.readOnly,
         this.focusNode,
         this.focus,
        @required this.controller,
        @required this.hint,
        @required this.fontSize,
        this.error,
        this.focusedBorderWidth,
        this.borderRadius,
        this.errorColor,
        this.hintTextColor,
        this.maxLines,
        this.padding,
        this.textAlign,
        this.fillColor,
        this.borderColor,
        this.focusedBorderColor,
        this.enabledBorder,
        this.cursorColor,
        this.textStyle,
        @required this.ontextChanged,
        @required this.countryChange,
        @required this.onSubmit,this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10,2.0,10,2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(
                color: error != null
                    ? AppValuesFilesLink().appValuesColors.editTextErrorColor
                    : AppValuesFilesLink().appValuesColors.appTransColor[700],
                width: 2 //                   <--- border color
            ),
            color: AppValuesFilesLink().appValuesColors.editTextBgColor[100],
          ),
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  //  width: screenWidth/5,
                  child: Container(
                      padding: EdgeInsets.only(right: 0),
                      color: AppValuesFilesLink()
                          .appValuesColors
                          .editTextBgColor[100],
                      child: CountryCodePicker(
                      onChanged: countryChange,
                      initialSelection: initialCountryCode,
                      favorite: ['+41','CH'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
    ),
    ),),

                Flexible(
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      readOnly: readOnly,
                      enableInteractiveSelection: true, //To remove selector
                      textAlignVertical: TextAlignVertical.center,
                      //textAlign: textAlign!=null?textAlign:TextAlign.left,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: inputAction == 1
                          ? TextInputAction.done
                          : inputAction == 2
                          ? TextInputAction.next
                          : TextInputAction.done,
                      /*  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],*/
                          inputFormatters: inputFormatters,

                      /*maxLength: maxLength,
                      maxLines: maxLines != null ? maxLines : 1,*/
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: fillColor != null
                              ? fillColor
                              : AppValuesFilesLink()
                              .appValuesColors
                              .editTextBgColor,
                          hintText: hint != null
                              ? hint
                              : AppValuesFilesLink()
                              .appValuesColors
                              .editTextHintColor,
                          contentPadding:
                          padding != null ? padding : EdgeInsets.all(0),
                          //counterText: inputAction == 3 ? (controller != null ? controller.text.length.toString() : '') : "",
                          counterText: "",
                          hintStyle: TextStyle(
                            color: hintTextColor != null
                                ? hintTextColor
                                : Colors.black87,
                            fontSize: fontSize,
                            //fontWeight: FontWeight.w300
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  borderRadius != null ? borderRadius : 0)),
                              borderSide: BorderSide(
                                color: borderColor != null
                                    ? borderColor
                                    : AppValuesFilesLink()
                                    .appValuesColors
                                    .appDisabledColor[400],
                                style: BorderStyle.none,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  borderRadius != null ? borderRadius : 0)),
                              borderSide: BorderSide(
                                  color: focusedBorderColor != null
                                      ? focusedBorderColor
                                      : AppValuesFilesLink()
                                      .appValuesColors
                                      .editTextEnabledBorderColor,
                                  style: BorderStyle.none,
                                  width: focusedBorderWidth != null
                                      ? focusedBorderWidth
                                      : 0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  borderRadius != null ? borderRadius : 0)),
                              borderSide: BorderSide(color: focusedBorderColor != null ? focusedBorderColor : AppValuesFilesLink().appValuesColors.editTextEnabledBorderColor, style: BorderStyle.none, width: focusedBorderWidth != null ? focusedBorderWidth : 0)),
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: errorColor != null ? errorColor : AppValuesFilesLink().appValuesColors.appErrorTextColor, style: BorderStyle.solid)),
                          //errorText: error,
                          errorMaxLines: 2),
                      onSubmitted: onSubmit,
                      style:textStyle?? TextStyle(
                        fontSize: fontSize,
                          color: AppValuesFilesLink()
                              .appValuesColors
                              .textNormalColor[400]),

                      onChanged: ontextChanged,
                      cursorColor: cursorColor != null
                          ? cursorColor
                          : AppValuesFilesLink().appValuesColors.editCursorColor,
                    ))
              ],
            ),
          ),
        ),
        error != null
            ? Padding(
          padding: EdgeInsets.only(top: 5, left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              error ?? '',
              style: TextStyle(
                  color: AppValuesFilesLink()
                      .appValuesColors
                      .editTextErrorColor,
                  fontSize: 12),
            ),
          ),
        )
            : Container()
      ],
    );
  }
}


class CountryCodePicker extends StatefulWidget {
  final ValueChanged<CountryCode> onChanged;
  //Exposed new method to get the initial information of the country
  final ValueChanged<CountryCode> onInit;
  final String initialSelection;
  final List<String> favorite;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final bool showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle searchStyle;
  final WidgetBuilder emptySearchBuilder;
  final Function(CountryCode) builder;

  /// shows the name of the country instead of the dialcode
  final bool showOnlyCountryWhenClosed;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widget.
  /// this is especially usefull in combination with [showOnlyCountryWhenClosed],
  /// because longer countrynames are displayed in one line
  final bool alignLeft;

  /// shows the flag
  final bool showFlag;

  /// contains the country codes to load only the specified countries.
  final List<String> countryFilter;

  CountryCodePicker({
    this.onChanged,
    this.onInit,
    this.initialSelection,
    this.favorite = const [],
    this.countryFilter = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.showCountryOnly = false,
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.emptySearchBuilder,
    this.showOnlyCountryWhenClosed = false,
    this.alignLeft = false,
    this.showFlag = true,
    this.builder,
  });

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codesE;

    List<CountryCode> elements = jsonList
        .map((s) => CountryCode(
      name: s['name'],
      code: s['code'],
      dialCode: s['dial_code'],
      flagUri: 'flags/${s['code'].toLowerCase()}.png',
    ))
        .toList();

    if(countryFilter.length > 0) {
      elements =  elements
          .where((c) => countryFilter.contains(c.code))
          .toList();
    }

    return new _CountryCodePickerState(elements);
  }
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  CountryCode selectedItem;
  List<CountryCode> elements = [];
  List<CountryCode> favoriteElements = [];

  _CountryCodePickerState(this.elements);
  @override
  Widget build(BuildContext context) {
    Widget _widget;
    if (widget.builder != null)
      _widget = InkWell(
        onTap: _showSelectionDialog,
        child: widget.builder(selectedItem),
      );
    else {
      _widget = GestureDetector(
        //padding: widget.padding,
        onTap: _showSelectionDialog,
        child:Container(
          margin: EdgeInsets.only(left: 12,right: 8),
          width: 40,
          child:  Flex(
            direction: Axis.horizontal,
            //mainAxisSize: MainAxisSize.min,

            children: <Widget>[
              widget.showFlag
                  ?  Image.asset(
                selectedItem.flagUri,
                package: 'country_code_picker',
                width: 32.0,
              )
                  : Container(),
              /*Flexible(
              fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
              child: Text(
                widget.showOnlyCountryWhenClosed
                    ? selectedItem.toCountryStringOnly()
                    : selectedItem.toString(),
                style: widget.textStyle ?? Theme.of(context).textTheme.button,
              ),
            ),*/
            ],
          ),
        ),
      );
    }
    return _widget;
  }

  @override
  void didUpdateWidget(CountryCodePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.initialSelection != widget.initialSelection) {
      if (widget.initialSelection != null) {
        selectedItem = elements.firstWhere(
                (e) =>
            (e.code.toUpperCase() == widget.initialSelection.toUpperCase()) ||
                (e.dialCode == widget.initialSelection.toString()),
            orElse: () => elements[0]);
      } else {
        selectedItem = elements[0];
      }
    }
  }

  @override
  initState() {
    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
              (e) =>
          (e.code.toUpperCase() == widget.initialSelection.toUpperCase()) ||
              (e.dialCode == widget.initialSelection.toString()),
          orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    //Change added: get the initial entered country information
    _onInit(selectedItem);

    favoriteElements = elements
        .where((e) =>
    widget.favorite.firstWhere(
            (f) => e.code == f.toUpperCase() || e.dialCode == f.toString(),
        orElse: () => null) !=
        null)
        .toList();
    super.initState();
  }

  void _showSelectionDialog() {
    showDialog(
      context: context,
      builder: (_) => SelectionDialog(elements, favoriteElements,
          showCountryOnly: widget.showCountryOnly,
          emptySearchBuilder: widget.emptySearchBuilder,
          searchDecoration: widget.searchDecoration,
          searchStyle: widget.searchStyle,
          showFlag: widget.showFlag),
    ).then((e) {
      if (e != null) {
        setState(() {
          selectedItem = e;
        });

        _publishSelection(e);
      }
    });
  }

  void _publishSelection(CountryCode e) {
    if (widget.onChanged != null) {
      widget.onChanged(e);
    }
  }

  void _onInit(CountryCode initialData){
    if(widget.onInit != null){
      widget.onInit(initialData);
    }
  }
}

