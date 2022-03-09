import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class StatsListTitle extends StatelessWidget {
  const StatsListTitle(
      {@required this.title,
      @required this.label,
       this.number,
      @required this.label2,
      this.number2,
      @required this.label3,
      this.number3,
      @required this.label4,
      this.numberString,
      this.number2String,
      this.number3String,
      this.number4String,
      this.number4,
      this.label5,
      this.number5,
      this.isDate = false});

  final String title;
  final String label;
  final int number;
  final String label2;
  final int number2;
  final String label3;
  final int number3;
  final String label4;
  final int number4;
  final String numberString;
  final String number2String;
  final String number3String;
  final String number4String;
  final String label5;
  final int number5;
  final bool isDate;

  @override
  Widget build(BuildContext context) {
    const _style1 = TextStyle(
      color: Palette.cumbiaDark,
      fontSize: 14,
    );
    const _style2 = TextStyle(
      color: Palette.black,
      fontSize: 14,
    );
    const _sBox = SizedBox(height: 16);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          _sBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: isDate ? _style2 : _style1,
              ),
              Text(
                number == null ? '$numberString' : '$number',
                style: isDate ? _style2 : _style1,
              ),
            ],
          ),
          _sBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label2,
                style: _style2,
              ),
              Text(
                number2 == null ? '$number2String' : '$number2',
                style: _style2,
              ),
            ],
          ),
          _sBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label3,
                style: _style2,
              ),
              Text(
                number3 == null ? '$number3String' : '$number3',
                style: _style2,
              ),
            ],
          ),
          _sBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label4,
                style: _style2,
              ),
              Text(
                number4 == null ? '$number4String' : '$number4',
                style: _style2,
              ),
            ],
          ),
          _sBox,
          label5 == null
              ? const SizedBox.shrink()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label5,
                      style: _style2,
                    ),
                    Text(
                      '$number5',
                      style: _style2,
                    ),
                  ],
                ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
