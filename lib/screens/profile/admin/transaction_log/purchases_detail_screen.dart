import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/components/components.dart';
import 'package:date_format/date_format.dart';

class PurchasesDetailScreen extends StatefulWidget {
  PurchasesDetailScreen(this.purchase);
  Purchase purchase;

  @override
  _PurchasesDetailScreenState createState() =>
      _PurchasesDetailScreenState(purchase);
}

class _PurchasesDetailScreenState extends State<PurchasesDetailScreen> {
  Purchase purchase;
  Merchant merchant;
  String commission = '0';

  _PurchasesDetailScreenState(this.purchase);

  @override
  void initState() {
    _getMerchant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        //actionsForegroundColor: Palette.black,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        border: Border.symmetric(),
        middle: Text(
          'Compra',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: CatapultaScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Palette.txtBgColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          "@${purchase.buyerName}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Palette.cumbiaIconGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              purchase.emeralds.toString(),
                              style: TextStyle(
                                color: Palette.cumbiaLight,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image(
                                image: AssetImage('images/emerald.png'),
                                height: 16.0),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          "Compró a",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Palette.cumbiaLight,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "@${purchase.streamName}",
                          style: TextStyle(
                            color: Palette.cumbiaIconGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Valor de la transacción',
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              Text(
                                purchase.emeralds.toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Palette.cumbiaIconGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Image(
                                image: AssetImage('images/emerald.png'),
                                height: 20.0,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Comisión Cumbia',
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "$commission%",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Palette.cumbiaIconGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'País de envío',
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              Text(
                                purchase.address.country,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Palette.cumbiaIconGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ciudad de envío',
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            purchase.address.city,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Palette.cumbiaIconGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Column(
                children: [
                  Text(
                    'Dirección de envío',
                    style: TextStyle(
                      fontSize: 14,
                      color: Palette.cumbiaGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      purchase.address.address,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Palette.cumbiaIconGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Fecha de pedido',
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            formatDate(
                                DateTime(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            purchase.datePurchase)
                                        .year,
                                    DateTime.fromMillisecondsSinceEpoch(
                                            purchase.datePurchase)
                                        .month,
                                    DateTime.fromMillisecondsSinceEpoch(
                                            purchase.datePurchase)
                                        .day),
                                ['dd', '/', 'mm', '/', 'yyyy']).toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Palette.cumbiaIconGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Comprado en',
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            purchase.purchaseType,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Palette.cumbiaIconGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  )
                ],
              ),
              SizedBox(height: 30.0),
              Column(
                children: [
                  Text(
                    'Estado',
                    style: TextStyle(
                      fontSize: 14,
                      color: Palette.cumbiaGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      purchase.received ? 'Recibido' : 'Enviado',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Palette.cumbiaIconGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              SizedBox(height: 30.0),
              Column(
                children: [
                  Text(
                    'Productos comprados',
                    style: TextStyle(
                      fontSize: 14,
                      color: Palette.cumbiaGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    children: productsList(purchase.products),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> productsList(List<Product> list) {
    List<Widget> products = [];

    for (Product p in list) {
      products.add(Container(
        margin: EdgeInsets.only(top: 10.0),
        color: Palette.txtBgColor,
        child: Row(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: FittedBox(
                    child: Image.network(p.imageUrl), fit: BoxFit.fill),
              ),
              width: MediaQuery.of(context).size.width / 6,
              height: MediaQuery.of(context).size.width / 6,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.productName, style: Styles.navTitleLbl),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: p.description,
                              style: Styles.txtTextLbl(
                                  color: Palette.cumbiaGrey, size: 14.0)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                '${p.unitsCarrito + p.unitsCheckout} unidades',
                style: TextStyle(fontSize: 12, color: Palette.cumbiaIconGrey),
              ),
            ),
          ],
        ),
      ));
    }
    return products;
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  Future<void> _getMerchant() async {
    LogMessage.get("MERCHANT");
    await References.merchant
        .where('userId', isEqualTo: purchase.uuidStreamer)
        .get()
        .then((merchantStream) {
      LogMessage.getSuccess("MERCHANT");
      merchant = Merchant(
        id: merchantStream.docs.first.id,
        rate: Rate(
          rateA: merchantStream.docs.first.data()["rates"]["rateA"],
          rateB: merchantStream.docs.first.data()["rates"]["rateB"] ?? 0,
          rateC: merchantStream.docs.first.data()["rates"]["rateC"] ?? 0,
          rateD: merchantStream.docs.first.data()["rates"]["rateD"] ?? 0,
          rateE: merchantStream.docs.first.data()["rates"]["rateE"] ?? 0,
          rateF: merchantStream.docs.first.data()["rates"]["rateF"] ?? 0,
        ),
      );

      setState(() {
        if (purchase.emeralds >= 1 && purchase.emeralds <= 10) {
          commission = merchant.rate.rateA.toString();
        } else if (purchase.emeralds >= 11 && purchase.emeralds <= 100) {
          commission = merchant.rate.rateB.toString();
        } else if (purchase.emeralds >= 101 && purchase.emeralds <= 2000) {
          commission = merchant.rate.rateC.toString();
        } else if (purchase.emeralds >= 2001 && purchase.emeralds <= 5000) {
          commission = merchant.rate.rateD.toString();
        } else if (purchase.emeralds >= 5001 && purchase.emeralds <= 15000) {
          commission = merchant.rate.rateE.toString();
        } else {
          commission = merchant.rate.rateF.toString();
        }
      });
    }).catchError((e) {
      LogMessage.getError("MERCHANT", e);
    }).then((value) async {
      purchase.products.clear();
      await References.purchases
          .doc(purchase.id)
          .collection('products')
          .get()
          .then((value) {
        value.docs.forEach((pur) {
          setState(() {
            purchase.products.add(Product(
              unitsCarrito: pur.data()['unitsCarrito'],
              unitsCheckout: pur.data()['unitsCheckout'],
              imageUrl: (pur.data()['productInfo']['imageUrl'] != '' &&
                      pur.data()['productInfo']['imageUrl'] != null)
                  ? pur.data()['productInfo']['imageUrl']
                  : 'https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2Fno-image.png?alt=media&token=e8d0c24b-34b5-4d37-9811-ce308a9e98b2',
              productName: pur.data()['productInfo']['productName'] ?? '',
              description: pur.data()['productInfo']['description'] ?? '',
            ));
          });
        });
      });
    });
  }
}
