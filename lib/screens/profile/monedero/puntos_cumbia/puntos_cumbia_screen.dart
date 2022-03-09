import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import 'package:cumbialive/components/components.dart';

class PuntosCumbiaScreen extends StatelessWidget {
  const PuntosCumbiaScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.darkModeBGColor,
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.white,
        middle: Text(
          'Puntos Cumbia',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        backgroundColor: Palette.darkModeBGColor,
      ),
      body: SafeArea(
        child: Container(
          child: CatapultaScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: double.infinity, height: 60.0),
                  Text(
                    '300',
                    style: TextStyle(
                        color: Palette.cumbiaLight,
                        fontSize: 80,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Puntos Cumbia',
                    style:
                        TextStyle(color: Palette.cumbiaLight, fontSize: 18.0),
                  ),
                  SizedBox(height: 30.0),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Los puntos cumbia son',
                        style: TextStyle(color: Palette.cumbiaGrey),
                        children: [
                          TextSpan(
                            text: ' unidades que miden la bonificación extra',
                            style: TextStyle(color: Palette.white),
                          ),
                          TextSpan(
                            text: ' que Cumbia Live te entrega por tus ventas, '
                                'podrás acumular y redimir tus puntos '
                                'mensualmente siempre y',
                            style: TextStyle(color: Palette.cumbiaGrey),
                          ),
                          TextSpan(
                            text: ' cuando cumplas las horas mínimas requeridas'
                                ' de transmisión.',
                            style: TextStyle(color: Palette.white),
                          ),
                        ]),
                  ),
                  SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Horas transmitidas',
                        style: TextStyle(color: Palette.cumbiaGrey),
                      ),
                      Text(
                        '20',
                        style: TextStyle(color: Palette.cumbiaGrey),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Horas requeridas',
                        style: TextStyle(color: Palette.cumbiaLight),
                      ),
                      Text(
                        '30',
                        style: TextStyle(color: Palette.cumbiaLight),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  CumbiaButton(
                      onPressed: () {},
                      title: 'Canjear Puntos Cumbia',
                      backgroundColor: Palette.cumbiaGrey),
                  SizedBox(height: 30.0),
                  CatapultaDivider(height: 2.0),
                  SizedBox(height: 15.0),
                  Text('¡Atención!',
                      style: TextStyle(
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0)),
                  SizedBox(height: 5.0),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Estos puntos se ',
                        style: TextStyle(color: Palette.cumbiaGrey),
                        children: [
                          TextSpan(
                              text: 'reinician cada 30 días',
                              style: TextStyle(color: Palette.white)),
                          TextSpan(
                            text: ', trata de redimirlos antes de este tiempo.',
                            style: TextStyle(color: Palette.cumbiaGrey),
                          )
                        ]),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Quedan 17 días',
                    style: TextStyle(
                        color: Palette.cumbiaLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  SizedBox(height: 15.0),
                  CatapultaDivider(height: 2.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
