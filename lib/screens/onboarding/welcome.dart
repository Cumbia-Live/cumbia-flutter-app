import 'package:cumbialive/components/catapulta_scroll_view.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/screens/onboarding/widgets/points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      body: CatapultaScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Points(parte: '1'),
            Image.asset(
              'images/cumbiaLogo.png',
              height: 190,
            ),
            RichText(
              text: TextSpan(
                text: '¡Bienvenido a\n',
                style: TextStyle(
                  fontSize: 30,
                  color: Palette.cumbiaLight,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Cumbia Live!",
                    style: TextStyle(
                      fontSize: 30,
                      color: Palette.cumbiaLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                'Conocerás más de Colombia a través de live streaming y te compartiremos nuestra esencia, hasta llegar a tu hogar.',
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.black,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ShoppingInfo(),
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
                        'Comencemos',
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
