import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/profile/admin/earnings_commissions/widgets/commission_label.dart';
import 'package:cumbialive/screens/profile/admin/users_list/widgets/rate_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/components/components.dart';

class UsersDetailScreen extends StatefulWidget {
  UsersDetailScreen({this.user});
  User user;

  @override
  _UsersDetailScreenState createState() => _UsersDetailScreenState();
}

class _UsersDetailScreenState extends State<UsersDetailScreen> {
  List<Merchant> merchants = [];
  Merchant merchant = Merchant(
      rate: Rate(
    rateA: 0,
    rateB: 0,
    rateC: 0,
    rateD: 0,
    rateE: 0,
    rateF: 0,
  ));
  bool isLoadingMerchants = false;
  bool canPushBool = false;
  bool isLoading = false;
  final TextEditingController t1Controller = TextEditingController();
  final TextEditingController t2Controller = TextEditingController();
  final TextEditingController t3Controller = TextEditingController();
  final TextEditingController t4Controller = TextEditingController();
  final TextEditingController t5Controller = TextEditingController();
  final TextEditingController t6Controller = TextEditingController();
  @override
  void initState() {
    _getMerchant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const _styleTitle = TextStyle(
      color: Palette.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    const _styleLabel = TextStyle(
        color: Palette.darkGrey, fontSize: 14, fontWeight: FontWeight.w600);
    const _styleSubLabel = TextStyle(
      color: Palette.black,
      fontSize: 16,
    );
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          color: Palette.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        border: Border.symmetric(),
        middle: Text(
          '@${widget.user.username}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        backgroundColor: widget.user.roles.isMerchant
            ? Palette.userFont
            : Palette.cumbiaLight,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                color: widget.user.roles.isMerchant
                    ? Palette.userFont
                    : Palette.cumbiaLight,
              )),
              Expanded(child: Container(color: Palette.bgColor)),
            ],
          ),
          CatapultaScrollView(
            child: Stack(
              children: [
                Container(color: Palette.bgColor),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: (MediaQuery.of(context).size.width / 3) + 40,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  color: widget.user.roles.isMerchant
                                      ? Palette.userFont
                                      : Palette.cumbiaLight,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: MediaQuery.of(context).size.width / 3,
                              width: MediaQuery.of(context).size.width / 3,
                              child: widget.user.profilePictureURL == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Icon(
                                          Icons.person,
                                          color: Palette.cumbiaGrey,
                                        ),
                                      ),
                                    )
                                  : widget.user.profilePictureURL.isEmpty ??
                                          false
                                      ? Icon(
                                          widget.user.roles.isAdmin ?? false
                                              ? Icons.person
                                              : widget.user.roles.isMerchant ??
                                                      false
                                                  ? Icons.store_mall_directory
                                                  : Icons.person,
                                          color: Palette.cumbiaGrey,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Image.network(
                                                widget.user.profilePictureURL),
                                          ),
                                        ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    isLoadingMerchants
                        ? SizedBox.shrink()
                        : widget.user.roles.isMerchant
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Identificación', style: _styleTitle),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text(
                                        'Tipo de usuario',
                                        style: _styleLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
                                      child: Text(
                                        'Aliado Cumbia',
                                        style: _styleSubLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text(
                                        'Nombre de la tienda',
                                        style: _styleLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
                                      child: Text(
                                        widget.user.name,
                                        style: _styleSubLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text('NIT', style: _styleLabel),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
                                      child: Text(
                                        merchant.nit ?? '...',
                                        style: _styleSubLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text(
                                        'Nombre de usuario',
                                        style: _styleLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 20),
                                      child: Text('@${widget.user.username}',
                                          style: _styleSubLabel),
                                    ),
                                    const SizedBox(height: 10),
                                    Text('Contacto', style: _styleTitle),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child:
                                          Text('Celular', style: _styleLabel),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
                                      child: Text(
                                        widget.user.phoneNumber.basePhoneNumber,
                                        style: _styleSubLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text(
                                        'Correo electrónico',
                                        style: _styleLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
                                      child: Text(
                                        widget.user.email ?? '...',
                                        style: _styleSubLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text(
                                        'Lugar de recogida',
                                        style: _styleLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 20),
                                      child: Text(
                                        merchant.pickUpPoint ?? '...',
                                        style: _styleSubLabel,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text('Comercio', style: _styleTitle),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 10, 5),
                                          child: Text(
                                            'Categoría principal',
                                            style: _styleLabel,
                                          ),
                                        ),
                                        Text(
                                          merchant.category1 ?? '...',
                                          style: _styleSubLabel,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 10, 5),
                                          child: Text(
                                            'Categoría secundaria',
                                            style: _styleLabel,
                                          ),
                                        ),
                                        Text(
                                          merchant.category2 ?? 'N/A',
                                          style: _styleSubLabel,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 10, 5),
                                          child: Text(
                                            'Productos colombianos',
                                            style: _styleLabel,
                                          ),
                                        ),
                                        Text(
                                          merchant.colombianProducts ?? false
                                              ? 'SI'
                                              : 'NO' ?? '...',
                                          style: _styleSubLabel,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text(
                                        'Productos registrados',
                                        style: _styleLabel,
                                      ),
                                    ),
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      child: Container(
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Palette.cumbiaDark,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                'Visitar tienda',
                                                style: TextStyle(
                                                    color: Palette.bgColor,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Icon(
                                                Icons.chevron_right,
                                                size: 30,
                                                color: Palette.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 30),
                                      child:
                                          Text('Tarifas', style: _styleTitle),
                                    ),
                                    CommissionLabel(
                                      controller: t1Controller,
                                      label: '\$100 a \$1.000 COP',
                                      rate: merchant.rate.rateA.toString() ??
                                          "...",
                                      onChanged: (text) {
                                        _canPush();
                                      },
                                    ),
                                    CommissionLabel(
                                      controller: t2Controller,
                                      label: '\$1.100 a \$10.000 COP',
                                      rate: merchant.rate.rateB.toString() ??
                                          "...",
                                      onChanged: (text) {
                                        _canPush();
                                      },
                                    ),
                                    CommissionLabel(
                                      controller: t3Controller,
                                      label: '\$10.100 a \$200.000 COP',
                                      rate: merchant.rate.rateC.toString() ??
                                          "...",
                                      onChanged: (text) {
                                        _canPush();
                                      },
                                    ),
                                    CommissionLabel(
                                      controller: t4Controller,
                                      label: '\$200.100 a \$500.000 COP',
                                      rate: merchant.rate.rateD.toString() ??
                                          "...",
                                      onChanged: (text) {
                                        _canPush();
                                      },
                                    ),
                                    CommissionLabel(
                                      controller: t5Controller,
                                      label: '\$500.100 a \$1\'500.000 COP',
                                      rate: merchant.rate.rateE.toString() ??
                                          "...",
                                      onChanged: (text) {
                                        _canPush();
                                      },
                                    ),
                                    CommissionLabel(
                                      controller: t6Controller,
                                      label: '>\$\'500.100 COP',
                                      rate: merchant.rate.rateF.toString() ??
                                          "...",
                                      onChanged: (text) {
                                        _canPush();
                                      },
                                    ),
                                    CumbiaButton(
                                      onPressed: () {
                                        if (canPushBool) {
                                          _updateConstantRatesDoc();
                                          Navigator.pop(context);
                                        }
                                      },
                                      title: 'Actualizar tarifas',
                                      canPush: canPushBool,
                                      isLoading: isLoading,
                                    ),
                                    const SizedBox(height: 30),
                                    Text('Portafolio', style: _styleTitle),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text('Usuario de Instagram',
                                          style: _styleLabel),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
                                      child: Text(
                                        '@${merchant.instagram}' ?? 'N/A',
                                        style: _styleSubLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text(
                                        'Web',
                                        style: _styleLabel,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 20),
                                      child: Text(
                                          '${merchant.webPage}' ?? 'N/A',
                                          style: _styleSubLabel),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Identificación', style: _styleTitle),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text('Tipo de usuario',
                                          style: _styleLabel),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
                                      child: Text(
                                          widget.user.roles.isMerchant
                                              ? 'Aliado Cumbia'
                                              : 'Espectador',
                                          style: _styleSubLabel),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text('Nombre', style: _styleLabel),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
                                      child: Text(widget.user.name,
                                          style: _styleSubLabel),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text('Nombre de usuario',
                                          style: _styleLabel),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 20),
                                      child: Text('@${widget.user.username}',
                                          style: _styleSubLabel),
                                    ),
                                    Text('Contacto', style: _styleTitle),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child:
                                          Text('Celular', style: _styleLabel),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
                                      child: Text(
                                          widget
                                              .user.phoneNumber.basePhoneNumber,
                                          style: _styleSubLabel),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 5),
                                      child: Text('Correo electrónico',
                                          style: _styleLabel),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 20),
                                      child: Text(widget.user.email,
                                          style: _styleSubLabel),
                                    ),
                                    widget.user.addresses.length == 0
                                        ? const SizedBox.shrink()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Text('Domicilios',
                                                style: _styleTitle),
                                          ),
                                    Container(
                                      height:
                                          (170 * widget.user.addresses.length)
                                              .toDouble(),
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, position) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.user.addresses[position]
                                                        .idNumber
                                                    ? 'Domicilio principal'
                                                    : 'Domicilio #${position + 1}',
                                                style: TextStyle(
                                                  color: Palette.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 20, 10, 5),
                                                        child: Text(
                                                          'País',
                                                          style: _styleLabel,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 0, 0, 20),
                                                        child: Text(
                                                          widget
                                                              .user
                                                              .addresses[
                                                                  position]
                                                              .list,
                                                          style: _styleSubLabel,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Container(),
                                                    flex: 1,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 20, 10, 5),
                                                        child: Text('Ciudad',
                                                            style: _styleLabel),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 0, 0, 20),
                                                        child: Text(
                                                            widget
                                                                .user
                                                                .addresses[
                                                                    position]
                                                                .email,
                                                            style:
                                                                _styleSubLabel),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Container(),
                                                    flex: 2,
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 10, 5),
                                                child: Text('Dirección',
                                                    style: _styleLabel),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 0, 20),
                                                child: Text(
                                                    widget
                                                        .user
                                                        .addresses[position]
                                                        .accountHolder,
                                                    style: _styleSubLabel),
                                              ),
                                            ],
                                          );
                                        },
                                        itemCount: widget.user.addresses.length,
                                      ),
                                    ),
                                    Text('Finanzas', style: _styleTitle),
                                  ],
                                ),
                              )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  /// ::::::::::::: FUNCTIONS ::::::::::::: ///

  void _canPush() {
    if (t1Controller.text != merchant.rate.rateA.toString() ||
        t2Controller.text != merchant.rate.rateB.toString() ||
        t3Controller.text != merchant.rate.rateC.toString() ||
        t4Controller.text != merchant.rate.rateD.toString() ||
        t5Controller.text != merchant.rate.rateE.toString() ||
        t6Controller.text != merchant.rate.rateF.toString()) {
      setState(() {
        canPushBool = true;
      });
    } else {
      setState(() {
        canPushBool = false;
      });
    }
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  Future<void> _getMerchant() async {
    setState(() {
      isLoadingMerchants = true;
    });
    LogMessage.get("MERCHANT");
    References.merchant
        .where("userId", isEqualTo: widget.user.id)
        .get()
        .then((querySnapshot) {
      LogMessage.getSuccess("MERCHANT");
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          isLoadingMerchants = false;
        });
        setState(() {
          t1Controller.text = merchant.rate.rateA.toString();
          t2Controller.text = merchant.rate.rateB.toString();
          t3Controller.text = merchant.rate.rateC.toString();
          t4Controller.text = merchant.rate.rateD.toString();
          t5Controller.text = merchant.rate.rateE.toString();
          t6Controller.text = merchant.rate.rateF.toString();
        });
        querySnapshot.docs.forEach((merchantStream) {
          LogMessage.get("USERS");
          References.users
              .doc(merchantStream.data()["userId"])
              .get()
              .then((userDoc) {
            LogMessage.getSuccess("USERS");
            setState(() {
              if (userDoc.data().isNotEmpty) {
                merchants.add(
                  Merchant(
                    id: merchantStream.id,
                    user: User(
                      id: merchantStream.data()["userId"],
                      name: userDoc.data()["name"],
                      username: userDoc.data()["username"],
                      email: userDoc.data()["email"],
                      onLive: userDoc.data()["onLive"],
                    ),
                    pickUpPoint: merchantStream.data()["pickUpPoint"] ??
                        'Sin lugar de recogida',
                    category1: merchantStream.data()["principalCategory"],
                    category2: merchantStream.data()["secondaryCategory"],
                    instagram: merchantStream.data()["instagram"],
                    colombianProducts: merchantStream.data()["colombianProducts"],
                    webPage: merchantStream.data()["webPage"],
                    phoneNumber: merchantStream.data()["phoneNumber"],
                    email: merchantStream.data()["email"],
                    nit: merchantStream.data()["nit"],
                    razonSocial: merchantStream.data()["razonSocial"],
                    rate: Rate(
                      rateA: merchantStream.data()["rates"]["rateA"],
                      rateB: merchantStream.data()["rates"]["rateB"] ?? 0,
                      rateC: merchantStream.data()["rates"]["rateC"] ?? 0,
                      rateD: merchantStream.data()["rates"]["rateD"] ?? 0,
                      rateE: merchantStream.data()["rates"]["rateE"] ?? 0,
                      rateF: merchantStream.data()["rates"]["rateF"] ?? 0,
                    ),
                  ),
                );

                isLoadingMerchants = false;
                merchant = merchants[0];
                t1Controller.text = merchant.rate.rateA.toString();
                t2Controller.text = merchant.rate.rateB.toString();
                t3Controller.text = merchant.rate.rateC.toString();
                t4Controller.text = merchant.rate.rateD.toString();
                t5Controller.text = merchant.rate.rateE.toString();
                t6Controller.text = merchant.rate.rateF.toString();
              }
            });
          }).catchError((e) {
            setState(() {
              isLoadingMerchants = false;
            });

            LogMessage.getError("USERS", e);
          });
        });
      }
    }).catchError((e) {
      setState(() {
        isLoadingMerchants = false;

        merchant = merchants[0];
      });
      LogMessage.getError("MERCHANT", e);
    });
    setState(() {
      isLoadingMerchants = false;
    });
  }

  void _updateConstantRatesDoc() {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> rateMap = {
      'rates': {
        'rateA': int.parse(t1Controller.text.trim()),
        'rateB': int.parse(t2Controller.text.trim()),
        'rateC': int.parse(t3Controller.text.trim()),
        'rateD': int.parse(t4Controller.text.trim()),
        'rateE': int.parse(t5Controller.text.trim()),
        'rateF': int.parse(t6Controller.text.trim()),
      }
    };

    LogMessage.get("CONSTANT DOC 2");
    References.merchant.doc(merchant.id).update(rateMap).then((constantRates) {
      LogMessage.getSuccess("CONSTANT DOC 2");
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      LogMessage.getError("CONSTANT DOC 2", e);
      setState(() {
        isLoading = false;
      });
    });
  }
}
