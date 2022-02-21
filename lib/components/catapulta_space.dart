import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class CatapultaSpace extends StatelessWidget {
  const CatapultaSpace({
    this.flex,
    this.color,
  });

  final int flex;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Container(
        width: 0,
        color: color ?? Palette.transparent,
      ),
    );
  }
}
