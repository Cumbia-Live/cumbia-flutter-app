import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class RateLabel extends StatelessWidget {
  const RateLabel({
    @required this.label,
    @required this.rate,
  });
  final String label;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Palette.b5Grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              color: Palette.txtBgColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '$rate%' ?? '...',
                style: TextStyle(
                  color: Palette.black,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
