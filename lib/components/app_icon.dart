import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({this.height, this.width, this.imgRoute});

  final double height;
  final double width;
  final String imgRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Palette.transparent),
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(
          image: AssetImage(imgRoute ?? "images/iconoApp.png"),
          fit: BoxFit.cover,
        ),
      ),
      height: height ?? 60,
      width: width ?? 60,
    );
  }
}
