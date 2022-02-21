import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CumbiaRadioButton extends StatelessWidget {

  final String title;
  final int value;
  final Function onChanged;
  final int groupValue;

  const CumbiaRadioButton({Key key,this.title, this.value, this.onChanged, this.groupValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      child: RadioListTile(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        title: Text(title),
      ),
    );  }
}
