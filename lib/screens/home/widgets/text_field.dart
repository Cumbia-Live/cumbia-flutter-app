import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/config/visual/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.placeholder,
    this.keyboardType,
    this.isPassword,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.imageRoute,
    this.iconColor,
    this.initialValue,
    this.textCapitalization,
    this.validationText,
    this.autofocus,
    this.maxLength,
    this.title,
    this.textInputFormatters,
    this.prefixWidget,
    this.suffixWidget,
    this.key,
    this.width,
    this.enabled,
    this.onFieldSubmitted,
    this.suffixText,
    this.isAutocorrectActive = true,
    this.controller
  });

  Key key;
  String placeholder;
  TextInputType keyboardType;
  bool isPassword;
  Function onChanged;
  Function onTap;
  Function onEditingComplete;
  String imageRoute;
  Color iconColor;
  String initialValue;
  TextCapitalization textCapitalization;
  String validationText;
  bool autofocus;
  int maxLength;
  String title;
  List<TextInputFormatter> textInputFormatters;
  Widget prefixWidget;
  Widget suffixWidget;
  double width;
  bool enabled = true;
  Function onFieldSubmitted;
  String suffixText;
  bool isAutocorrectActive;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title == null
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text(
                    title,
                    style: Styles.txtTitleLbl,
                  ),
                ),
          Stack(
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: validationText != null && validationText != ""
                      ? Palette.transparent
                      : Palette.txtBgColor,
                  border: Border.all(
                    color: onChanged == null
                        ? Palette.transparent
                        : validationText != null && validationText != ""
                            ? Palette.red
                            : Palette.transparent,
                    width: 2,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: prefixWidget == null
                        ? 16
                        : onChanged == null
                            ? 8
                            : 18),
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    prefixWidget ?? const SizedBox.shrink(),
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        key: key,
                        enabled: enabled,
                        autofocus: autofocus ?? false,
                        style: Styles.txtTextLbl(),
                        keyboardAppearance: Brightness.light,
                        textCapitalization:
                            textCapitalization ?? TextCapitalization.none,
                        autocorrect: isAutocorrectActive,
                        initialValue: initialValue,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: placeholder,
                          suffixText: suffixText ?? "",
                          hintStyle: Styles.placeholderLbl,
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Palette.transparent)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Palette.transparent)),
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Palette.transparent)),
                          disabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Palette.transparent)),
                        ),
                        inputFormatters: textInputFormatters ?? [],
                        keyboardType: keyboardType ?? TextInputType.text,
                        obscureText: isPassword ?? false,
                        onChanged: onChanged,
                        onTap: onTap,
                        onEditingComplete: onEditingComplete,
                        onFieldSubmitted: onFieldSubmitted,

                      ),
                    ),
                    suffixWidget ?? const SizedBox.shrink(),

                  ],
                ),
              ),
            ],
          ),
          validationText != null && validationText != ""
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Container(
                    child: Text(
                      validationText ?? 'Por favor, rellena este campo.',
                      style: Styles.validationLbl,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}