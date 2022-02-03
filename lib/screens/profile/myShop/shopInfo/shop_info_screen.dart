import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/components/components.dart';

Merchant merchant;
bool colP;

class ShopInfoScreen extends StatefulWidget {
  @override
  _ShopInfoScreenState createState() => _ShopInfoScreenState();

  ShopInfoScreen(Merchant mer) {
    merchant = mer;
    colP = merchant.colombianProducts;
  }
}

class _ShopInfoScreenState extends State<ShopInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController(text: merchant.shopName);
  final TextEditingController usernameController =
      TextEditingController(text: user.username);
  final TextEditingController phoneController =
      TextEditingController(text: user.phoneNumber.basePhoneNumber);
  final TextEditingController pickUpPointController =
      TextEditingController(text: merchant.pickUpPoint);
  final TextEditingController category1Controller =
      TextEditingController(text: merchant.category1);
  final TextEditingController category2Controller =
      TextEditingController(text: merchant.category2);
  final TextEditingController instagramController =
      TextEditingController(text: merchant.instagram);
  final TextEditingController webPageController =
      TextEditingController(text: merchant.webPage);

  bool canPush = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.white,
        middle: Text(
          'Datos de tienda',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        backgroundColor: _getBGColor(),
      ),
      body: SafeArea(
        child: Container(
          child: CatapultaScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0),
                        Text('Identificación', style: Styles.titleLbl),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          placeholder: 'Ingresa un nombre',
                          controller: nameController,
                          onChanged: _canPush,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor, rellena este campo';
                            } else {
                              return null;
                            }
                          },
                          title: 'Nombre de la tienda',
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'NIT',
                          style: Styles.txtTitleLbl,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Text(
                            merchant.nit,
                            style: Styles.txtTitleLbl.copyWith(fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          prefixText: '@',
                          placeholder: 'Usuario',
                          onChanged: _canPush,
                          controller: usernameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor, rellena este campo';
                            } else if (value.length < 6 || value.length > 12) {
                              return 'El usuario debe tener una longitud de 6 a 12 caracteres';
                            } else {
                              return null;
                            }
                          },
                          title: 'Nombre de usuario',
                        ),
                        SizedBox(height: 60.0),
                        Text('Contacto', style: Styles.titleLbl),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          keyboardType: TextInputType.phone,
                          placeholder: 'Ingresa un numero celular',
                          prefixText: '${user.phoneNumber.dialingCode} ',
                          onChanged: _canPush,
                          controller: phoneController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor, rellena este campo';
                            } else if (value.length < 10) {
                              return 'Debe tener al menos 10 números';
                            } else {
                              return null;
                            }
                          },
                          title: 'Celular',
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Correo electrónico',
                          style: Styles.txtTitleLbl,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Text(
                            user.email,
                            style: Styles.txtTitleLbl.copyWith(fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        merchant.pickUpPoint != null
                            ? CumbiaTextField(
                                placeholder: 'Ingresa una dirección',
                                onChanged: _canPush,
                                controller: pickUpPointController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor, rellena este campo';
                                  } else {
                                    return null;
                                  }
                                },
                                title: 'Lugar de recogida',
                              )
                            : buttonItem('pickUpPoint', 'un lugar de recogida',
                                'Lugar de recogida'),
                        SizedBox(height: 60.0),
                        Text('Comercio', style: Styles.titleLbl),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          placeholder: 'Especifica una categoría',
                          onChanged: _canPush,
                          controller: category1Controller,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor, rellena este campo';
                            } else {
                              return null;
                            }
                          },
                          title: 'Categoría principal',
                        ),
                        SizedBox(height: 20.0),
                        merchant.category2 != null
                            ? CumbiaTextField(
                                placeholder: 'Especifica una categoría',
                                onChanged: _canPush,
                                controller: category2Controller,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor, rellena este campo';
                                  } else {
                                    return null;
                                  }
                                },
                                title: 'Categoría secundaria',
                              )
                            : buttonItem('category2', 'una categoría',
                                'Categoría secundaria'),
                        SizedBox(height: 20.0),
                        Text(
                          'Productos colombianos',
                          style: Styles.txtTitleLbl,
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Row(
                            children: [
                              Expanded(
                                  child: get1OptionButton('Si', !colP, () {
                                setState(() {
                                  colP = true;
                                });
                              })),
                              Expanded(
                                  child: get1OptionButton('No', colP, () {
                                setState(() {
                                  colP = false;
                                });
                              }))
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Productos registrados',
                          style: Styles.txtTitleLbl,
                        ),
                        SizedBox(height: 5.0),
                        GestureDetector(
                          onTap: () {},
                          child: Card(
                            color: Palette.cumbiaDark,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ir a Mis productos', style: Styles.btn),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Palette.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 60.0),
                        Text('Portafolio', style: Styles.titleLbl),
                        SizedBox(height: 20.0),
                        merchant.instagram != null
                            ? CumbiaTextField(
                                prefixText: '@',
                                placeholder: 'Usuario',
                                onChanged: _canPush,
                                controller: instagramController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor, rellena este campo';
                                  } else {
                                    return null;
                                  }
                                },
                                title: 'Usuario de instagram',
                              )
                            : buttonItem('instagram', 'un usuario de instagram',
                                'Usuario de instagram'),
                        SizedBox(height: 20.0),
                        merchant.webPage != null
                            ? CumbiaTextField(
                                placeholder: 'Ingresa la dirección',
                                onChanged: _canPush,
                                controller: webPageController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor, rellena este campo';
                                  } else {
                                    return null;
                                  }
                                },
                                title: 'Web',
                              )
                            : buttonItem('web', 'una página web', 'Web'),
                        SizedBox(height: 30.0),
                        CumbiaButton(
                          title: 'Guardar cambios',
                          onPressed: () async {
                            if (canPush) {
                              showConfirmAlert(
                                context,
                                'Actualizando información',
                                'Su información se actualizó exitosamente.',
                                () {
                                  updateData();
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          },
                          canPush: canPush,
                          backgroundColor: _getBGColor(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get1OptionButton(title, canPush, onPressed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 35,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: !canPush ? Palette.cumbiaDark : Palette.grey,
          ),
          child: Stack(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Center(
                  child: Text(
                    title ?? "Continuar",
                    style: Styles.btn,
                  ),
                ),
                onPressed: canPush
                    ? () {
                        onPressed();
                      }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buttonItem(campo, textButton, title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.txtTitleLbl,
        ),
        SizedBox(height: 5.0),
        Container(
          height: 62.0,
          decoration: BoxDecoration(
            color: Palette.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: DottedBorder(
            padding: EdgeInsets.zero,
            strokeWidth: 2.0,
            dashPattern: [3, 3],
            color: Palette.cumbiaGrey,
            borderType: BorderType.RRect,
            radius: const Radius.circular(8.0),
            child: RaisedButton(
              padding: EdgeInsets.zero,
              color: Palette.transparent,
              textColor: Palette.cumbiaGrey,
              disabledColor: Palette.transparent,
              disabledTextColor: Palette.cumbiaGrey,
              elevation: 0,
              onPressed: () {
                setState(() {
                  if (campo == 'category2') {
                    merchant.category2 = '';
                  } else if (campo == 'instagram') {
                    merchant.instagram = '';
                  } else if (campo == 'web') {
                    merchant.webPage = '';
                  } else if (campo == 'pickUpPoint') {
                    merchant.pickUpPoint = '';
                  }
                });
              },
              child: Center(
                child: Text(
                  'Toca para agregar $textButton',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _canPush(String value) {
    setState(() {
      if (_formKey.currentState.validate()) {
        canPush = true;
      } else {
        canPush = false;
      }
    });
  }

  Color _getBGColor() {
    return user.roles.isAdmin
        ? Palette.cumbiaDark
        : user.roles.isMerchant
            ? Palette.cumbiaSeller
            : Palette.cumbiaLight;
  }

  Future<void> updateData() async {
    await References.users.doc(user.id).update({
      'username': usernameController.text.trim(),
      'phoneNumber': {
        'basePhoneNumber': phoneController.text.trim(),
        'dialingCode': user.phoneNumber.dialingCode
      },
    });

    var document;
    await References.merchant
        .where('userId', isEqualTo: user.id)
        .get()
        .then((value) => document = value.docs.first.id)
        .then((value) => {
              References.merchant.doc(document).update({
                'shopName': nameController.text.trim(),
                'phoneNumber': phoneController.text.trim(),
                'pickUpPoint': pickUpPointController.text.trim() == ''
                    ? null
                    : pickUpPointController.text.trim(),
                'principalCategory': category1Controller.text.trim(),
                'secondaryCategory': category2Controller.text.trim() == ''
                    ? null
                    : category2Controller.text.trim(),
                'colombianProducts': colP,
                'instagram': instagramController.text.trim() == ''
                    ? null
                    : instagramController.text.trim(),
                'webPage': webPageController.text.trim() == ''
                    ? null
                    : webPageController.text.trim(),
              })
            });
  }
}
