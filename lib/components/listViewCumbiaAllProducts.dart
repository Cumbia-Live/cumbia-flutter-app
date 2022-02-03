import 'package:cumbialive/model/models.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
//import 'package:cumbialive/screens/store_profile/profile_product_detail.dart';

class ListViewCumbiaAllProducts extends StatelessWidget {
  ListViewCumbiaAllProducts({@required this.product, @required this.onPress});

  final Product product;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: 124.0,
                margin: EdgeInsets.only(left: 115.0),
                decoration: BoxDecoration(
                  color: Palette.colorCampos,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  constraints: BoxConstraints(maxWidth: 180),
                                  child: Text(
                                    product.productName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16.0),
                                  )),
                              Text(
                                product.color == "No especifica" &&
                                        product.dimension == "No especifica" &&
                                        product.size == "No especifica"
                                    ? "No especifica"
                                    : product.color == "" &&
                                            product.dimension == "" &&
                                            product.size == ""
                                        ? "No especifica"
                                        : product.color == "No especifica" ||
                                                product.color == ""
                                            ? "${product.dimension}/${product.size}"
                                            : product.dimension ==
                                                        "No especifica" ||
                                                    product.dimension == ""
                                                ? "${product.color}/${product.size}"
                                                : product.size ==
                                                            "No especifica" ||
                                                        product.size == ""
                                                    ? "${product.color}/${product.dimension}"
                                                    : "${product.color}/${product.dimension}/${product.size}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Palette.darkGrey,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${product.price.toString()} COP ",
                                    style: Styles.precioProductos,
                                  ),
                                  Image.asset(
                                    'images/emerald.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 124,
                          width: 40,
                          child: Icon(
                            Icons.chevron_right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                ),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  height: 125.0,
                  width: 125.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
