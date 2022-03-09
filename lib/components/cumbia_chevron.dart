import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class CumbiaChevron extends StatelessWidget {
  final Color color;

  const CumbiaChevron({this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.chevron_right,
      size: 18,
      color: color ?? Palette.black.withOpacity(0.25),
    );
  }
}
