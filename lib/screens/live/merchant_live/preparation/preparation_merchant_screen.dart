import 'dart:convert';
import 'dart:io';
import 'package:cumbialive/model/models.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreparationMerchantScreen extends StatefulWidget {
  @override
  _PreparationMerchantScreenState createState() => _PreparationMerchantScreenState();
}

class _PreparationMerchantScreenState extends State<PreparationMerchantScreen>
    with AutomaticKeepAliveClientMixin<PreparationMerchantScreen> {
  final picker = ImagePicker(); // Picker de imágenes del dispositivo
  File helperImageFile;
  Live live = Live();  
  String category = "No especificada"; // Categoría elegida por el usuario
  String title = ""; // Descripción del en vivo
  String pickerData = "";
  List<String> categoriesPicker = [];

  /// Validadores
  String validationDescription;
  bool validationImagen = false;
  bool validateCategory = false;
  bool isLoading = false;
  String liveId;
  @override
  void initState() {
    // TODO: implement initState
    _getCategories();

    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        backgroundColor: Palette.bgColor,
        //actionsForegroundColor: Palette.black,
        border: Border.all(color: Palette.transparent),
        middle: Text(
          "Go Live",
          style: Styles.navTitleLbl,
        ),
      ),
      body: CatapultaScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Miniatura",
                style: Styles.txtTitleLbl,
              ),
              const SizedBox(height: 8),
              Text(
                "Toma una foto horizontal para que tus espectadores puedan verla antes de entrar al livestream.",
                style: Styles.secondaryLbl,
              ),
              const SizedBox(height: 16),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _alertImagePicker,
                child: Container(
                  height: (MediaQuery.of(context).size.width - 32) * 9 / 16,
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    color: helperImageFile == null
                        ? Palette.skeleton
                        : Palette.transparent,
                    image: helperImageFile == null
                        ? null
                        : DecorationImage(
                            image: FileImage(helperImageFile),
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                  child: helperImageFile == null
                      ? Center(
                          child: Text(
                            "Toca para tomar una foto",
                            style: TextStyle(
                              fontSize: 15,
                              color: validationImagen
                                  ? Palette.red
                                  : Palette.black.withOpacity(0.25),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 32),
              CumbiaTextField(
                title: "Título",
                placeholder: "Mi Livestream Genial",
                validationText: validationDescription,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (text) {
                  setState(() {
                    title = text;
                  });
                  if (title.length > 0) {
                    setState(() {
                      validationDescription = "";
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              CumbiaPicker(
                categoryName: category,
                validateCategory: validateCategory,
                fontStyle: category == "No especificada"
                    ? FontStyle.italic
                    : FontStyle.normal,
                check: category == "No especificada" ? false : true,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  showPickerArray(context);
                },
                isSelected: category == "No especificada" ? false : true,
              ),
              const SizedBox(height: 20),
              const CatapultaSpace(),
              CumbiaButton(
                title: "Seleccionar productos",
                canPush: cansPush(),
                isLoading: isLoading,
                onPressed: () {
                  if (title == "" || title == null) {
                    setState(() {
                      validationDescription = "Por favor, rellena este campo.";
                    });
                  } else {
                    setState(() {
                      validationDescription = "";
                    });
                  }

                  if (category == "No especificada" || category == null) {
                    setState(() {
                      validateCategory = true;
                    });
                  } else {
                    setState(() {
                      validateCategory = false;
                    });
                  }

                  if (helperImageFile == null) {
                    setState(() {
                      validationImagen = true;
                    });
                  }

                  if (cansPush()) {
                    _onJoin();
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// ::::::::::::: FUNCTIONS ::::::::::::: ///

  bool cansPush() {
    return title != "" &&
        title != null &&
        category != "No especificada" &&
        category != null &&
        helperImageFile != null;
  }

  void _alertImagePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text("Tomar foto"),
            onPressed: () {
              Navigator.pop(context);
              _getImageFromCamera();
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Volver"),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Future _getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        helperImageFile = File(pickedFile.path);
        validationImagen = false;
      }
    });
  }

  showPickerArray(BuildContext context) {
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
          category =
              picker.adapter.text.replaceAll("[", "").replaceAll("]", "");
          validateCategory = false;
        });
      },
      confirmText: "Confirmar",
      confirmTextStyle: Styles.txtBtn(),
      cancelText: "Cancelar",
      cancelTextStyle: Styles.txtBtn(),
    ).showModal(context);
  }

  /// ::::::::::::: BACK ::::::::::::: ///




  void _onJoin() {
    setState(() {
      live.auxImage = helperImageFile;
      live.labelLive = title;
      live.categoryLive = LiveCategory(name: category);
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseProductsScreen(live: live,),
      ),
    );
  }

  // Descarga las categorías
  void _getCategories() {
    LogMessage.get("CATEGORÍAS");
    References.categorias.get().then((querySnapshot) {
      categories.clear();
      LogMessage.getSuccess("CATEGORÍAS");
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          categoriesPicker.add(
            doc.data()["name"],
          );
        });
      }
      setState(() {
        pickerData = categoriesPicker.join("\"\,\"");
        pickerData = "[[\"$pickerData\"]]";
        print(pickerData);
      });
    }).catchError((e) {
      LogMessage.getError("CATEGORÍAS", e);
      setState(() {
        // isLoadingCategoriesLayout = false;
      });
    });
  }
}
