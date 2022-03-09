import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/screens/home/home_screen.dart';
import 'package:cumbialive/screens/nav_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
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
                imageSource: "images/check.png",
              ),
              title: "¡Solicitud enviada!",
              label:
                  "Estaremos revisando tu solicitud para ser Aliado Cumbia y nos pondremos en contacto a la brevedad.",
              onPressed: () {
                //print("SUGERIR PRODUCTOS");
              },
            ),
            CatapultaSpace(),
            _button()
          ],
        ),
      )),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          CumbiaButton(
            title: "¡Listo!",
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
    );
  }
}
