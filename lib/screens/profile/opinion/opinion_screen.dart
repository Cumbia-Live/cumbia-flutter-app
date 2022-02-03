import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';

import '../../../config/config.dart';
import 'package:cumbialive/components/components.dart';

class OpinionScreen extends StatelessWidget {
  const OpinionScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.bgColor,
        appBar: CupertinoNavigationBar(
          border: Border.symmetric(),
         // actionsForegroundColor: Palette.black,
          middle: Text(
            '¿Qué opinas?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Palette.black,
            ),
          ),
          backgroundColor: Palette.bgColor,
        ),
        body: SafeArea(
          child: Container(
            child: CatapultaScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: double.infinity, height: 40.0),
                    Image(
                      height: MediaQuery.of(context).size.width / 2.5,
                      image: AssetImage('images/icono.png'),
                    ),
                    SizedBox(height: 20.0),
                    RichText(
                      text: TextSpan(
                          text: 'CUMBIA',
                          style: Styles.largeTitleLbl
                              .copyWith(color: Palette.black, fontSize: 55.0),
                          children: [
                            TextSpan(
                              text: ' LIVE',
                              style:
                                  Styles.largeTitleLbl.copyWith(fontSize: 55.0),
                            )
                          ]),
                    ),
                    SizedBox(height: 40.0),
                    Text(
                        'Para el equipo de cumbia live es muy\nimportante saber '
                        'qué opinas de\nnuestro producto, así '
                        'podemos\nmejorarlo cada día.',
                        style: TextStyle(
                            color: Palette.cumbiaIconGrey,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    SizedBox(height: 40.0),
                    CumbiaTextField(
                        title: 'Comentario o sugerencia',
                        maxlines: 4,
                        placeholder:
                            'Escribe aquí una sugerencia para Cumbia Live',
                        validator: null),
                    SizedBox(height: 30.0),
                    CumbiaButton(
                        onPressed: () {
                          showAlert(
                            context: context,
                            title: "ENVIAR COMENTARIO",
                          );
                        },
                        title: 'Enviar comentario',
                        backgroundColor: Palette.cumbiaLight),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
