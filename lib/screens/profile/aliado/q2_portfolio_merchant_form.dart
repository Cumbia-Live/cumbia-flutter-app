import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../screens.dart';

class PortFolioFormQ2 extends StatefulWidget {
  final Merchant merchant;
  const PortFolioFormQ2({Key key, this.merchant}) : super(key: key);

  @override
  _PortFolioFormQ2State createState() => _PortFolioFormQ2State();
}

class _PortFolioFormQ2State extends State<PortFolioFormQ2> {
  // Variables de input de usuario
  String webPage = "";
  String instagram = "";
  var maskFormatter = new MaskTextInputFormatter(
      mask: '@######################################',
      filter: {"#": RegExp(r'^[a-zA-Z0-9&%=.@_-]+$')});
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
              setState(() {});
              if (_canPush()) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => TradeFormQ3(
                      merchant: Merchant(
                          phoneNumber: widget.merchant.phoneNumber,
                          email: widget.merchant.email,
                          nit: widget.merchant.nit,
                          razonSocial: widget.merchant.razonSocial,
                          instagram: instagram,
                          webPage: webPage),
                    ),
                  ),
                );
              } else {
                showAlertPortfolio(context, "Necesitamos un dato",
                    "Por favor, ingresa tu Instagram o página web para que podamos consultar tu portafolio de productos.");
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
            //reverse:
            percent: 0.5,
            // progressColor: _
            backgroundColor: Palette.grey,
            progressColor: Palette.cumbiaLight,
            center: Text(
              "2 de 4",
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
            "Portafolio",
            style: Styles.btnPromoter,
          ),
          const SizedBox(height: 12),
          Text(
            "Revisaremos tu portafolio. Las fotos deben refeljar la calidad de tus productos.",
            style: Styles.secondaryLbl,
          ),
          const SizedBox(height: 28),
          CumbiaTextField(
            title: "Instagram (opcional)",
            placeholder: "@cumbialive",
            textCapitalization: TextCapitalization.none,
            textInputFormatters: [maskFormatter],
            onChanged: (text) {
              setState(() {
                instagram = text;
                instagram = instagram.replaceAll('@', '');
              });
            },
          ),
          const SizedBox(height: 36),
          CumbiaTextField(
            title: "Página web (opcional)",
            placeholder: "www.cumbialive.com",
            initialValue: webPage,
            keyboardType: TextInputType.url,
            textCapitalization: TextCapitalization.none,
            onChanged: (text) {
              setState(() {
                webPage = text;
              });
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  bool _canPush() {
    if ((webPage != null && webPage != "") ||
        (instagram != null && instagram != "")) {
      return true;
    } else {
      return false;
    }
  }

  void showAlertPortfolio(BuildContext context, String title, String message) {
    showAlert(
      context: context,
      title: title,
      body: message,
      actions: [
        // ignore: missing_required_param
        AlertAction(
          text: "Listo",
          isDefaultAction: true,
        ),
      ],
    );
  }
}
