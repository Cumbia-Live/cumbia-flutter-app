import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/components/cumbia_radio_button.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


import '../../../screens.dart';
import 'widgets/q2_text_field.dart';

// ignore: must_be_immutable
class Q2ProductDetailScreen extends StatefulWidget {
  Q2ProductDetailScreen({Key key, this.product}) : super(key: key);
  Product product;
  @override
  _Q2ProductDetailScreenState createState() => _Q2ProductDetailScreenState();
}

const _gap12 = SizedBox(height: 12.0);
const _gap20 = SizedBox(height: 20.0);

class _Q2ProductDetailScreenState extends State<Q2ProductDetailScreen> {
  Product product = Product();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController largeController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int finalPrice = 0;
  double constCommission = 0.10;
  int emeralds = 0;
  bool canPushBool = false;
  int _groupValue = 1;

  @override
  void initState() {
    product = widget.product;
    setState(() {
      unitsController.text = '0';
      _groupValue =  product.isFreeShipping != null && product.isFreeShipping ? 0 : 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: CatapultaScrollView(
            child: Column(
              children: [
                PercentIndicator(
                  /// onPressed: controller.back,
                  percent: 0.66,
                  step: '2 de 3',
                  text: 'Registro de producto',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2. Detalles del producto',
                        style: Styles.titleRegister,
                      ),
                      _gap20,
                      Text(
                        'Medidas',
                        style: Styles.txtTitleLbl,
                      ),
                      _gap12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Q2TextField(
                            controller: heightController,
                            text1: 'Alto',
                            text2: '(cm)',
                            placeholder: 'Ej: 50',
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                onChanged: (text){
                                  _canPush();
                                },
                            validator: (value) {
                              if (value == '0') {
                                return 'No puede ser 0';
                              } else if (value.isEmpty) {
                                return 'Campo obligatorio';
                              }
                              return null;
                            },
                          ),
                          Q2TextField(
                            controller: largeController,
                            text1: 'Largo',
                            text2: '(cm)',
                            placeholder: 'Ej: 50',
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                 onChanged: (text){
                                  _canPush();
                                },
                                validator: (value) {
                              if (value == '0') {
                                return 'No puede ser 0';
                              } else if (value.isEmpty) {
                                return 'Campo obligatorio';
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                      _gap12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Q2TextField(
                            controller: widthController,
                            text1: 'Ancho',
                            text2: '(cm)',
                            placeholder: 'Ej: 50',
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                 onChanged: (text){
                                  _canPush();
                                },
                                validator: (value) {
                              if (value == '0') {
                                return 'No puede ser 0';
                              } else if (value.isEmpty) {
                                return 'Campo obligatorio';
                              }
                              return null;
                            },
                          ),
                          Q2TextField(
                            controller: weightController,
                            text1: 'Peso',
                            text2: '(kg)',
                            placeholder: 'Ej: 50',
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                 onChanged: (text){
                                  _canPush();
                                },
                                validator: (value) {
                              if (value == '0') {
                                return 'No puede ser 0';
                              } else if (value.isEmpty) {
                                return 'Campo obligatorio';
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 9),
                CumbiaDivider(
                  margin: const EdgeInsets.symmetric(
                    vertical: 26,
                  ),
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: CumbiaTextField(
                              controller: unitsController,
                              title: 'Unidades disponibles',
                              placeholder: 'Ej: 100',
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              initialValue: unitsController.text,
                               onChanged: (text){
                                  _canPush();
                                },
                              validator: (value) {
                              if (value == '0') {
                                return 'No puede ser 0';
                              } else if (value.isEmpty) {
                                return 'Campo obligatorio';
                              }
                              return null;
                            },
                            ),
                          ),
                          Container(
                            height: 55,
                            width: 125,
                            margin: const EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Palette.black.withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              children: [
                                CupertinoButton(
                                  onPressed: removeValue,
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    height: 55,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Palette.black.withOpacity(0.4),
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
                                CupertinoButton(
                                  onPressed: addValue,
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    height: 55,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: Palette.black.withOpacity(0.4),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      _gap20,
                      CumbiaTextField(
                        controller: priceController,
                        title: 'Precio (COP)',
                        placeholder: 'Escribe una cifra',
                        onChanged: (text) {
                          _canPush();

                          setEmeralds();
                          setPrice();
                        },
                        
                        validator: (value) {
                          if (value.isNotEmpty) {
                            return null;
                          } else {
                            return 'Por favor, rellena este campo';
                          }
                        },
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        
                      ),
                      _gap20,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Seleccione el envío",
                          style: Styles.txtTitleLbl.copyWith(
                            // color: isDark?Palette.b5Grey :labelTextColor,
                            //fontSize: sizeLabeltext,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CumbiaRadioButton(
                            title: "Envío gratis",
                            onChanged: (newValue) {
                              _canPush();
                              setState( () {
                                print(_groupValue);
                                product.isFreeShipping = true;
                                _groupValue = newValue;
                              });
                            },
                            groupValue: _groupValue,
                            value: 0,
                          ),
                          CumbiaRadioButton(
                            title: "Envío pagado",
                            onChanged: (newValue) {
                              _canPush();

                              print(_groupValue);

                              setState( () {
                                product.isFreeShipping = false;
                                _groupValue = newValue;
                                print(_groupValue);
                              });
                            },
                            groupValue: _groupValue,
                            value: 1,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                _gap20,
                ListTile(
                  leading: Text(
                    'Comisión Cumbia Live',
                    style: Styles.txtTextLbl(
                      color: Palette.black.withOpacity(0.6),
                    ),
                  ),
                  trailing: Text(
                    '${(constCommission * 100).toInt()}%',
                    style: Styles.txtTextLbl(
                      color: Palette.black.withOpacity(0.6),
                    ),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Precio final (COP)',
                    style: Styles.txtTextLbl(
                      color: Palette.black.withOpacity(0.6),
                    ),
                  ),
                  trailing: Text(
                    NumberFormat.simpleCurrency()
                        .format(
                          finalPrice,
                        )
                        .replaceAll('.00', '')
                        .replaceAll(',', '.'),
                    style: Styles.txtTextLbl(
                      color: Palette.black.withOpacity(0.6),
                    ),
                  ),
                ),
                ListTile(
                  leading: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Row(
                      children: [
                        Text(
                          'Precio final ( ',
                          style: Styles.txtTextLbl(
                            color: Palette.black.withOpacity(0.6),
                          ),
                        ),
                        Image.asset(
                          'images/emerald.png',
                          height: 35,
                        ),
                        Text(
                          ' )',
                          style: Styles.txtTextLbl(
                            color: Palette.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Text(
                    '$emeralds',
                    style: Styles.txtTextLbl(
                        color: Palette.cumbiaDark, weight: FontWeight.bold),
                  ),
                ),
                CatapultaSpace(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CumbiaButton(
                    onPressed: () {
                      if(canPushBool){
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
    );
  }

  String addValue() {
    if (unitsController.text == '' || unitsController.text == null) return null;
    var auxInt = int.parse(unitsController.text);
    auxInt++;
    var auxString = auxInt.toString();
    return unitsController.text = auxString;
  }

  String removeValue() {
    if (unitsController.text == '' || unitsController.text == null) return null;
    var auxInt = int.parse(unitsController.text);

    if (auxInt == 1) return null;
    auxInt--;

    var auxString = auxInt.toString();
    return unitsController.text = auxString;
  }

  void setPrice() {
    setState(() {
      var aux = int.parse(priceController.text.trim());
      finalPrice = (aux + (aux * constCommission).round());
    });
  }

  void setEmeralds() {
    setState(() {
      emeralds = (finalPrice / 10).round();
    });
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
      product.height = double.parse(heightController.text.trim());
      product.large = double.parse(largeController.text.trim());
      product.width = double.parse(widthController.text.trim());
      product.weight = double.parse(weightController.text.trim());
      product.avaliableUnits = int.parse(unitsController.text.trim());
      product.price = int.parse(priceController.text.trim());
      product.emeralds = emeralds;
      product.comission = constCommission;
    });
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Q3ProductVariantScreen(
        product: product,
        ),
      ),
    );
  }
}
