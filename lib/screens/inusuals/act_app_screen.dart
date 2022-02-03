import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActAppScreen extends StatefulWidget {
  @override
  _ActAppScreenState createState() => _ActAppScreenState();
}

class _ActAppScreenState extends State<ActAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: ShortMessageView(
        topWidget: AppIcon(),
        title: "Actualización requerida",
        label:
            "Esta versión de Agrupa expiró. Por favor, visita ${getDispositivoType() == Dispositivo.ios ? "App" : "Play"} Store para actualizarla.",
        buttonLabel: "Actualizar Agrupa",
        onPressed: () async {
          if (await canLaunch(updateURL)) {
            await launch(updateURL);
          } else {
            showBasicAlert(
              context,
              "No podemos abrir ${getDispositivoType() == Dispositivo.ios ? "App" : "Play"} Store.",
              "Por favor, intenta más tarde.",
            );
          }
        },
      ),
    );
  }
}
