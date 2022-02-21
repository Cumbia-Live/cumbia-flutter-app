import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import '../../../config/config.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/model/models.dart';

class ListPurchases extends StatefulWidget {
  final List<Purchase> purchases;

  @override
  _ListPurchasesState createState() => _ListPurchasesState(purchases);

  ListPurchases(this.purchases);
}

class _ListPurchasesState extends State<ListPurchases> {
  List<Purchase> purchases;

  _ListPurchasesState(this.purchases);

  @override
  Widget build(BuildContext context) {
    return CatapultaScrollView(
      child: Column(
        children: [
          SizedBox(height: 30.0),
          Column(
            children: list(context),
          ),
        ],
      ),
    );
  }

  List<Widget> list(BuildContext context) {
    var listPurchases = <Widget>[];
    purchases.forEach((element) => {
          element.products.forEach((product) {
            listPurchases.add(Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              color: Palette.txtBgColor,
              child: ListTile(
                title: Text(product.productName,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                leading: Container(
                    height: MediaQuery.of(context).size.width / 6,
                    width: MediaQuery.of(context).size.width / 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    )),
                subtitle: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: product.description,
                          style: Styles.txtTextLbl(
                              color: Palette.cumbiaGrey, size: 14)),
                      TextSpan(text: '\n'),
                      TextSpan(
                        style: element.received
                            ? Styles.txtTextLbl(
                                color: Palette.cumbiaLight, size: 12)
                            : Styles.txtTextLbl(
                                color: Palette.cumbiaGrey, size: 12),
                        text: element.received
                            ? formatDate(
                                DateTime(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            element.dateReceived)
                                        .year,
                                    DateTime.fromMillisecondsSinceEpoch(
                                            element.dateReceived)
                                        .month,
                                    DateTime.fromMillisecondsSinceEpoch(
                                            element.dateReceived)
                                        .day),
                                ['dd', '/', 'mm', '/', 'yyyy']).toString()
                            : formatDate(
                                DateTime(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            element.datePurchase)
                                        .year,
                                    DateTime.fromMillisecondsSinceEpoch(
                                            element.datePurchase)
                                        .month,
                                    DateTime.fromMillisecondsSinceEpoch(
                                            element.datePurchase)
                                        .day),
                                ['dd', '/', 'mm', '/', 'yyyy']).toString(),
                      )
                    ],
                  ),
                ),
                isThreeLine: true,
                trailing: (element.received && product.rated)
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Palette.cumbiaIconGrey,
                        ),
                        onPressed: () async {
                          Merchant m;
                          await References.merchant
                              .where('userId', isEqualTo: product.uid)
                              .get()
                              .then((value) {
                            m = Merchant(
                                shopName:
                                    value.docs.first.data()['shopName']);
                          }).then((value) async {
                            List<dynamic> review = [];
                            await References.reviews
                                .where('uid', isEqualTo: user.id)
                                .where('productId',
                                    isEqualTo: product.idProduct)
                                .get()
                                .then((value) {
                              review.add(value.docs.first.data()['review']);
                              review.add(value.docs.first.data()['rate']);
                            }).then((value) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      MyPurchasesProductScreen(
                                          product, element, m,
                                          rev: review),
                                ),
                              );
                            });
                          });
                        },
                      )
                    : (element.received && !product.rated)
                        ? GestureDetector(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Palette.cumbiaLight,
                                ),
                                Text(
                                  'Calificar',
                                  style: TextStyle(
                                      fontSize: 12, color: Palette.cumbiaLight),
                                ),
                                Text('producto',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Palette.cumbiaLight)),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            onTap: () async {
                              Merchant m;
                              await References.merchant
                                  .where('userId', isEqualTo: product.uid)
                                  .get()
                                  .then((value) {
                                m = Merchant(
                                    shopName:
                                        value.docs.first.data()['shopName']);
                              }).then((value) async {
                                final result = await Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        MyPurchasesProductScreen(
                                            product, element, m),
                                  ),
                                );
                                setState(() {
                                  product = result;
                                });
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Palette.cumbiaIconGrey,
                            ),
                            onPressed: () async {
                              Merchant m;
                              await References.merchant
                                  .where('userId', isEqualTo: product.uid)
                                  .get()
                                  .then((value) {
                                m = Merchant(
                                    shopName:
                                        value.docs.first.data()['shopName']);
                              }).then((value) => {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                MyPurchasesProductScreen(
                                                    product, element, m),
                                          ),
                                        )
                                      });
                            },
                          ),
              ),
            ));
          })
        });

    return listPurchases;
  }
}
