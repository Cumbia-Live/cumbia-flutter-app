import 'package:cumbialive/model/models.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
//import 'package:cumbialive/screens/store_profile/profile_product_detail.dart';

class ListViewCumbia extends StatelessWidget {
  ListViewCumbia({@required this.product, @required this.onPress});

  final Product product;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 100,
        child: ListTile(
          title: Container(
            child: Text(product.productName),
            margin: EdgeInsets.only(
              top: 8,
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                            : product.dimension == "No especifica" ||
                                    product.dimension == ""
                                ? "${product.color}/${product.size}"
                                : product.size == "No especifica" ||
                                        product.size == ""
                                    ? "${product.color}/${product.dimension}"
                                    : "${product.color}/${product.dimension}/${product.size}",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
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
                    width: 25,
                    height: 25,
                    fit: BoxFit.contain,
                  )
                ],
              ),
            ],
          ),
          leading: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            width: 75.0,
            height: 75.0,
          ),
          trailing: Container(
            height: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chevron_right,
                ),
              ],
            ),
          ),
          onTap: onPress,
        ),
        decoration: BoxDecoration(
          color: Palette.colorCampos,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      ),
    );
  }
}
