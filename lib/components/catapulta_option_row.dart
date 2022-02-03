import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatapultaOptionRow extends StatelessWidget {
  CatapultaOptionRow({
    @required this.text,
    this.onTap,
    this.iconData,
  });

  String text;
  Function onTap;
  IconData iconData;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Row(
        children: <Widget>[
          iconData == null
              ? const SizedBox.shrink()
              : Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              iconData,
              size: 24,
              color: Palette.black.withOpacity(0.85),
            ),
          ),
          Container(
            color: Palette.bgColor,
            height: 50,
            child: Center(
              child: Text(
                '$text',
                style: Styles.configLbl,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Palette.bgColor,
              height: 50,
            ),
          ),
          Container(
            height: 50,
            color: Palette.bgColor,
            child: Icon(
              Icons.chevron_right,
              color: Palette.black.withOpacity(0.25),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
