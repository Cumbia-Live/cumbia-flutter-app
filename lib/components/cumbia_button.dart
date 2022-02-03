import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CumbiaButton extends StatelessWidget {
  CumbiaButton({
    @required this.onPressed,
    this.title,
    this.backgroundColor,
    this.shadowColor,
    this.isLoading = false,
    this.width,
    this.canPush = false,
    this.withCheck = false,
  });

  String title;
  Color backgroundColor;
  Color shadowColor;
  Function onPressed;
  bool isLoading;
  double width;
  bool canPush;
  bool withCheck;

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
            color:
                canPush ? backgroundColor ?? Palette.cumbiaLight : Palette.grey,
          ),
          child: Stack(
            children: [
              CupertinoButton(
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
              withCheck
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Palette.cumbiaDark,
                              size: 25,
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ],
    );
  }
}
