import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/config/constants/emerald_constants.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/stats_list_title.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  bool isSearching = false;
  DateTime now;
  int month = 1;
  List<User> users = [];
  List<User> merchants = [];
  List<User> audience = [];
  List<User> colombians = [];
  List<User> internationalUsers = [];
  List<Product> products = [];
  List<Purchase> purchases = [];
  TabController _tabController;
  List<Product> soldProducts = [];
  int totalProducts = 0;
  int shopProducts = 0;
  int streamingProducts = 0;
  int arrivedProducts = 0;
  String totalSales;
  String nationalSales;
  String internationalSales;
  DateTime yearAgo;
  int yearAgoInt = 0;
  String anualSales;
  String sales1;
  String sales2;
  String sales3;
  String sales4;
  int receivedProducts = 0;
  int inProcessProducts = 0;
  int failedProducts = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    now = DateTime.now();
    month = now.month;
    yearAgo = DateTime(now.year - 1, now.month, now.day);
    yearAgoInt = yearAgo.millisecondsSinceEpoch;
    _getUsers();
    _getProducts();
    _getPurchases();
    Future.delayed(const Duration(seconds: 1), () {
      _soldProductsInt();
      _soldShopProductsInt();
      _soldStreamingProducts();
      _receivedProductsInt();
      _nationalPurchaseInt();
      _anualSalesPurchaseInt();
      _receivedPurchasesInt();
      _failedPurchasesInt();
      sales1 = _getDate(month);
      sales2 = _getDate(month - 1);
      sales3 = _getDate(month - 2);
      sales4 = _getDate(month - 3);
      _totalSales();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Palette.cumbiaDark,
          leading: CupertinoNavigationBarBackButton(
            color: Palette.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Estadísticas de desempeño',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Palette.white,
            ),
          ),
          bottom: TabBar(
            unselectedLabelColor: Palette.black.withOpacity(0.2),
            labelColor: Palette.white,
            tabs: [
              Tab(
                child: Text(
                  'General',
                ),
              ),
              Tab(
                child: Text(
                  'Esmeraldas',
                ),
              ),
            ],
            controller: _tabController,
            indicatorColor: Palette.cumbiaLight,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
      ),
      body: TabBarView(
        children: [
          general(),
          emeralds(),
        ],
        controller: _tabController,
      ),
    );
  }

  Widget general() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          StatsListTitle(
            title: 'Usuarios',
            label: 'Usuarios totales',
            number: users.length,
            label2: 'Usuarios espectadores',
            number2: audience.length,
            label3: 'Usuarios vendedores',
            number3: merchants.length,
            label4: 'Usuarios colombianos',
            number4: colombians.length,
            label5: 'Usuarios internacionales',
            number5: internationalUsers.length,
          ),
          StatsListTitle(
            title: 'Productos',
            label: 'Productos registrados',
            number: products.length,
            label2: 'Productos vendidos',
            number2: totalProducts,
            label3: 'Productos entregados',
            number3: arrivedProducts,
            label4: 'Productos comprados en streaming',
            number4: streamingProducts,
            label5: 'Productos comprados en tienda',
            number5: shopProducts,
          ),
          StatsListTitle(
            title: 'Ventas',
            label: 'Ventas totales',
            numberString: totalSales ?? "0 COP",
            label2: 'Ventas nacionales',
            number2String: nationalSales ?? "0 COP",
            label3: 'Ventas internacionales',
            number3String: internationalSales ?? "0 COP",
            label4: 'Ventas mensuales promedio\n(últimos 12 meses)',
            number4String: anualSales ?? "0 COP",
          ),
          StatsListTitle(
            title: 'Ventas totales por mes',
            isDate: true,
            label: _salesPerMonth(month),
            numberString: sales1 ?? "0 COP",
            label2: _salesPerMonth(month - 1),
            number2String: sales2 ?? "0 COP",
            label3: _salesPerMonth(month - 2),
            number3String: sales3 ?? "0 COP",
            label4: _salesPerMonth(month - 3),
            number4String: sales4 ?? "0 COP",
          ),
          StatsListTitle(
            title: 'Pedidos',
            label: 'Pedidos totales',
            number: purchases.length ?? 0,
            label2: 'Pedidos entregados',
            number2: receivedProducts,
            label3: 'Pedidos en proceso',
            number3: inProcessProducts,
            label4: 'Pedidos fallidos',
            number4: failedProducts,
          ),
        ],
      ),
    );
  }

  Widget emeralds() {
    return Column(
      children: [],
    );
  }

  /// ::::::::::::: FUNCTIONS ::::::::::::: ///

  String _salesPerMonth(int monthSales) {
    if (monthSales == 1) {
      return 'Enero';
    } else if (monthSales == 2) {
      return 'Febrero';
    } else if (monthSales == 3) {
      return 'Marzo';
    } else if (monthSales == 4) {
      return 'Abril';
    } else if (monthSales == 5) {
      return 'Mayo';
    } else if (monthSales == 6) {
      return 'Junio';
    } else if (monthSales == 7) {
      return 'Julio';
    } else if (monthSales == 8) {
      return 'Agosto';
    } else if (monthSales == 9 || monthSales == -3) {
      return 'Septiembre';
    } else if (monthSales == 10 || monthSales == -2) {
      return 'Octubre';
    } else if (monthSales == 11 || monthSales == -1) {
      return 'Noviembre';
    } else if (monthSales == 12 || monthSales == 0) {
      return 'Diciembre';
    }
  }

  DateTime _initDateTime(int month) {
    if (month == 1) {
      return DateTime(now.year, 1, 1);
    } else if (month == 2) {
      return DateTime(now.year, 2, 1);
    } else if (month == 3) {
      return DateTime(now.year, 3, 1);
    } else if (month == 4) {
      return DateTime(now.year, 4, 1);
    } else if (month == 5) {
      return DateTime(now.year, 5, 1);
    } else if (month == 6) {
      return DateTime(now.year, 6, 1);
    } else if (month == 7) {
      return DateTime(now.year, 7, 1);
    } else if (month == 8) {
      return DateTime(now.year, 8, 1);
    } else if (month == 9 || month == -3) {
      return DateTime(now.year, 9, 1);
    } else if (month == 10 || month == -2) {
      return DateTime(now.year, 10, 1);
    } else if (month == 11 || month == -1) {
      return DateTime(now.year, 11, 1);
    } else if (month == 12 || month == 0) {
      return DateTime(now.year, 12, 1);
    }
  }

  DateTime _endDateTime(int month) {
    if (month == 1) {
      return DateTime(now.year, 1, 31);
    } else if (month == 2) {
      return DateTime(now.year, 2, 28);
    } else if (month == 3) {
      return DateTime(now.year, 3, 31);
    } else if (month == 4) {
      return DateTime(now.year, 4, 30);
    } else if (month == 5) {
      return DateTime(now.year, 5, 31);
    } else if (month == 6) {
      return DateTime(now.year, 6, 30);
    } else if (month == 7) {
      return DateTime(now.year, 7, 31);
    } else if (month == 8) {
      return DateTime(now.year, 8, 31);
    } else if (month == 9 || month == -3) {
      return DateTime(now.year, 9, 30);
    } else if (month == 10 || month == -2) {
      return DateTime(now.year, 10, 31);
    } else if (month == 11 || month == -1) {
      return DateTime(now.year, 11, 30);
    } else if (month == 12 || month == 0) {
      return DateTime(now.year, 12, 31);
    }
  }

  void _soldProductsInt() {
    setState(() {
      totalProducts = 0;
      for (int i = 0; i < soldProducts.length; i++) {
        totalProducts += soldProducts[i].unitsCheckout;
        totalProducts += soldProducts[i].unitsCarrito;
      }
    });
  }

  void _soldStreamingProducts() {
    setState(() {
      streamingProducts = 0;
      for (int i = 0; i < soldProducts.length; i++) {
        streamingProducts += soldProducts[i].unitsCheckout;
      }
    });
  }

  void _soldShopProductsInt() {
    setState(() {
      shopProducts = 0;
      for (int i = 0; i < soldProducts.length; i++) {
        shopProducts += soldProducts[i].unitsCarrito;
      }
    });
  }

  void _receivedProductsInt() {
    setState(() {
      arrivedProducts = 0;
      for (int i = 0; i < soldProducts.length; i++) {
        if (soldProducts[i].isReceived && soldProducts[i].unitsCarrito != 0) {
          arrivedProducts++;
          arrivedProducts = arrivedProducts * soldProducts[i].unitsCarrito;
        } else if (soldProducts[i].isReceived &&
            soldProducts[i].unitsCheckout != 0) {
          arrivedProducts++;
          arrivedProducts = arrivedProducts * soldProducts[i].unitsCheckout;
        }
      }
    });
  }

  void _totalSales() {
    int sales = 0;
    setState(() {
      sales = 0;
      for (int i = 0; i < purchases.length; i++) {
        sales += purchases[i].emeralds;
      }

      totalSales = '${NumberFormat.simpleCurrency().format(
            (sales * trmEmeralds).toInt(),
          ).replaceAll('.00', '').replaceAll(',', '.')} COP';
    });
  }

  void _nationalPurchaseInt() {
    setState(() {
      int auxNational = 0;
      int auxInternational = 0;
      for (int i = 0; i < purchases.length; i++) {
        if (purchases[i].address.country == 'Colombia') {
          auxNational += purchases[i].emeralds;
        } else {
          auxInternational += purchases[i].emeralds;
        }
      }
      nationalSales = '${NumberFormat.simpleCurrency().format(
            (auxNational * trmEmeralds).toInt(),
          ).replaceAll('.00', '').replaceAll(',', '.')} COP';
      internationalSales = '${NumberFormat.simpleCurrency().format(
            (auxInternational * trmEmeralds).toInt(),
          ).replaceAll('.00', '').replaceAll(',', '.')} COP';
    });
  }

  void _anualSalesPurchaseInt() {
    setState(() {
      int auxSales = 0;

      for (int i = 0; i < purchases.length; i++) {
        if (purchases[i].datePurchase > yearAgoInt &&
            purchases[i].datePurchase < now.millisecondsSinceEpoch) {
          auxSales += purchases[i].emeralds;
        }
      }
      auxSales = (auxSales ~/ 12);
      anualSales = '${NumberFormat.simpleCurrency().format(
            (auxSales * trmEmeralds).toInt(),
          ).replaceAll('.00', '').replaceAll(',', '.')} COP';
    });
  }

  String _getDate(
    int month,
  ) {
    int aux = 0;

    setState(() {
      for (int i = 0; i < purchases.length; i++) {
        if (purchases[i].datePurchase >
                _initDateTime(month).millisecondsSinceEpoch &&
            purchases[i].datePurchase <
                _endDateTime(month).millisecondsSinceEpoch) {
          aux += purchases[i].emeralds;
        }
      }
    });
    return '${NumberFormat.simpleCurrency().format(
          (aux * trmEmeralds).toInt(),
        ).replaceAll('.00', '').replaceAll(',', '.')} COP';
  }

  void _receivedPurchasesInt() {
    setState(() {
      arrivedProducts = 0;
      for (int i = 0; i < purchases.length; i++) {
        if (purchases[i].received) {
          receivedProducts++;
        } else {
          inProcessProducts++;
        }
      }
    });
  }

  void _failedPurchasesInt() {
    setState(() {
      arrivedProducts = 0;
      for (int i = 0; i < purchases.length; i++) {
        if (purchases[i].failed ?? false) {
          failedProducts++;
        }
      }
    });
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  void _getUsers() {
    LogMessage.get("USERS");
    References.users.get().then((querySnapshot) {
      LogMessage.getSuccess("USERS");
      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((userDoc) {
            users.add(
              User(
                id: userDoc.id,
                emeralds: userDoc.data()["esmeraldas"],
                phoneNumber: PhoneNumberCumbia(
                  dialingCode:
                      userDoc.data()["phoneNumber"]["dialingCode"] ?? '+57',
                ),
                roles: UserRoles(
                  isMerchant: userDoc.data()["roles"]["isMerchant"],
                ),
              ),
            );
          });
        }
        merchants = users.where((element) => element.roles.isMerchant).toList();
        audience = users.where((element) => !element.roles.isMerchant).toList();
        internationalUsers = users
            .where((element) => element.phoneNumber.dialingCode != '+57')
            .toList();
        colombians = users
            .where((element) => element.phoneNumber.dialingCode == '+57')
            .toList();
      });
    }).catchError((e) {
      LogMessage.getError("USERS", e);
    });
  }

  void _getProducts() {
    LogMessage.get("PRODUCTS");
    References.products.get().then((querySnapshot) {
      LogMessage.getSuccess("PRODUCTS");
      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((productDoc) {
            products.add(Product(id: productDoc.id));
          });
        }
      });
    }).catchError((e) {
      LogMessage.getError("PRODUCTS", e);
    });
  }

  void _getPurchases() {
    LogMessage.get("PURCHASES");
    References.purchases
        .orderBy('datePurchase')
        .get()
        .then((querySnapshot) {
      LogMessage.getSuccess("PURCHASES");
      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((purchaseDoc) {
            purchases.add(
              Purchase(
                id: purchaseDoc.id,
                received: purchaseDoc.data()['received'],
                failed: purchaseDoc.data()['failed'],
                datePurchase: purchaseDoc.data()['datePurchase'],
                emeralds: purchaseDoc.data()['emeralds'],
                address: Address(
                  country: purchaseDoc.data()['address']['country'],
                ),
              ),
            );
            References.purchases
                .doc(purchaseDoc.id)
                .collection("products")
                .get()
                .then((querySnapshotProduct) {
              if (querySnapshotProduct.docs.isNotEmpty) {
                querySnapshotProduct.docs.forEach((productDoc) {
                  soldProducts.add(
                    Product(
                      id: productDoc.id,
                      unitsCheckout: productDoc.data()['unitsCheckout'],
                      unitsCarrito: productDoc.data()['unitsCarrito'],
                      isReceived:
                          productDoc.data()['productInfo']['isReceived'] ?? false,
                    ),
                  );
                });
              }
            });
          });
        }
      });
    }).catchError((e) {
      LogMessage.getError("PURCHASES", e);
    });
  }
}
