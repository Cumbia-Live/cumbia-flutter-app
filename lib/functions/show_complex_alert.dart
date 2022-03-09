import 'package:flutter/cupertino.dart';
import 'package:flutter_alert/flutter_alert.dart';

void showMainActionAlert(
    BuildContext context, String title, String message, Function onPressed,
    {String mainActionText = "Continuar", bool isDestructiveAction = false}) {
  showAlert(
    context: context,
    title: title,
    body: message,
    actions: [
      // ignore: missing_required_param
      AlertAction(
        text: "Volver",
      ),
      AlertAction(
        text: mainActionText,
        isDestructiveAction: isDestructiveAction,
        onPressed: onPressed,
        isDefaultAction: true,
      ),
    ],
  );
}
