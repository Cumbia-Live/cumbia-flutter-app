import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/shopping_cart/confirmation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Address dataAddress;
List<Product> p;
int tEmeralds;
String details;

class Q3ShoppingCartScreen extends StatefulWidget {
  @override
  _Q3ShoppingCartScreenState createState() => _Q3ShoppingCartScreenState();

  Q3ShoppingCartScreen(
      Address address, List<Product> product, int emeralds, String d) {
    dataAddress = address;
    p = product;
    tEmeralds = emeralds;
    details = d;
  }
}

class _Q3ShoppingCartScreenState extends State<Q3ShoppingCartScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.black,
        middle: Text(
          'Información para pago',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.black,
          ),
        ),
        backgroundColor: Palette.bgColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.check_box, color: Palette.grey, size: 40.0),
                  Icon(Icons.check_box, color: Palette.grey, size: 40.0),
                  Icon(Icons.looks_3_rounded,
                      color: Palette.cumbiaDark, size: 40.0),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información para pago',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Palette.black,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          controller: TextEditingController(text: user.name),
                          title: 'Nombre',
                          placeholder: null,
                          validator: null,
                          enabled: false,
                        ),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          controller: TextEditingController(
                              text: user.phoneNumber.basePhoneNumber),
                          title: 'Celular',
                          placeholder: null,
                          validator: null,
                          enabled: false,
                        ),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          title: 'Correo electrónico',
                          validator: null,
                          controller: TextEditingController(text: user.email),
                          placeholder: null,
                          enabled: false,
                        ),
                      ],
                    ),
                  ),
                ),
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
                          style: TextStyle(color: Palette.grey),
                        ),
                        Row(
                          children: [
                            Text(
                              "${user.emeralds.toString()} COP ",
                              style: TextStyle(color: Palette.grey),
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
                    CumbiaButton(
                      onPressed: () async {
                        _addPurchase();

                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Confirmation(p),
                            ));
                      },
                      title: 'Siguiente',
                      backgroundColor: Palette.cumbiaDark,
                      canPush: true,
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

  Future<void> _addPurchase() async {
    var time = DateTime.now().millisecondsSinceEpoch;
    String idMerchant = '';
    String idDocument = '';

    p.sort((a, b) => a.uid.compareTo(b.uid));

    for (var i = 0; i < p.length; i++) {
      if (p[i].uid != idMerchant) {
        var auxEmeralds = 0;
        p.where((element) => element.uid == p[i].uid).forEach((element) {
          auxEmeralds += element.emeralds * element.unitsCarrito;
        });
        Map<String, dynamic> purchaseMap = ({
          "uuidStreamer": p[i].uid,
          "uuidBuyer": user.id,
          "address": {
            "address": dataAddress.address,
            "city": dataAddress.city,
            "country": dataAddress.country,
          },
          "details": details.trim() ?? '',
          "datePurchase": time,
          "dateReceived": 0,
          "received": false,
          "rated": false,
          "rate": 0,
          "failed": false,
          "emeralds": auxEmeralds,
          "purchaseType": 'Tienda',
        });
        LogMessage.post("PURCHASE");
        await References.purchases.add(purchaseMap).then((r) async {
          LogMessage.postSuccess("PURCHASE");
          idDocument = r.id;
        }).catchError((e) {
          showBasicAlert(
            context,
            "Hubo un error.",
            "Por favor, intenta más tarde.",
          );
          LogMessage.postError("PURCHASE", e);
        });
        idMerchant = p[i].uid;
      }
      var productDoc = <String, dynamic>{
        'uid': user.id,
        'productInfo': {
          'mainProductId': p[i].mainProductId ?? '',
          'imageUrl': p[i].imageUrl ?? '',
          'productName': p[i].productName ?? '',
          'description': p[i].description ?? '',
          'reference': p[i].reference ?? '',
          'isVariant': p[i].isVariant,
        },
        'productId': p[i].id,
        'rated': false,
        'rate': 0,
        'especifications': {
          'height': p[i].height ?? '',
          'large': p[i].large ?? '',
          'width': p[i].width ?? '',
          'weight': p[i].weight ?? '',
        },
        'variantInfo': {
          'color': p[i].color ?? '',
          'dimension': p[i].dimension ?? '',
          'size': p[i].size ?? '',
          'material': p[i].material ?? '',
          'style': p[i].style ?? '',
        },
        'avaliableUnits': p[i].avaliableUnits ?? 0,
        'price': p[i].price ?? 0,
        'comission': p[i].comission ?? 0,
        'emeralds': p[i].emeralds ?? 0,
        'isSelected': false,
        'unitsCarrito': p[i].unitsCarrito ?? 0,
        'unitsCheckout': 0,
      };
      await References.purchases
          .doc(idDocument)
          .collection('products')
          .add(productDoc)
          .then((r) {
        Map<String, dynamic> productMap = {
          'avaliableUnits': p[i].avaliableUnits - p[i].unitsCarrito,
        };
        print("⏳ ACTUALIZARÉ PRODUCT");
        References.products.doc(p[i].id).update(productMap);
        LogMessage.postSuccess('PRODUCTS');
      }).catchError((e) {
        LogMessage.postError('PRODUCTS', e);
        showBasicAlert(
          context,
          'Hubo un error',
          'No pudimos enviar el feedback, por favor intenta más tarde.',
        );
      });
    }

    Map<String, dynamic> userMap = {
      'esmeraldas': user.emeralds - tEmeralds,
      'price': user.emeralds - tEmeralds,
    };
    print("⏳ ACTUALIZARÉ USER");
    References.users.doc(user.id).update(userMap);
    user.emeralds = user.emeralds - tEmeralds;
    shoppingCart.list.clear();
  }
}
