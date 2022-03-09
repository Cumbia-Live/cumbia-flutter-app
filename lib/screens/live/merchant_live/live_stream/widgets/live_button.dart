import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LiveButton extends StatelessWidget {
  LiveButton({
    @required this.onPressed,
    this.title,
    this.backgroundColor,
    this.isLoading = false,
    this.width,
    this.canPush = false,
   });

  String title;
  Color backgroundColor;
  Function onPressed;
  bool isLoading;
  double width;
  bool canPush;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 48,
          width: width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: canPush ? Palette.cumbiaLight : Palette.cumbiaRed,
          ),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: isLoading
                ? Center(
                    child: Container(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Palette.white),
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      title ?? "Continuar",
                      style: Styles.btn,
                    ),
                  ),
            onPressed: () {
              if (!isLoading) {
                onPressed();
              }
            },
          ),
        ),
      ],
    );
  }
}
