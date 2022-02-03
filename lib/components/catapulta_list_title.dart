import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';

class CatapultaListTitle extends StatelessWidget {
  CatapultaListTitle({
    @required this.text,
    this.onTap,
    this.iconData,
    this.iconColor,
    this.withoutIcon = false,
  });

  final String text;
  final VoidCallback onTap;
  final IconData iconData;
  final Color iconColor;
  final bool withoutIcon;

  @override
  Widget build(BuildContext context) {
    return withoutIcon
        ? ListTile(
            leading: Text(
              text,
              style: Styles.configLbl,
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Palette.black.withOpacity(0.5),
            ),
            onTap: onTap,
          )
        : ListTile(
            leading: Icon(
              iconData,
              color: iconColor ?? Palette.black,
            ),
            title: Text(
              text,
              style: Styles.configLbl,
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Palette.black.withOpacity(0.5),
            ),
            onTap: onTap,
          );
  }
}
