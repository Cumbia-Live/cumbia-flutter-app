import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class CumbiaProfileIcon extends StatelessWidget {
  final String imageSource;
  final Function onPressed;
  final bool withoutIcon;

  const CumbiaProfileIcon({this.imageSource, this.onPressed, this.withoutIcon});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: withoutIcon ?? false
          ? Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Palette.cumbiaLight),
              child: Center(
                child: Text(
                  user.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      color: Palette.cumbiaDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          : Container(
              height: 25,
              width: 25,
              child: Image.asset(imageSource ?? user?.profilePictureURL,
                  fit: BoxFit.contain),
            ),
    );
  }
}
