import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../config/config.dart';
import 'package:cumbialive/components/components.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.white,
        middle: Text(
          'Configuración',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        backgroundColor: _getBGColor(),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.0),
              CatapultaListTitle(
                text: 'Documentación legal',
                iconData: Icons.description,
                iconColor: Palette.cumbiaIconGrey,
                onTap: () {},
              ),
              CumbiaDivider(height: 2.0),
              CatapultaListTitle(
                text: 'Eliminar cuenta',
                iconColor: Colors.red,
                iconData: Icons.report,
                onTap: () {},
              ),
              CumbiaDivider(height: 2.0),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBGColor() {
    return user.roles.isAdmin
        ? Palette.cumbiaDark
        : user.roles.isMerchant
            ? Palette.cumbiaSeller
            : Palette.cumbiaLight;
  }
}
