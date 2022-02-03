import 'dart:io';

import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class MiniaturaPicker extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final File image;
  const MiniaturaPicker({
    Key key,
    @required this.onTap,
    @required this.image,
    @required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            color: Palette.skeleton,
            child: image == null
                ? const Center(
                    child: Text('Toca para tomar una foto'),
                  )
                : Image.file(
                    image,
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        Visibility(
          visible: image != null,
          child: Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Palette.cumbiaLight,
              ),
              onPressed: onDelete,
            ),
          ),
        )
      ],
    );
  }
}
