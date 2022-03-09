import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CumbiaTextField extends StatelessWidget {
  CumbiaTextField(
      {Key key,
      this.placeholder,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.validator,
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
      this.title,
      this.textInputFormatters,
      this.prefixWidget,
      this.suffixWidget,
      this.enabled = true,
      this.onFieldSubmitted,
      this.suffixText,
      this.autovalidateMode,
      this.isAutocorrectActive = true,
      this.prefixText,
      this.optional = '',
      this.maxlines = 1,
      this.autofocus = false,
      this.labelTextColor,
      this.sizeLabeltext,
      this.isDark = false})
      : super(key: key);

  final String prefixText;
  final String placeholder;
  final String optional;
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
  final String title;
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
  final bool autofocus;
  final Color labelTextColor;
  final double sizeLabeltext;
  final bool isDark;
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
        Visibility(
          visible: title != null,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: title == null
                ? const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: Styles.txtTitleLbl.copyWith(
                          color: isDark?Palette.b5Grey :labelTextColor,
                          fontSize: sizeLabeltext,
                        ),
                      ),
                      Text(
                        optional,
                        style: Styles.optional,
                      ),
                    ],
                  ),
          ),
        ),
        TextFormField(
          autofocus: autofocus,
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
        validationText == "" || validationText == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  validationText,
                  style: Styles.validationLbl,
                ),
              ),
      ],
    );
  }
}
