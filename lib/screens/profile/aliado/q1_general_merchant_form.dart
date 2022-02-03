import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/profile/aliado/q2_portfolio_merchant_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ContactFormQ1 extends StatefulWidget {
  @override
  _ContactFormQ1State createState() => _ContactFormQ1State();
}

class _ContactFormQ1State extends State<ContactFormQ1> {
  // Variables de input de usuario
  String email;
  String phoneNumber = "";
  String nit = "";
  String razonSocial = "";

  // Validation text de txts
  String emailValidationText;
  String phoneNumberValidationText;
  String nitValidationText;
  String razonSocialValidationText;

  // Regex para validación de mail
  RegExp emailRegExp = RegExp("[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      email = user.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CatapultaScrollView(
          child: GestureDetector(
        onTap: () {
          if (FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: Column(
          children: [
            _backAndProgress(),
            _setUpFront(),
            CatapultaSpace(),
            _button()
          ],
        ),
      )),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CumbiaButton(
            title: "Siguiente",
            canPush: _canPush(),
            onPressed: () {
              setState(() {
                validateInput();
              });
              if (_canPush()) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PortFolioFormQ2(
                      merchant: Merchant(
                        phoneNumber: phoneNumber,
                        email: email,
                        nit: nit,
                        razonSocial: razonSocial,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _backAndProgress() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoNavigationBarBackButton(
            color: Palette.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CircularPercentIndicator(
            radius: 65,
            lineWidth: 5.0,
            animation: true,
            percent: 0.25,
            backgroundColor: Palette.grey,
            progressColor: Palette.cumbiaLight,
            center: Text(
              "1 de 4",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }

  Widget _setUpFront() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "General",
            style: Styles.btnPromoter,
          ),
          const SizedBox(height: 12),
          Text(
            "Usaremos estos datos para contactarte y validar la información que nos proveas.",
            style: Styles.secondaryLbl,
          ),
          const SizedBox(height: 28),
          CumbiaTextField(
            title: "Celular",
            placeholder: "+57 321 1234567",
            validationText: phoneNumberValidationText,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.none,
            onChanged: (text) {
              setState(() {
                phoneNumber = text;
                phoneNumberValidationText = null;
              });
            },
          ),
          const SizedBox(height: 36),
          CumbiaTextField(
            title: "E-mail",
            placeholder: "hola@cumbialive.com",
            initialValue: email,
            validationText: emailValidationText,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            onChanged: (text) {
              setState(() {
                email = text;
                emailValidationText = null;
              });
            },
          ),
          const SizedBox(height: 36),
          CumbiaTextField(
            title: "NIT",
            placeholder: "987654321",
            initialValue: nit,
            validationText: nitValidationText,
            textCapitalization: TextCapitalization.none,
            onChanged: (text) {
              setState(() {
                nit = text;
                nitValidationText = null;
              });
            },
          ),
          const SizedBox(height: 36),
          CumbiaTextField(
            title: "Razón social",
            placeholder: "Empresa SAS",
            initialValue: razonSocial,
            validationText: razonSocialValidationText,
            textCapitalization: TextCapitalization.words,
            onChanged: (text) {
              setState(() {
                razonSocial = text;
                razonSocialValidationText = null;
              });
            },
          ),
          const SizedBox(height: 24),
        ],
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

    if (phoneNumber.length > 0 && phoneNumber.length < 10) {
      phoneNumberValidationText = "La celular debe tener 10 o más caracteres.";
    } else if (phoneNumber != null && phoneNumber != "") {
      phoneNumberValidationText = null;
    } else if (phoneNumber == null || phoneNumber == "") {
      phoneNumberValidationText = "Por favor, rellena este campo.";
    }

    if (nit == null || nit == "") {
      nitValidationText = "Por favor, rellena este campo.";
    } else {
      nitValidationText = null;
    }

    if (razonSocial == null || razonSocial == "") {
      razonSocialValidationText = "Por favor, rellena este campo.";
    } else {
      razonSocialValidationText = null;
    }
  }

  bool _canPush() {
    return email != null &&
        email != "" &&
        emailValidationText == null &&
        phoneNumber != null &&
        phoneNumber != "" &&
        phoneNumberValidationText == null &&
        phoneNumber.length >= 10 &&
        nit != null &&
        nit != "" &&
        razonSocial != null &&
        razonSocial != "";
  }
}
