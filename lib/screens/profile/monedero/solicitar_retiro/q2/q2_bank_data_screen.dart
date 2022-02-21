import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/profile/monedero/solicitar_retiro/q1/widgets/cumbia_data_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../screens.dart';

// ignore: must_be_immutable
class Q2BankDataScreen extends StatefulWidget {
  Q2BankDataScreen({Key key, this.withdrawal}) : super(key: key);
  Withdrawal withdrawal;
  @override
  _Q2BankDataScreenState createState() => _Q2BankDataScreenState();
}

const _gap12 = SizedBox(height: 12.0);
const _gap20 = SizedBox(height: 20.0);

class _Q2BankDataScreenState extends State<Q2BankDataScreen> {
  Withdrawal withdrawal = Withdrawal();
  final TextEditingController accountNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> bancos = [
    'Bancolombia',
    'BBVA',
  ];
  List<String> types = [
    'Ahorros',
    'Corriente',
  ];
  String bank = 'Bancolombia';
  String accountType = 'Ahorros';
  bool canPushBool = false;

  @override
  void initState() {
    withdrawal = widget.withdrawal;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.darkModeBGColor,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: CatapultaScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PercentIndicator(
                    percent: 0.66,
                    step: '2 de 3',
                    text: 'Registro de producto',
                    isDark: true,
                  ),
                  Text(
                    '2. Datos bancarios',
                    style: Styles.titleRegister,
                  ),
                  _gap20,
                  Text(
                    'Banco',
                    style: Styles.txtTitleLbl.copyWith(
                      color: Palette.b5Grey,
                      // fontSize: sizeLabeltext,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CumbiaDataPicker(
                    list: bancos,
                    selectedItem: bank,
                  ),
                  _gap20,
                  Text(
                    'Tipo de cuenta',
                    style: Styles.txtTitleLbl.copyWith(
                      color: Palette.b5Grey,
                      // fontSize: sizeLabeltext,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CumbiaDataPicker(
                    list: types,
                    selectedItem: accountType,
                  ),
                  _gap20,
                  CumbiaTextField(
                      controller: accountNumberController,
                      title: 'Número de cuenta',
                      isDark: true,
                      placeholder: 'Ej: 46513278564',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _canPush();
                      },
                      validator: (value) {
                        if (value.isNotEmpty) {
                          return null;
                        } else{
                          return 'Por favor, rellena este campo';
                        }
                      },
                    ),
                    
                  CatapultaSpace(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CumbiaButton(
                      onPressed: () {
                        if (canPushBool) {
                          _push();
                        }
                      },
                      title: 'Siguiente',
                      canPush: canPushBool,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _canPush() {
    if (_formKey.currentState.validate()) {
      setState(() {
        canPushBool = true;
      });
    } else {
      setState(() {
        canPushBool = false;
      });
    }
  }

  void _push() {
    setState(() {
      withdrawal.accountNumber = accountNumberController.text.trim();
      withdrawal.bankName = bank;
      withdrawal.accountType = accountType;
    });
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Q3WithdrawalDataScreen(
          withdrawal: withdrawal,
        ),
      ),
    );
  }
}
