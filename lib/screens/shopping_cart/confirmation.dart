import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

List<Product> p;
User merchant;
bool animation = true;
Color back = Palette.black;

class Confirmation extends StatefulWidget {
  @override
  _Confirmation createState() => _Confirmation();

  Confirmation(List<Product> product) {
    p = [...product];
  }
}

class _Confirmation extends State<Confirmation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  final notification = LoadUsers();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _Confirmation() {
    animation = true;
    back = Palette.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: back,
      body: !animation
          ? SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: AssetImage(
                                'images/check.png',
                              ),
                              height: MediaQuery.of(context).size.width / 2),
                          SizedBox(height: 20.0),
                          Text(
                            '¡Compra realizada con éxito!',
                            style: TextStyle(
                                color: Palette.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 40.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'Puedes hacer seguimiento a tu compra desde la opción de ',
                                style: TextStyle(color: Palette.cumbiaGrey),
                                children: [
                                  TextSpan(
                                    text: '\"Mis Compras\"',
                                    style: TextStyle(
                                        color: Palette.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' en la sección de ',
                                    style: TextStyle(color: Palette.cumbiaGrey),
                                  ),
                                  TextSpan(
                                    text: 'perfil.',
                                    style: TextStyle(
                                        color: Palette.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          CumbiaButton(
                            onPressed: () {
                              traerTienda();
                            },
                            title: 'Ver más tiendas',
                            backgroundColor: Palette.cumbiaLight,
                            canPush: true,
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('Productos adquiridos',
                            style: TextStyle(
                                color: Palette.cumbiaGrey, fontSize: 18.0)),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          height: 100.0,
                          child: PageView(
                            children: getProductsCard(),
                            controller: PageController(
                                initialPage: 0, viewportFraction: 0.8),
                            pageSnapping: false,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          : SafeArea(
              child: Expanded(
                child: Center(
                  child: Container(
                    child: getAnimation(),
                  ),
                ),
              ),
            ),
    );
  }

  void traerTienda() {
    List<User> usersList = [];
    LogMessage.get("USERS");
    References.users.get().then((querySnapshot) {
      LogMessage.getSuccess("USERS");
      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((userDoc) {
            usersList.add(
              User(
                id: userDoc.id,
                profilePictureURL: userDoc.data()['profilePictureURL'],
                name: userDoc.data()['name'],
                username: userDoc.data()['username'],
                email: userDoc.data()['email'],
                addresses: userDoc.data()["addresses"]
                    .map(
                      (addressMap) => Address(
                        address: addressMap['address'],
                        city: addressMap['city'],
                        country: addressMap['country'],
                        isPrincipal: addressMap['isPrincipal'],
                      ),
                    )
                    .toList(),
                emeralds: userDoc.data()["esmeraldas"],
                phoneNumber: PhoneNumberCumbia(
                  dialingCode: userDoc.data()["phoneNumber"]["dialingCode"],
                  basePhoneNumber: userDoc.data()["phoneNumber"]
                      ["basePhoneNumber"],
                ),
                roles: UserRoles(
                  isMerchant: userDoc.data()["roles"]["isMerchant"],
                ),
              ),
            );
          });
        }

        usersList.forEach((user) {
          p.forEach((product) {
            if (product.uid == user.id) {
              notification.sendNotificationBuyProductToken(user);
            }
          });
        });
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => NavScreen(),
          ),
        );
      });
    }).catchError((e) {
      LogMessage.getError("USERS", e);
    });
  }

  int totalEmeralds() {
    int sum = 0;
    for (Product pro in p) {
      sum += pro.price * pro.unitsCarrito;
    }

    return sum;
  }

  Widget getAnimation() {
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          animation = false;
          back = Palette.cumbiaSeller;
        });
      }
    });
    return Lottie.asset(
      'animations/cocumbia.json',
      controller: controller,
      onLoaded: (composition) {
        controller
          ..duration = composition.duration
          ..forward();
      },
    );
    // int aux = totalEmeralds();
    // print(aux);
    // if (aux >= 100 && aux <= 1000) {
    //   return Lottie.asset(
    //     'animations/cumbianisimo.json',
    //     controller: controller,
    //     onLoaded: (composition) {
    //       controller
    //         ..duration = composition.duration
    //         ..forward();
    //     },
    //   );
    // } else if (aux >= 1100 && aux <= 10000) {
    //   return Lottie.asset(
    //     'animations/cocumbia.json',
    //     controller: controller,
    //     onLoaded: (composition) {
    //       controller
    //         ..duration = composition.duration
    //         ..forward();
    //     },
    //   );
    // } else if (aux >= 10100 && aux <= 200000) {
    //   return Lottie.asset(
    //     'animations/jaguar.json',
    //     controller: controller,
    //     onLoaded: (composition) {
    //       controller
    //         ..duration = composition.duration
    //         ..forward();
    //     },
    //   );
    // } else if (aux >= 200100 && aux <= 500000) {
    //   return Lottie.asset(
    //     'animations/colibri.json',
    //     controller: controller,
    //     onLoaded: (composition) {
    //       controller
    //         ..duration = composition.duration
    //         ..forward();
    //     },
    //   );
    // } else if (aux >= 500100 && aux <= 1500000) {
    //   return Lottie.asset(
    //     'animations/mono.json',
    //     controller: controller,
    //     onLoaded: (composition) {
    //       controller
    //         ..duration = composition.duration
    //         ..forward();
    //     },
    //   );
    // } else {
    //   return Lottie.asset(
    //     'animations/mariposa.json',
    //     controller: controller,
    //     onLoaded: (composition) {
    //       controller
    //         ..duration = composition.duration
    //         ..forward();
    //     },
    //   );
    // }
  }

  List<Widget> getProductsCard() {
    List<Widget> list = [];
    for (Product pr in p) {
      list.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Palette.white, width: 1.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 76,
                  height: 76,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(pr.imageUrl,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 180),
                            child: Text(
                              pr.productName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Palette.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: 180),
                            child: Text(
                              pr.color == "No especifica" &&
                                      pr.dimension == "No especifica" &&
                                      pr.size == "No especifica"
                                  ? "No especifica"
                                  : pr.color == "" &&
                                          pr.dimension == "" &&
                                          pr.size == ""
                                      ? "No especifica"
                                      : pr.color == "No especifica" ||
                                              pr.color == ""
                                          ? "${pr.dimension}/${pr.size}"
                                          : pr.dimension == "No especifica" ||
                                                  pr.dimension == ""
                                              ? "${pr.color}/${pr.size}"
                                              : pr.size == "No especifica" ||
                                                      pr.size == ""
                                                  ? "${pr.color}/${pr.dimension}"
                                                  : "${pr.color}/${pr.dimension}/${pr.size}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Palette.cumbiaGrey,
                                fontSize: 12.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${pr.price.toString()} COP ",
                            style: TextStyle(
                              color: Palette.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                          Image(
                              image: AssetImage('images/emerald.png'),
                              height: 20.0),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ));
    }
    return list;
  }
}
