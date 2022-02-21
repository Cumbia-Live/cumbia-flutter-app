import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:cumbialive/model/product/product.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({@required this.product});

  final Product product;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Palette.bgColor,
      appBar: AppBar(
        // Título centrado
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.product.productName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        //color de fondo
        backgroundColor: Palette.cumbiaSeller,
        // Establecer la imagen de la pantalla frontal
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Palette.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        // Coloca el icono detrás
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart_sharp),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => Q1ShoppingCartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        width: double.maxFinite,
                        child: Stack(
                          children: [
                            Card(
                              color: Palette.cumbiaDark,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.all(20),
                              // Dentro de esta propiedad usamos ClipRRect
                              child: ClipRRect(
                                // Los bordes del contenido del card se cortan usando BorderRadius
                                borderRadius: BorderRadius.circular(20),
                                // EL widget hijo que será recortado segun la propiedad anterior
                                child: Column(
                                  children: <Widget>[
                                    // Usamos el widget Image para mostrar una imagen
                                    Container(
                                      child: Image(
                                        // Como queremos traer una imagen desde un url usamos NetworkImage
                                        image: NetworkImage(
                                            widget.product.imageUrl),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                    ),
                                    // Usamos Container para el contenedor de la descripción
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Precio",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Palette.white,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${widget.product.price.toString()} COP ",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                  color: Palette.white,
                                                ),
                                              ),
                                              Image.asset(
                                                'images/emerald.png',
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.contain,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.productName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.cumbiaSeller,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                width: 0,
                              ),
                              Text(
                                "Descripción",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Palette.cumbiaSeller,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.product.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Palette.cumbiaIconGrey,
                                ),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(
                            left: 20,
                            bottom: 10,
                            top: 20,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Color",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Palette.cumbiaSeller,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      widget.product.color.isEmpty
                                          ? "No especifica"
                                          : widget.product.color,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Palette.cumbiaIconGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tamaño",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Palette.cumbiaSeller,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      widget.product.dimension.isEmpty
                                          ? "No especifica"
                                          : widget.product.dimension,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Palette.cumbiaIconGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                              width: 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Talla",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Palette.cumbiaSeller,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      widget.product.size.isEmpty
                                          ? "No especifica"
                                          : widget.product.size,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Palette.cumbiaIconGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Material",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Palette.cumbiaSeller,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      widget.product.material.isEmpty
                                          ? "No especifica"
                                          : widget.product.material,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Palette.cumbiaIconGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(
                          left: 50,
                          right: 50,
                          bottom: 20,
                          top: 20,
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Calificación',
                              style: TextStyle(
                                fontSize: 16,
                                color: Palette.cumbiaSeller,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Expanded(child: printStars(0.0, 5.0, context)),
                                Column(
                                  children: [
                                    Text(
                                      "0.0",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Palette.cumbiaLight,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        '0 calificaciones',
                                        style: TextStyle(
                                            color: Palette.cumbiaLight),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Reseñas del producto',
                              style: TextStyle(
                                fontSize: 16,
                                color: Palette.cumbiaSeller,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 25,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                      ),
                      SizedBox(height: 50.0),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: FlatButton(
                      color: Palette.cumbiaCian,
                      textColor: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: MediaQuery.of(context).size.width - 50,
                        height: 48,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: shoppingCart.list
                                          .where((element) =>
                                              element.id == widget.product.id)
                                          .isNotEmpty
                                      ? 'Agregado al carro  '
                                      : 'Agregar al carro  ',
                                  style: Styles.btn,
                                ),
                                WidgetSpan(
                                  child: Icon(Icons.shopping_cart_rounded,
                                      size: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onPressed: () {
                        if (shoppingCart.list
                            .where((element) => element.id == widget.product.id)
                            .isNotEmpty) {
                          showConfirmAlert(context, 'Ups!',
                              'El producto ya se encuentra en el carro', () {});
                        } else {
                          setState(() {
                            shoppingCart.list.add(widget.product);
                          });
                        }
                        // shoppingCart.list.add(widget.product);
                        // showNotification("Carro de Compras",
                        //     "Has agregado el producto al carro de compras");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget printStars(double stars, double maxStars, BuildContext context) {
    List<Widget> list = [];
    double aux = stars;
    double count = 0;

    while (count < maxStars) {
      if (aux - 1 >= 0) {
        list.add(Icon(
          Icons.star,
          color: Palette.cumbiaLight,
          size: MediaQuery.of(context).size.width / 10,
        ));
        aux--;
      } else if (aux - 0.5 >= 0) {
        list.add(Icon(
          Icons.star_half,
          color: Palette.cumbiaLight,
          size: MediaQuery.of(context).size.width / 10,
        ));
        aux -= 0.5;
      } else {
        list.add(Icon(
          Icons.star_border,
          color: Palette.cumbiaLight,
          size: MediaQuery.of(context).size.width / 10,
        ));
      }
      count++;
    }

    return Row(children: list, crossAxisAlignment: CrossAxisAlignment.end);
  }

  Future<Widget> showNotification(String titulo, String cuerpo) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15),
              Text(
                "$titulo",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text("$cuerpo"),
              SizedBox(height: 20),
              Divider(
                height: 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Palette.cumbiaDark,
                ),
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Q1ShoppingCartScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      "continuar al carro",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Palette.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Palette.cumbiaDark,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text(
                      "Seguir mirando",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Palette.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Color _getBGColor() {
  return user.roles.isAdmin ?? false
      ? Palette.cumbiaDark
      : user.roles.isMerchant ?? false
          ? Palette.cumbiaSeller
          : Palette.cumbiaLight;
}
