import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/model/emerald_package/emerald_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class RecargarScreen extends StatefulWidget {
  @override
  _RecargarScreenState createState() => _RecargarScreenState();
}

class _RecargarScreenState extends State<RecargarScreen>
    with SingleTickerProviderStateMixin {
  // Controlador para tab/menú dinámico
  TabController _tabController;

  /// Esto reemplaza el query de ProductDetails de las Stores
  // Lista de paquetes de esmeraldas in-app descargados de DB (Firestore)
  List<EmeraldPackage> packagesInApp = List();
  // Lista de paquetes de esmeraldas para web descargados de DB (Firestore)
  List<EmeraldPackage> packagesWeb = List();

  // IAP Plugin Instance
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  // Está disponible el IAP en el celular
  bool _available = true;

  // Compras pasadas del usuario
  List<PurchaseDetails> _purchases = List();

  // Actualiza purchases
  StreamSubscription _subscription;

  @override
  void initState() {
    _initializeIAP();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getPackagesFromDB();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  // Fetch products y purchases
  void _initializeIAP() async {
    // Confirmamos disponibilidad de IAP Plugin
    _available = await _iap.isAvailable();

    if (_available) {
      // Fetch paquetes disponibles y purchases pasadas del usuario
      List<Future> futures = [_getProducts(), _getPastPurchases()];
      await Future.wait(futures);

      // Escuchar nuevas compras
      _subscription = _iap.purchaseUpdatedStream.listen((data) => setState(() {
            print("NUEVA COMPRA");
            _purchases.addAll(data);
            // Aquí se validaría la compra según Business Logic
            // puedo tomar el ID de data para identificar el paquete comprado,
            // para luego act el numEsmeraldas del user en la base de datos
            _verifyPurchase();

            packagesInApp.forEach((package) {
              if (data.last.productID == package.id) {
                // El producto que compró fue package
                print("Antes tenía ${user.emeralds} esmeraldas");
                print("Acaba de comprar ${package.cantidad} esmeraldas");
                user.emeralds += package.cantidad;
                print("Por tanto, ahora tiene ${user.emeralds} esmeraldas");

                // Si lo de arriba funciona, entonces sólo es necesario
                // actualizar las esmeraldas del usuario en la base de datos
              }
            });

            ///
          }));
    }
  }

  /// Ya lo descargamos de FB, no hay que consumirlo de Stores
  // Consulta todos los productos disponibles para venta
  Future<void> _getProducts() async {
    List<String> idsArray = List();
    packagesInApp.forEach((package) {
      idsArray.add(package.id);
    });
    Set<String> ids = Set.from(idsArray);

    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    if (response.error != null) {
      print(
          "ERROR AL CONSULTAR PRODUCTOS DE STORES: ${response.error.message}");
    } else {
      setState(() {
        // Insertar detalles de producto en EmeraldPackage, si ids coinciden
        response.productDetails.forEach((productDetail) {
          packagesInApp.forEach((package) {
            if (productDetail.id == package.id) {
              package.productDetails = productDetail;
            }
          });
        });
      });
    }
  }

  /// Sí lo necesitamos, para que Apple entienda que es un
  /// consumible consumidoy que puede volver a comprarlo
  Future<void> _getPastPurchases() async {
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();
    for (PurchaseDetails purchase in response.pastPurchases) {
      if (Platform.isIOS) {
        _iap.completePurchase(purchase);
      }
    }

    if (response.error != null) {
      print("ERROR AL CONSULTAR COMPRAS PASADAS: ${response.error.message}");
    } else {
      setState(() {
        _purchases = response.pastPurchases;
      });
    }
  }

  // Lógica de negocio interna para setup un IAP consumible
  void _verifyPurchase() {}

  void _buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    _iap.buyConsumable(purchaseParam: purchaseParam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.darkModeBGColor,
      appBar: AppBar(
        backgroundColor: Palette.darkModeBGColor,
        leading: CupertinoNavigationBarBackButton(
          color: Palette.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Recargar esmeraldas",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        bottom: TabBar(
          unselectedLabelColor: Palette.white.withOpacity(0.4),
          labelColor: Palette.cumbiaLight,
          tabs: [
            Tab(
              child: Text(
                'Recargar en app',
              ),
            ),
            Tab(
              child: Text(
                'Recargar en web',
              ),
            ),
          ],
          controller: _tabController,
          indicatorColor: Palette.cumbiaLight,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _setupEnAppLayout(),
          _setupEnWebLayout(),
        ],
      ),
    );
  }

  /// TODO @JESÚS: Aquí editas el contenido de la recarga dentro del app
  Widget _setupEnAppLayout() {
    return packagesInApp.length == 0 || !_available
        ? Center(
            child: Text(
              "No hay paquetes disponibles\nen este momento.",
              style: Styles.btn,
              textAlign: TextAlign.center,
            ),
          )
        : Column(
            children: [
              /// Este Row son los dos contenedores de paquetes de arriba
              packagesInApp.length == 0
                  ? const SizedBox.shrink()
                  : Row(
                      children: [
                        // Este se muestra siempre que haya a menos 1 paquete por mostrar
                        Expanded(
                          child: Container(
                            height: 230,
                            margin: EdgeInsets.fromLTRB(16, 24, 8, 16),
                            color: Palette.darkModeAccentColor,
                          ),
                        ),
                        // Este se muestra solamente si hay 2 o más paquetes por mostrar
                        Expanded(
                          child: packagesInApp.length > 1
                              ? Container(
                                  height: 230,
                                  margin: EdgeInsets.fromLTRB(8, 24, 16, 16),
                                  color: Palette.darkModeAccentColor,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),

              /// Este Expanded tiene la lista de todos los paquetes para recargar
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${packagesInApp[position].id}, ${packagesInApp[position].productDetails.price}",
                              style: Styles.btn,
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Text(
                              "Recargar",
                              style: Styles.txtBtn(),
                            ),
                            onPressed: () {
                              print("RECARGAR: ${packagesInApp[position].id}");
                            },
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: packagesInApp.length,
                ),
              ),
            ],
          );
  }

  /// TODO @JESÚS: Aquí editas el contenido de la recarga en la página web
  Widget _setupEnWebLayout() {
    return packagesWeb.length == 0
        ? Center(
            child: Text(
              "No hay paquetes disponibles\nen este momento.",
              style: Styles.btn,
              textAlign: TextAlign.center,
            ),
          )
        : Column(
            children: [
              /// Este Row son los dos contenedores de paquetes de arriba
              packagesWeb.length == 0
                  ? const SizedBox.shrink()
                  : Row(
                      children: [
                        // Este se muestra siempre que haya a menos 1 paquete por mostrar
                        Expanded(
                          child: Container(
                            height: 230,
                            margin: EdgeInsets.fromLTRB(16, 24, 8, 16),
                            color: Palette.darkModeAccentColor,
                          ),
                        ),
                        // Este se muestra solamente si hay 2 o más paquetes por mostrar
                        Expanded(
                          child: packagesWeb.length > 1
                              ? Container(
                                  height: 230,
                                  margin: EdgeInsets.fromLTRB(8, 24, 16, 16),
                                  color: Palette.darkModeAccentColor,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),

              /// Este Expanded tiene la lista de todos los paquetes para recargar
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              packagesWeb[position].id,
                              style: Styles.btn,
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Text(
                              "Recargar",
                              style: Styles.txtBtn(),
                            ),
                            onPressed: () {
                              print("RECARGAR: ${packagesWeb[position].id}");
                            },
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: packagesWeb.length,
                ),
              ),
            ],
          );
  }

  _getPackagesFromDB() {
    FirebaseFirestore.instance
        .collection("emerald_packages")
        .get()
        .then((querySnapshot) {
      LogMessage.getSuccess("Paquetes de esmeraldas");
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((packDoc) {
          setState(() {
            if (getDispositivoType() == Dispositivo.ios &&
                (packDoc.data()["isIos"] ?? false)) {
              //IOS
              packagesInApp.add(EmeraldPackage(
                id: packDoc.id,
                cantidad: packDoc.data()["cantidad"],
                precioCOP: packDoc.data()["precioCOP"],
                productDetails: ProductDetails(
                  id: null,
                  description: null,
                  price: null,
                  title: null,
                ),
              ));
            } else if (getDispositivoType() == Dispositivo.android &&
                (packDoc.data()["isAndroid"] ?? false)) {
              //ANDROID
              packagesInApp.add(EmeraldPackage(
                id: packDoc.id,
                cantidad: packDoc.data()["cantidad"],
                precioCOP: packDoc.data()["precioCOP"],
                productDetails: ProductDetails(
                  id: null,
                  description: null,
                  price: null,
                  title: null,
                ),
              ));
            }
            if (packDoc.data()["isWeb"] ?? false) {
              //WEB
              packagesWeb.add(EmeraldPackage(
                id: packDoc.id,
                cantidad: packDoc.data()["cantidad"],
                precioCOP: packDoc.data()["precioCOP"],
                productDetails: ProductDetails(
                  id: null,
                  description: null,
                  price: null,
                  title: null,
                ),
              ));
            }
          });
        });
        print("${packagesInApp.length} PAQUETES IN-APP DESCARGADOS");
        print("${packagesWeb.length} PAQUETES WEB DESCARGADOS");
      } else {
        print("0 PAQUETES DESCARGADOS");
      }
    }).catchError((e) {
      LogMessage.getError("Paquetes de esmeraldas", e);
    });
  }
}
