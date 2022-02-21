import 'package:flutter/cupertino.dart';
import 'package:flutter_alert/flutter_alert.dart';

void showBasicAlert(BuildContext context, String title, String message) {
  showAlert(
    context: context,
    title: title,
    body: message,
    actions: [
      // ignore: missing_required_param
      AlertAction(
        text: "Aceptar",
        isDefaultAction: true,
      ),
    ],
  );
}
