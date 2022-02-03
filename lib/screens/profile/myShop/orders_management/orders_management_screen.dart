import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/components/components.dart';
import 'package:date_format/date_format.dart';
import 'package:cumbialive/screens/screens.dart';

int sectionSelect = 0;
List<Purchase> ordersInfo = [];
List<Order> orders = [];

class OrderManagementScreen extends StatelessWidget {
  OrderManagementScreen(List<Purchase> list) {
    ordersInfo = list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.white,
        middle: Text(
          'Gestión de pedidos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        backgroundColor: _getBGColor(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: SelectScreen()),
          ],
        ),
      ),
    );
  }

  Color _getBGColor() {
    return user.roles.isAdmin
        ? Palette.cumbiaDark
        : user.roles.isMerchant
            ? Palette.cumbiaSeller
            : Palette.cumbiaLight;
  }
}

class SelectScreen extends StatefulWidget {
  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  PageController pageController = PageController(initialPage: 0);
  Future<int> _list;

  @override
  void initState() {
    _list = _listOrders();
    super.initState();
  }

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
                              color: sectionSelect == 0
                                  ? Palette.cumbiaDark
                                  : Palette.transparent,
                              width: 3.0))),
                  padding: EdgeInsets.only(top: 30.0),
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      'Lista de pedidos',
                      style: Styles.navBtn(
                              size: 15,
                              color: sectionSelect == 0
                                  ? null
                                  : Palette.cumbiaGrey)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: sectionSelect != 0
                    ? () {
                        setState(() {
                          sectionSelect = 0;
                          pageController.animateToPage(0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.decelerate);
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
                              color: sectionSelect == 1
                                  ? Palette.cumbiaDark
                                  : Palette.transparent,
                              width: 3.0))),
                  padding: EdgeInsets.only(top: 30.0),
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      'Pedidos entregados',
                      style: Styles.navBtn(
                              size: 15,
                              color: sectionSelect == 1
                                  ? null
                                  : Palette.cumbiaGrey)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: sectionSelect != 1
                    ? () {
                        setState(() {
                          sectionSelect = 1;
                          pageController.animateToPage(1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.decelerate);
                        });
                      }
                    : null,
              ),
            ),
          ],
        ),
        Expanded(
          child: FutureBuilder(
            future: _list,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    OrdersList(orders
                        .where((element) => !element.purchase.received)
                        .toList()),
                    OrdersDelivered(orders
                        .where((element) => element.purchase.received)
                        .toList()),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Container(
                      child: CircularProgressIndicator(strokeWidth: 10),
                      margin: EdgeInsets.only(top: 100.0),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Future<int> _listOrders() async {
    orders.clear();
    for (Purchase element in ordersInfo) {
      var username = await References.users
          .doc(element.uuidBuyer)
          .get()
          .then((value) => value.data()['username']);
      orders.add(Order(
        order: element.id.substring(0, 10),
        buyer: username,
        purchase: element,
      ));
    }
    return 0;
  }
}

///Productos no entregados
class OrdersList extends StatefulWidget {
  final List<Order> orders;

  OrdersList(this.orders);

  @override
  _OrdersListState createState() => _OrdersListState(orders);
}

class _OrdersListState extends State<OrdersList> {
  List<Order> orders = [];
  final List<Order> ordersBackup;

  static const _border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(6.0),
      ),
      borderSide: BorderSide.none);

  _OrdersListState(this.ordersBackup) {
    this.orders = this.ordersBackup;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
              style: Styles.txtTextLbl(),
              decoration: InputDecoration(
                fillColor: Palette.skeleton,
                filled: true,
                hintStyle: Styles.placeholderLbl,
                hintText: 'Buscar pedido',
                enabledBorder: _border,
                focusedBorder: _border,
                border: _border,
                disabledBorder: _border,
                suffixIcon: Icon(
                  Icons.search,
                  color: Palette.cumbiaIconGrey,
                ),
              ),
              validator: null,
              onChanged: filter),
        ),
        SizedBox(height: 10.0),
        Expanded(
          child: CatapultaScrollView(
            child: Column(children: this.orders),
          ),
        ),
      ],
    );
  }

  void filter(String value) {
    setState(() {
      if (value != '') {
        this.orders = ordersBackup
            .where((element) =>
                element.order.toLowerCase().contains(value.toLowerCase()))
            .toList();
      } else {
        this.orders = ordersBackup;
      }
    });
  }
}

///Pedidos entregados
class OrdersDelivered extends StatelessWidget {
  final List<Order> orders;

  OrdersDelivered(this.orders);

  @override
  Widget build(BuildContext context) {
    return CatapultaScrollView(
      child: Column(
        children: getOrdersDelivered(),
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  List<Widget> getOrdersDelivered() {
    List<Widget> list = [];

    String date = formatDate(
        DateTime(DateTime.fromMillisecondsSinceEpoch(0).year,
            DateTime.fromMillisecondsSinceEpoch(0).month),
        ['MM', ' ', 'yyyy']);

    this.orders.sort(
        (a, b) => b.purchase.dateReceived.compareTo(a.purchase.dateReceived));

    for (Order p in this.orders) {
      String aux = formatDate(
          DateTime(
              DateTime.fromMillisecondsSinceEpoch(p.purchase.dateReceived).year,
              DateTime.fromMillisecondsSinceEpoch(p.purchase.dateReceived)
                  .month),
          ['MM', ' ', 'yyyy']);
      if (aux != date) {
        list.add(SizedBox(height: 30.0));
        list.add(Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(aux,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        ));
        date = aux;
      }
      list.add(p);
    }

    return list;
  }
}

class Order extends StatefulWidget {
  final String order;
  final String buyer;
  final Purchase purchase;

  Order({
    Key key,
    this.order,
    this.buyer,
    this.purchase,
  }) : super(key: key);

  @override
  _OrderState createState() =>
      _OrderState(order: this.order, buyer: this.buyer, purchase: purchase);
}

class _OrderState extends State<Order> {
  String order;
  String buyer;
  Purchase purchase;
  bool hide = false;

  _OrderState({
    this.order,
    this.buyer,
    this.purchase,
  });

  @override
  Widget build(BuildContext context) {
    return !hide
        ? Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            color: Palette.txtBgColor,
            child: Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FittedBox(
                        child: Image(
                          image: AssetImage('images/check.png'),
                        ),
                        fit: BoxFit.fill),
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
                        Text(order, style: Styles.navTitleLbl),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: buyer,
                                  style: Styles.txtTextLbl(
                                      color: Palette.cumbiaGrey, size: 14.0)),
                              TextSpan(text: '\n'),
                              TextSpan(
                                  style: Styles.txtTextLbl(
                                      color: Palette.cumbiaLight,
                                      weight: purchase.isSend
                                          ? null
                                          : FontWeight.bold,
                                      size: 12),
                                  text: '${purchase.received ? formatDate(DateTime(DateTime.fromMillisecondsSinceEpoch(purchase.dateReceived).year, DateTime.fromMillisecondsSinceEpoch(purchase.dateReceived).month, DateTime.fromMillisecondsSinceEpoch(purchase.dateReceived).day), [
                                      'dd',
                                      '/',
                                      'mm',
                                      '/',
                                      'yyyy'
                                    ]).toString() : purchase.isSend ? 'Enviado' : 'En preparación'}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Palette.cumbiaIconGrey,
                    ),
                  ),
                  onTap: () async {
                    final aux = await Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              OrderScreen(purchase, [this.order, this.buyer]),
                        ));
                    setState(() {
                      if (aux != null) {
                        purchase.isSend = aux[0];
                        purchase.received = aux[1];
                        if (purchase.received) {
                          this.hide = true;
                          purchase.dateReceived = aux[2];
                        }
                      }
                    });
                  },
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
