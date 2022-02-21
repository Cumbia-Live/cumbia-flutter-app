import 'package:cumbialive/config/constants/emerald_constants.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/components/components.dart';
import 'package:intl/intl.dart';

class PendingPaymentsDetailScreen extends StatefulWidget {
  PendingPaymentsDetailScreen({this.withdrawal});
  Withdrawal withdrawal;

  @override
  _PendingPaymentsDetailScreenState createState() =>
      _PendingPaymentsDetailScreenState();
}

class _PendingPaymentsDetailScreenState
    extends State<PendingPaymentsDetailScreen> {
  List<Merchant> merchants = [];

  bool isLoadingMerchants = false;
  bool canPushBool = false;
  bool isLoading = false;
  Merchant merchant = Merchant();
  final TextEditingController t1Controller = TextEditingController();
  final TextEditingController t2Controller = TextEditingController();
  final TextEditingController t3Controller = TextEditingController();
  final TextEditingController t4Controller = TextEditingController();
  final TextEditingController t5Controller = TextEditingController();
  final TextEditingController t6Controller = TextEditingController();
  final df = new DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    const _styleTitle = TextStyle(
      color: Palette.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    const _styleLabel = TextStyle(
      color: Palette.darkGrey,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
    const _styleSubLabel = TextStyle(
      color: Palette.black,
      fontSize: 16,
    );
    const _styleLabelRow = TextStyle(
      color: Palette.black,
      fontSize: 14,
    );
    const _styleEmeralds = TextStyle(
      color: Palette.cumbiaLight,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(
            color: Palette.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          border: Border.symmetric(),
          middle: Text(
            'Pago a @${widget.withdrawal.userName}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Palette.black,
            ),
          ),
          backgroundColor: Palette.bgColor),
      body: CatapultaScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Text('Información de retiro', style: _styleTitle),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fecha de solicitud',
                        style: _styleLabel,
                      ),
                      Text(
                        '${df.format(DateTime.fromMillisecondsSinceEpoch(widget.withdrawal.date))}',
                        style: _styleLabelRow,
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cantidad de esmeraldas',
                        style: _styleLabel,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.withdrawal.emeralds}',
                            style: _styleEmeralds,
                          ),
                          Image.asset('images/emerald.png', height: 15)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Equivalente a',
                        style: _styleLabel,
                      ),
                      Text(
                        '${NumberFormat.simpleCurrency().format(
                              widget.withdrawal.emeralds * trmEmeralds,
                            ).replaceAll('.00', '').replaceAll(',', '.')} COP',
                        style: _styleLabelRow,
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text('Dtos personales', style: _styleTitle),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 5),
                    child: Text('Titular de cuenta', style: _styleLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                    child: Text(
                      '${widget.withdrawal.accountType}',
                      style: _styleSubLabel,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 5),
                    child: Text('Correo electrónico', style: _styleLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                    child: Text(widget.withdrawal.email, style: _styleSubLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 5),
                    child: Text('Tipo de identificación', style: _styleLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                    child: Text(
                      widget.withdrawal.idType,
                      style: _styleSubLabel,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 5),
                    child: Text('Número de identificación', style: _styleLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                    child: Text(
                      '${widget.withdrawal.idNumber}',
                      style: _styleSubLabel,
                    ),
                  ),
                  Text('Datos bancarios', style: _styleTitle),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 5),
                    child: Text('Banco', style: _styleLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                    child: Text(
                      widget.withdrawal.bankName,
                      style: _styleSubLabel,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 5),
                    child: Text('Tipo de cuenta', style: _styleLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                    child: Text(
                      widget.withdrawal.accountType,
                      style: _styleSubLabel,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 5),
                    child: Text('Número de cuenta', style: _styleLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                    child: Text(
                      widget.withdrawal.accountNumber,
                      style: _styleSubLabel,
                    ),
                  ),
                  CumbiaButton(
                      onPressed: () {}, title: 'Realizar pago', canPush: true)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
