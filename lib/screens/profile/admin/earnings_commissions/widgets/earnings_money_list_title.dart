import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EarningsMoneyListTitle extends StatelessWidget {
  const EarningsMoneyListTitle({
    @required this.title,
    @required this.label,
    @required this.number,
    @required this.label2,
    @required this.number2,
    this.label3,
    this.number3,
    this.label4,
    this.number4,
  });

  final String title;
  final String label;
  final int number;
  final String label2;
  final int number2;
  final String label3;
  final int number3;
  final String label4;
  final int number4;

  @override
  Widget build(BuildContext context) {
    const _style1 = TextStyle(
      color: Palette.cumbiaLight,
      fontSize: 14,
    );
    const _style2 = TextStyle(
      color: Palette.black,
      fontSize: 14,
    );
    const _sBox = SizedBox(height: 16);
    const _shrink = SizedBox.shrink();
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
                style: _style2,
              ),
              Text(
                '${NumberFormat.simpleCurrency().format(number).replaceAll('.00', '').replaceAll(',', '.')} COP',
                style: _style1,
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
                '${NumberFormat.simpleCurrency().format(number2).replaceAll('.00', '').replaceAll(',', '.')} COP',
                style: _style1,
              ),
            ],
          ),
          number3 == null?_shrink:_sBox,
          number3 == null?_shrink:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label3,
                style: _style2,
              ),
              Text(
                '${NumberFormat.simpleCurrency().format(number3).replaceAll('.00', '').replaceAll(',', '.')} COP',
                style: _style1,
              ),
            ],
          ),
          number3 == null || number4 == null? _shrink:_sBox,
          number3 == null|| number4 == null?_shrink:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label4,
                style: _style2,
              ),
              Text(
                '$number4',
                style: _style1,
              ),
            ],
          ),
          number3 == null|| number4 == null?_shrink:_sBox,
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
