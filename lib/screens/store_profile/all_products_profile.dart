import 'package:flutter/cupertino.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/model/product/product.dart';
import 'package:cumbialive/components/listViewCumbiaAllProducts.dart';
import 'package:cumbialive/screens/store_profile/profile_product_detail.dart';

class AllProfileProducts extends StatefulWidget {
  AllProfileProducts({@required this.lstProducts});

  final List<Product> lstProducts;

  @override
  _AllProfileProductsState createState() => _AllProfileProductsState();
}

class _AllProfileProductsState extends State<AllProfileProducts> {
  List<Product> lstProduct = [];
  List<Product> product = [];
  List<Product> lstOtherProduct = [];
  List<List<Product>> lstAllProducts = List();
  @override
  void initState() {
    setState(() {
      lstProduct = widget.lstProducts;
    });
    getOtherProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: AppBar(
        // Título centrado
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Lista de Productos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        //color de fondo
        backgroundColor: Palette.cumbiaSeller,
        // Establecer la imagen de la pantalla frontal
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Palette.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        // Coloca el icono detrás
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart_sharp),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => Q1ShoppingCartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          lstAllProducts.isNotEmpty
              ? CatapultaScrollView(
                  child: Stack(
                    children: [
                      Container(color: Palette.bgColor),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: createListProducts(),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "         Aún no hay\nproductos autorizados",
                      style: Styles.ulTransmision,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  List<Widget> createListProducts() {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < lstAllProducts.length; i++) {
      list.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                lstAllProducts[i][0].productName,
                style: Styles.titleProducts,
              ),
              margin: EdgeInsets.only(
                left: 20,
                bottom: 10,
                top: 40,
              ),
            ),
            Center(
              child: Container(
                height: 145.0 * lstAllProducts[i].length,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: lstAllProducts[i].length,
                  itemBuilder: (context, index) {
                    return ListViewCumbiaAllProducts(
                      product: lstAllProducts[i][index],
                      onPress: () {
                        print(lstAllProducts[i][index].productName);
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ProductDetails(
                              product: lstAllProducts[i][index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
    return list;
  }

  List<Product> getProducts(int index) {
    if (lstAllProducts.isNotEmpty) {
      return lstAllProducts[index];
    }
    return [];
  }

  void getOtherProducts() {
    lstOtherProduct.clear();
    List<Product> p = [...lstProduct];
    if (lstProduct.isNotEmpty) {
      for (var i = 0; i < lstProduct.length; i++) {
        if (p.isNotEmpty) {
          for (var j = 0; j < p.length; j++) {
            if (lstProduct[i]
                .productName
                .toLowerCase()
                .contains(p[j].productName.toLowerCase())) {
              lstOtherProduct.add(p[j]);
            } else {}
          }
          if (lstOtherProduct.isNotEmpty) {
            lstAllProducts.add([...lstOtherProduct]);
            for (var i = 0; i < lstOtherProduct.length; i++) {
              if (p.isNotEmpty) {
                for (var j = 0; j < p.length; j++) {
                  if (lstOtherProduct[i]
                      .productName
                      .toLowerCase()
                      .contains(p[j].productName.toLowerCase())) {
                    p.removeAt(j);
                  }
                }
              }
            }
            lstOtherProduct.clear();
          }
        }
      }
    }
  }
}
