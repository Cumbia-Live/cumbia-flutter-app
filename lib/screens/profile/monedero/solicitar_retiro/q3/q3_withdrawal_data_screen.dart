import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../screens.dart';

// ignore: must_be_immutable
class Q3WithdrawalDataScreen extends StatefulWidget {
  Q3WithdrawalDataScreen({this.withdrawal});
  Withdrawal withdrawal;
  @override
  _Q3WithdrawalDataScreenState createState() => _Q3WithdrawalDataScreenState();
}

const _gap12 = SizedBox(height: 12.0);
const _gap20 = SizedBox(height: 20.0);

class _Q3WithdrawalDataScreenState extends State<Q3WithdrawalDataScreen> {
  final TextEditingController emeraldsController = TextEditingController();

  Withdrawal withdrawal = Withdrawal();

  bool isLoading = false;
  String documentId = '';
  String emeralds = '0';
  int finalEmeralds = 0;
  bool canPushBool = false;
  @override
  void initState() {
    setState(() {
      emeraldsController.text = '0';
      withdrawal = widget.withdrawal;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.darkModeBGColor,
      body: Form(
        child: SafeArea(
          child: CatapultaScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PercentIndicator(
                  isDark: true,
                  percent: 1,
                  step: '3 de 3',
                  text: 'Registro de producto',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3. Variantes del producto',
                        style: Styles.titleRegister,
                        textAlign: TextAlign.start,
                      ),
                      _gap20,
                      Container(
                        padding: const EdgeInsets.all(12),
                        height: 104,
                        decoration: BoxDecoration(
                          color: Color(0xFF575757),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Saldo disponible',
                              style: TextStyle(
                                color: Palette.cumbiaGrey,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '${user.emeralds}',
                                  style: TextStyle(
                                    color: Palette.cumbiaLight,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 7,
                                  ),
                                  child: Text(
                                    '  COP ',
                                    style: TextStyle(
                                      color: Palette.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 7,
                                  ),
                                  child: Image.asset(
                                    'images/emerald.png',
                                    height: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _gap20,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: CumbiaTextField(
                              controller: emeraldsController,
                              title: 'Cantidad a retirar',
                              isDark: true,
                              placeholder: 'Ej: 100',
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              initialValue: emeraldsController.text,
                              onChanged: (text) {
                                setState(() {
                                  if (emeraldsController.text.isEmpty) {
                                    emeralds = '0';
                                    withdrawal.emeralds = int.parse(emeralds);
                                  } else {
                                    emeralds = emeraldsController.text;
                                    withdrawal.emeralds = int.parse(emeralds);
                                  }
                                });
                                _canPush();
                              },
                              validator: (value) {
                                if (value == '0') {
                                  return 'No puede ser 0';
                                } else if (value.isEmpty) {
                                  return 'Campo obligatorio';
                                } else if (int.parse(value) > user.emeralds) {
                                  return 'Fondos insuficientes';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40, left: 10),
                            child:
                                Image.asset('images/emerald.png', height: 50),
                          ),
                          CatapultaSpace(),
                          Container(
                            height: 55,
                            width: 125,
                            margin: const EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Palette.bgColor,
                              ),
                              color: Palette.bgColor,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CupertinoButton(
                                    onPressed: removeValue,
                                    padding: EdgeInsets.zero,
                                    child: Container(
                                      width: 60,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color:
                                                Palette.black.withOpacity(0.4),
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 30,
                                        color: Palette.black.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CupertinoButton(
                                    onPressed: addValue,
                                    padding: EdgeInsets.zero,
                                    child: Container(
                                      width: 60,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color:
                                                Palette.black.withOpacity(0.4),
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.arrow_drop_up,
                                        size: 30,
                                        color: Palette.black.withOpacity(0.8),
                                      ),
                                    ),
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
                Container(
                  height: 20,
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 50,
                //   child: ListTile(
                //     leading: Text(
                //       'Equivalente a',
                //       style: Styles.txtTextLbl(
                //         color: Palette.b5Grey,
                //       ),
                //     ),
                //     trailing: Text(
                //       '${NumberFormat.simpleCurrency().format(
                //             (int.parse(emeralds ?? 0) * 100),
                //           ).replaceAll('.00', '').replaceAll(',', '.')} COP',
                //       style: Styles.txtTextLbl(
                //         color: Palette.b5Grey,
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ListTile(
                    leading: Text(
                      'Total a retirar',
                      style: Styles.txtTextLbl(
                        color: Palette.bgColor,
                      ),
                    ),
                    trailing: Text(
                      '${NumberFormat.simpleCurrency().format(
                            (int.parse(emeralds ?? 0) * 1),
                          ).replaceAll('.00', '').replaceAll(',', '.')} COP',
                      style: Styles.txtTextLbl(
                        color: Palette.bgColor,
                      ),
                    ),
                  ),
                ),
                CatapultaSpace(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CumbiaButton(
                    onPressed: () {
                      if (canPushBool) {
                        _finalEmerald();
                        updateUserEmeralds();
                        putWithdrawal();
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SuccessWithdrawalScreen(),
                          ),
                        );
                      }
                    },
                    title: 'Solicitar retiro',
                    isLoading: isLoading,
                    canPush: canPushBool,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> putWithdrawal() async {
    setState(() {
      isLoading = true;
    });
    var withdrawalDoc = <String, dynamic>{
      'userid': user.id,
      'userName': user.username,
      'accountHolder': withdrawal.accountHolder,
      'email': withdrawal.email,
      'idType': withdrawal.idType,
      'idNumber': withdrawal.idNumber,
      'bankName': withdrawal.bankName,
      'accountType': withdrawal.accountType,
      'accountNumber': withdrawal.accountNumber,
      'date': DateTime.now().millisecondsSinceEpoch,
      'emeralds': int.parse(emeralds),
    };
    LogMessage.post('WITHDRAWAL');
    await References.withdrawal.add(withdrawalDoc).then((r) {
      setState(() {
        isLoading = false;
      });

      LogMessage.postSuccess('WITHDRAWAL');
    }).catchError((e) {
      LogMessage.postError('WITHDRAWALT', e);
      setState(() {
        isLoading = false;
      });
      showBasicAlert(
        context,
        'Hubo un error',
        'No pudimos enviar el feedback, por favor intenta más tarde.',
      );
    });
  }

  void _finalEmerald() {
    finalEmeralds = user.emeralds - int.parse(emeraldsController.text);
    user.emeralds = finalEmeralds;
  }

  Future<void> updateUserEmeralds() async {
    setState(() {
      isLoading = true;
    });
    var userDoc = <String, dynamic>{
      'esmeraldas': finalEmeralds,
    };
    LogMessage.post('UDATEUSEREMERALDS');
    await References.users.doc(user.id).update(userDoc).then((r) {
      setState(() {
        isLoading = false;
      });
      LogMessage.postSuccess('UDATEUSEREMERALDS');
    }).catchError((e) {
      LogMessage.postError('UDATEUSEREMERALDS', e);
      setState(() {
        isLoading = false;
      });
      showBasicAlert(
        context,
        'Hubo un error',
        'No pudimos enviar el feedback, por favor intenta más tarde.',
      );
    });
  }

  void _canPush() {
    if (emeraldsController.text.trim() != '' &&
        emeraldsController.text.trim() != null &&
        emeraldsController.text.trim() != '0' &&
        int.parse(emeraldsController.text.trim()) <= user.emeralds) {
      setState(() {
        canPushBool = true;
      });
    } else {
      setState(() {
        canPushBool = false;
      });
    }
  }

  String addValue() {
    setState(() {
      if (emeraldsController.text == '' || emeraldsController.text == null)
        return null;
      var auxInt = int.parse(emeraldsController.text);
      auxInt = auxInt + 100;
      var auxString = auxInt.toString();
      emeraldsController.text = auxString;
      withdrawal.emeralds = int.parse(emeralds);
      _canPush();

      return emeralds = auxString;
    });
  }

  String removeValue() {
    setState(() {
      if (emeraldsController.text == '' || emeraldsController.text == null)
        return null;
      var auxInt = int.parse(emeraldsController.text);

      if (auxInt == 1) return null;
      auxInt = auxInt - 100;

      var auxString = auxInt.toString();
      emeraldsController.text = auxString;
      withdrawal.emeralds = int.parse(emeralds);
      _canPush();

      return emeralds = auxString;
    });
  }
}
