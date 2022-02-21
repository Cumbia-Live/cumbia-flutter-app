import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/shopping_cart/q2_shopping_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Q1ShoppingCartScreen extends StatefulWidget {
  @override
  _Q1ShoppingCartScreenState createState() => _Q1ShoppingCartScreenState();
}

List<Widget> productsList = [];
Future<int> _createList;

int tEmeralds = 0;

class _Q1ShoppingCartScreenState extends State<Q1ShoppingCartScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    this.products = [...shoppingCart.list];
    _createList = createList();
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
          "Carro de compras",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.black,
          ),
        ),
        //color de fondo
        backgroundColor: Palette.bgColor,
        // Establecer la imagen de la pantalla frontal
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Palette.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(right: 14),
                child: Text(
                  "Editar",
                  style: TextStyle(
                    color: Palette.cumbiaDark,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.looks_one_rounded,
                      color: Palette.cumbiaDark, size: 40.0),
                  Icon(Icons.looks_two_rounded,
                      color: Palette.grey, size: 40.0),
                  Icon(Icons.looks_3_rounded, color: Palette.grey, size: 40.0),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            productsList.isNotEmpty
                ? Expanded(
                    child: SingleChildScrollView(
                      child: FutureBuilder(
                        future: _createList,
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            totalEmeralds();
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(children: productsList),
                            );
                          } else {
                            return Column(
                              children: [
                                Container(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 10),
                                  margin: EdgeInsets.only(top: 100.0),
                                )
                              ],
                            );
                          }
                        }),
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 60, 20, 20),
                      child: Center(
                          child: Text(
                        "Aún no tienes productos en tu carro, ve a buscar algunos!!!",
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
            Container(
              decoration: BoxDecoration(
                color: Palette.cumbiaSeller,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Saldo disponible',
                          style: TextStyle(
                              color: user.emeralds < tEmeralds
                                  ? Palette.red
                                  : Palette.grey),
                        ),
                        Row(
                          children: [
                            Text(
                              "${user.emeralds.toString()} COP ",
                              style: TextStyle(
                                  color: user.emeralds < tEmeralds
                                      ? Palette.red
                                      : Palette.grey),
                            ),
                            Image(
                                image: AssetImage('images/emerald.png'),
                                height: 20.0),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: TextStyle(
                                color: Palette.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                "${tEmeralds.toString()} COP ",
                                style: TextStyle(
                                    color: Palette.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Image(
                                  image: AssetImage('images/emerald.png'),
                                  height: 20.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                    user.emeralds < tEmeralds
                        ? CumbiaButton(
                            onPressed: canPush() ? () {} : () {},
                            title: 'Recargar Esmeraldas',
                            backgroundColor: Palette.red,
                          )
                        : CumbiaButton(
                            onPressed: !canPush()
                                ? () {
                                    showConfirmAlert(
                                        context,
                                        'Aviso',
                                        'El carro de compras esta vacío, agrega algún producto para continuar con la compra',
                                        () {});
                                  }
                                : () async {
                                    List<Address> list = [];
                                    List<dynamic> data;
                                    await References.users
                                        .doc(user.id)
                                        .get()
                                        .then((value) {
                                      data = value.data()['addresses'] as List;
                                    }).then((value) {
                                      data.forEach((element) {
                                        list.add(Address(
                                            country: element['country'],
                                            city: element['city'],
                                            address: element['address'],
                                            isPrincipal:
                                                element['isPrincipal']));
                                      });
                                    }).then((value) async {
                                      await Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              Q2ShoppingCartScreen(
                                                  list, shoppingCart.list),
                                        ),
                                      );
                                    });
                                  },
                            title: 'Siguiente',
                            backgroundColor: Palette.cumbiaDark,
                            canPush: canPush(),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void totalEmeralds() {
    int acum = 0;
    if (this.products.isNotEmpty) {
      for (var i = 0; i < this.products.length; i++) {
        acum += (this.products[i].price * this.products[i].unitsCarrito);
      }
    }
    tEmeralds = acum;
  }

  void update() {
    setState(() {
      this.products = [...shoppingCart.list];
      totalEmeralds();
    });
  }

  Future<int> createList() async {
    productsList.clear();

    if (this.products.isNotEmpty) {
      for (var i = 0; i < this.products.length; i++) {
        var id = this.products[i].id;

        await References.products.doc(id).get().then((value) {
          productsList.add(ProductItem(
            imageUrl: value.data()['productInfo']['imageUrl'],
            name: value.data()['productInfo']['productName'] ?? "No especifica",
            description:
                value.data()['productInfo']['description'] ?? "No especifica",
            price: value.data()['price'],
            id: value.id,
            update: update,
          ));
        }).catchError((e) => print('error $e'));
      }
      update();
    }
    return 1;
  }

  bool canPush() {
    if (productsList.length < 1) {
      return false;
    } else {
      return true;
    }
  }
}

class ProductItem extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String description;
  final int price;
  final String id;
  final Function update;

  const ProductItem(
      {Key key,
      this.imageUrl,
      this.name,
      this.description,
      this.price,
      this.id,
      this.update})
      : super(key: key);

  @override
  _ProductItemState createState() =>
      _ProductItemState(imageUrl, name, description, price, id, update);
}

class _ProductItemState extends State<ProductItem> {
  List<Product> products = [];
  String imageUrl;
  String name;
  String description;
  int price;
  String id;
  Function update;

  int count;
  bool hide = false;

  @override
  void initState() {
    super.initState();
    this.products = [...shoppingCart.list];
  }

  _ProductItemState(this.imageUrl, this.name, this.description, this.price,
      this.id, this.update) {
    count = shoppingCart.list
        .where((element) => element.id == id)
        .first
        .unitsCarrito;
  }

  @override
  Widget build(BuildContext context) {
    return hide
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Palette.cumbiaDark,
                child: Column(
                  children: [
                    Container(
                      color: Palette.grey,
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(10.0),
                              height: MediaQuery.of(context).size.width / 6,
                              width: MediaQuery.of(context).size.width / 6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  description,
                                  style: TextStyle(fontSize: 12.0),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              width: MediaQuery.of(context).size.width / 4,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (count - 1 > 0) {
                                          this
                                              .products
                                              .where(
                                                  (element) => element.id == id)
                                              .first
                                              .unitsCarrito--;
                                          count--;
                                          update();
                                        } else {
                                          showMainActionAlert(
                                              context,
                                              'Eliminar producto.',
                                              '¿Desea eliminar el producto del carro?',
                                              () {
                                            setState(() {
                                              remove(id);
                                              hide = true;
                                              update();
                                            });
                                          });
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Palette.cumbiaDark,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      width: MediaQuery.of(context).size.width /
                                          12,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              12,
                                      child: Center(
                                        child: Icon(
                                          Icons.remove,
                                          color: Palette.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Center(
                                          child: Text(count.toString(),
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold)))),
                                  GestureDetector(
                                    onTap: () {
                                      if (count + 1 <=
                                          shoppingCart.list
                                              .where(
                                                  (element) => element.id == id)
                                              .first
                                              .avaliableUnits) {
                                        setState(
                                          () {
                                            shoppingCart.list
                                                .where((element) =>
                                                    element.id == id)
                                                .first
                                                .unitsCarrito++;
                                            count++;
                                            update();
                                          },
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Palette.cumbiaDark,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      width: MediaQuery.of(context).size.width /
                                          12,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              12,
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Palette.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Precio',
                              style: TextStyle(
                                  color: Palette.white, fontSize: 16.0),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${(price * count).toString()} COP ",
                                  style: TextStyle(
                                      color: Palette.white, fontSize: 16.0),
                                ),
                                Image(
                                    image: AssetImage('images/emerald.png'),
                                    height: 20.0),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void remove(id) {
    shoppingCart.list.removeWhere((element) => element.id == id);
    this.products.removeWhere((element) => element.id == id);
  }
}
