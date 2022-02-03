import 'dart:io';

import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

 
class CumbiaImagePicker extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final File image;
  const CumbiaImagePicker({
    Key key,
    @required this.onTap,
    @required this.image,
    @required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: 200,
              width: 200,
              color: Palette.skeleton,
              child: image == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.upload_sharp,
                          color: Palette.black,
                          size: 60,
                        ),
                        Text(
                          'Sube una imagen \n del producto',
                          textAlign: TextAlign.center,
                        ),
                      ],
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
      ),
    );
  }
}
