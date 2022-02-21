import 'package:cached_network_image/cached_network_image.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';

import '../../../screens.dart';

class DetailMerchantScreen extends StatefulWidget {
  DetailMerchantScreen({this.merchant});
  Merchant merchant;
  @override
  _DetailMerchantScreenState createState() => _DetailMerchantScreenState();
}

class _DetailMerchantScreenState extends State<DetailMerchantScreen> {
  @override
  void initState() {
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: CupertinoButton(
                onPressed: () {
                  showBasicAlertReject();
                },
                padding: EdgeInsets.zero,
                child: Text(
                  "Rechazar",
                  style: Styles.validationLbl,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Palette.white,
      body: Column(
        children: [
          _setupHeaderLayout(),
          _setupMerchantInformationLayout(),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 48),
            child: CumbiaButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SetRatesScreen(
                      merchant: widget.merchant,
                    ),
                  ),
                );
              },
              title: "Definir tarifas",
              canPush: true,
            ),
          ),
        ],
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

  Widget _setupMerchantInformationLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Contacto",
            style: Styles.navTitleLbl,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Celular", style: Styles.labelAdmin),
              GestureDetector(
                onTap: _alertContact,
                child: Text(
                  "+57${widget.merchant.phoneNumber}",
                  style: Styles.labelAdminUnderline,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Correo", style: Styles.labelAdmin),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Contactar.launchEmail(
                          context, widget.merchant.email, "", "");
                    },
                    child: Text(
                      "${widget.merchant.email}",
                      style: Styles.labelAdminUnderline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        CumbiaDivider(margin: EdgeInsets.symmetric(vertical: 20)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Comercio",
            style: Styles.navTitleLbl,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Categoría principal", style: Styles.labelAdmin),
              Text(
                "${widget.merchant.category1}",
                style: Styles.labelBoldAdmin,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Categoría secundaria", style: Styles.labelAdmin),
              widget.merchant.category2 == ""
                  ? Text("N/A", style: Styles.labelAdmin)
                  : Text(
                      "${widget.merchant.category2}",
                      style: Styles.labelBoldAdmin,
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Productos colombianos", style: Styles.labelAdmin),
              Text(
                "${widget.merchant.colombianProducts ? "Sí" : "No"}",
                style: Styles.labelBoldAdmin,
              ),
            ],
          ),
        ),
        CumbiaDivider(margin: EdgeInsets.symmetric(vertical: 20)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Portafolio",
            style: Styles.navTitleLbl,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Instagram", style: Styles.labelAdmin),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: widget.merchant.instagram == ""
                      ? Text("N/A", style: Styles.labelAdmin)
                      : GestureDetector(
                          onTap: () {
                            Contactar.launchInstagram(
                                context, widget.merchant.instagram);
                          },
                          child: Text(
                            "@${widget.merchant.instagram}",
                            style: Styles.labelAdminUnderline,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Web", style: Styles.labelAdmin),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: widget.merchant.webPage == ""
                      ? Text("N/A", style: Styles.labelAdmin)
                      : GestureDetector(
                          onTap: () {
                            Contactar.launchUrlWeb(
                                context, widget.merchant.webPage);
                            print(widget.merchant.webPage);
                          },
                          child: Text(
                            "${widget.merchant.webPage}",
                            style: Styles.labelAdminUnderline,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _alertContact() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text("Llamar"),
            isDestructiveAction: false,
            onPressed: () {
              Contactar.llamar(context, widget.merchant.phoneNumber);
            },
          ),
          CupertinoActionSheetAction(
            child: Text("WhatsApp"),
            isDestructiveAction: false,
            onPressed: () {
              Contactar.escribir(context, widget.merchant.phoneNumber);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Volver"),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void showBasicAlertReject() {
    showAlert(
      context: context,
      title: "Rechazar vendedor",
      body:
          "Se le notificará al usuario que fue rechazado y su solicitud será eliminada.",
      actions: [
        // ignore: missing_required_param
        AlertAction(
          text: "volver",
        ),
        AlertAction(
            text: "rechazar",
            isDestructiveAction: true,
            onPressed: () {
              _updateMerchant();
            }),
      ],
    );
  }

  Future<void> _updateMerchant() async {
    Map<String, dynamic> merchantMap = {
      "isRejected": true,
    };

    print("⏳ ACTUALIZARÉ MERCHANT");
    References.merchant
        .doc(widget.merchant.id)
        .update(merchantMap)
        .then((r) async {
      print("✔ LIVE MERCHANT");
    }).catchError((e) {
      showBasicAlert(
        context,
        "Hubo un error.",
        "Por favor, intenta más tarde.",
      );
      print("💩️ ERROR AL ACTUALIZAR MERCHANT: $e");
    });
  }

}
