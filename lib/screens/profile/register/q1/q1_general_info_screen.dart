import 'dart:io';

import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../screens.dart';



class Q1GeneralInfoScreen extends StatefulWidget {
  Q1GeneralInfoScreen({Key key}) : super(key: key);

  @override
  _Q1GeneralInfoScreenState createState() => _Q1GeneralInfoScreenState();
}

const _gap20 = SizedBox(height: 20.0);

class _Q1GeneralInfoScreenState extends State<Q1GeneralInfoScreen> {
  File _image;
  Product product = Product();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool canPushBool = false;

  @override
  void initState() {
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
                percent: 0.33,
                step: '1 de 3',
                text: 'Registro de producto',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. Información general del producto',
                      style: Styles.titleRegister,
                    ),
                    _gap20,
                    Text(
                      'Imagen principal del producto',
                      style: Styles.labelRegister,
                    ),
                    SizedBox(height: 15.0),
                    CumbiaImagePicker(
                      onTap: _getImageFromGallery,
                      image: product.auxImage ?? null,
                      onDelete: _getNewImageFromGallery,
                    ),
                    _gap20,
                    CumbiaTextField(
                      controller: nameController,
                      title: 'Nombre del producto',
                      placeholder: 'Ej: Camiseta azul',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {
                        _canPush();
                      },
                      validator: (value) {
                        if (value.isNotEmpty) {
                          return null;
                        } else {
                          return 'Por favor, rellena este campo';
                        }
                      },
                    ),
                    _gap20,
                    CumbiaTextField(
                      controller: referenceController,
                      title: 'Referencia',
                      placeholder: 'Ej: Marca de mi empresa',
                      optional: 'Opcional',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    _gap20,
                    CumbiaTextField(
                      controller: descriptionController,
                      title: 'Descripción',
                      placeholder: 'Escribe una breve descripción del producto',
                      optional: '150 caracteres',
                      maxlines: 5,
                      onChanged: (value) {
                        _canPush();
                      },
                      validator: (value) {
                        if (value.isNotEmpty) {
                          return null;
                        } else {
                          return 'Por favor, rellena este campo';
                        }
                      },
                      textInputFormatters: [
                        LengthLimitingTextInputFormatter(150),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ],
                ),
              ),
              CatapultaSpace(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CumbiaButton(
                  onPressed: () async {
                    if (canPushBool) {
                      _push();
                    }
                  },
                  title: 'Siguiente',
                  canPush: canPushBool,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  void _push() {
    setState(() {
      product.productName = nameController.text.trim();
      product.reference = referenceController.text.trim();
      product.description = descriptionController.text.trim();
    });
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Q2ProductDetailScreen(
          product: product,
        ),
      ),
    );
  }

  void _canPush() {
    if (nameController.text != '' && descriptionController.text != '' ) {
      setState(() {
        canPushBool = true;
      });
    } else {
      setState(() {
        canPushBool = false;
      });
    }
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
