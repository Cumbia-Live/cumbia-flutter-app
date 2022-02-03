import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class CatapultaDivider extends StatelessWidget {
  final EdgeInsets margin;
  final double height;

  const CatapultaDivider({Key key, this.margin, this.height = 1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      height: height,
      width: double.infinity,
      color: Palette.grey.withOpacity(0.4),
    );
  }
}
