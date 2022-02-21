import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class CumbiaIconRoundOutlined extends StatelessWidget {
  final double height;
  final double width;
  final IconData iconData;
  final double size;
  final bool image;
  final String imageSource;

  const CumbiaIconRoundOutlined({this.height, this.width, this.iconData, this.size, this.image, this.imageSource});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

      ),
      child: image ?? false
      ? Image.asset(imageSource,height: 150,)
      :Icon(
        iconData,
        size: size ?? 28,
        color: Palette.black.withOpacity(0.85),
      ),
    );
  }
}
