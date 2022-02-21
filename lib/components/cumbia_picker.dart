import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/config/visual/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CumbiaPicker extends StatelessWidget {
  final String categoryName;
  final String title;
  final Function onPressed;
  final bool validateCategory;
  final FontStyle fontStyle;
  final bool check;
  final bool isSelected;

  const CumbiaPicker({
    this.title,
    this.categoryName,
    this.onPressed,
    this.validateCategory,
    this.fontStyle,
    this.check,
    this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? "Categoría",
              style: Styles.txtTitleLbl,
            ),
            CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text(
                  isSelected ? "Cambiar" : "Elegir",
                  style: TextStyle(
                      color: Palette.cumbiaDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
                onPressed: onPressed),
          ],
        ),
        !validateCategory
            ? Row(
                children: [
                  Text(
                    "$categoryName  ",
                    style: Styles.italicbl(fontStyle: fontStyle),
                  ),
                  isSelected
                      ? Icon(
                          Icons.check_circle_outline,
                          color: Palette.cumbiaDark,
                          size: 20,
                        )
                      : const SizedBox.shrink()
                ],
              )
            : Text(
                'Por favor, elige una categoría.',
                style: Styles.validationLbl,
              ),
      ],
    );
  }
}
