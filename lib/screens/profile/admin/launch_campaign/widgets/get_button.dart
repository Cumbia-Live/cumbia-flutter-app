import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetButton extends StatelessWidget {
  const GetButton({
    this.canPush = false,
    this.onPressed,
    this.title
  });

  final bool canPush;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 33,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: !canPush ? Palette.cumbiaDark : Palette.grey,
          ),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Palette.white,
                ),
              ),
            ),
            onPressed: onPressed
          ),
        ),
      ],
    );
  }
}
