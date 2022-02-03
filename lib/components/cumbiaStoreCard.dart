import 'package:flutter/material.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';

class CumbiaStoreCard extends StatelessWidget {
  const CumbiaStoreCard({
    @required this.tienda,
    @required this.onPress,
  });

  final Merchant tienda;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          children: [
            Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    tienda.user.profilePictureURL,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Text(
                tienda.razonSocial,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Palette.black,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              height: 20,
              width: MediaQuery.of(context).size.width * 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
