import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddUnitsScreen extends StatefulWidget {
  AddUnitsScreen({Key key, @required this.product}) : super(key: key);
  Product product;
  @override
  _AddUnitsScreenState createState() => _AddUnitsScreenState();
}

const gap18 = SizedBox(height: 18.0);

class _AddUnitsScreenState extends State<AddUnitsScreen> {
  final TextEditingController unitsController = TextEditingController();
  bool isLoadingBtn = false;
  int auxInt = 0;
  bool canPushBool = false;
  Product productAux;
  @override
  void initState() {
    setState(() {
      unitsController.text = '0';
      productAux = widget.product;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Palette.bgColor,
       // actionsForegroundColor: Palette.black,
        border: Border.all(color: Palette.transparent),
        middle: Text(
          'Actualizar existencias',
          style: Styles.navTitleLbl,
        ),
      ),
      body: CatapultaScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.productName,
                  style: TextStyle(
                    color: Palette.darkGrey,
                    fontSize: 14,
                  ),
                ),
                variantLabel(widget.product) == ''
                    ? SizedBox.shrink()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          variantLabel(widget.product),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Palette.cumbiaGrey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        child: Image.network(
                          widget.product.imageUrl ??
                              'https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2FliveImage.png?alt=media&token=d9c84a2f-92e8-4f4f-9f79-17b82c992016',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: unitsController.text,
                        onChanged: (text) {
                          _canPush();
                          print(unitsController.text);
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
                            onPressed: (){
                              removeValue();
                              _canPush();
                            },
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
                            onPressed: (){
                              addValue();
                              _canPush();
                            },
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
                CatapultaSpace(),
                CumbiaButton(
                  onPressed: () {
                    _updateUser();
                  },
                  title: 'Actualizar',
                  isLoading: isLoadingBtn,
                  canPush: canPushBool,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _canPush() {
    if (auxInt > 0) {
      setState(() {
        canPushBool = true;
      });
    }
  }

  String variantLabel(Product product) {
    // ignore: lines_longer_than_80_chars
    return '${product.color.isNotEmpty ? '${product.color}/' : ''}${product.dimension.isNotEmpty ? '${product.dimension}/' : ''}${product.size.isNotEmpty ? '${product.size}/' : ''}${product.material.isNotEmpty ? '${product.material}/' : ''}${product.style.isNotEmpty ? '${product.style}/' : ''}';
  }

  String addValue() {
    if (unitsController.text == '' || unitsController.text == null) return null;
    auxInt = int.parse(unitsController.text);
    print(auxInt);
    auxInt++;
    var auxString = auxInt.toString();
    return unitsController.text = auxString;
  }

  String removeValue() {
    if (unitsController.text == '' || unitsController.text == null) return null;
    auxInt = int.parse(unitsController.text);

    if (auxInt == 1) return null;
    print(auxInt);

    auxInt--;

    var auxString = auxInt.toString();
    return unitsController.text = auxString;
  }

  void _updateUser() {
    setState(() {
      isLoadingBtn = true;
    });
    Map<String, dynamic> productMap = {
      "avaliableUnits": int.parse(unitsController.text.trim()),
     
    };
    print("⏳ ACTUALIZARÉ PRODUCT");
    References.products
        .doc(widget.product.id)
        .update(productMap)
        .then((r) async {
      print("✔ PRODUCT ACTUALIZADO");
      setState(() {
        isLoadingBtn = false;
        productAux.isSelected = true;
        productAux.avaliableUnits = int.parse(unitsController.text.trim());
      });
      Navigator.pop(context, productAux);
    }).catchError((e) {
      setState(() {
        isLoadingBtn = false;
      });

      print("💩️ ERROR AL ACTUALIZAR PRODUCT: $e");
    });
  }
}
