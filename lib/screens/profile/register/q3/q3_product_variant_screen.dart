import 'dart:math';

import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../screens.dart';

// ignore: must_be_immutable
class Q3ProductVariantScreen extends StatefulWidget {
  Q3ProductVariantScreen({Key key, this.product}) : super(key: key);
  final Product product;

  @override
  _Q3ProductVariantScreenState createState() => _Q3ProductVariantScreenState();
}

const _gap12 = SizedBox(height: 12.0);
const _gap20 = SizedBox(height: 20.0);

class _Q3ProductVariantScreenState extends State<Q3ProductVariantScreen> {
  final notification = LoadUsers();
  List<Product> variants = [];
  Product product = Product();
  bool isLoading = false;
  String documentId = '';

  @override
  void initState() {
    setState(() {
      product = widget.product;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SafeArea(
          child: CatapultaScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PercentIndicator(
                  percent: 1,
                  step: '3 de 3',
                  text: 'Registro de producto',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3. Variantes del producto',
                        style: Styles.titleRegister,
                        textAlign: TextAlign.start,
                      ),
                      _gap20,
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        // ignore: lines_longer_than_80_chars
                        'Aplica para productos con variantes de color, tamaño, talla, material o acabado.',
                        style: TextStyle(
                          color: Palette.cumbiaGrey,
                          fontSize: 12,
                        ),
                      ),
                      _gap12,
                      Container(
                        height: 101 * variants.length.toDouble(),
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, position) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              width: MediaQuery.of(context).size.width,
                              color: Palette.grey.withOpacity(0.25),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Container(
                                      color: Palette.white,
                                      width: 60,
                                      height: 60,
                                      child: Image.file(
                                        variants[position].auxImage,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            variantLabel(position),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Palette.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Text(
                                              // ignore: lines_longer_than_80_chars
                                              '${NumberFormat.simpleCurrency().format(variants[position].price)} COP'
                                                  .replaceAll('.00', '')
                                                  .replaceAll(',', '.'),
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            // ignore: lines_longer_than_80_chars
                                            '${variants[position].avaliableUnits} ${variants[position].avaliableUnits == 1 ? 'unidad' : 'unidades'}',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CatapultaSpace(),
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                EditVariantScreen(
                                              product: widget.product,
                                            ),
                                          ),
                                        );
                                        if (result != null) {
                                          setState(() {
                                            variants.removeAt(position);
                                            variants.add(result as Product);
                                          });
                                        }
                                        verificar();
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Palette.black.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: variants.length,
                        ),
                      ),
                      DottedBorder(
                        color: Palette.cumbiaGrey,
                        strokeWidth: 1,
                        child: CupertinoButton(
                          onPressed: () async {
                            final Product result = await Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => VariantScreen(
                                  product: widget.product,
                                ),
                              ),
                            );

                            if (result != null) {
                              Product aux = Product();
                              aux = clonar(result);
                              print("Variante nueva: ${aux.color}");
                              verificar();
                              variants.add(aux);
                              setState(() {});
                            }
                            verificar();
                          },
                          child: Container(
                            height: 46,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                'Toca para agregar una variante',
                                style: TextStyle(
                                  color: Palette.cumbiaGrey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CatapultaSpace(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CumbiaButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await putproduct();
                      await putVariants();

                      setState(() {
                        isLoading = false;
                      });
                      notification.sendNotificationProductIsCreatedTopic();
                      verificar();
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => SuccessProductScreen(),
                        ),
                      );
                    },
                    title: 'Registrar producto',
                    isLoading: isLoading,
                    canPush: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Product clonar(Product p) {
    Product pClonado = Product();
    pClonado.auxImage = p.auxImage;
    pClonado.avaliableUnits = p.avaliableUnits;
    pClonado.color = p.color;
    pClonado.comission = p.comission;
    pClonado.description = p.description;
    pClonado.dimension = p.dimension;
    pClonado.emeralds = p.emeralds;
    pClonado.height = p.height;
    pClonado.id = p.id;
    pClonado.idProduct = p.idProduct;
    pClonado.imageUrl = p.imageUrl;
    pClonado.isCheckout = p.isCheckout;
    pClonado.isFreeShipping = p.isFreeShipping;
    pClonado.isReceived = p.isReceived;
    pClonado.isSelected = p.isSelected;
    pClonado.isShipmentRequired = p.isShipmentRequired;
    pClonado.isVariant = p.isVariant;
    pClonado.large = p.large;
    pClonado.mainProductId = p.mainProductId;
    pClonado.material = p.material;
    pClonado.mercahnt = p.mercahnt;
    pClonado.price = p.price;
    pClonado.productName = p.productName;
    pClonado.rate = p.rate;
    pClonado.rated = p.rated;
    pClonado.reference = p.reference;
    pClonado.reviews = p.reviews;
    pClonado.size = p.size;
    pClonado.style = p.style;
    pClonado.uid = p.uid;
    pClonado.unitsCarrito = p.unitsCarrito;
    pClonado.unitsCheckout = p.unitsCheckout;
    pClonado.weight = p.weight;
    pClonado.width = p.width;
    return pClonado;
  }

  void verificar() {
    for (int i = 0; i < variants.length; i++) {
      print("Producto $i : ${variants[i].productName}");
      print("Producto $i : ${variants[i].color}");
      print("Producto $i : ${variants[i].material}");
    }
  }

  String variantLabel(int position) {
    // ignore: lines_longer_than_80_chars
    return '${variants[position].color.isNotEmpty ? '${variants[position].color}/' : ''}${variants[position].dimension.isNotEmpty ? '${variants[position].dimension}/' : ''}${variants[position].size.isNotEmpty ? '${variants[position].size}/' : ''}${variants[position].material.isNotEmpty ? '${variants[position].material}/' : ''}${variants[position].style.isNotEmpty ? '${variants[position].style}/' : ''}';
  }

  Future<void> putproduct() async {
    await _uploadProductImage();
    var mainProduct = <String, dynamic>{
      'idProduct': product.idProduct,
      'uid': user.id,
      'productInfo': {
        'imageUrl': product.imageUrl ?? '',
        'productName': product.productName,
        'description': product.description,
        'reference': product.reference,
        'isVariant': false
      },
      'especifications': {
        'height': product.height,
        'large': product.large,
        'width': product.width,
        'weight': product.weight,
      },
      'variantInfo': {
        'color': '',
        'dimension': '',
        'size': '',
        'material': '',
        'style': '',
      },
      'avaliableUnits': product.avaliableUnits,
      'price': product.price,
      'comission': product.comission,
      'emeralds': product.emeralds,
      'isSelected': false,
      'unitsCarrito': 0,
      'unitsCheckout': 0,
      'isFreeShipping': product.isFreeShipping,
      'isShipmentRequired': product.isShipmentRequired,
    };
    // Subo doc
    LogMessage.post('MAIN PRODUCT');
    await References.products.add(mainProduct).then((r) {
      setState(() {
        Map<String, dynamic> productMap = {
          'idProduct': r.id,
        };
        print("⏳ ACTUALIZARÉ PRODUCT");
        References.products.doc(r.id).update(productMap).then((r) async {
          print("✔ PRODUCT ACTUALIZADO");
          setState(() {
            isLoading = false;
          });
        }).catchError((e) {
          setState(() {
            isLoading = false;
          });
          showBasicAlert(
            context,
            "Hubo un error.",
            "Por favor, intenta más tarde.",
          );
          print("💩️ ERROR AL ACTUALIZAR PRODUCT: $e");
        });

        documentId = r.id;
      });
      LogMessage.postSuccess('MAIN PRODUCT');
    }).catchError((e) {
      LogMessage.postError('MAIN PRODUCT', e);
      setState(() {
        //isLoading = false;
      });
      showBasicAlert(
        context,
        'Hubo un error',
        'No pudimos enviar el feedback, por favor intenta más tarde.',
      );
    });
  }

  Future<void> putVariants() async {
    Map<String, dynamic> productDoc(int position) {
      // Creo doc a subir
      var productDoc = <String, dynamic>{
        'uid': user.id,
        'idProduct': variants[position].idProduct,
        'productInfo': {
          'mainProductId': documentId,
          'imageUrl': variants[position].imageUrl ?? '',
          'productName': variants[position].productName,
          'description': variants[position].description,
          'reference': variants[position].reference,
          'isVariant': true
        },
        'especifications': {
          'height': variants[position].height,
          'large': variants[position].large,
          'width': variants[position].width,
          'weight': variants[position].weight,
        },
        'variantInfo': {
          'color': variants[position].color,
          'dimension': variants[position].dimension,
          'size': variants[position].size,
          'material': variants[position].material,
          'style': variants[position].style,
        },
        'avaliableUnits': variants[position].avaliableUnits,
        'price': variants[position].price,
        'comission': variants[position].comission,
        'emeralds': variants[position].emeralds,
        'isSelected': false,
        'unitsCarrito': 0,
        'unitsCheckout': 0,
      };
      return productDoc;
    }

    for (var i = 0; i < variants.length; i++) {
      // Subo doc
      await _uploadVariantsImage(i);
      LogMessage.post('VARIANT');
      await References.products.add(productDoc(i)).then((r) {
        LogMessage.postSuccess('VARIANT');
        Map<String, dynamic> productMap = {
          'idProduct': r.id,
        };
        print("⏳ ACTUALIZARÉ PRODUCT");
        References.products.doc(r.id).update(productMap).then((r) async {
          print("✔ PRODUCT ACTUALIZADO");
          setState(() {
            isLoading = false;
          });
        }).catchError((e) {
          setState(() {
            isLoading = false;
          });
          showBasicAlert(
            context,
            "Hubo un error.",
            "Por favor, intenta más tarde.",
          );
          print("💩️ ERROR AL ACTUALIZAR PRODUCT: $e");
        });
      }).catchError((e) {
        LogMessage.postError('VARIANT', e);
        setState(() {
          //isLoading = false;
        });
        showBasicAlert(
          context,
          'Hubo un error',
          'No pudimos enviar el feedback, por favor intenta más tarde.',
        );
      });
    }
  }

  Future<void> _uploadProductImage() async {
    setState(() {
      //isLoading = true;
    });

    LogMessage.post("IMAGEN");
    var random = Random();
    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('thumbnails/${random.nextInt(1000000000)}')
        .putFile(product.auxImage)
        .then((snapshot) => () async {
              if (snapshot.state == TaskState.success) {
                LogMessage.postSuccess("IMAGEN");
                var prueba = await snapshot.ref.getDownloadURL();
                print(prueba.toString());
                setState(() {
                  product.imageUrl = prueba.toString();
                });
              } else {
                LogMessage.postError("RESPONSE", snapshot.state);
                setState(() {
                  //isLoading = false;
                });
                showBasicAlert(
                  context,
                  "La foto no se subió",
                  "Por favor, intenta de nuevo más tarde.",
                );
              }
            });
  }

  Future<void> _uploadVariantsImage(int position) async {
    setState(() {
      //isLoading = true;
    });

    LogMessage.post("IMAGEN");
    var random = Random();
    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('thumbnails/${random.nextInt(1000000000)}')
        .putFile(variants[position].auxImage)
        .then((snapshot) => () async {
              if (snapshot.state == TaskState.success) {
                LogMessage.postSuccess("IMAGEN");

                var prueba = await snapshot.ref.getDownloadURL();
                setState(() {
                  variants[position].imageUrl = prueba.toString();
                });
              } else {
                LogMessage.postError("RESPONSE", snapshot.state);
                setState(() {
                  //isLoading = false;
                });
                showBasicAlert(
                  context,
                  "La foto no se subió",
                  "Por favor, intenta de nuevo más tarde.",
                );
              }
            });
  }
}
