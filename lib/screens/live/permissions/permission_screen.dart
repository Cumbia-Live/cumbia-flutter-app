import 'package:permission_handler/permission_handler.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PermissionsScreen extends StatefulWidget {
  @override
  _PermissionsScreenState createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  /// Rsultado de solictar los permisos
  PermissionStatus statusMic;
  PermissionStatus statusCamera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        backgroundColor: Palette.bgColor,
        //actionsForegroundColor: Palette.black,
        border: Border.all(color: Palette.transparent),
        middle: Text(
          "Go Live",
          style: Styles.navTitleLbl,
        ),
      ),
      body: CatapultaScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                child: Image.asset(
                  "images/ilustracion_video.png",
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "Permisos de cámara y micrófono",
                style: Styles.permisosTitleLbl,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                child: Text(
                  "Necesitamos acceder al micrófono y a la cámara de tu celular para transmitir videos en vivo.",
                  style: Styles.tittleLiveLbl,
                ),
              ),
              CumbiaButton(
                title: "Habilitar micrófono",
                canPush: statusMic == PermissionStatus.granted ? false : true,
                withCheck: statusMic == PermissionStatus.granted ? true : false,
                onPressed: () {
                  _handleButton(false);
                },
              ),
              const SizedBox(height: 10),
              CumbiaButton(
                title: "Habilitar cámara",
                canPush:
                    statusCamera == PermissionStatus.granted ? false : true,
                withCheck:
                    statusCamera == PermissionStatus.granted ? true : false,
                onPressed: () {
                  _handleButton(true);
                },
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  void _handleButton(bool isCamera) async {
    if (isCamera) {
      await _handleCamera(Permission.camera);
    } else {
      await _handleMic(Permission.microphone);
    }
    if (statusCamera == PermissionStatus.granted &&
        statusMic == PermissionStatus.granted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => PreparationMerchantScreen(),
        ),
      );
    } else if (statusCamera == PermissionStatus.denied ||
        statusMic == PermissionStatus.denied) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => WithoutPermissionsScreen(),
        ),
      );
    }
  }

  /// ::::::::::::: PERMISOS ::::::::::::: ///

  Future<void> _handleCamera(Permission permission) async {
    final PermissionStatus status = await permission.request();
    setState(() {
      statusCamera = status;
    });
  }

  Future<void> _handleMic(Permission permission) async {
    final status = await permission.request();
    setState(() {
      statusMic = status;
    });
  }
}
