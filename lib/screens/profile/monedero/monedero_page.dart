import 'package:cumbialive/config/constants/emerald_constants.dart';
import 'package:cumbialive/functions/functions.dart';

import '../../screens.dart';
import 'ventas/ventas.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/model/models.dart';
import 'puntos_cumbia/puntos_cumbia_screen.dart';

var movimientos = <Movement>[];

var ventas = <Purchase>[];

class MonederoPage extends StatefulWidget {
  MonederoPage(
      List<Purchase> list, List<Purchase> v, List<Withdrawal> retiros) {
    ventas = v;
    movimientos.clear();
    for (Purchase p in list) {
      for (Product n in p.products) {
        for (var i = 0; i < n.unitsCheckout + n.unitsCarrito; i++) {
          movimientos.add(Movement(
              n.productName,
              n.description,
              DateTime.fromMillisecondsSinceEpoch(p.datePurchase).toUtc(),
              true,
              n.price * -1,
              'Compra de producto'));
        }
      }
    }
    for (Purchase p in v) {
      for (Product n in p.products) {
        for (var i = 0; i < n.unitsCarrito + n.unitsCheckout; i++) {
          movimientos.add(Movement(
              n.productName,
              n.description,
              DateTime.fromMillisecondsSinceEpoch(p.datePurchase).toUtc(),
              true,
              n.price,
              'Venta de producto'));
        }
      }
    }
    for (Withdrawal p in retiros) {
      movimientos.add(Movement(
          'Retiro de dinero',
          '',
          DateTime.fromMillisecondsSinceEpoch(p.date).toUtc(),
          true,
          p.emeralds * -1,
          'Retiro desde app'));
    }
  }

  @override
  _MonederoPageState createState() => _MonederoPageState();
}

enum MonederoScreen {
  ventas,
  monedero,
  movimientos,
}

class _MonederoPageState extends State<MonederoPage> {
  MonederoScreen monederoScreen = MonederoScreen.monedero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.darkModeBGColor,
      appBar: CupertinoNavigationBar(
        backgroundColor: Palette.darkModeBGColor,
        //actionsForegroundColor: Palette.white,
        middle: Text(
          monederoScreen == MonederoScreen.ventas
              ? "Ventas"
              : monederoScreen == MonederoScreen.monedero
                  ? "Monedero"
                  : "Movimientos",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        border: Border.symmetric(),
      ),
      body: CatapultaScrollView(
        child: monederoScreen == MonederoScreen.ventas
            ? _setupVentasLayout()
            : monederoScreen == MonederoScreen.monedero
                ? _setupMonederoLayout()
                : setupMovimientosLayout(),
      ),
      bottomNavigationBar: CustomTabBar(
        tabItems: [
          user.roles.isMerchant
              ? CustomTabBarItem(
                  isActive: monederoScreen == MonederoScreen.ventas,
                  title: "Ventas",
                  symbol: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Icon(
                      Icons.loyalty,
                      color: monederoScreen == MonederoScreen.ventas
                          ? null
                          : Palette.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      monederoScreen = MonederoScreen.ventas;
                    });
                  },
                )
              : null,
          CustomTabBarItem(
            isActive: monederoScreen == MonederoScreen.monedero,
            title: "Monedero",
            symbol: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Image(
                image: AssetImage('images/emerald.png'),
                height: 24.0,
              ),
            ),
            onPressed: () {
              setState(() {
                monederoScreen = MonederoScreen.monedero;
              });
            },
          ),
          CustomTabBarItem(
            isActive: monederoScreen == MonederoScreen.movimientos,
            title: "Movimientos",
            symbol: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Icon(
                Icons.swap_vert,
                color: monederoScreen == MonederoScreen.movimientos
                    ? null
                    : Palette.white,
              ),
            ),
            onPressed: () {
              setState(() {
                monederoScreen = MonederoScreen.movimientos;
              });
            },
          ),
        ],
      ),
    );
  }

  /// TODO: @JESÚS, edita este para las ventas
  Widget _setupVentasLayout() {
    return ventas.isNotEmpty
        ? VentasPage(ventas)
        : Container(
            height: 10,
            child: Center(
              child: Text(
                "Aún no hay ventas registradas",
                style: TextStyle(color: Palette.white),
              ),
            ),
          );
  }

  Widget _setupMonederoLayout() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Palette.darkModeAccentColor,
              border: Border.all(color: Palette.cumbiaLight),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Saldo dispoible",
                        style: TextStyle(color: Palette.cumbiaGrey),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Column(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${user.emeralds != null ? user.emeralds : 0}",
                                style: TextStyle(
                                  color: Palette.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'COP ',
                                  style: TextStyle(
                                      color: Palette.cumbiaLight,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image(
                                  image: AssetImage('images/emerald.png'),
                                  height: 30.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CatapultaDivider(height: 1),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text('Equivalente a',
                //           style: TextStyle(color: Palette.cumbiaGrey)),
                //       Text(
                //         formattedMoneyValue(
                //             ((user.emeralds != null ? user.emeralds : 0) *
                //                     trmEmeralds)
                //                 .round()),
                //         style: TextStyle(
                //           color: Palette.cumbiaGrey,
                //         ),
                //       )
                //     ],
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(height: 20.0),

          /// PUNTOS CUMBIA

          !user.roles.isMerchant
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => PuntosCumbiaScreen(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Palette.darkModeAccentColor,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 90.0,
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, left: 10.0),
                              child: Text('Quedan 17 días',
                                  style: TextStyle(
                                      color: Palette.cumbiaLight,
                                      fontSize: 10.0)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${user.puntosCumbia ?? 0}',
                                  style: TextStyle(
                                    color: Palette.cumbiaLight,
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Puntos Cumbia',
                                style: TextStyle(
                                  color: Palette.cumbiaLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Palette.cumbiaGrey),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
          !user.roles.isMerchant
              ? const SizedBox.shrink()
              : SizedBox(height: 20.0),

          /// RECARGA Y RETIRO
          /// COMENTADO HASTA QUE SE COMPLETE LA RECARGA Y RETIRO DE ESMERALDAS

          Row(
            children: [
              // Expanded(
              //   child: CupertinoButton(
              //     padding: EdgeInsets.zero,
              //     onPressed: () {
              //       showBasicAlert(
              //         context,
              //         "Sección en construcción",
              //         "¡Muy pronto podrás recargar todas tus esmeraldas!",
              //       );

              //       Navigator.push(
              //         context,
              //         CupertinoPageRoute(
              //           builder: (context) => RecargarScreen(),
              //         ),
              //       );
              //     },
              //     child: recargaItem(
              //       Icons.monetization_on,
              //       Icons.phone_android,
              //       'Recargar\nEsmeraldas',
              //       true,
              //     ),
              //   ),
              // ),
              // !user.roles.isMerchant
              //     ? const SizedBox.shrink()
              //     : SizedBox(width: 20.0),
              !user.roles.isMerchant
                  ? const SizedBox.shrink()
                  : Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Q1PersonalDataScreen(),
                            ),
                          );
                        },
                        child: recargaItem(Icons.phone_android,
                            Icons.monetization_on, 'Solicitar\nRetiro', false),
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }

  Widget setupMovimientosLayout() {
    return Column(
      children: getMovimientos(movimientos),
    );
  }

  List<Widget> getMovimientos(List<Movement> list) {
    var actualDate = DateTime(0);
    var movs = <Widget>[
      SizedBox(width: double.infinity, height: 20.0),
    ];
    list.sort((a, b) => b.fecha.compareTo(a.fecha));

    for (var l in list) {
      if (actualDate != l.fecha) {
        movs.add(SizedBox(height: 10.0));
        movs.add(Text(
          formatDate(l.fecha, ['dd', ' ', 'MM', ' ', 'yyyy']),
          style: TextStyle(fontSize: 10.0, color: Palette.cumbiaGrey),
        ));
        actualDate = l.fecha;
      }
      movs.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      l.nombre,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Palette.white,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: l.status ? l.tipo : 'En proceso',
                        style: l.status
                            ? TextStyle(
                                color: Palette.cumbiaLight, fontSize: 12.0)
                            : TextStyle(color: Palette.red, fontSize: 12.0),
                        children: [
                          TextSpan(text: '\n'),
                          TextSpan(
                            text: l.descripcion,
                            style: TextStyle(color: Palette.cumbiaGrey),
                          )
                        ]),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      l.valor > 0
                          ? '+${l.valor.toString()}'
                          : l.valor.toString(),
                      style: TextStyle(
                          color: l.status
                              ? l.valor < 0
                                  ? Palette.red
                                  : Palette.cumbiaLight
                              : Palette.cumbiaIconGrey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5.0),
                    Image(
                      image: AssetImage('images/emerald.png'),
                      height: 24.0,
                    )
                  ],
                ),
              )
            ],
          )));
    }

    return movs;
  }

  Widget recargaItem(
      IconData icon1, IconData icon2, String text, bool selected) {
    return Container(
      decoration: BoxDecoration(
          color: Palette.darkModeAccentColor,
          borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: selected ? Palette.cumbiaLight : Palette.cumbiaGrey)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon1,
                        color: selected ? Palette.cumbiaLight : Palette.white,
                        size: 45.0),
                    Icon(Icons.arrow_right,
                        color: selected ? Palette.cumbiaLight : Palette.white,
                        size: 30.0),
                    Icon(icon2,
                        color: selected ? Palette.cumbiaLight : Palette.white,
                        size: 45.0),
                  ],
                ),
                SizedBox(height: 5.0),
                Text(
                  text,
                  style: TextStyle(
                      color: selected ? Palette.cumbiaLight : Palette.white,
                      fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTabBarItem extends StatelessWidget {
  CustomTabBarItem({
    this.onPressed,
    this.isActive = false,
    this.isDark = true,
    this.title,
    this.symbol = const SizedBox.shrink(),
  });

  bool isDark;
  bool isActive;
  void Function() onPressed;
  String title;
  Widget symbol;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          color: isDark
              ? isActive
                  ? Palette.darkModeBGColor
                  : Palette.darkModeAccentColor
              : isActive
                  ? Palette.bgColor
                  : Palette.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              symbol,
              Center(
                child: Text(
                  title ?? "Título",
                  style: isDark
                      ? TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Palette.white,
                        )
                      : TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Palette.darkModeBGColor,
                        ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  CustomTabBar({this.tabItems});
  List<Widget> tabItems;
  @override
  Widget build(BuildContext context) {
    tabItems.removeWhere((item) => item == null);
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        children: tabItems,
      ),
    );
  }
}
