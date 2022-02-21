import 'package:permission_handler/permission_handler.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LiveScreen extends StatefulWidget {
  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen>
    with AutomaticKeepAliveClientMixin<LiveScreen> {
  /// Verifica si tiene los permisos de la cámara y el micrófono activados
  bool cameraPermissions = false;
  bool micPermissions = false;
  bool cameraDenied = false;
  bool micDenied = false;

  @override
  void initState() {
    _handlePermissionCamera();
    _handlePermissionMic();
    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Palette.bgColor,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CatapultaScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 48),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "images/icono.png",
                      height: MediaQuery.of(context).size.width * 0.3,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "Inicia un livestream",
                      style: Styles.largeTitleLbl,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "¡Estás a segundos de transmitir un livestream!",
                      style: Styles.secondaryLbl,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Text(
                          "Importante:",
                          style: Styles.txtBtn(size: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '''
Queremos que tengas una experiencia segura y divertida, así que antes de que inicies el stream, por favor recuerda:

Mantente a salvo y permanece atento a tus alrededores.

Protege tu privacidad, compartir tu ubicación o información personal puede ser riesgoso.

Respeta la seguridad, privacidad y propiedad de los demás. Pregunta antes de hacer un stream.

Respeta el contenido de los demás, no transmitas conciertos, eventos, shows ni películas sin permiso.

No son apropiadas actividades ilegales, violencia contra ti mismo u otras personas, acoso, incitación al odio, violencia explícita, sexo ni desnudez.

''',
                      style: Styles.paragraphLbl,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Palette.bgColor,
                  padding: const EdgeInsets.all(16.0),
                  child: CumbiaButton(
                    title: "¡Entendido!",
                    canPush: true,
                    onPressed: () {
                      _handlePermissionCamera();
                      _handlePermissionMic();
                      if (cameraDenied || micDenied) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => WithoutPermissionsScreen(),
                          ),
                        );
                      } else if (cameraPermissions && micPermissions) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => PreparationScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => PermissionsScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ::::::::::::: PERMISOS ::::::::::::: ///

  Future<void> _handlePermissionCamera() async {
    final status = await Permission.camera.isGranted;
    final denied = await Permission.camera.isDenied;

    setState(() {
      cameraPermissions = status;
      cameraDenied = denied;
    });
  }

  Future<void> _handlePermissionMic() async {
    final status = await Permission.microphone.isGranted;
    final denied = await Permission.microphone.isDenied;
    setState(() {
      micPermissions = status;
      micDenied = denied;
    });
  }
}
