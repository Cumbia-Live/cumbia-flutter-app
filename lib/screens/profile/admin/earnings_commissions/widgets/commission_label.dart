import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class CommissionLabel extends StatelessWidget {
  const CommissionLabel(
      {@required this.label, @required this.rate, this.controller, this.onChanged});
  final String label;
  final String rate;
  final TextEditingController controller;
  final  ValueChanged<String> onChanged;
  static const _border = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(6.0),
    ),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
            child: Center(
              child: TextFormField(
                controller: controller,
                onChanged: onChanged,
                textAlign: TextAlign.center,
                style: Styles.txtTextLbl(),
                keyboardAppearance: Brightness.light,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Palette.skeleton,
                  filled: true,
                  suffixText: '%',
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 1, minHeight: 0),
                  hintStyle: Styles.placeholderLbl,
                  enabledBorder: _border,
                  focusedBorder: _border,
                  border: _border,
                  disabledBorder: _border,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
