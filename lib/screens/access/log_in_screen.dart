import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Variables de input de usuario
  String email;
  String password;

  // Validation text de txts
  String emailValidationText;
  String passwordValidationText;

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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: () {
          if (FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Palette.bgColor,
          body: CatapultaScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
              child: Column(
                children: [
                  Image.asset(
                    "images/icono.png",
                    height: MediaQuery.of(context).size.width * 0.3,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "¡Bienvenido!",
                    style: Styles.largeTitleLbl,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Rellena los campos y accede a Cumbia Live.",
                    style: Styles.secondaryLbl,
                    textAlign: TextAlign.center,
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
                  CumbiaTextField(
                    title: "Contraseña",
                    placeholder: "6+ caracteres",
                    validationText: passwordValidationText,
                    textCapitalization: TextCapitalization.none,
                    isPassword: true,
                    onChanged: (text) {
                      password = text.trim();
                      setState(() {
                        passwordValidationText = null;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Text(
                            "Recuperar contraseña",
                            style: Styles.txtBtn(),
                            textAlign: TextAlign.left,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ResetPassowrdScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Text(
                            "Crear cuenta",
                            style: Styles.txtBtn(),
                            textAlign: TextAlign.right,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CreateAccountScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  CatapultaSpace(),
                  const SizedBox(height: 48),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Al crear una cuenta aceptas nuestros ",
                      style: Styles.secondaryLbl,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Términos y Condiciones',
                          style: Styles.txtBtn(fontWeight: FontWeight.w500),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => LegalScreen(
                                    pNumber: 1,
                                  ),
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text: ' y ',
                        ),
                        TextSpan(
                          text: 'Políticas de Privacidad',
                          style: Styles.txtBtn(fontWeight: FontWeight.w500),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => LegalScreen(
                                    pNumber: 7,
                                  ),
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CumbiaButton(
                    title: "Iniciar sesión",
                    canPush: _canPush(),
                    isLoading: isLoadingBtn,
                    onPressed: () {
                      setState(() {
                        validateInput();
                      });
                      if (_canPush()) {
                        _loginUser();
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
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

    if (password != null && password != "") {
      passwordValidationText = null;
    } else {
      passwordValidationText = "Por favor, rellena este campo.";
    }
  }

  bool _canPush() {
    return email != null &&
        email != "" &&
        emailValidationText == null &&
        password != null &&
        password != "" &&
        passwordValidationText == null;
  }

  void _loginUser() {
    print("⏳ INICIARÉ SESIÓN");
    setState(() {
      isLoadingBtn = true;
    });

    print(email + " " + password);
    Auth().signIn(email, password).then((firebaseUser) async {
      FirebaseFirestore.instance
          .doc("users/${firebaseUser?.uid}")
          .get()
          .then((userDoc) {

        if (userDoc.data()["roles"]["isBloqueado"] == true) {
          // Usuario bloqueado
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => BannedScreen(),
            ),
          );
        } else {
          user.id = userDoc.id;
          user.name = userDoc.data()["name"];
          user.email = userDoc.data()['email'];
          user.username = userDoc.data()['username'];
          user.pushToken = userDoc.data()['pushToken'];
          user.profilePictureURL = userDoc.data()['profilePictureURL'];
          user.emeralds = userDoc.data()['esmeraldas'];
          user.roles = UserRoles(
              isAdmin: userDoc.data()['roles']["isAdmin"],
              isMerchant: userDoc.data()['roles']["isMerchant"]);
          user.addresses = userDoc.data()["addresses"]
              .map(
                (addressMap) => Address(
              address: addressMap['address'],
              city: addressMap['city'],
              country: addressMap['country'],
              isPrincipal: addressMap['isPrincipal'],
            ),
          ).toList();

          print("✔️ USER DESCARGADO");
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NavScreen(index: 0),
            ),
          );
        }
        setState(() {
          isLoadingBtn = false;
        });
      }).catchError((e) {
        print("💩 ERROR AL OBTENER USUARIO: $e");
      });

      print("✔️ SESIÓN INICIADA");
    }).catchError((e) {
      print("💩️ ERROR AL INICIAR SESIÓN: $e");
      if (e is PlatformException) {
        handleSignInError(context, e.code);
      }
      setState(() {
        isLoadingBtn = false;
      });
    });
  }
}
