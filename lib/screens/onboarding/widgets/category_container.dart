import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/category/live_category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    this.category,
    this.onPressed,

  });
  final LiveCategory category;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.only(right: 15,bottom:15),
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: category.isSelected ? Palette.cumbiaLight : Palette.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Palette.cumbiaLight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            category.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: category.isSelected ? Palette.white : Palette.cumbiaLight,
            ),
          ),
        ),
      ),
    );
  }
}
