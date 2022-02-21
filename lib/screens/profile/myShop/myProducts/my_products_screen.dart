import 'package:cumbialive/screens/profile/myShop/myProducts/editProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/screens/screens.dart';

int sectionSelected = 0;
List<Product> productsData = [];

class MyProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.white,
        middle: Text(
          'Mis productos',
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

  MyProductsScreen(List<Product> p) {
    productsData = p;
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
                      'Productos registrados',
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
                      'Reseñas de productos',
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
              RegisteredProducts(),
              ReviewProducts(),
            ],
          ),
        ),
      ],
    );
  }
}

///Productos registrados

class RegisteredProducts extends StatefulWidget {
  @override
  _RegisteredProductsState createState() => _RegisteredProductsState();
}

class _RegisteredProductsState extends State<RegisteredProducts> {
  List<RegisteredProductItem> productsBackup = [];
  List<RegisteredProductItem> products = [];

  static const _border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(6.0),
      ),
      borderSide: BorderSide.none);

  _RegisteredProductsState() {
    list();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
              style: Styles.txtTextLbl(),
              decoration: InputDecoration(
                fillColor: Palette.skeleton,
                filled: true,
                hintStyle: Styles.placeholderLbl,
                hintText: 'Ej: Camiseta de cuadros',
                enabledBorder: _border,
                focusedBorder: _border,
                border: _border,
                disabledBorder: _border,
                suffixIcon: Icon(
                  Icons.search,
                  color: Palette.cumbiaIconGrey,
                ),
              ),
              validator: null,
              onChanged: filtro),
        ),
        SizedBox(height: 10.0),
        Expanded(
          child: CatapultaScrollView(
            child: Column(
              children: products,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: CumbiaButton(
              title: 'Registrar nuevo producto',
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Q1GeneralInfoScreen(),
                  ),
                );
              },
              canPush: true),
        )
      ],
    );
  }

  void filtro(String value) {
    setState(() {
      if (value != '') {
        products = productsBackup
            .where((element) =>
                element.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      } else {
        products = productsBackup;
      }
    });
  }

  void list() {
    productsBackup.clear();

    productsData.forEach((element) => {
          productsBackup.add(RegisteredProductItem(
            name: element.productName ?? 'Sin nombre',
            description: element.description ?? 'Sin descripción',
            urlImage: element.imageUrl,
            avaliableUnits: element.avaliableUnits ?? 0,
            id: element.id,
          ))
        });

    products = productsBackup;
  }
}

class RegisteredProductItem extends StatefulWidget {
  final String name;
  final String description;
  final int avaliableUnits;
  final String urlImage;
  final String id;

  const RegisteredProductItem(
      {Key key,
      this.name,
      this.description,
      this.avaliableUnits,
      this.urlImage,
      this.id})
      : super(key: key);

  @override
  _RegisteredProductItemState createState() => _RegisteredProductItemState(
      name: this.name,
      description: this.description,
      avaliableUnits: this.avaliableUnits,
      urlImage: this.urlImage,
      id: this.id);
}

class _RegisteredProductItemState extends State<RegisteredProductItem> {
  String name;
  String description;
  int avaliableUnits;
  final String urlImage;
  final String id;

  _RegisteredProductItemState(
      {this.name,
      this.description,
      this.avaliableUnits,
      this.urlImage,
      this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      color: Palette.txtBgColor,
      child: Row(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child:
                  FittedBox(child: Image.network(urlImage), fit: BoxFit.fill),
            ),
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.width / 4,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Styles.navTitleLbl),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: description,
                            style: Styles.txtTextLbl(
                                color: Palette.cumbiaGrey, size: 14.0)),
                        TextSpan(text: '\n'),
                        TextSpan(
                            style: Styles.txtTextLbl(
                                color: avaliableUnits == 0
                                    ? Palette.red
                                    : Palette.cumbiaGrey,
                                size: 12),
                            text: '$avaliableUnits Unidades'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Icon(
                    Icons.edit_sharp,
                    color: Palette.cumbiaIconGrey,
                  ),
                  Text(
                    'Editar',
                    style:
                        TextStyle(fontSize: 12, color: Palette.cumbiaIconGrey),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            onTap: () async {
              Product p;
              await References.products
                  .doc(id)
                  .get()
                  .then((element) => {
                        p = new Product(
                          id: id,
                          isVariant: element.data()['isVariant'],
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
                          price: element.data()['price'] ?? '',
                          color: element.data()['variantInfo']['color'] ?? '',
                          size: element.data()['variantInfo']['size'] ?? '',
                          isFreeShipping: element.data()['isFreeShipping']?? false,
                          isShipmentRequired: element.data()['isShipmentRequired']?? true,

                        )
                      })
                  .then((value) async {
                List<dynamic> info = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => EditProductScreen(p),
                  ),
                );
                setState(() {
                  name = info[0];
                  description = info[1];
                  avaliableUnits = info[2];
                });
              });
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

///Reseñas de productos
class ReviewProducts extends StatelessWidget {
  List<ReviewProductItem> products = [];

  ReviewProducts() {
    list();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.0),
        Expanded(
          child: CatapultaScrollView(
            child: Column(
              children: products,
            ),
          ),
        ),
      ],
    );
  }

  void list() {
    products.clear();

    productsData.forEach((element) => {
          products.add(ReviewProductItem(
            name: element.productName ?? 'Sin nombre',
            description: element.description ?? 'Sin descripción',
            urlImage: element.imageUrl,
            product: element,
          ))
        });
  }
}

class ReviewProductItem extends StatelessWidget {
  final String name;
  final String description;
  final String urlImage;
  final Product product;

  const ReviewProductItem(
      {Key key, this.name, this.description, this.urlImage, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      color: Palette.txtBgColor,
      child: Row(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child:
                  FittedBox(child: Image.network(urlImage), fit: BoxFit.fill),
            ),
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.width / 4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Styles.navTitleLbl),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: description,
                          style: Styles.txtTextLbl(color: Palette.cumbiaGrey)),
                    ],
                  ),
                ),
                printStars(getGeneralRate(), 5),
              ],
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Palette.cumbiaIconGrey,
                  ),
                  Text(
                    'Ver',
                    style:
                        TextStyle(fontSize: 12, color: Palette.cumbiaIconGrey),
                  ),
                  Text(
                    'reseñas',
                    style:
                        TextStyle(fontSize: 12, color: Palette.cumbiaIconGrey),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ReviewsScreen(product),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  double getGeneralRate() {
    int cont = 0;
    for (var i = 0; i < product.reviews.length; i++) {
      cont += product.reviews[i].rate;
    }

    return double.parse((cont / product.reviews.length).toStringAsFixed(1));
  }

  Widget printStars(double stars, double maxStars) {
    List<Widget> list = [];
    double aux = stars;
    double count = 0;

    while (count < maxStars) {
      if (aux - 1 >= 0) {
        list.add(Icon(
          Icons.star,
          color: Palette.cumbiaDark,
          size: 20.0,
        ));
        aux--;
      } else if (aux - 0.5 >= 0) {
        list.add(Icon(
          Icons.star_half,
          color: Palette.cumbiaDark,
          size: 20.0,
        ));
        aux -= 0.5;
      } else {
        list.add(Icon(
          Icons.star_border,
          color: Palette.cumbiaDark,
          size: 20.0,
        ));
      }
      count++;
    }
    list.add(Text(
      ' $stars',
      style: TextStyle(color: Palette.cumbiaDark, fontWeight: FontWeight.bold),
    ));

    return Row(children: list, crossAxisAlignment: CrossAxisAlignment.end);
  }
}
