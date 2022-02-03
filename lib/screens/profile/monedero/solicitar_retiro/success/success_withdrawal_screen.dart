import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../screens.dart';

class SuccessWithdrawalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Palette.darkModeBGColor,
    body: SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
            CatapultaSpace(),
            ShortMessageView(
              isDark: true,
              topWidget: CumbiaIconRoundOutlined(
                image: true,
                imageSource: 'images/check.png',
              ),
              title: '¡Retiro solicitado con\néxito!',
              label:
                  // ignore: lines_longer_than_80_chars
                  'Puedes encontrar solicitud de retiro en la sección "Movimientos" de tu monedero.',
              onPressed: () {},
            ),
            CatapultaSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  CumbiaButton(
                    title: 'Aceptar',
                    canPush: true,
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ProfileScreen(),
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
