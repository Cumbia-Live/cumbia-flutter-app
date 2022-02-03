import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/components/components.dart';
import 'package:date_format/date_format.dart';
import 'package:cumbialive/functions/functions.dart';

Product product;
Purchase purchase;
Merchant merchant;
List<dynamic> review;

class MyPurchasesProductScreen extends StatefulWidget {
  @override
  _MyPurchasesProductScreenState createState() =>
      _MyPurchasesProductScreenState();

  MyPurchasesProductScreen(Product p, Purchase pur, Merchant m, {rev}) {
    product = p;
    purchase = pur;
    merchant = m;
    review = rev;
  }
}

class _MyPurchasesProductScreenState extends State<MyPurchasesProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        //actionsForegroundColor: Palette.black,
        border: Border.symmetric(),
        middle: Text(
          product.productName,
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
                'Imagen del producto',
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.cumbiaGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              (purchase.received == true && product.rated == false)
                  ? rate()
                  : SizedBox.shrink(),
              SizedBox(height: 30.0),
              Text(
                'Descripción',
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.cumbiaGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Palette.cumbiaIconGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Vendedor/Tienda',
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.cumbiaGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  merchant.shopName,
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
                            fontSize: 16,
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          purchase.received
                              ? 'Fecha de entrega'
                              : 'Tentativa de entrega',
                          style: TextStyle(
                            fontSize: 16,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            purchase.received
                                ? formatDate(
                                    DateTime(
                                        DateTime.fromMillisecondsSinceEpoch(
                                                purchase.dateReceived)
                                            .year,
                                        DateTime.fromMillisecondsSinceEpoch(
                                                purchase.dateReceived)
                                            .month,
                                        DateTime.fromMillisecondsSinceEpoch(
                                                purchase.dateReceived)
                                            .day),
                                    ['dd', '/', 'mm', '/', 'yyyy']).toString()
                                : purchase.daysToReceive != null
                                    ? formatDate(
                                        DateTime(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    purchase.datePurchase)
                                                .year,
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    purchase.datePurchase)
                                                .month,
                                            DateTime.fromMillisecondsSinceEpoch(
                                                        purchase.datePurchase)
                                                    .day +
                                                purchase.daysToReceive),
                                        [
                                            'dd',
                                            '/',
                                            'mm',
                                            '/',
                                            'yyyy'
                                          ]).toString()
                                    : ' - ',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: purchase.received
                                  ? Palette.cumbiaLight
                                  : Palette.cumbiaIconGrey,
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
                            purchase.received ? 'Recibido' : 'Enviado',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: purchase.received
                                  ? Palette.cumbiaLight
                                  : Palette.cumbiaIconGrey,
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
                'Precio',
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
                      product.emeralds.toString(),
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
              (purchase.received == true && product.rated == true)
                  ? getReview()
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int stars = 0;

  Widget rate() {
    int characters = 150;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Toca una estrella para calificar',
            style: TextStyle(
              fontSize: 16.0,
              color: Palette.cumbiaGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  child: Icon(stars >= 1 ? Icons.star : Icons.star_border,
                      color: Palette.cumbiaLight,
                      size: MediaQuery.of(context).size.width / 6),
                  onTap: () {
                    setState(() {
                      stars = 1;
                    });
                  }),
              GestureDetector(
                  child: Icon(stars >= 2 ? Icons.star : Icons.star_border,
                      color: Palette.cumbiaLight,
                      size: MediaQuery.of(context).size.width / 6),
                  onTap: () {
                    setState(() {
                      stars = 2;
                    });
                  }),
              GestureDetector(
                  child: Icon(stars >= 3 ? Icons.star : Icons.star_border,
                      color: Palette.cumbiaLight,
                      size: MediaQuery.of(context).size.width / 6),
                  onTap: () {
                    setState(() {
                      stars = 3;
                    });
                  }),
              GestureDetector(
                  child: Icon(stars >= 4 ? Icons.star : Icons.star_border,
                      color: Palette.cumbiaLight,
                      size: MediaQuery.of(context).size.width / 6),
                  onTap: () {
                    setState(() {
                      stars = 4;
                    });
                  }),
              GestureDetector(
                  child: Icon(stars >= 5 ? Icons.star : Icons.star_border,
                      color: Palette.cumbiaLight,
                      size: MediaQuery.of(context).size.width / 6),
                  onTap: () {
                    setState(() {
                      stars = 5;
                    });
                  }),
            ],
          ),
          SizedBox(height: 20.0),
          Form(
            key: _formKey,
            child: CumbiaTextField(
              maxlines: 3,
              labelTextColor: Palette.cumbiaGrey,
              title: 'Escribe una reseña',
              placeholder: 'Escribe aquí una breve reseña del producto',
              controller: reviewController,
              optional: '$characters carácteres',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Ingresa una reseña';
                } else if (value.length > 150) {
                  return 'No puedes superar los 150 carácteres';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                setState(() {
                  characters = 150 - reviewController.text.length;
                });
              },
            ),
          ),
          SizedBox(height: 20.0),
          CumbiaButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                if (stars == 0) {
                  showBasicAlert(
                      context, 'Error', 'Selecciona el número de estrellas');
                } else {
                  showMainActionAlert(
                      context, 'Confirmar', '¿Desea enviar la reseña?',
                      () async {
                    newReview();
                    showConfirmAlert(context, 'Enviado',
                        'La reseña fue enviada exitosamente', () {
                      Navigator.of(context).pop(product);
                    });
                  });
                }
              }
            },
            title: 'Enviar reseña',
            backgroundColor: Palette.cumbiaDark,
            canPush: true,
          ),
        ],
      ),
    );
  }

  Widget getReview() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calificación',
            style: TextStyle(
              fontSize: 16.0,
              color: Palette.cumbiaGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(review[1] >= 1 ? Icons.star : Icons.star_border,
                  color: Palette.cumbiaLight,
                  size: MediaQuery.of(context).size.width / 6),
              Icon(review[1] >= 2 ? Icons.star : Icons.star_border,
                  color: Palette.cumbiaLight,
                  size: MediaQuery.of(context).size.width / 6),
              Icon(review[1] >= 3 ? Icons.star : Icons.star_border,
                  color: Palette.cumbiaLight,
                  size: MediaQuery.of(context).size.width / 6),
              Icon(review[1] >= 4 ? Icons.star : Icons.star_border,
                  color: Palette.cumbiaLight,
                  size: MediaQuery.of(context).size.width / 6),
              Icon(review[1] >= 5 ? Icons.star : Icons.star_border,
                  color: Palette.cumbiaLight,
                  size: MediaQuery.of(context).size.width / 6),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            'Reseña',
            style: TextStyle(
              fontSize: 16.0,
              color: Palette.cumbiaGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              review[0],
              style: TextStyle(
                fontSize: 16.0,
                color: Palette.cumbiaIconGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Future<void> newReview() async {
    Map<String, dynamic> review = {
      'uid': user.id,
      'productId': product.idProduct,
      'rate': stars,
      'review': reviewController.text.trim(),
      'date': DateTime.now().millisecondsSinceEpoch,
    };

    References.reviews.add(review);
    References.purchases
        .doc(purchase.id)
        .collection('products')
        .where('productId', isEqualTo: product.idProduct)
        .get()
        .then((value) {
      References.purchases
          .doc(purchase.id)
          .collection('products')
          .doc(value.docs.first.id)
          .update({
        'rate': stars,
        'rated': true,
      });
    });

    product.rated = true;
  }
}
