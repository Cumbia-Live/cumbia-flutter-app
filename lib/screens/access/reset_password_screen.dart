import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'success_reset_password_screen.dart';

class ResetPassowrdScreen extends StatefulWidget {
  @override
  _ResetPassowrdScreenState createState() => _ResetPassowrdScreenState();
}

class _ResetPassowrdScreenState extends State<ResetPassowrdScreen> {
  // Variables de input de usuario
  String email;
  // Validation text de txts
  String emailValidationText;

  // Regex para validación de mail
  RegExp emailRegExp = RegExp("[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+");

  // Estado de actividad del botón
  bool isLoadingBtn = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Palette.bgColor,
        appBar: CupertinoNavigationBar(
          backgroundColor: Palette.bgColor,
          //actionsForegroundColor: Palette.black,
          border: Border.all(color: Palette.transparent),
        ),
        body: CatapultaScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recuperar\ncontraseña",
                  style: Styles.largeTitleLbl,
                ),
                const SizedBox(height: 40),
                CumbiaTextField(
                  title: "E-mail",
                  placeholder: "hola@cumbialive.com",
                  validationText: emailValidationText,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  onChanged: (text) {
                    email = text.trim();
                    setState(() {
                      emailValidationText = null;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  "Enviaremos un link a tu e-mail con el que podrás recuperar tu contraseña.",
                  style: Styles.secondaryLbl,
                ),
                CatapultaSpace(),
                const SizedBox(height: 48),
                CumbiaButton(
                  title: "Enviar link",
                  canPush: _canPush(),
                  isLoading: isLoadingBtn,
                  onPressed: () {
                    setState(() {
                      validateInput();
                    });
                    if (_canPush()) {
                      _sendCodeToMail();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateInput() {
    if (email == null || email == "") {
      emailValidationText = "Por favor, rellena este campo.";
    } else if (!emailRegExp.hasMatch(email)) {
      emailValidationText = "Por favor, ingresa un e-mail válido.";
    } else {
      emailValidationText = null;
    }
  }

  bool _canPush() {
    return email != null && email != "" && emailValidationText == null;
  }

  void _sendCodeToMail() {
    setState(() {
      isLoadingBtn = true;
    });
    print("⏳ ENVIARÉ EMAIL");
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((r) {
      setState(() {
        isLoadingBtn = false;
      });
      print("✔️ EMAIL ENVIADO");
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => SuccessResetPasswordScreen(
            email: email,
          ),
        ),
      );
    }).catchError((e) {
      print("💩 ERROR AL ENVIAR EMAIL: $e");
      if (e is PlatformException) {
        handleResetPasswordError(context, e.code);
      }
      setState(() {
        isLoadingBtn = false;
      });
    });
  }
}
