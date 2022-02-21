import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/merchant/merchant_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../screens.dart';

class ContractPage extends StatefulWidget {
  final Merchant merchant;
  const ContractPage({Key key, this.merchant}) : super(key: key);

  @override
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  // Variables de input de usuario
  String email;
  String phoneNumber;
  bool isLoading = false;

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: CatapultaDivider(),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView(
                  children: [
                    _setUpContract(),
                  ],
                ),
              ),
            ),
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
          const SizedBox(height: 16),
          CumbiaButton(
            title: "¡Listo!",
            canPush: true,
            onPressed: () {
              _addMerchant();
            },
            isLoading: isLoading,
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
            percent: 1,
            backgroundColor: Palette.grey,
            progressColor: Palette.cumbiaLight,
            center: Text(
              "4 de 4",
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
            "Términos y condiciones para el emprendedor",
            style: Styles.btnPromoter,
          ),
          const SizedBox(height: 12),
          Text(
            "Lee cuidadosamente el contrato de Aliado Cumbia antes de enviar tu solicitud a revisión.",
            style: Styles.secondaryLbl,
          ),
        ],
      ),
    );
  }

  Widget _setUpContract() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contrato de Aliado Cumbia:",
            style: Styles.labelPromoter,
          ),
          const SizedBox(height: 15),
          Text(
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas."
            "Usaremos estos datos para contactarte y validar la información que nos proveas.",
            style: Styles.secondaryLbl,
          ),
        ],
      ),
    );
  }

  void _addMerchant() {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> merchantMap = ({
      "userId": user.id,
      "username": user.username,
      "phoneNumber": widget.merchant.phoneNumber,
      "email": widget.merchant.email,
      "instagram": widget.merchant.instagram,
      "webPage": widget.merchant.webPage,
      "nit": widget.merchant.nit,
      "razonSocial": widget.merchant.razonSocial,
      "principalCategory": widget.merchant.category1,
      "secondaryCategory": widget.merchant.category2,
      "colombianProducts": widget.merchant.colombianProducts,
      "isApproved": false,
      "isRejected": false,
      "isOpen": false,
    });
    LogMessage.post("MERCHANT");
    References.merchant.add(merchantMap).then((r) async {
      LogMessage.postSuccess("MERCHANT");
      setState(() {
        isLoading = false;
      });
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => SuccessPage(),
        ),
      );
    }).catchError((e) {
      LogMessage.postError("MERCHANT", e);
      setState(() {
        isLoading = false;
      });
    });
  }
}
