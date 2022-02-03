import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/home/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:date_format/date_format.dart';
import 'purchases_detail_screen.dart';
import 'withdrawal_detail_screen.dart';

class TransactionLogScreen extends StatefulWidget {
  @override
  _TransactionLogScreenState createState() => _TransactionLogScreenState();
}

class _TransactionLogScreenState extends State<TransactionLogScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Withdrawal> withdrawalList = [];
  List<Purchase> purchasesList = [];

  List<Purchase> purchasesListBackup = [];
  List<Withdrawal> withdrawalListBackup = [];

  String searchPurchase = "";
  String searchWithdrawal = "";

  bool isLoading = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _getUsers();
    Future.delayed(const Duration(seconds: 1), () {});

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
            'Registro de transacciones',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Palette.white,
            ),
          ),
          bottom: TabBar(
            unselectedLabelColor: Palette.black.withOpacity(0.4),
            labelColor: Palette.white,
            tabs: [
              Tab(
                child: Text(
                  'Compras',
                ),
              ),
              Tab(
                child: Text(
                  'Recargas y retiros',
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
          purchases(),
          withdrawals(),
        ],
        controller: _tabController,
      ),
    );
  }

  Widget withdrawals() {
    return CatapultaScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: CustomTextField(
                initialValue: searchText,
                suffixWidget: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Palette.black.withOpacity(0.25),
                    )),
                placeholder: "Ej: @usuario",
                onChanged: (text) {
                  searchText = text;
                  setState(() {
                    searchWithdrawal = text;
                  });
                  _filterByWithdrawal(text);
                  if (text == "") {
                    withdrawalList = withdrawalListBackup;
                  }
                },
              ),
            ),
            isLoading
                ? _loadingLayout()
                : withdrawalList.isEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        color: Palette.bgColor,
                        child: Center(
                          child: Text(
                            "No hay resultados que\ncoincidan con tu búsqueda",
                            textAlign: TextAlign.center,
                            style: Styles.shortMessageLbl(),
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        color: Palette.bgColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                          child: Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, position) {
                                return setupWithdrawalsListLayout(
                                    position, withdrawalList);
                              },
                              itemCount: withdrawalList.length,
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget purchases() {
    return CatapultaScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: CustomTextField(
                initialValue: searchText,
                suffixWidget: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Palette.black.withOpacity(0.25),
                    )),
                placeholder: "Ej: @usuario",
                onChanged: (text) {
                  searchText = text;
                  setState(() {
                    searchPurchase = text;
                  });
                  _filterByPurchase(text);
                  if (text == "") {
                    setState(() {
                      purchasesList = purchasesListBackup;
                    });
                  }
                },
              ),
            ),
            isLoading
                ? _loadingLayout()
                : purchasesList.isEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        color: Palette.bgColor,
                        child: Center(
                          child: Text(
                            "No hay resultados que\ncoincidan con tu búsqueda",
                            textAlign: TextAlign.center,
                            style: Styles.shortMessageLbl(),
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        color: Palette.bgColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                          child: Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, position) {
                                return setupPurchasesListLayout(
                                  position,
                                  purchasesList,
                                );
                              },
                              itemCount: purchasesList.length,
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _loadingLayout() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      color: Palette.bgColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Expanded(
          child: ListView.builder(
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Palette.txtBgColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Palette.black.withOpacity(0.5),
                              highlightColor: Palette.black.withOpacity(0.2),
                              child: Container(
                                height: 10,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: Palette.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Shimmer.fromColors(
                              baseColor: Palette.black.withOpacity(0.5),
                              highlightColor: Palette.black.withOpacity(0.2),
                              child: Container(
                                height: 10,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: Palette.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Shimmer.fromColors(
                          baseColor: Palette.black.withOpacity(0.5),
                          highlightColor: Palette.black.withOpacity(0.2),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Palette.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: 5,
          ),
        ),
      ),
    );
  }

  /// FRONT

  int datePurchase = 0;
  Widget date(Purchase p) {
    if (p.datePurchase != datePurchase) {
      datePurchase = p.datePurchase;
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          formatDate(
              DateTime(
                  DateTime.fromMillisecondsSinceEpoch(p.datePurchase).year,
                  DateTime.fromMillisecondsSinceEpoch(p.datePurchase).month,
                  DateTime.fromMillisecondsSinceEpoch(p.datePurchase).day),
              ['dd', '/', 'mm', '/', 'yyyy']).toString(),
          style: TextStyle(fontSize: 12.0),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget setupPurchasesListLayout(int position, List<Purchase> list) {
    if (position == 0) {
      datePurchase = 0;
    }
    return Column(
      children: [
        date(list[position]),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => PurchasesDetailScreen(list[position]),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Palette.txtBgColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      "@${list[position].buyerName}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Palette.cumbiaIconGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          list[position].emeralds.toString(),
                          style: TextStyle(
                            color: Palette.cumbiaLight,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image(
                            image: AssetImage('images/emerald.png'),
                            height: 16.0),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      "Compró a",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Palette.cumbiaLight,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "@${list[position].streamName}",
                      style: TextStyle(
                        color: Palette.cumbiaIconGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  int dateWithdrawal = 0;
  Widget dateW(Withdrawal p) {
    if (p.date != datePurchase) {
      datePurchase = p.date;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          formatDate(
              DateTime(
                  DateTime.fromMillisecondsSinceEpoch(p.date).year,
                  DateTime.fromMillisecondsSinceEpoch(p.date).month,
                  DateTime.fromMillisecondsSinceEpoch(p.date).day),
              ['dd', '/', 'mm', '/', 'yyyy']).toString(),
          style: TextStyle(fontSize: 12.0),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget setupWithdrawalsListLayout(int position, List<Withdrawal> list) {
    if (position == 0) {
      dateWithdrawal = 0;
    }
    return Column(
      children: [
        dateW(list[position]),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => WithdrawalDetailScreen(list[position]),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Palette.txtBgColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "@${list[position].userName}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Palette.cumbiaIconGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      "Retiró",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Palette.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "${list[position].emeralds}",
                          style: TextStyle(
                            color: Palette.cumbiaLabelGrey,
                            fontSize: 14,
                          ),
                        ),
                        Image(
                            image: AssetImage('images/emerald.png'),
                            height: 16.0),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _filterByWithdrawal(String text) {
    setState(() {
      withdrawalList = withdrawalList
          .where((user) => user.userName
              .toLowerCase()
              .replaceAll(" ", "")
              .replaceAll("á", "a")
              .replaceAll("é", "e")
              .replaceAll("í", "i")
              .replaceAll("ó", "o")
              .replaceAll("ú", "u")
              .contains(
                text
                    .toLowerCase()
                    .replaceAll(" ", "")
                    .replaceAll("á", "a")
                    .replaceAll("é", "e")
                    .replaceAll("í", "i")
                    .replaceAll("ó", "o")
                    .replaceAll("ú", "u"),
              ))
          .toList();
    });
  }

  void _filterByPurchase(String text) {
    setState(() {
      purchasesList = purchasesList
          .where(
            (ally) =>
                ally.uuidBuyer
                    .toLowerCase()
                    .replaceAll(" ", "")
                    .replaceAll("á", "a")
                    .replaceAll("é", "e")
                    .replaceAll("í", "i")
                    .replaceAll("ó", "o")
                    .replaceAll("ú", "u")
                    .contains(
                      text
                          .toLowerCase()
                          .replaceAll(" ", "")
                          .replaceAll("á", "a")
                          .replaceAll("é", "e")
                          .replaceAll("í", "i")
                          .replaceAll("ó", "o")
                          .replaceAll("ú", "u"),
                    ) ||
                ally.uuidStreamer
                    .toLowerCase()
                    .replaceAll(" ", "")
                    .replaceAll("á", "a")
                    .replaceAll("é", "e")
                    .replaceAll("í", "i")
                    .replaceAll("ó", "o")
                    .replaceAll("ú", "u")
                    .contains(
                      text
                          .toLowerCase()
                          .replaceAll(" ", "")
                          .replaceAll("á", "a")
                          .replaceAll("é", "e")
                          .replaceAll("í", "i")
                          .replaceAll("ó", "o")
                          .replaceAll("ú", "u"),
                    ),
          )
          .toList();
    });
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  void _getUsers() async {
    setState(() {
      isLoading = true;
    });
    LogMessage.get("PURCHASES");
    await References.purchases.get().then((querySnapshot) {
      LogMessage.getSuccess("PURCHASES");
      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((element) {
            purchasesListBackup.add(
              Purchase(
                  uuidStreamer: element.data()['uuidStreamer'],
                  uuidBuyer: element.data()['uuidBuyer'],
                  details: element.data()['details'],
                  datePurchase: element.data()['datePurchase'],
                  dateReceived: element.data()['dateReceived'],
                  daysToReceive: element.data()['daysToReceive'],
                  address: Address(
                      address: element.data()['address']['address'],
                      city: element.data()['address']['city'],
                      country: element.data()['address']['country']),
                  received: element.data()['received'],
                  rated: element.data()['rated'],
                  rate: element.data()['rate'],
                  emeralds: element.data()['emeralds'],
                  purchaseType: element.data()['purchaseType'] ?? 'Tienda',
                  id: element.id),
            );
          });
          purchasesListBackup
              .sort((a, b) => a.datePurchase.compareTo(b.datePurchase));
          purchasesList = purchasesListBackup;
        }
      });

      for (Purchase p in purchasesListBackup) {
        References.users
            .doc(p.uuidBuyer)
            .get()
            .then((value) => p.buyerName = value.data()['username']);
        References.users
            .doc(p.uuidStreamer)
            .get()
            .then((value) => p.streamName = value.data()['username']);
      }
    }).catchError((e) {
      LogMessage.getError("USERS", e);
    });

    References.withdrawal.get().then((value) {
      setState(() {
        value.docs.forEach((element) {
          withdrawalListBackup.add(Withdrawal(
              bankName: element.data()['bankName'],
              date: element.data()['date'],
              emeralds: element.data()['emeralds'],
              userName: element.data()['userName']));
        });
        withdrawalListBackup.sort((a, b) => a.date.compareTo(b.date));
        withdrawalList = withdrawalListBackup;
      });
    }).catchError((e) {
      LogMessage.getError("USERS", e);
    });

    setState(() {
      isLoading = false;
    });
  }
}
