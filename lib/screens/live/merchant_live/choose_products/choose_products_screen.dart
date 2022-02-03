import 'dart:math';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/live/merchant_live/live_stream/streamer_onlive_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../screens.dart';

// ignore: must_be_immutable
class ChooseProductsScreen extends StatefulWidget {
  ChooseProductsScreen({Key key, this.live}) : super(key: key);
  Live live;

  @override
  _ChooseProductsScreenState createState() => _ChooseProductsScreenState();
}

const _gap18 = SizedBox(height: 18.0);

class _ChooseProductsScreenState extends State<ChooseProductsScreen> {
  List<Product> products = [];
  List<Product> auxProducts = [];
  String thumbnailURL;
  bool isLoading = false;
  String liveId;
  Live liveAux;

  @override
  void initState() {
    setState(() {
      liveAux = widget.live;
    });
    getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Palette.bgColor,
        // actionsForegroundColor: Palette.black,
        border: Border.all(color: Palette.transparent),
        middle: Text(
          "Selección de productos",
          style: Styles.navTitleLbl,
        ),
      ),
      body: CatapultaScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _gap18,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text(
                        '''
Selecciona los productos que serán mostrados durante el livestream.''',
                      ),
                    ),
                    Text(
                      '${auxProducts.length}/15',
                      style: TextStyle(
                        color: Palette.cumbiaLight,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                _gap18,
                _gap18,
                products.isEmpty
                    ? CatapultaSpace()
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, position) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              width: MediaQuery.of(context).size.width,
                              color: products[position].isSelected
                                  ? Palette.cumbiaDark
                                  : Palette.grey.withOpacity(0.25),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Palette.white,
                                      width: 60,
                                      height: 60,
                                      child: Image.network(
                                        products[position].imageUrl ??
                                            'https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2FliveImage.png?alt=media&token=d9c84a2f-92e8-4f4f-9f79-17b82c992016',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            products[position].productName,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: products[position]
                                                          .avaliableUnits ==
                                                      0
                                                  ? Palette.cumbiaGrey
                                                  : products[position]
                                                          .isSelected
                                                      ? Palette.white
                                                      : Palette.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          variantLabel(position) == ''
                                              ? const SizedBox.shrink()
                                              : Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: Text(
                                                    // ignore: lines_longer_than_80_chars
                                                    variantLabel(position),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: products[position]
                                                                  .avaliableUnits ==
                                                              0
                                                          ? Palette.cumbiaGrey
                                                          : products[position]
                                                                  .isSelected
                                                              ? Palette.grey
                                                              : Palette.black
                                                                  .withOpacity(
                                                                      0.6),
                                                    ),
                                                  ),
                                                ),
                                          Text(
                                            // ignore: lines_longer_than_80_chars
                                            '${products[position].avaliableUnits} ${products[position].avaliableUnits == 1 ? 'unidad' : 'unidades'}',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: products[position]
                                                          .avaliableUnits ==
                                                      0
                                                  ? Palette.red
                                                  : products[position]
                                                          .isSelected
                                                      ? Palette.grey
                                                      : Palette.black
                                                          .withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CatapultaSpace(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        products[position].avaliableUnits == 0
                                            ? CupertinoButton(
                                                padding: EdgeInsets.zero,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.chevron_right,
                                                      color: Palette.black
                                                          .withOpacity(
                                                        0.6,
                                                      ),
                                                      size: 30,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      'Actualizar\nexistencias',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Palette.black
                                                            .withOpacity(0.6),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () async {
                                                  final result =
                                                      await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddUnitsScreen(
                                                        product:
                                                            products[position],
                                                      ),
                                                    ),
                                                  );
                                                  if (result != null) {
                                                    setState(() {
                                                      products
                                                          .removeAt(position);
                                                      auxProducts.remove(
                                                          products[position]);
                                                      products.add(
                                                          result as Product);
                                                      auxProducts.add(
                                                          result as Product);
                                                    });
                                                  }
                                                },
                                              )
                                            : CupertinoButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  print(products[position]
                                                      .isSelected);
                                                  addLive(position);
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      setIcon(position),
                                                      height: 17,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      'Agregar\nal live',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: products[
                                                                    position]
                                                                .isSelected
                                                            ? Palette.white
                                                            : Palette
                                                                .cumbiaLight,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: products.length ?? 0,
                        ),
                      ),
                CatapultaSpace(),
                _gap18,
                CumbiaButton(
                  onPressed: () {
                    _uploadProductImage();
                  },
                  title: '¡Go live!',
                  isLoading: isLoading,
                  canPush: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  void getProducts() {
    LogMessage.get('PRODUCTS');
    References.products
        .where('uid', isEqualTo: user.id)
        .get()
        .then((productDoc) {
      LogMessage.getSuccess('PRODUCTS');
      if (productDoc.docs.isNotEmpty) {
        productDoc.docs.forEach((product) {
          setState(() {
            products.add(
              Product(
                id: product.id,
                idProduct: product.data()['idProduct'],
                uid: product.data()['uid'],
                mainProductId: product.data()['productInfo']['mainProductId'],
                imageUrl: product.data()['productInfo']['imageUrl'],
                productName: product.data()['productInfo']['productName'],
                description: product.data()['productInfo']['description'],
                reference: product.data()['productInfo']['reference'],
                isVariant: product.data()['productInfo']['isVariant'],
                height: product.data()['especifications']['height'],
                large: product.data()['especifications']['large'],
                width: product.data()['especifications']['width'],
                weight: product.data()['especifications']['weight'],
                color: product.data()['variantInfo']['color'],
                dimension: product.data()['variantInfo']['dimension'],
                size: product.data()['variantInfo']['size'],
                material: product.data()['variantInfo']['material'],
                style: product.data()['variantInfo']['style'],
                avaliableUnits: product.data()['avaliableUnits'],
                price: product.data()['price'],
                isSelected: product.data()['isSelected'],
                comission: product.data()['comission'],
                emeralds: product.data()['emeralds'],
                unitsCarrito: 1,
                unitsCheckout: 1,
              ),
            );
          });
        });
      }
    }).catchError((e) {
      LogMessage.getError('PRODUCTS', e);
    });
  }

  void _uploadProductImage() async {
    setState(() {
      isLoading = true;
    });

    LogMessage.post("IMAGEN");
    Random random = Random();
    /*  UploadTask snapshot = await FirebaseStorage.instance
        .ref()
        .child("thumbnails/${user.id}/${random.nextInt(1000000000)}")
        .putFile(liveAux.auxImage);
        .onComplete;*/

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("thumbnails/${user.id}/${random.nextInt(1000000000)}");
    UploadTask uploadTask = ref.putFile(liveAux.auxImage);
    uploadTask.then((res) async {
      LogMessage.postSuccess("IMAGEN");
      thumbnailURL = await res.ref.getDownloadURL();
      print(res.ref.getDownloadURL());
      _joinLive();
    }).catchError((onError) {
      print(onError);
      LogMessage.postError("RESPONSE", onError);
      setState(() {
        isLoading = false;
      });
      showBasicAlert(
        context,
        "La foto no se subió",
        "Por favor, intenta de nuevo más tarde. Si el error persiste, comunícate con soporte.",
      );
    });

   /* if (snapshot.error == null) {
      LogMessage.postSuccess("IMAGEN");
      thumbnailURL = await snapshot.ref.getDownloadURL();

      _joinLive();
    } else {
      LogMessage.postError("RESPONSE", snapshot.error);
      setState(() {
        isLoading = false;
      });
      showBasicAlert(
        context,
        "La foto no se subió",
        "Por favor, intenta de nuevo más tarde. Si el error persiste, comunícate con soporte.",
      );
    }*/
  }

  Future<void> _putProducts() async {
    Map<String, dynamic> productDoc(int position) {
      // Creo doc a subir
      var productDoc = <String, dynamic>{
        'idProduct': auxProducts[position].idProduct,
        'uid': user.id,
        'productInfo': {
          'mainProductId': auxProducts[position].mainProductId ?? '',
          'imageUrl': auxProducts[position].imageUrl ?? '',
          'productName': auxProducts[position].productName,
          'description': auxProducts[position].description,
          'reference': auxProducts[position].reference,
          'isVariant': auxProducts[position].isVariant
        },
        'especifications': {
          'height': auxProducts[position].height,
          'large': auxProducts[position].large,
          'width': auxProducts[position].width,
          'weight': auxProducts[position].weight,
        },
        'variantInfo': {
          'color': auxProducts[position].color,
          'dimension': auxProducts[position].dimension,
          'size': auxProducts[position].size,
          'material': auxProducts[position].material,
          'style': auxProducts[position].style,
        },
        'avaliableUnits': auxProducts[position].avaliableUnits,
        'price': auxProducts[position].price,
        'comission': auxProducts[position].comission,
        'emeralds': auxProducts[position].emeralds,
        'isSelected': false,
        'unitsCarrito': 1,
        'unitsCheckout': 1,
      };
      return productDoc;
    }

    for (var i = 0; i < auxProducts.length; i++) {
      // Subo doc

      LogMessage.post('PRODUCTS');
      await References.lives
          .doc(liveId)
          .collection('productsLive')
          .add(productDoc(i))
          .then((r) {
        LogMessage.postSuccess('PRODUCTS');
      }).catchError((e) {
        LogMessage.postError('PRODUCTS', e);
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

  void _joinLive() {
    Map<String, dynamic> liveDoc = {
      "broadcasterId": user.id,
      "onLive": true,
      "category": {"name": liveAux.categoryLive.name},
      "title": liveAux.labelLive,
      "thumbnailURL": thumbnailURL,
      "dates": {
        "startDate": DateTime.now().millisecondsSinceEpoch,
        "endDate": null,
      }
    };
    Map<String, dynamic> messageDoc = {
      "userId": user.id,
      "message": "${user.username} está en vivo",
      "created": DateTime.now().millisecondsSinceEpoch,
      "username": user.username,
      "profilePictureURL": user.profilePictureURL,
    };
    LogMessage.post("LIVE");
    References.lives.add(liveDoc).then((value) async {
      setState(() {
        liveId = value.id;
      });
      References.lives
          .doc(value.id)
          .collection("messages")
          .add(messageDoc);
      LogMessage.postSuccess("LIVE");

      setState(() {
        isLoading = false;
      });
      categories.forEach((category) {
        category.isSelected = false;
      });
      await _putProducts();

      onJoin();
    }).catchError((e) {
      LogMessage.postError("LIVE", e);
      setState(() {
        isLoading = false;
      });
      showBasicAlert(
        context,
        "No podemos iniciar el Livestream",
        "Por favor, intenta de nuevo más tarde. Si el error persiste, comunícate con soporte.",
      );
    });
  }

  /// ::::::::::::: FUNCTIONA ::::::::::::: ///

  Future<void> onJoin() async {
    // await for camera and mic permissions before pushing video page
    await _handleCamera(Permission.camera);
    await _handleMic(Permission.microphone);
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StreamerPage(
          channelName: user.email,
          role: ClientRole.Broadcaster,
          liveId: liveId,
        ),
      ),
    );
  }

  Future<void> _handleCamera(Permission permission) async {
    final PermissionStatus status = await permission.request();
  }

  Future<void> _handleMic(Permission permission) async {
    final status = await permission.request();
  }

  String variantLabel(int position) {
    // ignore: lines_longer_than_80_chars
    return '${products[position].color.isNotEmpty ? '${products[position].color}/' : ''}${products[position].dimension.isNotEmpty ? '${products[position].dimension}/' : ''}${products[position].size.isNotEmpty ? '${products[position].size}/' : ''}${products[position].material.isNotEmpty ? '${products[position].material}/' : ''}${products[position].style.isNotEmpty ? '${products[position].style}/' : ''}';
  }

  String setIcon(int position) {
    if (!products[position].isSelected) {
      return 'images/plus.png';
    } else if (products[position].isSelected) {
      return 'images/check_live.png';
    }
    return 'images/plus.png';
  }

  bool addLive(int position) {
    setState(() {
      if (products[position].isSelected) {
        auxProducts.remove(products[position]);
        products[position].isSelected = false;
        print('cantidad ${auxProducts.length}');
        return false;
      } else if (auxProducts.length < 15) {
        auxProducts.add(products[position]);
        products[position].isSelected = true;
        print('cantidad ${auxProducts.length}');
      } else {
        showBasicAlert(context, 'No puedes agregar más productos', '');
      }
    });
    return true;
  }
}
