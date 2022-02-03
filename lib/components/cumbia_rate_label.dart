

import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';

class CumbiaRateLabel extends StatelessWidget {
   CumbiaRateLabel({this.rate, this.percent, this.padding});

  final String rate;
  final String percent;
  var padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$rate", style: Styles.labelAdmin),
          Text(
            "$percent",
            style: Styles.labelBoldAdmin,
          ),
        ],
      ),
    );
  }
}