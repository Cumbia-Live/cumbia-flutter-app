import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class CumbiaDivider extends StatelessWidget {
  final EdgeInsets margin;
  final double height;

  const CumbiaDivider({Key key, this.margin, this.height = 6})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      height: height,
      width: double.infinity,
      color: Palette.lightGrey.withOpacity(0.5),
    );
  }
}
