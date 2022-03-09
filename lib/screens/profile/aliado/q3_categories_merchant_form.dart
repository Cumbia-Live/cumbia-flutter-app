import 'dart:convert';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/profile/aliado/q4_agreement_merchant_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TradeFormQ3 extends StatefulWidget {
  final Merchant merchant;
  const TradeFormQ3({Key key, this.merchant}) : super(key: key);

  @override
  _TradeFormQ3State createState() => _TradeFormQ3State();
}

class _TradeFormQ3State extends State<TradeFormQ3> {
  // Variables de input de usuario
  String category1 = "No especificada";
  String category2 = "Opcional";
  bool colombianProducts = true;
  String pickerData = "";
  List<String> categories = [];

  // Validation text de txts
  bool validateCategory1 = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategories();
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: CatapultaDivider(),
            ),
            _colombianProducts(),
            CatapultaSpace(),
            _button()
          ],
        ),
      )),
    );
  }

  Widget _colombianProducts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            textAlign: TextAlign.start,
            text: TextSpan(
              text: "¿Tus productos son ensamblados o producidos en Colombia? ",
              style: Styles.tittleLiveLbl,
              children: <TextSpan>[
                TextSpan(
                  text: '🇨🇴',
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          ToggleSwitch(
            totalSwitches: 2,
            minWidth: 60.0,
            minHeight: 35,
            cornerRadius: 6,
            activeBgColor: [Palette.cumbiaDark],
            activeFgColor: Palette.white,
            inactiveBgColor: Palette.grey.withOpacity(0.6),
            inactiveFgColor: Palette.black,
            labels: ['Sí', 'No'],
            onToggle: (index) {
              if (index == 0) {
                colombianProducts = true;
              } else {
                colombianProducts = false;
              }
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
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
                if (category1 == "No especificada") {
                  validateCategory1 = true;
                } else {
                  validateCategory1 = false;
                }
              });
              if (_canPush()) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ContractPage(
                      merchant: Merchant(
                          phoneNumber: widget.merchant.phoneNumber,
                          email: widget.merchant.email,
                          nit: widget.merchant.nit,
                          razonSocial: widget.merchant.razonSocial,
                          instagram: widget.merchant.instagram,
                          webPage: widget.merchant.webPage,
                          category1: category1,
                          category2: category2 == "Opcional" ? "" : category2,
                          colombianProducts: colombianProducts),
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
            percent: 0.75,
            backgroundColor: Palette.grey,
            progressColor: Palette.cumbiaLight,
            center: Text(
              "3 de 4",
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
            "Comercio",
            style: Styles.btnPromoter,
          ),
          const SizedBox(height: 12),
          Text(
            "Elige hasta dos categorías con las que quieras aparecer en Cumbia Live.",
            style: Styles.secondaryLbl,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CumbiaPicker(
              categoryName: category1,
              validateCategory: validateCategory1,
              fontStyle: category1 == "No especificada"
                  ? FontStyle.italic
                  : FontStyle.normal,
              check: category1 == "No especificada" ? false : true,
              onPressed: () {
                showPickerArray(context, true);
              },
              title: "Categoría principal",
              isSelected: category1 == "No especificada" ? false : true,
            ),
          ),
          CumbiaPicker(
            title: "Categoría secundaria",
            categoryName: category2,
            validateCategory: false,
            check: category2 == "Opcional" ? false : true,
            fontStyle:
                category2 == "Opcional" ? FontStyle.italic : FontStyle.normal,
            onPressed: () {
              showPickerArray(context, false);
            },
            isSelected: category2 == "Opcional" ? false : true,
          ),
        ],
      ),
    );
  }

  bool _canPush() {
    return category1 != "No especificada" && category1 != category2;
  }

  showPickerArray(BuildContext context, bool isPrincipal) {
    Picker(
      diameterRatio: 1,
      itemExtent: 40,
      height: MediaQuery.of(context).size.height * 0.3,
      adapter: PickerDataAdapter<String>(
        pickerdata: JsonDecoder().convert(pickerData),
        isArray: true,
      ),
      selectedTextStyle: TextStyle(color: Palette.black),
      onConfirm: (Picker picker, List value) {
        setState(() {
          if (isPrincipal) {
            category1 =
                picker.adapter.text.replaceAll("[", "").replaceAll("]", "");
            validateCategory1 = false;
          } else {
            category2 =
                picker.adapter.text.replaceAll("[", "").replaceAll("]", "");
          }
        });
      },
      confirmText: "Confirmar",
      confirmTextStyle: Styles.txtBtn(),
      cancelText: "Cancelar",
      cancelTextStyle: Styles.txtBtn(),
    ).showModal(context);
  }

  // Descarga las categorías
  void _getCategories() {
    LogMessage.get("CATEGORÍAS");
    References.categorias.get().then((querySnapshot) {
      categories.clear();
      LogMessage.getSuccess("CATEGORÍAS");
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          categories.add(
            doc.data()["name"],
          );
        });
      }
      setState(() {
        pickerData = categories.join("\"\,\"");
        pickerData = "[[\"$pickerData\"]]";
      });
    }).catchError((e) {
      LogMessage.getError("CATEGORÍAS", e);
      setState(() {
        // isLoadingCategoriesLayout = false;
      });
    });
  }
}
