import 'package:cached_network_image/cached_network_image.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/profile/admin/requests_merchanst/succes_merchant_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';

class SetRatesScreen extends StatefulWidget {
  SetRatesScreen({this.merchant});
  Merchant merchant;
  @override
  _SetRatesScreenState createState() => _SetRatesScreenState();
}

class _SetRatesScreenState extends State<SetRatesScreen> {
  bool editar = false;
  Rates rates = Rates();

  @override
  void initState() {
    _getRates();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Palette.white,
        centerTitle: true,
        elevation: 0,
        leading: CupertinoNavigationBarBackButton(
          color: Palette.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Solicitud",
          style: Styles.navTitleLbl,
        ),
      ),
      backgroundColor: Palette.white,
      body: CatapultaScrollView(
        child: Column(
          children: [
            _setupHeaderLayout(),
            !editar ? _setRatesLayout() : _editRatesLayout(),
            Expanded(child: Container()),
            !editar
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                    child: CumbiaButton(
                      onPressed: showBasicAlertReject,
                      title: "Aprobar vendedor",
                      canPush: true,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _setupHeaderLayout() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    height: 80,
                    width: 80,
                    child: CachedNetworkImage(
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                        imageUrl: widget.merchant?.user?.profilePictureURL !=
                                    "" &&
                                widget.merchant?.user?.profilePictureURL != null
                            ? widget.merchant?.user?.profilePictureURL
                            : "https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2FliveImage.png?alt=media&token=d9c84a2f-92e8-4f4f-9f79-17b82c992016"),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width - 128,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 198,
                      child: Text(
                        "${widget.merchant.user.username}",
                        style: Styles.titleLive,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text("NIT: ${widget.merchant.nit}",
                          style: Styles.labelAdmin),
                    ),
                    Text("${widget.merchant.razonSocial}",
                        style: Styles.labelAdmin),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CumbiaDivider(),
        ),
      ],
    );
  }

  Widget _setRatesLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tarifas",
                style: Styles.navTitleLbl,
              ),
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    "Editar",
                    style: Styles.labelBoldAdminCumbia,
                  ),
                  onPressed: () {
                    setState(() {
                      editar = true;
                    });
                  })
            ],
          ),
        ),
        CumbiaRateLabel(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          rate: "\$100 a \$1.000 COP",
          percent: "${rates.rateA}%",
        ),
        CumbiaRateLabel(
          rate: "\$1.100 a \$10.000 COP",
          percent: "${rates.rateB}%",
        ),
        CumbiaRateLabel(
          rate: "\$10.100 a \$200.000 COP",
          percent: "${rates.rateC}%",
        ),
        CumbiaRateLabel(
          rate: "\$200.100 a \$500.000 COP",
          percent: "${rates.rateD}%",
        ),
        CumbiaRateLabel(
          rate: "\$500.100 a \$1.500.000 COP",
          percent: "${rates.rateE}%",
        ),
        CumbiaRateLabel(
          rate: "≥ \$1.500.100 COP",
          percent: "${rates.rateF}%",
        )
      ],
    );
  }

  Widget _editRatesLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tarifas",
                style: Styles.navTitleLbl,
              ),
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    "Listo",
                    style: Styles.labelBoldAdminCumbia,
                  ),
                  onPressed: () {
                    setState(() {
                      editar = false;
                    });
                  })
            ],
          ),
        ),
        CumbiaRateLabel(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          rate: "\$100 a \$1.000 COP",
          percent: "",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CumbiaTextField(
            initialValue: rates.rateA.toString(),
            keyboardType: TextInputType.number,
            onChanged: (text) {
              setState(() {
                rates.rateA = int.parse(text);
              });
            },
          ),
        ),
        CumbiaRateLabel(
          rate: "\$1.100 a \$10.000 COP",
          percent: "",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CumbiaTextField(
            initialValue: rates.rateB.toString(),
            keyboardType: TextInputType.number,
            onChanged: (text) {
              setState(() {
                rates.rateB = int.parse(text);
              });
            },
          ),
        ),
        CumbiaRateLabel(
          rate: "\$10.100 a \$200.000 COP",
          percent: "",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CumbiaTextField(
            initialValue: rates.rateC.toString(),
            keyboardType: TextInputType.number,
            onChanged: (text) {
              setState(() {
                rates.rateC = int.parse(text);
              });
            },
          ),
        ),
        CumbiaRateLabel(
          rate: "\$200.100 a \$500.000 COP",
          percent: "",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CumbiaTextField(
            initialValue: rates.rateD.toString(),
            keyboardType: TextInputType.number,
            onChanged: (text) {
              setState(() {
                rates.rateD = int.parse(text);
              });
            },
          ),
        ),
        CumbiaRateLabel(
          rate: "\$500.100 a \$1.500.000 COP",
          percent: "",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CumbiaTextField(
            initialValue: rates.rateE.toString(),
            keyboardType: TextInputType.number,
            onChanged: (text) {
              setState(() {
                rates.rateE = int.parse(text);
              });
            },
          ),
        ),
        CumbiaRateLabel(
          rate: "≥ \$1.500.100 COP",
          percent: "",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CumbiaTextField(
            initialValue: rates.rateF.toString(),
            keyboardType: TextInputType.number,
            onChanged: (text) {
              setState(() {
                rates.rateF = int.parse(text);
              });
            },
          ),
        ),
      ],
    );
  }

  void showBasicAlertReject() {
    showAlert(
      context: context,
      title: "Aprobar vendedor",
      body:
          "Se le notificará al usuario que fue aprobado y podrá aceptar su contrato.",
      actions: [
        // ignore: missing_required_param
        AlertAction(
          text: "volver",
        ),
        AlertAction(
            text: "Aprobar",
            isDefaultAction: true,
            onPressed: () {
              _updateMerchant();
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => SuccessMerchantPage(
                    merchant: widget.merchant,
                  ),
                ),
              );
            }),
      ],
    );
  }

  void _updateMerchant() {
    Map<String, dynamic> merchantMap = {
      "isApproved": true,
      "rates": {
        "rateA": rates.rateA,
        "rateB": rates.rateB,
        "rateC": rates.rateC,
        "rateD": rates.rateD,
        "rateE": rates.rateE,
        "rateF": rates.rateF,
      }
    };
    print("⏳ ACTUALIZARÉ MERCHANT");
    References.merchant
        .doc(widget.merchant.id)
        .update(merchantMap)
        .then((r) async {
      print("✔ LIVE MERCHANT");
      _updateUser();
    }).catchError((e) {
      showBasicAlert(
        context,
        "Hubo un error.",
        "Por favor, intenta más tarde.",
      );
      print("💩️ ERROR AL ACTUALIZAR MERCHANT: $e");
    });
  }

  Future<void> _updateUser() async {
    Map<String, dynamic> userMap = {
      "roles": {
        "isMerchant": true,
        "isAdmin": false,
      }
    };
    print("⏳ ACTUALIZARÉ USER");
    References.users
        .doc(widget.merchant.user.id)
        .update(userMap)
        .then((r) async {
      print("✔ LIVE USER");
    }).catchError((e) {
      showBasicAlert(
        context,
        "Hubo un error.",
        "Por favor, intenta más tarde.",
      );
      print("💩️ ERROR AL ACTUALIZAR USER: $e");
    });
  }

  void _getRates() {
    LogMessage.get("TARIFAS");
    References.rates.get().then((ratedoc) {
      categories.clear();
      LogMessage.getSuccess("TARIFAS");
      if (ratedoc.exists) {
        setState(() {
          rates = Rates(
              rateA: ratedoc.data()["rates"]["rateA"],
              rateB: ratedoc.data()["rates"]["rateB"],
              rateC: ratedoc.data()["rates"]["rateC"],
              rateD: ratedoc.data()["rates"]["rateD"],
              rateE: ratedoc.data()["rates"]["rateE"],
              rateF: ratedoc.data()["rates"]["rateF"]);
        });
      }
    }).catchError((e) {
      LogMessage.getError("TARIFAS", e);
    });
  }
}
