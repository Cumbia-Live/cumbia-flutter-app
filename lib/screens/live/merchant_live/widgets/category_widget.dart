import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    @required this.onTap,
    this.category,
    @required this.placeHolder,
    @required this.title,
    this.showCheck = true,
    Key key,
  }) : super(key: key);
  final LiveCategory category;
  final VoidCallback onTap;
  final String placeHolder;
  final String title;
  final bool showCheck;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
            ),
            TextButton(
              onPressed: onTap,
              child: Text(
                category != null ? 'Cambiar' : 'Elegir',
              ),
            )
          ],
        ),
        category != null
            ? Row(
                children: [
                  Text(
                    category.name,
                  ),
                  const SizedBox(width: 5),
                  Visibility(
                    visible: showCheck,
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Palette.cumbiaDark,
                      size: 20,
                    ),
                  ),
                ],
              )
            : Text(
                placeHolder,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
      ],
    );
  }
}
