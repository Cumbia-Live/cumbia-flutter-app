import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/components/listViewCumbia.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/store_profile/all_products_profile.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:cumbialive/components/cumbiaProductCard.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/screens/store_profile/profile_product_detail.dart';
import '../../components/listViewCumbia.dart';
import '../../model/product/product.dart';

class ProfileStoreScreen extends StatefulWidget {
  ProfileStoreScreen({@required this.tienda});
  final Merchant tienda;

  @override
  _ProfileStoreScreenState createState() => _ProfileStoreScreenState();
}

class _ProfileStoreScreenState extends State<ProfileStoreScreen> {
  List<Product> allProducts = [];
  List<Product> products = [];
  List<Product> otherProducts = [];
  Merchant tiendaAux;
  final notification = LoadUsers();

  @override
  void initState() {
    super.initState();
    setState(() {
      tiendaAux = widget.tienda;
    });
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.cumbiaSeller,
      appBar: AppBar(
        // Título centrado
        centerTitle: true,
        elevation: 0,
        title: Text(
          tiendaAux.razonSocial,
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
          CatapultaScrollView(
            child: Stack(
              children: [
                Container(color: Palette.bgColor),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              )
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
                            child: tiendaAux.user.profilePictureURL == null
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
                                : tiendaAux.user.profilePictureURL.isEmpty ??
                                        false
                                    ? Icon(
                                        user.roles.isAdmin ?? false
                                            ? Icons.person
                                            : user.roles.isMerchant ?? false
                                                ? Icons.store_mall_directory
                                                : Icons.person,
                                        color: Palette.cumbiaGrey,
                                        size:
                                            MediaQuery.of(context).size.width /
                                                3,
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.network(
                                              tiendaAux.user.profilePictureURL),
                                        ),
                                      ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 25.0, horizontal: 0.0),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Última Transmisión",
                            style: Styles.ulTransmision,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Hace 15 horas",
                            style: Styles.ulTransmision2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 50,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tiendaAux.category1,
                            style: Styles.categoriasPerfilTiendas,
                          ),
                          Text(
                            "   ",
                          ),
                          Icon(Icons.circle, size: 8),
                          Text(
                            "   ",
                          ),
                          Text(
                            tiendaAux.category2,
                            style: Styles.categoriasPerfilTiendas,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        "Productos",
                        style: Styles.titleRegister,
                      ),
                      margin: EdgeInsets.only(
                        left: 20,
                        bottom: 10,
                      ),
                    ),
                    Container(
                      child: allProducts.isNotEmpty
                          ? Container(
                              child: Text(
                                allProducts[0].productName,
                                style: Styles.labelBoldAdmin,
                              ),
                              margin: EdgeInsets.only(
                                left: 20,
                                bottom: 10,
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.all(20),
                              child: Text(
                                "",
                                style: Styles.ulTransmision,
                              ),
                            ),
                    ),
                    Container(
                      child: products.isNotEmpty
                          ? Container(
                              height:
                                  ((MediaQuery.of(context).size.width * 0.3) *
                                          this.tamanoGrid(products)) +
                                      10,
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount:
                                    products.length < 6 ? products.length : 6,
                                itemBuilder: (BuildContext context, index) {
                                  return CumbiaProductCard(
                                    product: products[index],
                                    borderColor: Palette.cumbiaLight,
                                    onPress: () {
                                      print(products.length);
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => ProductDetails(
                                            product: products[index],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.all(20),
                              child: Center(
                                child: Text(
                                  "        Aún no hay productos\nautorizados en ${widget.tienda.razonSocial}",
                                  style: Styles.ulTransmision,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: products.isNotEmpty
                          ? Container(
                              height: products.length < 2 ? 110.0 : 110.0 * 2,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    products.length < 2 ? products.length : 2,
                                itemBuilder: (context, index) {
                                  return ListViewCumbia(
                                    product: products[index],
                                    onPress: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => ProductDetails(
                                            product: products[index],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.all(20),
                              child: Text(
                                "",
                                style: Styles.ulTransmision,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: otherProducts.isNotEmpty
                          ? Container(
                              child: Text(
                                "Otros artículos de la tienda",
                                style: Styles.secondaryLbl,
                              ),
                              margin: EdgeInsets.only(
                                left: 20,
                                bottom: 10,
                              ),
                            )
                          : Container(
                              height: 5,
                            ),
                    ),
                    Container(
                      child: otherProducts.isNotEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemCount: otherProducts.length < 3
                                      ? otherProducts.length
                                      : 3,
                                  itemBuilder: (BuildContext context, index) {
                                    return CumbiaProductCard(
                                      product: otherProducts[index],
                                      borderColor:
                                          Colors.white.withOpacity(0.8),
                                      onPress: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                ProductDetails(
                                              product: otherProducts[index],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                              margin: EdgeInsets.only(
                                bottom: 20,
                              ),
                            )
                          : Container(
                              height: 5,
                            ),
                    ),
                    Center(
                      child: CumbiaButton(
                        backgroundColor: Palette.cumbiaDark,
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AllProfileProducts(
                                lstProducts: allProducts,
                              ),
                            ),
                          );
                        },
                        title: "Ver Todos los productos",
                        width: MediaQuery.of(context).size.width - 50,
                        canPush: true,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getOtherProducts() {
    if (allProducts.isNotEmpty) {
      for (var i = 0; i < allProducts.length; i++) {
        if (allProducts[i]
            .productName
            .toLowerCase()
            .contains(allProducts[0].productName.toLowerCase())) {
          products.add(allProducts[i]);
        } else {
          if (!allProducts[i].isVariant) {
            otherProducts.add(allProducts[i]);
          }
        }
      }
    }
  }

  double tamanoGrid(List<Product> productos) {
    double cont = 0;
    for (var i = 0; i < productos.length; i++) {
      if (i % 3 == 0) {
        cont++;
      }
    }
    return cont;
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  void getProducts() {
    allProducts.clear();
    LogMessage.get('PRODUCTS');
    References.products
        .where('uid', isEqualTo: widget.tienda.user.id)
        .get()
        .then((productDoc) {
      LogMessage.getSuccess('PRODUCTS');
      if (productDoc.docs.isNotEmpty) {
        productDoc.docs.forEach((product) {
          setState(() {
            allProducts.add(
              Product(
                id: product.id,
                idProduct: product.data()['idProduct'],
                uid: product.data()['uid'],
                mainProductId: product.data()['productInfo']['mainProductId'],
                imageUrl: product.data()['productInfo']['imageUrl'],
                productName: product.data()['productInfo']['productName'] ??
                    "No especifica",
                description: product.data()['productInfo']['description'] ??
                    "No especifica",
                reference:
                    product.data()['productInfo']['reference'] ?? "No especifica",
                isVariant: product.data()['productInfo']['isVariant'],
                height: product.data()['especifications']['height'] ??
                    "No especifica",
                large:
                    product.data()['especifications']['large'] ?? "No especifica",
                width:
                    product.data()['especifications']['width'] ?? "No especifica",
                weight: product.data()['especifications']['weight'] ??
                    "No especifica",
                color: product.data()['variantInfo']['color'] ?? "No especifica",
                dimension:
                    product.data()['variantInfo']['dimension'] ?? "No especifica",
                size: product.data()['variantInfo']['size'] ?? "No especifica",
                material:
                    product.data()['variantInfo']['material'] ?? "No especifica",
                style: product.data()['variantInfo']['style'] ?? "No especifica",
                avaliableUnits:
                    product.data()['avaliableUnits'] ?? "No especifica",
                price: product.data()['price'] ?? "No especifica",
                isSelected: product.data()['isSelected'],
                comission: product.data()['comission'],
                isFreeShipping: product.data()['isFreeShipping'] ?? false,
                emeralds: product.data()['emeralds'] ?? 0,
                unitsCarrito: 1,
                unitsCheckout: 1,
              ),
            );
            products.clear();
            otherProducts.clear();
            getOtherProducts();
          });
        });
      }
    }).catchError((e) {
      LogMessage.getError('PRODUCTS', e);
    });
  }
}

Color _getBGColor() {
  return user.roles.isAdmin ?? false
      ? Palette.cumbiaDark
      : user.roles.isMerchant ?? false
          ? Palette.cumbiaSeller
          : Palette.cumbiaLight;
}
