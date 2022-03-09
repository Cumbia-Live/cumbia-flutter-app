import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'list_purchases.dart';

int sectionSelected = 0;
List<Purchase> purchases = [];

class MyPurchasesScreen extends StatelessWidget {
  MyPurchasesScreen(List<Purchase> list) {
    purchases = list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.white,
        middle: Text(
          'Mis compras',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        backgroundColor: _getBGColor(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Selector()),
          ],
        ),
      ),
    );
  }

  Color _getBGColor() {
    return user.roles.isAdmin
        ? Palette.cumbiaDark
        : user.roles.isMerchant
            ? Palette.cumbiaSeller
            : Palette.cumbiaLight;
  }
}

class Selector extends StatefulWidget {
  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: sectionSelected == 0
                                  ? Palette.cumbiaDark
                                  : Palette.transparent,
                              width: 3.0))),
                  padding: EdgeInsets.only(top: 30.0),
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      'Productos en camino',
                      style: Styles.navBtn(
                              size: 15,
                              color: sectionSelected == 0
                                  ? null
                                  : Palette.cumbiaGrey)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: sectionSelected != 0
                    ? () {
                        setState(() {
                          sectionSelected = 0;
                          pageController.animateToPage(0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.decelerate);
                        });
                      }
                    : null,
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: sectionSelected == 1
                                  ? Palette.cumbiaDark
                                  : Palette.transparent,
                              width: 3.0))),
                  padding: EdgeInsets.only(top: 30.0),
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      'Productos recibidos',
                      style: Styles.navBtn(
                              size: 15,
                              color: sectionSelected == 1
                                  ? null
                                  : Palette.cumbiaGrey)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: sectionSelected != 1
                    ? () {
                        setState(() {
                          sectionSelected = 1;
                          pageController.animateToPage(1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.decelerate);
                        });
                      }
                    : null,
              ),
            ),
          ],
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ListPurchases(
                  purchases.where((element) => !element.received).toList()),
              ListPurchases(
                  purchases.where((element) => element.received).toList()),
            ],
          ),
        ),
      ],
    );
  }
}
