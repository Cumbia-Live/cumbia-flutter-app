import 'dart:io';

import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../screens.dart';
import 'widgets/cumbia_data_picker.dart';

class Q1PersonalDataScreen extends StatefulWidget {
  Q1PersonalDataScreen({Key key}) : super(key: key);

  @override
  _Q1PersonalDataScreenState createState() => _Q1PersonalDataScreenState();
}

const _gap20 = SizedBox(height: 20.0);

class _Q1PersonalDataScreenState extends State<Q1PersonalDataScreen> {
  Withdrawal withdrawal = Withdrawal();
  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedItem = 'Cédula de ciudadania';
  List<String> idType = ['Cédula de ciudadania', 'NIT'];
  bool canPushBool = false;
   RegExp emailRegExp = RegExp("[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+");

  @override
  void initState() {
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
              child: Column(
            children: [
              PercentIndicator(
                percent: 0.33,
                step: '1 de 3',
                text: 'Solicitar retiro',
                isDark: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. Información general del producto',
                      style: Styles.titleRegister,
                    ),
                    _gap20,
                    CumbiaTextField(
                      controller: accountHolderController,
                      title: 'Titular de cuenta',
                      isDark: true,
                      placeholder: 'Ej: Verónica Ardila',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.name,

                      onChanged: (value) {
                        _canPush();
                      },
                      validator: (value) {
                        if (value.isNotEmpty) {
                          return null;
                        } else {
                          return 'Por favor, rellena este campo';
                        }
                      },
                    ),
                    _gap20,
                    CumbiaTextField(
                      controller: emailController,
                      title: 'Correo electrónico',
                      isDark: true,
                      placeholder: 'Ej: vero@cumbialive.com',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        _canPush();
                      },
                      validator: (value) {
                        if(!emailRegExp.hasMatch(value)){
                          return 'Por favor, ingresa un e-mail válido.';
                        }else if (value.isNotEmpty) {
                          return null;
                        } else{
                          return 'Por favor, rellena este campo';
                        }
                      },
                    ),
                    _gap20,
                    Text(
                        'Tipo de identificación',
                        style: Styles.txtTitleLbl.copyWith(
                          color: Palette.b5Grey,
                          // fontSize: sizeLabeltext,
                        ),
                      ),
                      const SizedBox(height:10),
                    CumbiaDataPicker(list: idType,selectedItem: selectedItem,),
                    _gap20,
                    CumbiaTextField(
                      controller: idNumberController,
                      title: 'Número de identificación',
                      isDark: true,
                      placeholder: 'Ej: 123456789',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.number,

                      onChanged: (value) {
                        _canPush();
                      },
                      validator: (value) {
                        if (value.isNotEmpty) {
                          return null;
                        } else {
                          return 'Por favor, rellena este campo';
                        }
                      },
                    ),
                    _gap20,
                  ],
                ),
              ),
              CatapultaSpace(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CumbiaButton(
                  onPressed: () async {
                    if (canPushBool) {
                      _push();
                    }
                  },
                  title: 'Siguiente',
                  canPush: canPushBool,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  void _push() {
    setState(() {
      withdrawal.accountHolder = accountHolderController.text.trim();
      withdrawal.email = emailController.text.trim();
      withdrawal.idNumber = idNumberController.text.trim();
      withdrawal.idType = selectedItem;
    });
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Q2BankDataScreen(
          withdrawal: withdrawal,
        ),
      ),
    );
  }

  void _canPush() {
    if (accountHolderController.text != '' && idNumberController.text != '' && emailRegExp.hasMatch(emailController.text)) {
      setState(() {
        canPushBool = true;
      });
    } else {
      setState(() {
        canPushBool = false;
      });
    }
  }
}
