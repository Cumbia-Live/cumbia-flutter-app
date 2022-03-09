import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Q2TextField extends StatelessWidget {
  Q2TextField(
      {Key key,
      @required this.placeholder,
      this.keyboardType = TextInputType.text,
      @required this.controller,
      @required this.validator,
      this.isPassword = false,
      this.onChanged,
      this.onTap,
      this.onEditingComplete,
      this.imageRoute,
      this.iconColor,
      this.initialValue,
      this.textCapitalization = TextCapitalization.none,
      this.validationText,
      this.maxLength,
      this.textInputFormatters,
      this.prefixWidget,
      this.suffixWidget,
      this.enabled = true,
      this.onFieldSubmitted,
      this.suffixText,
      this.autovalidateMode,
      this.isAutocorrectActive = true,
      this.prefixText,
      this.optinal = '',
      this.maxlines = 1,
      @required this.text1,
      @required this.text2})
      : super(key: key);

  final String prefixText;
  final String placeholder;
  final String optinal;
  final TextInputType keyboardType;
  final bool isPassword;
  final ValueChanged<String> onChanged;
  final GestureTapCallback onTap;
  final VoidCallback onEditingComplete;
  final String imageRoute;
  final Color iconColor;
  final String initialValue;
  final TextCapitalization textCapitalization;
  final String validationText;
  final int maxLength;
  final List<TextInputFormatter> textInputFormatters;
  final Widget prefixWidget;
  final AutovalidateMode autovalidateMode;
  final Widget suffixWidget;
  final bool enabled;
  final ValueChanged<String> onFieldSubmitted;
  final String Function(String value) validator;
  final String suffixText;
  final bool isAutocorrectActive;
  final TextEditingController controller;
  final int maxlines;
  final String text1;
  final String text2;
  static const _border = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(6.0),
    ),
    borderSide: BorderSide.none,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            textAlign: TextAlign.start,
            text: TextSpan(
              text: text1,
              style: TextStyle(
                  fontSize: 10, color: Palette.black.withOpacity(0.7)),
              children: <TextSpan>[
                TextSpan(
                  text: ' $text2',
                  style: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: Palette.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.42,
          child: TextFormField(
            controller: controller,
            key: key,
            enabled: enabled,
            validator: validator,
            maxLines: maxlines,
            autovalidateMode: autovalidateMode,
            style: Styles.txtTextLbl(),
            keyboardAppearance: Brightness.light,
            textCapitalization: textCapitalization,
            autocorrect: isAutocorrectActive,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              fillColor: Palette.skeleton,
              filled: true,
              prefixIcon: prefixWidget,
              hintText: placeholder,
              suffixText: suffixText,
              suffix: suffixWidget,
              prefixIconConstraints: BoxConstraints(minWidth: 1, minHeight: 0),
              prefixText: prefixText,
              hintStyle: Styles.placeholderLbl,
              enabledBorder: _border,
              focusedBorder: _border,
              border: _border,
              disabledBorder: _border,
            ),
            inputFormatters: textInputFormatters,
            keyboardType: keyboardType,
            obscureText: isPassword,
            onChanged: onChanged,
            onTap: onTap,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ),
      ],
    );
  }
}
