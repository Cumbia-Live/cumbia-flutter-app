import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/config.dart';
import '../../../config/firebase/references.dart';
import '../../../functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/components/components.dart';

List<dynamic> dataAddress = [];
List<Widget> address = [];

bool editAddress = true;

class InfoUserScreen extends StatefulWidget {
  @override
  _InfoUserScreenState createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formAddressKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController(text: user.name);
  final TextEditingController usernameController =
      TextEditingController(text: user.username);
  final TextEditingController phoneController =
      TextEditingController(text: user.phoneNumber.basePhoneNumber);

  bool editAddress = false;
  bool addAddress = false;
  bool canPush = false;
  File auxImage;

  Future<dynamic> _addresses;

  @override
  void initState() {
    super.initState();
    _addresses = getAddressData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.white,
        middle: Text(
          'Editar Perfil',
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
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width / 2.5,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            color: _getBGColor(),
                          )),
                          Expanded(
                              child: Container(
                            color: Colors.transparent,
                          ))
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Container(
                        child: CumbiaImagePicker(
                          onTap: _getImageFromGallery,
                          image: auxImage ?? null,
                          onDelete: _getNewImageFromGallery,
                        ),
                        decoration: BoxDecoration(
                          color: Palette.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: MediaQuery.of(context).size.width / 2.5,
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Identificación', style: Styles.titleLbl),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          placeholder: 'Ingresa tu nombre',
                          controller: nameController,
                          onChanged: _canPush,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor, rellena este campo';
                            } else {
                              return null;
                            }
                          },
                          title: 'Nombre',
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
                        SizedBox(height: 60.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Mis domicilios', style: Styles.titleLbl),
                            GestureDetector(
                              child: editAddress
                                  ? GestureDetector(
                                      child: Text(
                                        "Guardar",
                                        style: TextStyle(
                                            color: Palette.cumbiaLight),
                                      ),
                                      onTap: () {
                                        if (_formAddressKey.currentState
                                            .validate()) {
                                          setState(() {
                                            editAddress = !editAddress;
                                            initAddressList();
                                          });
                                        }
                                      },
                                    )
                                  : GestureDetector(
                                      child: Text(
                                        "Editar",
                                        style: TextStyle(
                                            color: Palette.cumbiaLight),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          editAddress = !editAddress;
                                          initAddressList();
                                        });
                                      },
                                    ),
                            )
                          ],
                        ),
                        FutureBuilder(
                            future: _addresses,
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                return Form(
                                    key: _formAddressKey,
                                    child: Column(children: address));
                              } else {
                                return Text("Cargando domicilios...");
                              }
                            })),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: BoxDecoration(
                            color: editAddress
                                ? Palette.cumbiaLight
                                : Palette.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DottedBorder(
                            padding: EdgeInsets.zero,
                            strokeWidth: 2.0,
                            dashPattern: [3, 3],
                            color: editAddress
                                ? Palette.transparent
                                : Palette.cumbiaGrey,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(8.0),
                            child: RaisedButton(
                              padding: EdgeInsets.zero,
                              color: Palette.transparent,
                              textColor: Palette.white,
                              disabledColor: Palette.transparent,
                              disabledTextColor: Palette.cumbiaGrey,
                              elevation: 0,
                              onPressed: editAddress
                                  ? () {
                                      dataAddress.add({
                                        'country': '',
                                        'city': '',
                                        'address': '',
                                        'isPrincipal': false
                                      });
                                      initAddressList();
                                    }
                                  : null,
                              child: Center(
                                child: Text(
                                  'Toca para agregar otro domicilio',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        CumbiaButton(
                          title: 'Guardar cambios',
                          onPressed: () async {
                            if (editAddress) {
                              showBasicAlert(context, 'Error',
                                  'Primero debes guardar los cambios a los domicilios');
                            } else {
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

  Widget _createAddressItem(
      String country, String city, String address, bool isPrincipal, int id) {
    var countryController = TextEditingController(text: country);
    var cityController = TextEditingController(text: city);
    var addressController = TextEditingController(text: address);

    return Column(
      children: [
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isPrincipal
                ? Text(
                    'Domicilio Principal',
                    style: Styles.txtTitleLbl.copyWith(
                        color: Palette.cumbiaLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  )
                : Text(
                    'Domicilio ${id + 1}',
                    style: Styles.txtTitleLbl.copyWith(fontSize: 18.0),
                  ),
            editAddress
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isPrincipal) {
                          showBasicAlert(context, 'Error',
                              'No puedes eliminar el domicilio principal');
                        } else {
                          dataAddress.removeAt(id);
                          initAddressList();
                        }
                      });
                    },
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Palette.transparent,
                          ),
                          onPressed: null,
                        ),
                        Text('Eliminar', style: TextStyle(color: Palette.red)),
                        Icon(Icons.close, color: Palette.red)
                      ],
                    ),
                  )
                : isPrincipal
                    ? IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Palette.cumbiaLight,
                        ),
                        onPressed: null,
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Palette.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            for (var i = 0; i < dataAddress.length; i++) {
                              dataAddress[i]['isPrincipal'] = false;
                            }
                            dataAddress[id]['isPrincipal'] = true;

                            initAddressList();
                          });
                        })
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CumbiaTextField(
                controller: countryController,
                onChanged: (value) {
                  dataAddress[id]['country'] = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo vacio';
                  } else {
                    return null;
                  }
                },
                placeholder: 'País',
                title: 'País',
                labelTextColor: isPrincipal ? Palette.cumbiaLight : null,
                sizeLabeltext: 12.0,
                enabled: editAddress,
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: CumbiaTextField(
                controller: cityController,
                onChanged: (value) {
                  dataAddress[id]['city'] = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo vacio';
                  } else {
                    return null;
                  }
                },
                placeholder: 'Ciudad',
                title: 'Ciudad',
                labelTextColor: isPrincipal ? Palette.cumbiaLight : null,
                sizeLabeltext: 12.0,
                enabled: editAddress,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        CumbiaTextField(
          controller: addressController,
          onChanged: (value) {
            dataAddress[id]['address'] = value;
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Campo vacio';
            } else {
              return null;
            }
          },
          placeholder: 'Dirección',
          title: 'Dirección',
          labelTextColor: isPrincipal ? Palette.cumbiaLight : null,
          sizeLabeltext: 12.0,
          enabled: editAddress,
        ),
      ],
    );
  }

  void initAddressList() {
    setState(() {
      address.clear();
      for (var i = 0; i < dataAddress.length; i++) {
        address.add(_createAddressItem(
            dataAddress[i]['country'].toString(),
            dataAddress[i]['city'].toString(),
            dataAddress[i]['address'].toString(),
            dataAddress[i]['isPrincipal'] as bool,
            i));
        address.add(SizedBox(height: 20.0));
      }
    });
  }

  Future<dynamic> getAddressData() async {
    List data;
    await References.users.doc(user.id).get().then((value) => {
          data = value.data()['addresses'] as List,
        });

    dataAddress = data;
    initAddressList();

    return 1;
  }

  Future<void> updateData() async {
    await _uploadUserAvatar();

    user.name = nameController.text.trim();
    user.username = usernameController.text.trim();
    user.phoneNumber = PhoneNumberCumbia(
        dialingCode: user.phoneNumber.dialingCode,
        basePhoneNumber: phoneController.text.trim());

    References.users.doc(user.id).update({
      'name': nameController.text.trim(),
      'username': usernameController.text.trim(),
      'addresses': dataAddress,
      'profilePictureURL': user.profilePictureURL,
      'phoneNumber': {
        'basePhoneNumber': phoneController.text.trim(),
        'dialingCode': user.phoneNumber.dialingCode
      },
    });
  }

  final picker = ImagePicker();

  Future _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        auxImage = File(pickedFile.path);
      }
    });
  }

  Future _getNewImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      auxImage = null;
      if (pickedFile != null) {
        auxImage = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadUserAvatar() async {
    if (auxImage != null) {
      var random = Random();
      var snapshot = await FirebaseStorage.instance
          .ref()
          .child('thumbnails/${random.nextInt(1000000000)}')
          .putFile(auxImage)
          .then((snapshot) => ()async{
              if (snapshot.state  == TaskState.success) {
                var avatar = await snapshot.ref.getDownloadURL();
              user.profilePictureURL = avatar.toString();
            } else {
              showBasicAlert(
                context,
                "La foto no se subió",
                "Por favor, intenta de nuevo más tarde.",
              );
            }
      });


    }
  }
}
