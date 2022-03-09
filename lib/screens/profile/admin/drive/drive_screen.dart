import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/components/components.dart';

class DriveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.white,
        middle: Text(
          'Exportar al drive',
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
                text: 'Registro de transacciones',
                onTap: () {},
                withoutIcon: true,
              ),
              CatapultaListTitle(
                text: 'Pagos pendientes',
                onTap: () {},
                withoutIcon: true,
              ),
              CatapultaListTitle(
                text: 'Lista de usuarios',
                onTap: () {},
                withoutIcon: true,
              ),
              CatapultaListTitle(
                text: 'Estadísticas de desempeño',
                onTap: () {},
                withoutIcon: true,
              ),
              CatapultaListTitle(
                text: 'Solicitud de vendedores',
                onTap: () {},
                withoutIcon: true,
              ),
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
