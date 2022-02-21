import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CumbiaCategoryFilter extends StatelessWidget {
  final String title; // Texto a presentar
  final bool isSelected; // Define si aparece coloreado o no
  final bool isRemovable; // Define si muestra la X o no
  final Function onPressed; // Se ejecuta al tocarlo

  const CumbiaCategoryFilter({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.isSelected = false,
    this.isRemovable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Container(
          height: 32,
          padding: EdgeInsets.only(bottom: !isSelected ? 2 : 0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedDefaultTextStyle(
              style: isSelected
                  ? Styles.txtTextLbl(size: 28, color: Palette.cumbiaLight)
                  : Styles.txtTextLbl(
                      size: 15,
                      color: Palette.black.withOpacity(0.5),
                    ),
              child: Text(title),
              duration: const Duration(milliseconds: 200),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
