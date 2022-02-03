import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/shop/product_screen.dart';
import 'package:cumbialive/screens/shopping_cart/q1_shopping_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';
import 'package:cumbialive/components/components.dart';

Merchant merchant;
List<Product> products;

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreen createState() => _ShopScreen();

  ShopScreen(shop, p) {
    merchant = shop;
    products = p;
  }
}

class _ShopScreen extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        ////actionsForegroundColor: Palette.white,
        backgroundColor: Palette.cumbiaSeller,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Palette.cumbiaSeller,
        onPressed: () async {
          await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => Q1ShoppingCartScreen(),
            ),
          );
          setState(() {});
        },
        child: Stack(alignment: Alignment.bottomLeft, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_cart, color: Palette.white, size: 28.0),
          ),
          Container(
            decoration: BoxDecoration(
              color: Palette.cumbiaLight,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(shoppingCart.list.length.toString()),
            ),
          ),
        ]),
      ),
      body: SafeArea(
        child: Container(
          child: CatapultaScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    height: 20.0,
                    color: Palette.cumbiaSeller),
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width / 2.5,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            color: Palette.cumbiaSeller,
                          )),
                          Expanded(
                              child: Container(
                            color: Colors.transparent,
                          ))
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Palette.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: MediaQuery.of(context).size.width / 2.5,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: user.profilePictureURL == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Icon(
                                    Icons.person,
                                    color: Palette.cumbiaGrey,
                                  ),
                                ),
                              )
                            : user.profilePictureURL.isEmpty ?? false
                                ? Icon(
                                    user.roles.isAdmin ?? false
                                        ? Icons.person
                                        : user.roles.isMerchant ?? false
                                            ? Icons.store_mall_directory
                                            : Icons.person,
                                    color: Palette.cumbiaGrey,
                                    size: MediaQuery.of(context).size.width / 3,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child:
                                          Image.network(user.profilePictureURL),
                                    ),
                                  ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        'Última transmisión',
                        style: TextStyle(
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.bold),
                      )),
                      SizedBox(height: 5.0),
                      Center(
                          child: Text(
                        'Hace 15 horas',
                        style: TextStyle(
                            color: Palette.cumbiaGrey.withOpacity(0.5)),
                      )),
                      SizedBox(height: 18.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(merchant.category1),
                          (merchant.category2.isNotEmpty &&
                                  merchant.category2 != "")
                              ? (Text('   ·   ${merchant.category2}'))
                              : SizedBox.shrink()
                        ],
                      ),
                      SizedBox(height: 35.0),
                      Text(
                        'Productos',
                        style:
                            Styles.titleLbl.copyWith(color: Palette.cumbiaDark),
                      ),
                      SizedBox(height: 15.0),
                      showProducts(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showProducts() {
    if (products.length > 0) {
      return Column(
        children: [
          GestureDetector(
            onTap: () async {
              Product p;
              await References.products
                  .doc(products[0].id)
                  .get()
                  .then((element) => {
                        p = new Product(
                          uid: element.data()['uid'],
                          id: products[0].id,
                          unitsCarrito: 1,
                          isVariant: element.data()['productInfo']['isVariant'],
                          imageUrl: (element.data()['productInfo']['imageUrl'] !=
                                      '' &&
                                  element.data()['productInfo']['imageUrl'] !=
                                      null)
                              ? element.data()['productInfo']['imageUrl']
                              : 'https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2Fno-image.png?alt=media&token=e8d0c24b-34b5-4d37-9811-ce308a9e98b2',
                          productName:
                              element.data()['productInfo']['productName'] ?? '',
                          description:
                              element.data()['productInfo']['description'] ?? '',
                          reference:
                              element.data()['productInfo']['reference'] ?? '',
                          height: double.parse(element.data()['especifications']
                                      ['height']
                                  .toString()) ??
                              '',
                          large: double.parse(element.data()['especifications']
                                      ['large']
                                  .toString()) ??
                              '',
                          width: double.parse(element.data()['especifications']
                                      ['width']
                                  .toString()) ??
                              '',
                          weight: double.parse(element.data()['especifications']
                                      ['weight']
                                  .toString()) ??
                              '',
                          avaliableUnits: element.data()['avaliableUnits'] ?? '',
                          emeralds: element.data()['emeralds'] ?? '',
                          color: element.data()['variantInfo']['color'] ?? '',
                          size: element.data()['variantInfo']['size'] ?? '',
                          dimension:
                              element.data()['variantInfo']['dimension'] ?? '',
                          material:
                              element.data()['variantInfo']['material'] ?? '',
                          style: element.data()['variantInfo']['style'] ?? '',
                          comission: element.data()['comission'],
                          price: element.data()['price'],
                        )
                      })
                  .then((value) async => {
                        await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ProductScreen(p, merchant.id),
                          ),
                        ),
                      });
              setState(() {});
            },
            child: Container(
              height: MediaQuery.of(context).size.width / 3 * 1.8,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Palette.cumbiaLight, width: 2.0),
                            borderRadius: BorderRadius.circular(17.0)),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            ClipRRect(
                              child: Image.network(
                                products[0].imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Palette.cumbiaLight,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            text:
                                                '${products[0].productName}\n',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                            children: [
                                          TextSpan(
                                              text:
                                                  '${products[0].description}',
                                              style: TextStyle(fontSize: 10.0))
                                        ])),
                                    Row(
                                      children: [
                                        Text(
                                          '${(products[0].price.toString())}',
                                          style: TextStyle(
                                              color: Palette.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Image(
                                          image:
                                              AssetImage('images/emerald.png'),
                                          height: 20.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 2),
                  SizedBox(width: 10.0),
                  Expanded(
                      child: Column(
                        children: [
                          Expanded(child: getItemCard(1)),
                          SizedBox(height: 10.0),
                          Expanded(child: getItemCard(2)),
                        ],
                      ),
                      flex: 1),
                ],
              ),
            ),
          ),
          (products.length > 3) ? SizedBox(height: 10.0) : SizedBox.shrink(),
          (products.length > 3)
              ? Container(
                  height: MediaQuery.of(context).size.width / 2.2,
                  child: Row(
                    children: [
                      Expanded(child: getItemCard(3)),
                      SizedBox(width: 10.0),
                      Expanded(child: getItemCard(4)),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          (products.length > 5) ? SizedBox(height: 10.0) : SizedBox.shrink(),
          (products.length > 5)
              ? Container(
                  height: MediaQuery.of(context).size.width / 2.2,
                  child: Row(
                    children: [
                      Expanded(child: getItemCard(5)),
                      SizedBox(width: 10.0),
                      Expanded(child: getItemCard(6)),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          (products.length > 7) ? SizedBox(height: 10.0) : SizedBox.shrink(),
          (products.length > 7)
              ? Container(
                  height: MediaQuery.of(context).size.width / 2.2,
                  child: Row(
                    children: [
                      Expanded(child: getItemCard(7)),
                      SizedBox(width: 10.0),
                      Expanded(child: getItemCard(8)),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          SizedBox(height: 30.0),
          CumbiaButton(
            onPressed: () {},
            title: 'Ver todos los productos',
          )
        ],
      );
    } else {
      return Text('nohayproductos');
    }
  }

  Widget getItemCard(i) {
    return products.length > i
        ? GestureDetector(
            onTap: () async {
              Product p;
              await References.products
                  .doc(products[i].id)
                  .get()
                  .then((element) => {
                        p = new Product(
                          uid: element.data()['uid'],
                          id: products[i].id,
                          unitsCarrito: 1,
                          isVariant: element.data()['productInfo']['isVariant'],
                          imageUrl: (element.data()['productInfo']['imageUrl'] !=
                                      '' &&
                                  element.data()['productInfo']['imageUrl'] !=
                                      null)
                              ? element.data()['productInfo']['imageUrl']
                              : 'https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2Fno-image.png?alt=media&token=e8d0c24b-34b5-4d37-9811-ce308a9e98b2',
                          productName:
                              element.data()['productInfo']['productName'] ?? '',
                          description:
                              element.data()['productInfo']['description'] ?? '',
                          reference:
                              element.data()['productInfo']['reference'] ?? '',
                          height: double.parse(element.data()['especifications']
                                      ['height']
                                  .toString()) ??
                              '',
                          large: double.parse(element.data()['especifications']
                                      ['large']
                                  .toString()) ??
                              '',
                          width: double.parse(element.data()['especifications']
                                      ['width']
                                  .toString()) ??
                              '',
                          weight: double.parse(element.data()['especifications']
                                      ['weight']
                                  .toString()) ??
                              '',
                          avaliableUnits: element.data()['avaliableUnits'] ?? '',
                          emeralds: element.data()['emeralds'] ?? '',
                          color: element.data()['variantInfo']['color'] ?? '',
                          size: element.data()['variantInfo']['size'] ?? '',
                          dimension:
                              element.data()['variantInfo']['dimension'] ?? '',
                          material:
                              element.data()['variantInfo']['material'] ?? '',
                          style: element.data()['variantInfo']['style'] ?? '',
                          comission: element.data()['comission'],
                          price: element.data()['price'],
                          rated: element.data()['rated'] ?? false,
                          rate: element.data()['rated'] ?? 0,
                        )
                      })
                  .then((value) async => {
                        await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ProductScreen(p, merchant.id),
                          ),
                        ),
                      });
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Palette.cumbiaGrey, width: 2.0),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  ClipRRect(
                    child: Image.network(
                      products[i].imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0x88FFFFFF),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(products[i].price.toString())}',
                            style: TextStyle(
                                color: Palette.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Image(
                            image: AssetImage('images/emerald.png'),
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }
}
