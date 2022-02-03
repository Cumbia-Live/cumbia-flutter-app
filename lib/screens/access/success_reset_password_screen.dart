import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessResetPasswordScreen extends StatefulWidget {
  SuccessResetPasswordScreen({this.email});
  String email;

  @override
  _SuccessResetPasswordScreenState createState() =>
      _SuccessResetPasswordScreenState();
}

class _SuccessResetPasswordScreenState
    extends State<SuccessResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Palette.bgColor,
        body: CatapultaScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              children: [
                const CatapultaSpace(),
                Image.asset(
                  "images/ilustracion_email.png",
                  height: MediaQuery.of(context).size.width * 0.5,
                ),
                Text(
                  "¡Revisa tu bandeja!",
                  style: Styles.shortMessageTitleLbl,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Enviamos un link a ",
                    style: Styles.txtTextLbl(
                      color: Palette.black.withOpacity(0.5),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${widget.email}",
                        style: Styles.txtTextLbl(),
                      ),
                      TextSpan(
                        text: ' con el que podrás recuperar tu contraseña.',
                      ),
                    ],
                  ),
                ),
                const CatapultaSpace(),
                CumbiaButton(
                  title: "Ir a iniciar sesión",
                  canPush: true,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
