import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/screens/onboarding/widgets/points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens.dart';

class EmeraldsInfo extends StatefulWidget {
  EmeraldsInfo({Key key}) : super(key: key);

  @override
  _EmeraldsInfoState createState() => _EmeraldsInfoState();
}

class _EmeraldsInfoState extends State<EmeraldsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      body: CatapultaScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Points(parte: '3'),
            CatapultaSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/emeraldsInfo.png',
                  height: 250,
                ),
              ],
            ),
            CatapultaSpace(),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 0, 12),
              child: Text(
                '¿Qué son las\nesmeraldas?',
                style: TextStyle(
                  fontSize: 30,
                  color: Palette.cumbiaDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 25,
              color: Palette.cumbiaDark,
            ),
            Container(
              color: Palette.cumbiaSeller,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:5),

                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Palette.cumbiaLight),
                        ),
                        const SizedBox(width: 20),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            'La moneda dentro de la app.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Palette.bgColor,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:5),

                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Palette.cumbiaLight),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              'Facilita la comunicación entre países.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Palette.bgColor,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                  ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:5),

                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Palette.cumbiaLight),
                        ),
                        const SizedBox(width: 20),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            'Te va a permitir hacer pequeñas donaciones tus emprendimientos favoritos.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Palette.bgColor,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
             CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SelectCategories(),
                  ),
                );
              },
              child: Container(
                color: Palette.cumbiaLight,
                width: MediaQuery.of(context).size.width,
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Siguiente',
                        style: TextStyle(
                          fontSize: 20,
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Palette.white,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
