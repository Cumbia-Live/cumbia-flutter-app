import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/components/components.dart';
import 'package:date_format/date_format.dart';

Purchase actualPurchase;
List<String> info;
bool status;
bool received;
bool send;

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();

  OrderScreen(Purchase pur, List<String> list) {
    actualPurchase = pur;
    info = list;
    status = actualPurchase.received;
    received = actualPurchase.received;
    send = actualPurchase.isSend;
  }
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        //actionsForegroundColor: Palette.black,
        border: Border.symmetric(),
        middle: Text(
          info[0],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.black,
          ),
        ),
        backgroundColor: Palette.bgColor,
      ),
      body: CatapultaScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lista de productos',
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.cumbiaGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.0),
              productList(),
              SizedBox(height: 30.0),
              Text(
                'Destinatario',
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.cumbiaGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  '@${info[1]}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Palette.cumbiaIconGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'País de entrega',
                          style: TextStyle(
                            fontSize: 16,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            actualPurchase.address.country,
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
                          'Ciudad de entrega',
                          style: TextStyle(
                            fontSize: 16,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            actualPurchase.address.city,
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
              Text(
                'Dirección de entrega',
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.cumbiaGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  actualPurchase.address.address,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Palette.cumbiaIconGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                            fontSize: 16,
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
                                            actualPurchase.datePurchase)
                                        .year,
                                    DateTime.fromMillisecondsSinceEpoch(
                                            actualPurchase.datePurchase)
                                        .month,
                                    DateTime.fromMillisecondsSinceEpoch(
                                            actualPurchase.datePurchase)
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
                            fontSize: 16,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            actualPurchase.purchaseType,
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
              !status ? getStatus() : getReceived(),
              SizedBox(height: 30.0),
              Text(
                'Precio de pedido',
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.cumbiaGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      actualPurchase.emeralds.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
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
              SizedBox(height: 30.0),
              !status
                  ? CumbiaButton(
                      title: 'Guardar cambios',
                      backgroundColor: Palette.cumbiaLight,
                      canPush: true,
                      onPressed: () {
                        updateStatus();
                        Navigator.of(context).pop([
                          send,
                          received,
                          DateTime.now().millisecondsSinceEpoch
                        ]);
                      },
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  void updateStatus() {
    Map<String, dynamic> status = {
      'isSend': send,
      'received': received,
    };

    if (received) {
      status['dateReceived'] = DateTime.now().millisecondsSinceEpoch;
    }

    References.purchases.doc(actualPurchase.id).update(status);
  }

  Widget getStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estado',
          style: TextStyle(
            fontSize: 16,
            color: Palette.cumbiaGrey,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    send = false;
                    received = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: (!received && !send)
                        ? Palette.cumbiaDark
                        : Palette.grey,
                  ),
                  child: Center(
                    child: Text(
                      'En preparación',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (!received && !send)
                              ? Palette.lightGrey
                              : Palette.cumbiaGrey),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.0),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    send = true;
                    received = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color:
                        (!received && send) ? Palette.cumbiaDark : Palette.grey,
                  ),
                  child: Center(
                    child: Text(
                      'Enviado',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (!received && send)
                              ? Palette.lightGrey
                              : Palette.cumbiaGrey),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.0),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    send = true;
                    received = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: (received) ? Palette.cumbiaDark : Palette.grey,
                  ),
                  child: Center(
                    child: Text(
                      'Entregado',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (received)
                              ? Palette.lightGrey
                              : Palette.cumbiaGrey),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getReceived() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'Fecha de entrega',
                style: TextStyle(
                  fontSize: 16,
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
                                  actualPurchase.dateReceived)
                              .year,
                          DateTime.fromMillisecondsSinceEpoch(
                                  actualPurchase.dateReceived)
                              .month,
                          DateTime.fromMillisecondsSinceEpoch(
                                  actualPurchase.dateReceived)
                              .day),
                      ['dd', '/', 'mm', '/', 'yyyy']).toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Palette.cumbiaLight,
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
                'Estado',
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.cumbiaGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Entregado',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Palette.cumbiaLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        )
      ],
    );
  }

  Widget productList() {
    List<Widget> list = [];

    for (Product p in actualPurchase.products) {
      list.add(Container(
        margin: EdgeInsets.only(bottom: 5.0),
        color: Palette.txtBgColor,
        child: Row(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: FittedBox(
                    child: Image.network(p.imageUrl), fit: BoxFit.fill),
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
                    Text(p.productName, style: Styles.navTitleLbl),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: p.description,
                              style: Styles.txtTextLbl(
                                  color: Palette.cumbiaGrey, size: 14.0)),
                          TextSpan(text: '\n'),
                          TextSpan(
                            style: TextStyle(
                                color: Palette.cumbiaGrey, fontSize: 12),
                            text:
                                '${p.unitsCarrito} ${p.unitsCarrito == 1 ? 'Unidad' : 'Unidades'}',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Text((p.emeralds * p.unitsCarrito).toString(),
                      style: TextStyle(color: Palette.cumbiaLight)),
                  Image(image: AssetImage('images/emerald.png'), height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return list.isNotEmpty
        ? Column(
            children: list,
          )
        : SizedBox.shrink();
  }
}
