import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/profile/my_purchases/my_purchases_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cumbialive/config/config.dart';
import '../../functions/functions.dart';
import '../screens.dart';
import 'package:cumbialive/components/components.dart';

List<Purchase> compras = [];
List<Purchase> ventasD = [];
List<Withdrawal> retiros = [];

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        leading: const SizedBox.shrink(),
        border: Border.symmetric(),
        middle: Text(
          'Perfil',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        backgroundColor: _getBGColor(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: Container(color: _getBGColor())),
              Expanded(child: Container(color: Palette.bgColor)),
            ],
          ),
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
                                  color: _getBGColor(),
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
                                              user.profilePictureURL),
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
                      child: Text(
                        '¡Bienvenido, ${user.name.split(" ").first}!',
                        style: Styles.perfilNameLbl,
                      ),
                    ),
                    user.roles.isAdmin ?? false
                        ? CatapultaListTitle(
                            text: 'Panel de administrador',
                            iconData: Icons.build,
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => AdminScreen(),
                                ),
                              );
                            },
                            iconColor: Palette.cumbiaIconGrey,
                          )
                        : const SizedBox.shrink(),
                    user.roles.isAdmin ?? false
                        ? CatapultaDivider(height: 2.0)
                        : const SizedBox.shrink(),
                    CatapultaListTitle(
                      text: 'Información de usuario',
                      iconData: Icons.person,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => AdminScreen(),
                          ),
                        );
                      },
                      iconColor: Palette.cumbiaIconGrey,
                    ),
                    CatapultaDivider(height: 2.0),
                    CatapultaListTitle(
                      text: 'Mis compras',
                      iconData: Icons.shopping_cart,
                      onTap: () async {
                        List<Purchase> purchases = [];
                        await References.purchases
                            .where('uuidBuyer', isEqualTo: user.id)
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
                                    country: element.data()['address']
                                        ['country']),
                                received: element.data()['received'],
                                rated: element.data()['rated'],
                                rate: element.data()['rate'],
                                emeralds: element.data()['emeralds'],
                                purchaseType:
                                    element.data()['purchaseType'] ?? 'Tienda',
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
                                      isVariant: pur.data()['productInfo']
                                          ['isVariant'],
                                      imageUrl: (pur.data()['productInfo']
                                                      ['imageUrl'] !=
                                                  '' &&
                                              pur.data()['productInfo']
                                                      ['imageUrl'] !=
                                                  null)
                                          ? pur.data()['productInfo']['imageUrl']
                                          : 'https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2Fno-image.png?alt=media&token=e8d0c24b-34b5-4d37-9811-ce308a9e98b2',
                                      productName: pur.data()['productInfo']
                                              ['productName'] ??
                                          '',
                                      description: pur.data()['productInfo']
                                              ['description'] ??
                                          '',
                                      reference: pur.data()['productInfo']
                                              ['reference'] ??
                                          '',
                                      height: double.parse(pur
                                              .data()['especifications']['height']
                                              .toString()) ??
                                          '',
                                      large: double.parse(pur
                                              .data()['especifications']['large']
                                              .toString()) ??
                                          '',
                                      width: double.parse(pur
                                              .data()['especifications']['width']
                                              .toString()) ??
                                          '',
                                      weight: double.parse(pur
                                              .data()['especifications']['weight']
                                              .toString()) ??
                                          '',
                                      avaliableUnits:
                                          pur.data()['avaliableUnits'] ?? '',
                                      emeralds: pur.data()['emeralds'] ?? '',
                                      color: pur.data()['variantInfo']['color'] ??
                                          '',
                                      size:
                                          pur.data()['variantInfo']['size'] ?? '',
                                      dimension: pur.data()['variantInfo']
                                              ['dimension'] ??
                                          '',
                                      material: pur.data()['variantInfo']
                                              ['material'] ??
                                          '',
                                      style: pur.data()['variantInfo']['style'] ??
                                          '',
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
                                          MyPurchasesScreen(purchases),
                                    ),
                                  )
                                });
                      },
                      iconColor: Palette.cumbiaIconGrey,
                    ),
                    CatapultaDivider(height: 2.0),
                    CatapultaListTitle(
                      text: 'Mi monedero',
                      iconData: Icons.monetization_on,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                MonederoPage(compras, ventas, retiros),
                          ),
                        );
                      },
                      iconColor: Palette.cumbiaIconGrey,
                    ),
                    CatapultaDivider(height: 2.0),
                    ((user.roles.isAdmin ?? false) ||
                                (user.roles.isMerchant ?? false)) ==
                            false
                        ? CatapultaListTitle(
                            text: 'Conviértete en Aliado Cumbia',
                            iconData: Icons.favorite_border,
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ContactFormQ1(),
                                ),
                              );
                            },
                            iconColor: Palette.cumbiaIconGrey,
                          )
                        : CatapultaListTitle(
                            text: 'Mi tienda',
                            iconData: Icons.store_mall_directory,
                            onTap: () async {
                              bool open;
                              await References.merchant
                                  .where('userId', isEqualTo: user.id)
                                  .get()
                                  .then((value) => open =
                                      value.docs.first.data()['isOpen'])
                                  .then((value) => {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                MyShopScreen(open),
                                          ),
                                        )
                                      });
                            },
                            iconColor: Palette.cumbiaIconGrey,
                          ),
                    CatapultaDivider(height: 2.0),
                    CatapultaListTitle(
                      text: 'Configuración',
                      iconData: Icons.settings,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        );
                      },
                      iconColor: Palette.cumbiaIconGrey,
                    ),
                    CatapultaDivider(height: 2.0),
                    !(user.roles.isAdmin ?? false)
                        ? CatapultaListTitle(
                            text: '¿Qué opinas del app?',
                            iconData: Icons.message,
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => OpinionScreen(),
                                ),
                              );
                            },
                            iconColor: Palette.cumbiaIconGrey,
                          )
                        : const SizedBox.shrink(),
                    !(user.roles.isAdmin ?? false)
                        ? CatapultaDivider(height: 2.0)
                        : const SizedBox.shrink(),
                    CatapultaListTitle(
                      text: 'Chat de soporte',
                      iconData: MdiIcons.whatsapp,
                      onTap: () {
                        showMainActionAlert(
                            context,
                            'Redirección a soporte',
                            'Para recibir soporte serás redireccionado a '
                                'un chat de WhatsApp.', () {
                          Contactar.escribir(context, support.wappNumber);
                        });
                      },
                      iconColor: Palette.cumbiaIconGrey,
                    ),
                    CatapultaDivider(height: 2.0),
                    CatapultaListTitle(
                      text: 'Cerrar sesión',
                      iconData: Icons.file_download,
                      onTap: () {
                        showMainActionAlert(
                            context, '¿Quieres cerrar sesión?', '', () {
                          FirebaseAuth.instance.signOut().then((value) {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }).catchError((e) {
                            showBasicAlert(
                              context,
                              "No pudimos cerrar sesión",
                              "Por favor, intenta más tarde.",
                            );
                          });
                        },
                            mainActionText: "Continuar",
                            isDestructiveAction: true);
                      },
                      iconColor: Palette.cumbiaIconGrey,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void cargarDatos() async {
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
                  imageUrl: (pur.data()['productInfo']['imageUrl'] != '' &&
                          pur.data()['productInfo']['imageUrl'] != null)
                      ? pur.data()['productInfo']['imageUrl']
                      : 'https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2Fno-image.png?alt=media&token=e8d0c24b-34b5-4d37-9811-ce308a9e98b2',
                  productName: pur.data()['productInfo']['productName'] ?? '',
                  description: pur.data()['productInfo']['description'] ?? '',
                  reference: pur.data()['productInfo']['reference'] ?? '',
                  height: double.parse(
                          pur.data()['especifications']['height'].toString()) ??
                      '',
                  large: double.parse(
                          pur.data()['especifications']['large'].toString()) ??
                      '',
                  width: double.parse(
                          pur.data()['especifications']['width'].toString()) ??
                      '',
                  weight: double.parse(
                          pur.data()['especifications']['weight'].toString()) ??
                      '',
                  avaliableUnits: pur.data()['avaliableUnits'] ?? '',
                  emeralds: pur.data()['emeralds'] ?? '',
                  color: pur.data()['variantInfo']['color'] ?? '',
                  size: pur.data()['variantInfo']['size'] ?? '',
                  dimension: pur.data()['variantInfo']['dimension'] ?? '',
                  material: pur.data()['variantInfo']['material'] ?? '',
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
              purchaseType: element.data()['purchaseType'] ?? 'Tienda',
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
                    imageUrl: (pur.data()['productInfo']['imageUrl'] != '' &&
                            pur.data()['productInfo']['imageUrl'] != null)
                        ? pur.data()['productInfo']['imageUrl']
                        : 'https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2Fno-image.png?alt=media&token=e8d0c24b-34b5-4d37-9811-ce308a9e98b2',
                    productName: pur.data()['productInfo']['productName'] ?? '',
                    description: pur.data()['productInfo']['description'] ?? '',
                    reference: pur.data()['productInfo']['reference'] ?? '',
                    height: double.parse(
                            pur.data()['especifications']['height'].toString()) ??
                        '',
                    large: double.parse(
                            pur.data()['especifications']['large'].toString()) ??
                        '',
                    width: double.parse(
                            pur.data()['especifications']['width'].toString()) ??
                        '',
                    weight: double.parse(
                            pur.data()['especifications']['weight'].toString()) ??
                        '',
                    avaliableUnits: pur.data()['avaliableUnits'] ?? '',
                    emeralds: pur.data()['emeralds'] ?? '',
                    color: pur.data()['variantInfo']['color'] ?? '',
                    size: pur.data()['variantInfo']['size'] ?? '',
                    dimension: pur.data()['variantInfo']['dimension'] ?? '',
                    material: pur.data()['variantInfo']['material'] ?? '',
                    style: pur.data()['variantInfo']['style'] ?? '',
                    comission: pur.data()['comission'],
                    price: pur.data()['price'],
                    rated: pur.data()['rated'],
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
      });
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
