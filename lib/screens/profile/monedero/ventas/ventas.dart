import 'package:cumbialive/components/components.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import 'package:cumbialive/model/models.dart';

List<VentaModel> ventasData = [];

class VentasPage extends StatefulWidget {
  @override
  _VentasPageState createState() => _VentasPageState();

  VentasPage(List<Purchase> list) {
    ventasData.clear();
    for (Purchase p in list) {
      for (Product n in p.products) {
        var cant = n.unitsCarrito + n.unitsCheckout;
        ventasData.add(VentaModel(
            n.productName,
            n.description,
            n.price,
            n.price ~/ 10 * cant,
            DateTime.fromMillisecondsSinceEpoch(p.datePurchase).toUtc(),
            cant,
            imageUrl: n.imageUrl));
      }
    }
  }
}

class _VentasPageState extends State<VentasPage> {
  var pageController = PageController(initialPage: 0);
  var sectionSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: sectionSelected == 0
                                  ? Palette.cumbiaDark
                                  : Palette.transparent,
                              width: 3.0))),
                  padding: EdgeInsets.only(top: 30.0),
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      'Ventas por producto',
                      style: Styles.navBtn(
                              size: 15,
                              color: sectionSelected == 0
                                  ? null
                                  : Palette.cumbiaGrey)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: sectionSelected != 0
                    ? () {
                        setState(() {
                          sectionSelected = 0;
                        });
                      }
                    : null,
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: sectionSelected == 1
                                  ? Palette.cumbiaDark
                                  : Palette.transparent,
                              width: 3.0))),
                  padding: EdgeInsets.only(top: 30.0),
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      'Ventas por mes',
                      style: Styles.navBtn(
                              size: 15,
                              color: sectionSelected == 1
                                  ? null
                                  : Palette.cumbiaGrey)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: sectionSelected != 1
                    ? () {
                        setState(() {
                          sectionSelected = 1;
                        });
                      }
                    : null,
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: sectionSelected == 0 ? Productos() : Mes(),
          ),
        ),
      ],
    );
  }
}

class Venta {
  String name;
  String desc;
  int cont;
  int emeralds;
  bool bestProduct;

  Venta(this.name, this.desc, this.cont, this.emeralds, this.bestProduct);
}

class Productos extends StatelessWidget {
  List<Venta> v = [];

  Productos() {
    ventasData.sort((a, b) {
      var cmp = b.nombre.compareTo(a.nombre);
      if (cmp != 0) {
        return cmp;
      } else {
        return b.desc.compareTo(a.desc);
      }
    });
    var cont = 0;
    var auxName = '';
    var auxDesc = '';
    for (var i = 0; i < ventasData.length; i++) {
      if (auxDesc == '' && auxName == '') {
        auxName = ventasData[i].nombre;
        auxDesc = ventasData[i].desc;
        cont = ventasData[i].cant;
        v.add(Venta(auxName, auxDesc, cont,
            ventasData[i].emeralds * (ventasData[i].cant), null));
      } else if (auxName != ventasData[i].nombre ||
          auxDesc != ventasData[i].desc) {
        auxName = ventasData[i].nombre;
        auxDesc = ventasData[i].desc;
        cont = ventasData[i].cant;
        v.add(Venta(auxName, auxDesc, cont,
            ventasData[i].emeralds * ventasData[i].cant, null));
      } else {
        v[v.length - 1].cont += ventasData[i].cant;
        v[v.length - 1].emeralds += ventasData[i].emeralds * ventasData[i].cant;
      }
    }
    v.sort((a, b) => b.emeralds.compareTo(a.emeralds));
    v[0].bestProduct = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: list(v),
      ),
    );
  }

  List<Widget> list(List<Venta> ventas) {
    var listaVentas = <Widget>[];

    ventas.forEach((element) => {
          listaVentas.add(
            Container(
              height: 100.0,
              margin: EdgeInsets.only(top: 10.0),
              child: Card(
                color: Palette.cumbiaIconGrey,
                elevation: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.shopping_cart, size: 50.0),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 180),
                            child: Text(element.name.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Palette.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: element.desc.toString(),
                                    style: TextStyle(
                                        color: Palette.white, fontSize: 14.0)),
                                TextSpan(text: '\n\n'),
                                TextSpan(
                                    text: '${element.cont} unidades vendidas'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.star,
                            size: 18.0,
                            color: element.bestProduct != null
                                ? Palette.cumbiaLight
                                : Palette.transparent,
                          ),
                          SizedBox(height: 5.0),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${element.emeralds.toString()} ",
                                    style: TextStyle(
                                        color: Palette.cumbiaLight,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Image(
                                      image: AssetImage('images/emerald.png'),
                                      height: 26.0)
                                ],
                              ),
                              Text(
                                'Ingresos',
                                style: TextStyle(
                                    fontSize: 10, color: Palette.cumbiaGrey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        });

    return listaVentas;
  }
}

class Mes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ventasData.sort((a, b) {
      var cmp = b.fecha.compareTo(a.fecha);
      if (cmp != 0) {
        return cmp;
      } else {
        cmp = b.nombre.compareTo(a.nombre);
        if (cmp != 0) {
          return cmp;
        } else {
          return b.desc.compareTo(a.desc);
        }
      }
    });

    return Column(
        children: getVentas(ventasData),
        crossAxisAlignment: CrossAxisAlignment.start);
  }

  List<Widget> getVentas(List<VentaModel> list) {
    var ventas = <Widget>[
      SizedBox(width: double.infinity, height: 20.0),
    ];

    for (var i = 0; i < 3; i++) {
      ventas.add(SizedBox(height: 40.0));
      ventas.add(Row(
        children: [
          Text(
            formatDate(DateTime(DateTime.now().year, DateTime.now().month - i),
                ['MM', ' ', 'yyyy', ' ']),
            style: TextStyle(
                fontSize: 16.0,
                color: Palette.white,
                fontWeight: FontWeight.bold),
          ),
          Expanded(child: CatapultaDivider(height: 2.0)),
        ],
      ));
      ventas.add(SizedBox(height: 10.0));

      ventas.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Número de ventas',
              style: TextStyle(color: Palette.cumbiaGrey),
            ),
            Text(
              '${(list.where((element) => DateTime.now().month - i == element.fecha.month).toList().length)} unidades',
              style: TextStyle(color: Palette.white),
            )
          ],
        ),
      ));

      var contEsmeraldas = 0;
      var contPuntosCumbia = 0;
      var productos = <String>{};

      for (var l in list.where(
          (element) => DateTime.now().month - i == element.fecha.month)) {
        contEsmeraldas += l.emeralds * l.cant;
        contPuntosCumbia += l.cumbiap;
        productos.add('${l.nombre}|${l.desc}');
      }

      ventas.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dinero recibido',
              style: TextStyle(color: Palette.cumbiaGrey),
            ),
            Row(
              children: [
                Text(
                  '$contEsmeraldas COP ',
                  style: TextStyle(
                      color: Palette.cumbiaLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                Image(image: AssetImage('images/emerald.png'), height: 25.0),
              ],
            )
          ],
        ),
      ));

      ventas.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Horas transmitidas',
              style: TextStyle(color: Palette.cumbiaGrey),
            ),
            Text(
              '',
              style: TextStyle(color: Palette.white),
            )
          ],
        ),
      ));

      ventas.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Puntos Cumbia',
              style: TextStyle(color: Palette.cumbiaGrey),
            ),
            Text(
              '${contPuntosCumbia} PC',
              style: TextStyle(color: Palette.white),
            )
          ],
        ),
      ));

      ventas.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          'Productos vendidos',
          style: TextStyle(color: Palette.white),
        ),
      ));

      for (var p in productos) {
        var countVentas = 0;
        for (VentaModel vm in list
            .where((element) => element.fecha.month == DateTime.now().month - i)
            .where((element) => element.nombre == p.split('|')[0])
            .where((element) => element.desc == p.split('|')[1])) {
          countVentas += vm.cant;
        }
        ventas.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            height: 50.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 50.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      ventasData[i].imageUrl,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.split('|')[0].toString(),
                          style: TextStyle(
                              color: Palette.cumbiaGrey, fontSize: 14.0),
                        ),
                        Text(
                          p.split('|')[1].toString(),
                          style: TextStyle(
                              color: Palette.cumbiaGrey, fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$countVentas unidades',
                    style: TextStyle(color: Palette.white),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    }

    return ventas;
  }
}
