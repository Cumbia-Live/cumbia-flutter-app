import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cumbialive/config/config.dart';
import '../../../functions/functions.dart';
import '../../screens.dart';
import 'package:cumbialive/components/components.dart';
import 'sections.dart';

bool state = true;

class MyShopScreen extends StatefulWidget {
  @override
  _MyShopScreenState createState() => _MyShopScreenState();

  MyShopScreen(bool isOpen) {
    state = isOpen;
  }
}

class _MyShopScreenState extends State<MyShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        //actionsForegroundColor: Palette.white,
        border: Border.symmetric(),
        middle: Text(
          'Mi tienda',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        backgroundColor: _getBGColor(),
      ),
      body: CatapultaScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.0),
            ShopStateListTitle(),
            CatapultaDivider(height: 2.0),
            CatapultaListTitle(
              text: 'Mis productos',
              iconData: Icons.style,
              onTap: () async {
                List<Product> p = [];
                await References.products
                    .where('uid', isEqualTo: user.id)
                    .get()
                    .then((value) async {
                  for (var i = 0; i < value.docs.length; i++) {
                    p.add(new Product(
                        imageUrl: value.docs
                            .elementAt(i)
                            .data()['productInfo']['imageUrl'],
                        productName: value.docs
                            .elementAt(i)
                            .data()['productInfo']['productName'],
                        description: value.docs
                            .elementAt(i)
                            .data()['productInfo']['description'],
                        avaliableUnits:
                            value.docs.elementAt(i).data()['avaliableUnits'],
                        id: value.docs.elementAt(i).id));
                  }
                }).then((value) async {
                  for (var i = 0; i < p.length; i++) {
                    await References.reviews
                        .where('productId', isEqualTo: p[i].id)
                        .get()
                        .then((value) {
                      print(value.docs.length);
                      value.docs.forEach((element) async {
                        var name = await References.users
                            .doc(element.data()['uid'])
                            .get()
                            .then((value) => value.data()['username']);
                        p[i].reviews.add(Review(name, element.data()['rate'],
                            element.data()['review'], element.data()['date'] ?? 0));
                      });
                    });
                  }
                }).then((value) => {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => MyProductsScreen(p),
                            ),
                          )
                        });
              },
              iconColor: Palette.cumbiaIconGrey,
            ),
            CatapultaDivider(height: 2.0),
            CatapultaListTitle(
              text: 'Gestión de pedidos',
              iconData: Icons.local_shipping,
              onTap: () async {
                List<Purchase> purchases = [];
                await References.purchases
                    .where('uuidStreamer', isEqualTo: user.id)
                    .get()
                    .then((value) {
                  value.docs.forEach((element) async {
                    purchases.add(Purchase(
                        uuidStreamer: element.data()['uuidStreamer'],
                        uuidBuyer: element.data()['uuidBuyer'],
                        details: element.data()['details'],
                        datePurchase: element.data()['datePurchase'],
                        dateReceived: element.data()['dateReceived'],
                        daysToReceive: element.data()['daysToReceive'],
                        address: Address(
                            address: element.data()['address']['address'],
                            city: element.data()['address']['city'],
                            country: element.data()['address']['country']),
                        received: element.data()['received'],
                        isSend: element.data()['isSend'] ?? false,
                        rated: element.data()['rated'],
                        rate: element.data()['rate'],
                        emeralds: element.data()['emeralds'],
                        purchaseType: element.data()['purchaseType'] ?? 'Tienda',
                        id: element.id));
                  });
                }).then((value) async {
                  for (var i = 0; i < purchases.length; i++) {
                    await References.purchases
                        .doc(purchases[i].id)
                        .collection('products')
                        .get()
                        .then((value) {
                      value.docs.forEach((pur) {
                        purchases[i].products.add(Product(
                              uid: pur.data()['uid'],
                              id: pur.id,
                              idProduct: pur.data()['productId'],
                              unitsCarrito: pur.data()['unitsCarrito'],
                              isVariant: pur.data()['productInfo']['isVariant'],
                              imageUrl: (pur.data()['productInfo']['imageUrl'] !=
                                          '' &&
                                      pur.data()['productInfo']['imageUrl'] !=
                                          null)
                                  ? pur.data()['productInfo']['imageUrl']
                                  : 'https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2Fno-image.png?alt=media&token=e8d0c24b-34b5-4d37-9811-ce308a9e98b2',
                              productName:
                                  pur.data()['productInfo']['productName'] ?? '',
                              description:
                                  pur.data()['productInfo']['description'] ?? '',
                              reference:
                                  pur.data()['productInfo']['reference'] ?? '',
                              height: double.parse(pur.data()['especifications']
                                          ['height']
                                      .toString()) ??
                                  '',
                              large: double.parse(pur.data()['especifications']
                                          ['large']
                                      .toString()) ??
                                  '',
                              width: double.parse(pur.data()['especifications']
                                          ['width']
                                      .toString()) ??
                                  '',
                              weight: double.parse(pur.data()['especifications']
                                          ['weight']
                                      .toString()) ??
                                  '',
                              avaliableUnits: pur.data()['avaliableUnits'] ?? '',
                              emeralds: pur.data()['emeralds'] ?? '',
                              color: pur.data()['variantInfo']['color'] ?? '',
                              size: pur.data()['variantInfo']['size'] ?? '',
                              dimension:
                                  pur.data()['variantInfo']['dimension'] ?? '',
                              material:
                                  pur.data()['variantInfo']['material'] ?? '',
                              style: pur.data()['variantInfo']['style'] ?? '',
                              comission: pur.data()['comission'],
                              price: pur.data()['price'],
                              rated: pur.data()['rated'],
                            ));
                      });
                    });
                  }
                }).then((value) => {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  OrderManagementScreen(purchases),
                            ),
                          )
                        });
              },
              iconColor: Palette.cumbiaIconGrey,
            ),
            CatapultaDivider(height: 2.0),
            CatapultaListTitle(
              text: 'Mis ventas (Monedero)',
              iconData: Icons.loyalty,
              onTap: () async {
                List<Purchase> compras = [];
                List<Purchase> ventas = [];
                List<Withdrawal> retiros = [];
                await References.purchases
                    .where('uuidBuyer', isEqualTo: user.id)
                    .get()
                    .then((value) {
                  value.docs.forEach((element) async {
                    compras.add(Purchase(
                        uuidStreamer: element.data()['uuidStreamer'],
                        uuidBuyer: element.data()['uuidBuyer'],
                        details: element.data()['details'],
                        datePurchase: element.data()['datePurchase'],
                        dateReceived: element.data()['dateReceived'],
                        daysToReceive: element.data()['daysToReceive'],
                        address: Address(
                            address: element.data()['address']['address'],
                            city: element.data()['address']['city'],
                            country: element.data()['address']['country']),
                        received: element.data()['received'],
                        rated: element.data()['rated'],
                        rate: element.data()['rate'],
                        emeralds: element.data()['emeralds'],
                        purchaseType: element.data()['purchaseType'] ?? 'Tienda',
                        id: element.id));
                  });
                }).then((value) async {
                  for (var i = 0; i < compras.length; i++) {
                    await References.purchases
                        .doc(compras[i].id)
                        .collection('products')
                        .get()
                        .then((value) {
                      value.docs.forEach((pur) {
                        compras[i].products.add(Product(
                              uid: pur.data()['uid'],
                              id: pur.id,
                              idProduct: pur.data()['productId'],
                              unitsCarrito: pur.data()['unitsCarrito'],
                              unitsCheckout: pur.data()['unitsCheckout'],
                              isVariant: pur.data()['productInfo']['isVariant'],
                              imageUrl: (pur.data()['productInfo']['imageUrl'] !=
                                          '' &&
                                      pur.data()['productInfo']['imageUrl'] !=
                                          null)
                                  ? pur.data()['productInfo']['imageUrl']
                                  : 'https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2Fno-image.png?alt=media&token=e8d0c24b-34b5-4d37-9811-ce308a9e98b2',
                              productName:
                                  pur.data()['productInfo']['productName'] ?? '',
                              description:
                                  pur.data()['productInfo']['description'] ?? '',
                              reference:
                                  pur.data()['productInfo']['reference'] ?? '',
                              height: double.parse(pur.data()['especifications']
                                          ['height']
                                      .toString()) ??
                                  '',
                              large: double.parse(pur.data()['especifications']
                                          ['large']
                                      .toString()) ??
                                  '',
                              width: double.parse(pur.data()['especifications']
                                          ['width']
                                      .toString()) ??
                                  '',
                              weight: double.parse(pur.data()['especifications']
                                          ['weight']
                                      .toString()) ??
                                  '',
                              avaliableUnits: pur.data()['avaliableUnits'] ?? '',
                              emeralds: pur.data()['emeralds'] ?? '',
                              color: pur.data()['variantInfo']['color'] ?? '',
                              size: pur.data()['variantInfo']['size'] ?? '',
                              dimension:
                                  pur.data()['variantInfo']['dimension'] ?? '',
                              material:
                                  pur.data()['variantInfo']['material'] ?? '',
                              style: pur.data()['variantInfo']['style'] ?? '',
                              comission: pur.data()['comission'],
                              price: pur.data()['price'],
                              rated: pur.data()['rated'],
                            ));
                      });
                    });
                  }
                }).then((value) async {
                  await References.purchases
                      .where('uuidStreamer', isEqualTo: user.id)
                      .get()
                      .then((value) {
                    value.docs.forEach((element) async {
                      ventas.add(Purchase(
                          uuidStreamer: element.data()['uuidStreamer'],
                          uuidBuyer: element.data()['uuidBuyer'],
                          details: element.data()['details'],
                          datePurchase: element.data()['datePurchase'],
                          dateReceived: element.data()['dateReceived'],
                          daysToReceive: element.data()['daysToReceive'],
                          address: Address(
                              address: element.data()['address']['address'],
                              city: element.data()['address']['city'],
                              country: element.data()['address']['country']),
                          received: element.data()['received'],
                          rated: element.data()['rated'],
                          rate: element.data()['rate'],
                          emeralds: element.data()['emeralds'],
                          purchaseType:
                              element.data()['purchaseType'] ?? 'Tienda',
                          id: element.id));
                    });
                  }).then((value) async {
                    for (var i = 0; i < ventas.length; i++) {
                      await References.purchases
                          .doc(ventas[i].id)
                          .collection('products')
                          .get()
                          .then((value) {
                        value.docs.forEach((pur) {
                          ventas[i].products.add(Product(
                                uid: pur.data()['uid'],
                                id: pur.id,
                                idProduct: pur.data()['productId'],
                                unitsCarrito: pur.data()['unitsCarrito'],
                                unitsCheckout: pur.data()['unitsCheckout'],
                                isVariant: pur.data()['productInfo']['isVariant'],
                                imageUrl: (pur.data()['productInfo']
                                                ['imageUrl'] !=
                                            '' &&
                                        pur.data()['productInfo']['imageUrl'] !=
                                            null)
                                    ? pur.data()['productInfo']['imageUrl']
                                    : 'https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2Fno-image.png?alt=media&token=e8d0c24b-34b5-4d37-9811-ce308a9e98b2',
                                productName: pur.data()['productInfo']
                                        ['productName'] ??
                                    '',
                                description: pur.data()['productInfo']
                                        ['description'] ??
                                    '',
                                reference:
                                    pur.data()['productInfo']['reference'] ?? '',
                                height: double.parse(pur.data()['especifications']
                                            ['height']
                                        .toString()) ??
                                    '',
                                large: double.parse(pur.data()['especifications']
                                            ['large']
                                        .toString()) ??
                                    '',
                                width: double.parse(pur.data()['especifications']
                                            ['width']
                                        .toString()) ??
                                    '',
                                weight: double.parse(pur.data()['especifications']
                                            ['weight']
                                        .toString()) ??
                                    '',
                                avaliableUnits:
                                    pur.data()['avaliableUnits'] ?? '',
                                emeralds: pur.data()['emeralds'] ?? '',
                                color: pur.data()['variantInfo']['color'] ?? '',
                                size: pur.data()['variantInfo']['size'] ?? '',
                                dimension:
                                    pur.data()['variantInfo']['dimension'] ?? '',
                                material:
                                    pur.data()['variantInfo']['material'] ?? '',
                                style: pur.data()['variantInfo']['style'] ?? '',
                                comission: pur.data()['comission'],
                                price: pur.data()['price'],
                                rated: pur.data()['rated'],
                             isFreeShipping: pur.data()['isFreeShipping'] ?? false,

                          ));
                        });
                      });
                    }
                  }).then((value) async {
                    await References.withdrawal
                        .where('userid', isEqualTo: user.id)
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        retiros.add(Withdrawal(
                            date: element.data()['date'],
                            emeralds: element.data()['emeralds']));
                      });
                    });
                  }).then((value) => {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    MonederoPage(compras, ventas, retiros),
                              ),
                            )
                          });
                });
              },
              iconColor: Palette.cumbiaIconGrey,
            ),
            CatapultaDivider(height: 2.0),
            CatapultaListTitle(
              text: 'Live merchant',
              iconData: Icons.camera_alt_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PreparationMerchantScreen(),
                  ),
                );
              },
              iconColor: Palette.cumbiaIconGrey,
            ),
            CatapultaDivider(height: 2.0),
            CatapultaListTitle(
              text: 'Datos de tienda',
              iconData: Icons.edit_sharp,
              onTap: () async {
                Merchant merchant;
                await References.merchant
                    .where('userId', isEqualTo: user.id)
                    .get()
                    .then((value) => merchant = new Merchant(
                          shopName:
                              value.docs.first.data()['shopName'] ?? '',
                          pickUpPoint:
                              value.docs.first.data()['pickUpPoint'] ?? null,
                          instagram:
                              value.docs.first.data()['instagram'] ?? null,
                          webPage:
                              value.docs.first.data()['webPage'] ?? null,
                          category1:
                              value.docs.first.data()['principalCategory'] ??
                                  '',
                          category2:
                              value.docs.first.data()['secondaryCategory'] ??
                                  null,
                          nit: value.docs.first.data()['nit'],
                          colombianProducts:
                              value.docs.first.data()['colombianProducts'] ??
                                  true,
                        ))
                    .then((value) => {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ShopInfoScreen(merchant),
                            ),
                          )
                        });
              },
              iconColor: Palette.cumbiaIconGrey,
            ),
          ],
        ),
      ),
    );
  }
}

class ShopStateListTitle extends StatefulWidget {
  @override
  _ShopStateListTitleState createState() => _ShopStateListTitleState();
}

class _ShopStateListTitleState extends State<ShopStateListTitle> {
  final String text = 'Estado de tienda';
  final IconData iconData = Icons.store_mall_directory;
  final Color iconColor = Palette.cumbiaIconGrey;

  _ShopStateListTitleState() {
    isOpen();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
              iconData,
              color: iconColor ?? Palette.black,
            ) ??
            null,
        title: Text(
          text,
          style: Styles.configLbl,
        ),
        trailing: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Row(
            children: [
              Expanded(
                child: getButton('Abierta', !state, () {
                  setState(() {
                    state = true;
                    _setIsOpen(state);
                  });
                }),
              ),
              SizedBox(width: 3.0),
              Expanded(
                child: getButton('Cerrada', state, () {
                  showMainActionAlert(context, 'Cerrar tienda',
                      'Si cierras la tienda tus productos no podrán ser mostrados al público',
                      () {
                    setState(() {
                      state = false;
                      _setIsOpen(state);
                    });
                  },
                      mainActionText: "Cerrar tienda",
                      isDestructiveAction: true);
                }),
              ),
            ],
          ),
        ));
  }

  Widget getButton(title, canPush, onPressed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: !canPush ? Palette.cumbiaDark : Palette.grey,
          ),
          child: Stack(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Center(
                  child: Text(
                    title ?? "Continuar",
                    style: Styles.btn,
                  ),
                ),
                onPressed: canPush
                    ? () {
                        onPressed();
                      }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> isOpen() async {
    bool open;
    await References.merchant
        .where('userId', isEqualTo: user.id)
        .get()
        .then((value) => open = value.docs.first.data()['isOpen']);

    state = open;
  }
}

Future<void> _setIsOpen(isOpen) async {
  var document;
  await References.merchant
      .where('userId', isEqualTo: user.id)
      .get()
      .then((value) => document = value.docs.first.id)
      .then((value) => {
            References.merchant
                .doc(document)
                .update({'isOpen': isOpen})
          });
}

Color _getBGColor() {
  return user.roles.isAdmin ?? false
      ? Palette.cumbiaDark
      : user.roles.isMerchant ?? false
          ? Palette.cumbiaSeller
          : Palette.cumbiaLight;
}
