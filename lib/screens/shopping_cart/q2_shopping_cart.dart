import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/network/api_connection.dart';
import 'package:cumbialive/screens/shopping_cart/q3_shopping_cart.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Address> dataAddress = [];
Address selected;
List<Product> p;
int tEmeralds = 0;

class Q2ShoppingCartScreen extends StatefulWidget {
  @override
  _Q2ShoppingCartScreenState createState() => _Q2ShoppingCartScreenState();

  Q2ShoppingCartScreen(List address, List<Product> product) {
    dataAddress = address;
    p = product;
    selected =
        dataAddress.where((element) => element.isPrincipal == true).first;
    totalEmeralds();
  }
}



class _Q2ShoppingCartScreenState extends State<Q2ShoppingCartScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController details = TextEditingController();

  String shippingCost = "Fetching...";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() async{
      shippingCost = await getDHLQoute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.black,
        middle: Text(
          'Información para envío',
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
                  Icon(Icons.looks_two_rounded,
                      color: Palette.cumbiaDark, size: 40.0),
                  Icon(Icons.looks_3_rounded, color: Palette.grey, size: 40.0),
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
                          'Información para envío',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Palette.black,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          controller:
                              TextEditingController(text: selected.country),
                          title: 'País',
                          placeholder: null,
                          validator: null,
                          enabled: false,
                        ),
                        selected.country.trim().toLowerCase() != 'colombia'
                            ? SizedBox(height: 10.0)
                            : SizedBox.shrink(),
                        selected.country.trim().toLowerCase() != 'colombia'
                            ? Row(
                                children: [
                                  Icon(Icons.error_outline, color: Palette.red),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                          text:
                                              'Los envios internacionales tienen un costo adicional de ',
                                          style: TextStyle(
                                              color: Palette.cumbiaIconGrey),
                                          children: [
                                            TextSpan(
                                              text: '$shippingCost COP.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          controller:
                              TextEditingController(text: selected.city),
                          title: 'Ciudad',
                          placeholder: null,
                          validator: null,
                          enabled: false,
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Dirección',
                          style: Styles.txtTitleLbl,
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 3.0,
                                  style: BorderStyle.solid,
                                  color: Palette.cumbiaDark),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: DropdownButton<Address>(
                              isExpanded: true,
                              underline: SizedBox.shrink(),
                              value: selected,
                              onChanged: (Address newValue) {
                                setState(() {
                                  selected = newValue;
                                  totalEmeralds();
                                });
                              },
                              items: dataAddress.map<DropdownMenuItem<Address>>(
                                  (Address value) {
                                return DropdownMenuItem<Address>(
                                  value: value,
                                  child: Text(value.address),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        dataAddress.length > 1
                            ? SizedBox(height: 10.0)
                            : SizedBox.shrink(),
                        dataAddress.length > 1
                            ? Row(
                                children: [
                                  Icon(Icons.error_outline,
                                      color: Palette.cumbiaDark),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Tienes más de una dirección, ',
                                          style: TextStyle(
                                              color: Palette.cumbiaIconGrey),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '¿A cuál de estas deseas que llegue la compra?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          title: 'Detalles (opcional)',
                          validator: null,
                          controller: details,
                          placeholder: 'Escribe los detalles de tu envío.',
                          maxlines: 3,
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
                    user.emeralds < tEmeralds
                        ? CumbiaButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => RecargarScreen(),
                                  ));
                            },
                            title: 'Recargar Esmeraldas',
                            backgroundColor: Palette.red,
                            canPush: true,
                          )
                        : CumbiaButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => Q3ShoppingCartScreen(
                                      selected,
                                      p,
                                      tEmeralds,
                                      details.text.trim()),
                                ),
                              );
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
}

void totalEmeralds() {
  int acum = 0;
  for (var i = 0; i < shoppingCart.list.length; i++) {
    acum += (shoppingCart.list[i].price * shoppingCart.list[i].unitsCarrito);
  }
  tEmeralds = acum;
  if (selected.country.trim().toLowerCase() != 'colombia') {
    tEmeralds += 500;
  }
}
