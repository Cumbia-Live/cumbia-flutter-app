import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CumbiaTextButton extends StatelessWidget {
  const CumbiaTextButton({this.title, this.onPressed});

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? "Continuar",
            style: Styles.txtBtn(size: 15),
          ),
          CumbiaChevron(color: Palette.cumbiaDark),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
