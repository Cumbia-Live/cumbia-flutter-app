import 'package:flutter/cupertino.dart';
import 'package:flutter_alert/flutter_alert.dart';

void showConfirmAlert(BuildContext context, String title, String message, Function onPressed) {
  showAlert(
    context: context,
    title: title,
    body: message,
    actions: [
      AlertAction(
          text: "Continuar",
          isDefaultAction: true,
          onPressed: onPressed
      ),
    ],
  );
}
