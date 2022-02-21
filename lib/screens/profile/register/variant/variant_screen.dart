import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VariantScreen extends StatefulWidget {
  VariantScreen({Key key, this.product}) : super(key: key);
  Product product = Product();

  @override
  _VariantScreenState createState() => _VariantScreenState();
}

const _gap20 = SizedBox(height: 20.0);

class _VariantScreenState extends State<VariantScreen> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController dimensionController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController styleController = TextEditingController();
  Product product = Product();
  bool cancPushBool = false;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      product = widget.product;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 0,
        leading: CupertinoNavigationBarBackButton(
          color: Palette.black,
        ),
        title: Text(
          'Variantes del producto',
          style: Styles.navTitleLbl,
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: CatapultaScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CumbiaTextField(
                  controller: colorController,
                  title: 'Variante de color',
                  optional: '(opcional)',
                  placeholder: 'Ej: Rojo',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (t){
                    canPush();
                  },
                ),
                _gap20,
                CumbiaTextField(
                  controller: dimensionController,
                  title: 'Variante de tamaño',
                  optional: '(opcional)',
                  placeholder: 'Ej: Grande',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (t){
                    canPush();
                  },
                ),
                _gap20,
                CumbiaTextField(
                  controller: sizeController,
                  title: 'Variante de talla',
                  optional: '(opcional)',
                  placeholder: 'Ej: S',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (t){
                    canPush();
                  },
                ),
                _gap20,
                CumbiaTextField(
                  controller: materialController,
                  title: 'Variante de material',
                  optional: '(opcional)',
                  placeholder: 'Ej: Algodón',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (t){
                    canPush();
                  },
                ),
                _gap20,
                CumbiaTextField(
                  controller: styleController,
                  title: 'Variante de estilo',
                  optional: '(opcional)',
                  placeholder: 'Ej: Clásico',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (t){
                    canPush();
                  },
                ),
                _gap20,
                _gap20,
                CatapultaSpace(),
                CumbiaButton(
                  onPressed: (){
                    if(cancPushBool){
                      push();
                    }
                  },
                  title: 'Finalizar registro de variantes',
                  canPush: cancPushBool,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void push() {
    setState(() {
      product.color = colorController.text.trim() ?? '';
      product.dimension = dimensionController.text.trim() ?? '';
      product.size = sizeController.text.trim() ?? '';
      product.material = materialController.text.trim() ?? '';
      product.style = styleController.text.trim() ?? '';
    });
    Navigator.pop(context, product);
  }

  void canPush() {
    if (colorController.text.trim() != '' ||
        dimensionController.text.trim() != '' ||
        sizeController.text.trim() != '' ||
        materialController.text.trim() != '' ||
        styleController.text.trim() != '') {
          setState(() {
            cancPushBool = true;
          });
        }else{
          setState(() {
            cancPushBool = false;
          });
        }
  }
  @override
  void dispose() {
    colorController.dispose();
    dimensionController.dispose();
    sizeController.dispose();
    materialController.dispose();
    styleController.dispose();
    
    super.dispose();
  }
}
