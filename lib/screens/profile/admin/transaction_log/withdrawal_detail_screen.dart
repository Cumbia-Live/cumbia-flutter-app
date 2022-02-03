import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/components/components.dart';
import 'package:date_format/date_format.dart';

class WithdrawalDetailScreen extends StatefulWidget {
  WithdrawalDetailScreen(this.withdrawal);
  Withdrawal withdrawal;

  @override
  _WithdrawalDetailScreenState createState() =>
      _WithdrawalDetailScreenState(withdrawal);
}

class _WithdrawalDetailScreenState extends State<WithdrawalDetailScreen> {
  Withdrawal withdrawal;

  _WithdrawalDetailScreenState(this.withdrawal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        //actionsForegroundColor: Palette.black,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        border: Border.symmetric(),
        middle: Text(
          'Retiro',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: CatapultaScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                      "@${withdrawal.userName}",
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
                              "${withdrawal.emeralds}",
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
              SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Valor del retiro',
                    style: TextStyle(
                      fontSize: 14,
                      color: Palette.cumbiaGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        Text(
                          withdrawal.emeralds.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Palette.cumbiaIconGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image(
                          image: AssetImage('images/emerald.png'),
                          height: 20.0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Banco del retiro',
                    style: TextStyle(
                      fontSize: 14,
                      color: Palette.cumbiaGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      withdrawal.bankName,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Palette.cumbiaIconGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Fecha de retiro',
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            formatDate(
                                DateTime(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            withdrawal.date)
                                        .year,
                                    DateTime.fromMillisecondsSinceEpoch(
                                            withdrawal.date)
                                        .month,
                                    DateTime.fromMillisecondsSinceEpoch(
                                            withdrawal.date)
                                        .day),
                                ['dd', '/', 'mm', '/', 'yyyy']).toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Palette.cumbiaIconGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Medio',
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.cumbiaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "App",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Palette.cumbiaIconGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
