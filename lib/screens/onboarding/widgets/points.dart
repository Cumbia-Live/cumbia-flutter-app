import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class Points extends StatelessWidget {
  const Points({
    @required this.parte,
  });
  final String parte;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 11,
            width: 11,
            decoration: parte == '1'
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.cumbiaLight,
                  )
                : BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Palette.cumbiaLight,
                    ),
                  ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 11,
            width: 11,
            decoration: parte == '2'
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.cumbiaLight,
                  )
                : BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Palette.cumbiaLight,
                    ),
                  ),
          ),
          Container(
            height: 11,
            width: 11,
            decoration: parte == '3'
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.cumbiaLight,
                  )
                : BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Palette.cumbiaLight,
                    ),
                  ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 11,
            width: 11,
            decoration: parte == '4'
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.cumbiaLight,
                  )
                : BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Palette.cumbiaLight,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
