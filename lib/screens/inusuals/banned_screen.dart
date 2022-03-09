import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannedScreen extends StatefulWidget {
  @override
  _BannedScreenState createState() => _BannedScreenState();
}

class _BannedScreenState extends State<BannedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: ShortMessageView(
        title: "Cuenta suspendida",
        label:
            "Un administrador suspendió tu cuenta porque incumpliste una norma comunitaria.",
        buttonLabel: "Escribir a soporte",
        onPressed: () {
          Contactar.escribir(context, support.wappNumber);
        },
      ),
    );
  }
}
