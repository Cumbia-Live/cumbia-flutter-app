import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Product product;
String merchant;

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();

  ProductScreen(p, merchantId) {
    product = p;
    merchant = merchantId;
  }
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        //actionsForegroundColor: Palette.white,
        border: Border.symmetric(),
        middle: Text(
          product.productName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        backgroundColor: Palette.cumbiaSeller,
      ),
      bottomNavigationBar: Container(
          color: Palette.bgColor,
          height: 90.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CumbiaButton(
                title: shoppingCart.list
                        .where((element) => element.id == product.id)
                        .isNotEmpty
                    ? 'Agregado al carro'
                    : 'Agregar al carro',
                onPressed: () {
                  if (shoppingCart.list
                      .where((element) => element.id == product.id)
                      .isNotEmpty) {
                    showConfirmAlert(context, 'Ups!',
                        'El producto ya se encuentra en el carro', () {});
                  } else {
                    setState(() {
                      if(product.isFreeShipping != null && product.isFreeShipping){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enjoy Free Shipping")));
                      }
                      shoppingCart.list.add(product);
                    });
                  }
                }),
          )),
      body: CatapultaScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Palette.cumbiaLight,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Precio',
                            style: TextStyle(
                                color: Palette.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                product.emeralds.toString(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.white),
                              ),
                              Image(
                                  image: AssetImage('images/emerald.png'),
                                  height: 20.0),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                product.productName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Palette.black,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Descripción',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Palette.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Palette.cumbiaIconGrey,
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
                          'Color',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Palette.black,
                          ),
                        ),
                        Text(
                          product.color,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Palette.cumbiaIconGrey,
                          ),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Tamaño',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Palette.black,
                          ),
                        ),
                        Text(
                          product.size,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Palette.cumbiaIconGrey,
                          ),
                        )
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
                          'Talla',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Palette.black,
                          ),
                        ),
                        Text(
                          product.dimension,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Palette.cumbiaIconGrey,
                          ),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Material',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Palette.black,
                          ),
                        ),
                        Text(
                          product.material,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Palette.cumbiaIconGrey,
                          ),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
