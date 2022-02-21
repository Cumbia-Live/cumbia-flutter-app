import 'dart:io';

import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


import '../q2/widgets/q2_text_field.dart';

class EditVariantScreen extends StatefulWidget {
  EditVariantScreen({Key key, this.product}) : super(key: key);
  Product product;

  @override
  _EditVariantScreenState createState() => _EditVariantScreenState();
}

const _gap12 = SizedBox(height: 12.0);
const _gap20 = SizedBox(height: 20.0);

class _EditVariantScreenState extends State<EditVariantScreen> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController dimensionController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController styleController = TextEditingController();
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
  bool canPushBool = true;
  Product product = Product();

  @override
  void initState() {
    setState(() {
      colorController.text = widget.product.color ?? '';
      dimensionController.text = widget.product.dimension ?? '';
      sizeController.text = widget.product.size ?? '';
      materialController.text = widget.product.material ?? '';
      styleController.text = widget.product.style ?? '';

      heightController.text =
          widget.product.height.toString().replaceAll('.0', '');
      largeController.text =
          widget.product.large.toString().replaceAll('.0', '');
      widthController.text =
          widget.product.width.toString().replaceAll('.0', '');
      weightController.text =
          widget.product.weight.toString().replaceAll('.0', '');

      unitsController.text = widget.product.avaliableUnits.toString();
      priceController.text = widget.product.price.toString();
      setPrice();
      setEmeralds();
      product.auxImage = widget.product.auxImage;

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: Palette.black,
        ),
        backgroundColor: Palette.bgColor,
        elevation: 0,
        title: Text(
          'Variante',
          style: Styles.navTitleLbl,
          textAlign: TextAlign.center,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: CatapultaScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _gap20,
                      Text(
                        'Imagen de variante',
                        style: Styles.txtTitleLbl,
                      ),
                      _gap20,
                      CumbiaImagePicker(
                        onTap: _getImageFromGallery,
                        image: product.auxImage ?? null,
                        onDelete: _getNewImageFromGallery,
                      ),
                      _gap20,
                      CumbiaTextField(
                        controller: colorController,
                        title: 'Variante de color',
                        optional: '(opcional)',
                        placeholder: 'Ej: Rojo',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (t) {
                          _canPush();
                        },
                      ),
                      _gap20,
                      CumbiaTextField(
                        controller: dimensionController,
                        title: 'Tamaño',
                        optional: '(opcional)',
                        placeholder: 'Ej: Grande',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (t) {
                          _canPush();
                        },
                      ),
                      _gap20,
                      CumbiaTextField(
                        controller: sizeController,
                        title: 'Talla',
                        optional: '(opcional)',
                        placeholder: 'Ej: S',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (t) {
                          _canPush();
                        },
                      ),
                      _gap20,
                      CumbiaTextField(
                        controller: materialController,
                        title: 'Material',
                        optional: '(opcional)',
                        placeholder: 'Ej: Algodón',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (t) {
                          _canPush();
                        },
                      ),
                      _gap20,
                      CumbiaTextField(
                        controller: styleController,
                        title: 'Estilo',
                        optional: '(opcional)',
                        placeholder: 'Ej: Clásico',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (t) {
                          _canPush();
                        },
                      ),
                    ],
                  ),
                ),
                CumbiaDivider(
                  margin: const EdgeInsets.symmetric(
                    vertical: 26,
                  ),
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medidas',
                        style: Styles.txtTitleLbl,
                      ),
                      _gap20,
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
                            onChanged: (text) {
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
                            onChanged: (text) {
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
                            onChanged: (text) {
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
                            onChanged: (text) {
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
                              onChanged: (text) {
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
                          'assets/images/emerald.png',
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
                      if (canPushBool) {
                        push();
                      }
                    },
                    canPush: canPushBool,
                    title: 'Guardar cambios',
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

  void push() {
    setState(() {
      product.color = colorController.text.trim() ?? '';
      product.dimension = dimensionController.text.trim() ?? '';
      product.size = sizeController.text.trim() ?? '';
      product.material = materialController.text.trim() ?? '';
      product.style = styleController.text.trim() ?? '';

      product.height = double.parse(heightController.text.trim());
      product.large = double.parse(largeController.text.trim());
      product.weight = double.parse(weightController.text.trim());
      product.width = double.parse(widthController.text.trim());

      product.avaliableUnits = int.parse(unitsController.text.trim());
      product.price = int.parse(priceController.text.trim());
      
    });
    Navigator.pop(context, product);
  }

  void _canPush() {
    if (_formKey.currentState.validate() &&
        (colorController.text.trim() != '' ||
            dimensionController.text.trim() != '' ||
            sizeController.text.trim() != '' ||
            materialController.text.trim() != '' ||
            styleController.text.trim() != '')) {
      setState(() {
        canPushBool = true;
      });
    } else {
      setState(() {
        canPushBool = false;
      });
    }
    print('el estado es: $canPushBool');
  }

  final picker = ImagePicker();

  Future _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        product.auxImage = File(pickedFile.path);
      }
    });
  }

  Future _getNewImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      product.auxImage = null;
      if (pickedFile != null) {
        product.auxImage = File(pickedFile.path);
      }
    });
  }
}
