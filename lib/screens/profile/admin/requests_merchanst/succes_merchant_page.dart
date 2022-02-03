import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/home/home_screen.dart';
import 'package:cumbialive/screens/nav_screen.dart';
import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessMerchantPage extends StatefulWidget {
  SuccessMerchantPage({this.merchant});
  Merchant merchant;
  @override
  _SuccessMerchantPageState createState() => _SuccessMerchantPageState();
}

class _SuccessMerchantPageState extends State<SuccessMerchantPage> {
  final notification = LoadUsers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
            CatapultaSpace(),
            ShortMessageView(
              topWidget: CumbiaIconRoundOutlined(
                image: true,
                imageSource: "images/check.png",
              ),
              title: "¡Vendedor aprobado!",
              label:
                  "El vendedor fue notificado y la próxima vez que entre a la aplicación podrá aceptar el contrato y posteriormente publicar sus productos.",
              onPressed: () {
                notification
                    .sendNotificationApprovedSellerToken(widget.merchant.user);
                //print("SUGERIR PRODUCTOS");
              },
            ),
            CatapultaSpace(),
            _button()
          ],
        ),
      )),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          CumbiaButton(
            title: "Ver más solicitudes!",
            canPush: true,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context, widget.merchant.id);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
