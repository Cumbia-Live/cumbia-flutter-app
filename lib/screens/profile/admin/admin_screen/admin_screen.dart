import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/components/components.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.white,
        middle: Text(
          'Panel de administrador',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        backgroundColor: Palette.cumbiaDark,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Text("(falta, se hace después del monedero)"),
              CatapultaListTitle(
                text: 'Registro de transacciones',
                iconData: Icons.remove_red_eye,
                iconColor: Palette.cumbiaIconGrey,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => TransactionLogScreen(),
                    ),
                  );
                },
              ),
              CatapultaListTitle(
                text: 'Pagos pendientes',
                iconColor: Palette.cumbiaIconGrey,
                iconData: Icons.alarm,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => PendingPaymentsScreen(),
                    ),
                  );
                },
              ),
              CatapultaListTitle(
                text: 'Ingresos y comisión',
                iconData: Icons.attach_money,
                iconColor: Palette.cumbiaIconGrey,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => EarningsScreen(),
                    ),
                  );
                },
              ),
              CatapultaListTitle(
                text: 'Lista de usuarios',
                iconColor: Palette.cumbiaIconGrey,
                iconData: Icons.list,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => UserListScreen(),
                    ),
                  );
                },
              ),
              CatapultaListTitle(
                text: 'Estadísticas de desempeño',
                iconData: Icons.insert_chart,
                iconColor: Palette.cumbiaIconGrey,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => StatisticsScreen(),
                    ),
                  );
                },
              ),
              CatapultaListTitle(
                text: 'Solicitud de vendedores',
                iconColor: Palette.cumbiaIconGrey,
                iconData: Icons.shopping_bag,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ConsultMerchantScreen(),
                    ),
                  );
                },
              ),
              CatapultaListTitle(
                text: 'Campaña de lanzamiento',
                iconData: Icons.flag_rounded,
                iconColor: Palette.cumbiaIconGrey,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LaunchCampaign(),
                    ),
                  );
                },
              ),
              CatapultaListTitle(
                text: 'Exportar a drive',
                iconColor: Palette.cumbiaIconGrey,
                iconData: Icons.cloud_upload,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => DriveScreen(),
                    ),
                  );
                },
              ),
              CatapultaListTitle(
                text: 'Formulario de retiro',
                iconColor: Palette.cumbiaIconGrey,
                iconData: Icons.alarm,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => Q1PersonalDataScreen(),
                    ),
                  );
                },
              ),
              CatapultaListTitle(
                text: 'Onboarding',
                iconColor: Palette.cumbiaIconGrey,
                iconData: Icons.alarm,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => Welcome(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
