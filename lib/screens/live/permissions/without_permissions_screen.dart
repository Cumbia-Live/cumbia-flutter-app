import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class WithoutPermissionsScreen extends StatefulWidget {
  @override
  _WithoutPermissionsScreenState createState() =>
      _WithoutPermissionsScreenState();
}

class _WithoutPermissionsScreenState extends State<WithoutPermissionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: Center(
                            child: ShortMessageView(
                              topWidget: CumbiaIconRoundOutlined(
                                image: true,
                                imageSource: "images/live.png",
                              ),
                              title:
                                  "Negaste los permisos, tienes que ir a configuaración para activarlos",
                              withoutLabel: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CumbiaButton(
                            title: "Ir",
                            canPush: true,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoAlertDialog(
                                        title: Text('Camera Permission'),
                                        content: Text(
                                            'This app needs camera access to take pictures for upload user profile photo'),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            child: Text('Deny'),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                          CupertinoDialogAction(
                                            child: Text('Settings'),
                                            onPressed: () => openAppSettings(),
                                          ),
                                        ],
                                      ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
