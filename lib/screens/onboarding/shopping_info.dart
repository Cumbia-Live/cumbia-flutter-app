import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/screens/onboarding/widgets/points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens.dart';

class ShoppingInfo extends StatefulWidget {
  ShoppingInfo({Key key}) : super(key: key);

  @override
  _ShoppingInfoState createState() => _ShoppingInfoState();
}

class _ShoppingInfoState extends State<ShoppingInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      body: CatapultaScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Points(parte: '2'),
            CatapultaSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/shoppingInfo.png',
                  height: 370,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 0, 12),
              child: Text(
                'Live Stream\nShopping',
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
                padding: const EdgeInsets.all(60),
                child: Text(
                  'Brinda un servicio más auténtico, puedes describir cómo se siente, se ve o huele un producto.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Palette.white,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => EmeraldsInfo(),
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
