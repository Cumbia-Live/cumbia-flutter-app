import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';

import '../../../nav_screen.dart';

class SuccessProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            children: [
              CatapultaSpace(),
              ShortMessageView(
                topWidget: CumbiaIconRoundOutlined(
                  image: true,
                  imageSource: 'images/check.png',
                ),
                title: '¡Producto registrado \ncon éxito!',
                label:
                    // ignore: lines_longer_than_80_chars
                    'Puedes encontrar tu producto en la\nsección ¨Mis productos¨de tu perfil.',
                onPressed: () {},
              ),
              CatapultaSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    CumbiaButton(
                      title: 'Ver mis productos',
                      canPush: true,
                      onPressed: () {
                        Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => NavScreen(),
                        ),
                      );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
