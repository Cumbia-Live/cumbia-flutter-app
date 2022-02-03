import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactar {
  static void llamar(BuildContext context, String phoneNumber) async {
    phoneNumber.replaceAll("+", "");
    String url = "tel:$phoneNumber";
    await canLaunch(url)
        ? await launch(url)
        : showAlert(
            context: context,
            title: "No pudimos llamar al $phoneNumber.",
            body: "",
            actions: [
              // ignore: missing_required_param
              AlertAction(
                text: "Volver",
              ),
              AlertAction(
                text: "Escribir",
                isDefaultAction: true,
                onPressed: () {
                  escribir(context, phoneNumber);
                },
              ),
            ],
          );
  }

  static void escribir(BuildContext context, String phoneNumber) async {
    phoneNumber.replaceAll("+", "");
    if (phoneNumber.length == 10) {
      phoneNumber = "57$phoneNumber";
    }
    await canLaunch("https://wa.me/$phoneNumber")
        ? launch("https://wa.me/$phoneNumber")
        : showAlert(
            context: context,
            title: "No pudimos abrir WhatsApp.",
            body: "",
            actions: [
              // ignore: missing_required_param
              AlertAction(
                text: "Volver",
              ),
              AlertAction(
                text: "Llamar",
                isDefaultAction: true,
                onPressed: () {
                  llamar(context, phoneNumber);
                },
              ),
            ],
          );
  }
  static void launchEmail(BuildContext context, String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showAlert(
        context: context,
        title: "Hubo un error",
        body: "Por favor, intenta, más tarde",
        actions: [
          // ignore: missing_required_param
          AlertAction(
            text: "Volver",
          ),

        ],
      );
    }
  }

  static void launchInstagram(BuildContext context, String instaUser) async {
    instaUser.replaceAll("@", "");
    var url = 'https://www.instagram.com/$instaUser/';

    if (await canLaunch(url)) {
      showAlert(
        context: context,
        title: "Instagram",
        body: "Si te lleva a la página principal, significa que el usario no existe",
        actions: [
          // ignore: missing_required_param
          AlertAction(text: "Volver"),
          AlertAction(
            text: "Continuar",
            onPressed: ()async{
              await launch(
                  url,
                  universalLinksOnly: true,
              );
            }
          ),

        ],
      );

    } else {
      showAlert(
        context: context,
        title: "Hubo un error",
        body: "Por favor, intenta, más tarde",
        actions: [
          // ignore: missing_required_param
          AlertAction(
            text: "Volver",
          ),

        ],
      );
    }
  }
  static void launchUrlWeb(BuildContext context, String webPage) async {
    var url = 'https://$webPage';

    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );

    } else {
      showAlert(
        context: context,
        title: "Hubo un error",
        body: "Por favor, intenta, más tarde",
        actions: [
          // ignore: missing_required_param
          AlertAction(
            text: "Volver",
          ),

        ],
      );
    }
  }
}
