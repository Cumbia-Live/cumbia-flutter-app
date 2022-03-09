import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiamondsScreen extends StatefulWidget {
  @override
  _DiamondsScreenState createState() => _DiamondsScreenState();
}

class _DiamondsScreenState extends State<DiamondsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child:

      Scaffold(

        backgroundColor: Palette.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              brightness: Brightness.light,
              backgroundColor: Palette.white,
              title: Text(
                "Diamonds",
                style: Styles.navTitleLbl,
              ),
              centerTitle: true,
              actions: [],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 28),
                child: Column(
                  children: [


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
