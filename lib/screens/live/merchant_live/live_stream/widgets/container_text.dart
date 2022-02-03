import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerText extends StatelessWidget {
  ContainerText({
    @required this.title,
    @required this.label,
  });

  final String label;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Palette.b8Grey,
            fontSize: 14,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 15),
          padding: const EdgeInsets.all(8),
          height: 36,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Palette.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: Styles.txtTextLbl(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
