import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../screens.dart';

class PendingPaymentsScreen extends StatefulWidget {
  @override
  _PendingPaymentsScreenState createState() => _PendingPaymentsScreenState();
}

class _PendingPaymentsScreenState extends State<PendingPaymentsScreen>
    with SingleTickerProviderStateMixin {
  List<Withdrawal> withdrawalList = [];
  bool isLoading = false;

  @override
  void initState() {
    _getWithdrawal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'Pagos pendientes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
      ),
      body: viewers(),
    );
  }

  Widget viewers() {
    return CatapultaScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            isLoading
                ? _loadingLayout()
                : withdrawalList.isEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        width: MediaQuery.of(context).size.width,
                        color: Palette.bgColor,
                        child: Center(
                          child: Text(
                            "No hay pagos\npendientes",
                            textAlign: TextAlign.center,
                            style: Styles.shortMessageLbl(),
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        width: MediaQuery.of(context).size.width,
                        color: Palette.bgColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                          child: Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, position) {
                                return setupViewersListLayout(
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
  Widget setupViewersListLayout(int position, List list) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PendingPaymentsDetailScreen(
              withdrawal: list[position],
            ),
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
                  "@${list[position].userName}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Palette.cumbiaIconGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '${list[position].price}',
                      style: TextStyle(
                          color: Palette.cumbiaLight,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Image.asset('images/emerald.png', height: 15)
                  ],
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              size: 25,
              color: Palette.cumbiaDark,
            )
          ],
        ),
      ),
    );
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  void _getWithdrawal() {
    setState(() {
      isLoading = true;
    });
    LogMessage.get("Withdrawal");
    References.withdrawal.get().then((querySnapshot) {
      LogMessage.getSuccess("Withdrawal");
      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((withdrawalDoc) {
            withdrawalList.add(
              Withdrawal(
                id: withdrawalDoc.id,
                userid: withdrawalDoc.data()['userid'],
                userName: withdrawalDoc.data()['userName'],
                accountHolder: withdrawalDoc.data()['accountHolder'],
                email: withdrawalDoc.data()['email'],
                idType: withdrawalDoc.data()["idType"],
                idNumber: withdrawalDoc.data()["idNumber"],
                bankName: withdrawalDoc.data()["bankName"],
                accountType: withdrawalDoc.data()["accountType"],
                accountNumber: withdrawalDoc.data()["accountNumber"],
                date: withdrawalDoc.data()["date"],
                emeralds: withdrawalDoc.data()["emeralds"],
              ),
            );
          });
        }
      });
    }).catchError((e) {
      LogMessage.getError("Withdrawal", e);
    });
    setState(() {
      isLoading = false;
    });
  }
}
