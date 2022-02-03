import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class CumbiaDataPicker extends StatefulWidget {
  CumbiaDataPicker({
    this.list,
    this.selectedItem,
  });

  String selectedItem;
  List<String> list = [];

  @override
  _CumbiaDataPickerState createState() => _CumbiaDataPickerState();
}

class _CumbiaDataPickerState extends State<CumbiaDataPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Palette.skeleton,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButton<String>(
            hint: Text(
              widget.selectedItem,
              style: Styles.txtTextLbl(),
            ),
            elevation: 30,
            isExpanded: true,
            isDense: true,
            underline: const SizedBox.shrink(),
            items: widget.list.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  child: Text(
                    value,
                    style: Styles.txtTextLbl(),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String value) {
              setState(() {
                widget.selectedItem = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
