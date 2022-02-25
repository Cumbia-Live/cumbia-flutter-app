import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/users/user_model.dart' as userModel;
import 'package:cumbialive/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  //Notificación push
  final notification = LoadUsers();
  // Variables de input de usuario
  String name;
  String email;
  String password;
  String username;
  userModel.PhoneNumberCumbia phoneNumber = userModel.PhoneNumberCumbia(
    dialingCode: '+57',
  );

  // Validation text de txts
  String nameValidationText;
  String emailValidationText;
  String passwordValidationText;
  String usernameValidationText;
  String phoneNumberValidationText;

  // Validation de la imagen
  String profilePicValidationText;
  // Validation del username
  bool usernameIsAvailable = false;

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
        body: CatapultaScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  "Crear cuenta",
                  style: Styles.largeTitleLbl,
                ),
                const SizedBox(height: 4),
                Text(
                  "Rellena los campos y únete a Cumbia Live.",
                  style: Styles.secondaryLbl,
                ),
                const SizedBox(height: 40),
                CumbiaTextField(
                  title: "Nombre",
                  placeholder: "Vero Ardila",
                  validationText: nameValidationText,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (text) {
                    name = text.trim();
                    setState(() {
                      nameValidationText = null;
                    });
                  },
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                CumbiaTextField(
                  title: "Usuario de Cumbia",
                  placeholder: "cumbialive",
                  validationText: usernameValidationText,
                  textCapitalization: TextCapitalization.none,
                  isAutocorrectActive: false,
                  prefixWidget: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "@",
                      style: username != "" && username != null
                          ? Styles.txtTextLbl()
                          : Styles.placeholderLbl,
                    ),
                  ),
                  onChanged: (text) {
                    username = text.trim();
                    setState(() {
                      usernameValidationText = null;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CountryCodePicker(
                      onChanged: (text) {
                        setState(() {
                          phoneNumber.dialingCode = text.toString();
                        });
                      },
                      initialSelection: 'CO',
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 140,
                      child: CumbiaTextField(
                        placeholder: "Número de celular",
                        validationText: usernameValidationText,
                        keyboardType: TextInputType.number,
                        isAutocorrectActive: false,
                        textInputFormatters: [
                          // ignore: deprecated_member_use
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (text) {
                          setState(() {
                            phoneNumber.basePhoneNumber = text.trim();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                phoneNumberValidationText == "" ||
                        phoneNumberValidationText == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          phoneNumberValidationText,
                          style: Styles.validationLbl,
                        ),
                      ),
                const SizedBox(height: 42),
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
                                  pNumber: 7,
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
                                  pNumber: 1,
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
                const SizedBox(height: 24),
                CumbiaButton(
                  title: "Crear cuenta",
                  isLoading: isLoadingBtn,
                  canPush: _canPush(),
                  onPressed: () {
                    notification.sendNotificationUserIsCreatedTopic();
                    setState(() {
                      validateInput();
                    });
                  },
                ),
                const SizedBox(height: 24),
                const CatapultaSpace(),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "¿Ya tienes una cuenta? ",
                      style: Styles.secondaryLbl,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Inicia sesión",
                          style: Styles.txtBtn(fontWeight: FontWeight.w500),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => LoginScreen(),
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
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateInput() {
    if (username != null && username != "") {
      usernameValidationText = null;
    } else {
      usernameValidationText = "Por favor, rellena este campo.";
    }

    if (name != null && name != "") {
      nameValidationText = null;
    } else {
      nameValidationText = "Por favor, rellena este campo.";
    }

    if (email == null || email == "") {
      emailValidationText = "Por favor, rellena este campo.";
    } else if (!emailRegExp.hasMatch(email)) {
      emailValidationText = "Por favor, ingresa un e-mail válido.";
    } else {
      emailValidationText = null;
    }

    if (password != null && password != "") {
      if (password.length < 6) {
        passwordValidationText = "La contraseña debe tener 6 o más caracteres.";
      } else {
        passwordValidationText = null;
      }
    } else {
      passwordValidationText = "Por favor, rellena este campo.";
    }

    if (phoneNumber.basePhoneNumber != null &&
        phoneNumber.basePhoneNumber != "") {
      phoneNumberValidationText = null;
    } else {
      phoneNumberValidationText = "Por favor, rellena este campo.";
    }

    if (_canPush()) {
      _validateUsername();
    }
  }

  bool _canPush() {
    return name != null &&
        name != "" &&
        nameValidationText == null &&
        email != null &&
        email != "" &&
        emailValidationText == null &&
        password != null &&
        password != "" &&
        passwordValidationText == null &&
        username != null &&
        username != "" &&
        usernameValidationText == null &&
        phoneNumber.basePhoneNumber != null &&
        phoneNumber.basePhoneNumber != "" &&
        phoneNumberValidationText == null;
  }

  void _validateUsername() {
    setState(() {
      isLoadingBtn = true;
    });
    LogMessage.get("USERNAME");
    References.users
        .where("username", isEqualTo: username)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        print("USUARIO OCUPADO");
        usernameIsAvailable = false;
        setState(() {
          usernameValidationText =
              "Este usuario ya existe, por favor elige otro.";
          isLoadingBtn = false;
        });
      } else {
        print("USUARIO DISPONIBLE");
        usernameIsAvailable = true;
        _registerUser();
      }
    }).catchError((e) {
      LogMessage.getError("USERNAME", e);
      setState(() {
        isLoadingBtn = false;
      });
    });
  }

  void _registerUser() {
    print("⏳ REGISTRARÉ USER");

    Auth().signUp(email, password).then((userId) async {
      Map<String, dynamic> userMap = {
        "name": name,
        "email": email,
        "username": username,
        "pushToken": null,
        "profilePictureURL": null,
        "addresses": [],
        "emeralds": 0,
        // "esmeraldas": campaign.isActive ? campaign.amount : 0,
        "phoneNumber": {
          "basePhoneNumber": phoneNumber.basePhoneNumber,
          "dialingCode": phoneNumber.dialingCode,
        },
        "roles": {
          "isAdmin": false,
          "isMerchant": false,
        },
      };

      User firebaseUser = await Auth().getCurrentUser();
      FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .set(userMap)
          .then((r) {
        FirebaseFirestore.instance
            .doc("users/${firebaseUser?.uid}")
            .get()
            .then((userDoc) {
          user.id = userDoc.id;
          user.name = userDoc.data()["name"];
          user.email = userDoc.data()['email'];
          user.username = userDoc.data()['username'];
          user.pushToken = userDoc.data()['pushToken'];
          user.profilePictureURL = userDoc.data()['profilePictureURL'];
          user.emeralds = userDoc.data()['esmeraldas'];
          user.phoneNumber = phoneNumber;
          user.roles = userModel.UserRoles(isAdmin: false, isMerchant: false);

          print("✔️ USER DESCARGADO");
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NavScreen(index: 0),
            ),
          );
          setState(() {
            isLoadingBtn = false;
          });
        }).catchError((e) {
          print("💩 ERROR AL OBTENER USUARIO: $e");
        });
        print("✔️️ USER REGISTRADO");
      });
    }).catchError((e) {
      print("💩️ ERROR AL REGISTRARSE: $e");
      if (e is PlatformException) {
        handleSignUpError(context, e.code);
      }
      setState(() {
        isLoadingBtn = false;
      });
    });
  }
}
