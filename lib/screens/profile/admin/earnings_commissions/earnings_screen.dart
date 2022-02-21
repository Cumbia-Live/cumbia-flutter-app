import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/config/constants/emerald_constants.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/profile/admin/earnings_commissions/widgets/earnings_emeralds_list_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../screens.dart';
import 'widgets/commission_label.dart';
import 'widgets/earnings_money_list_title.dart';

class EarningsScreen extends StatefulWidget {
  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}

const _styleTitle = TextStyle(
  color: Palette.black,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

class _EarningsScreenState extends State<EarningsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Product> soldProducts = [];
  List<Purchase> purchases = [];
  int appStore = 0;
  int playStore = 0;
  int web = 0;
  Rate rates = Rate();
  final TextEditingController t1Controller = TextEditingController();
  final TextEditingController t2Controller = TextEditingController();
  final TextEditingController t3Controller = TextEditingController();
  final TextEditingController t4Controller = TextEditingController();
  final TextEditingController t5Controller = TextEditingController();
  final TextEditingController t6Controller = TextEditingController();
  bool canPushBool = false;
  bool isLoading = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _getConstantRatesDoc();
    _getConstantDoc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Palette.cumbiaDark,
          leading: CupertinoNavigationBarBackButton(
            color: Palette.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Ingresos y comisión',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Palette.white,
            ),
          ),
          bottom: TabBar(
            unselectedLabelColor: Palette.black.withOpacity(0.2),
            labelColor: Palette.white,
            tabs: [
              Tab(
                child: Text(
                  'Ingresos',
                ),
              ),
              Tab(
                child: Text(
                  'Comisión',
                ),
              ),
            ],
            controller: _tabController,
            indicatorColor: Palette.cumbiaLight,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
      ),
      body: TabBarView(
        children: [
          earnings(),
          commission(),
        ],
        controller: _tabController,
      ),
    );
  }
  /// ::::::::::::: FRONT ::::::::::::: ///

  Widget earnings() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          EarningsEmeraldsListTitle(
            title: 'Esmeraldas vendidas',
            label: 'AppStore',
            number: appStore,
            label2: 'PlayStore',
            number2: playStore,
            label3: 'Web',
            number3: web,
          ),
          EarningsMoneyListTitle(
            title: 'Esmeraldas vendidas',
            label: 'AppStore',
            number: appStore * trmEmeralds.toInt(),
            label2: 'PlayStore',
            number2: playStore * trmEmeralds.toInt(),
            label3: 'Web',
            number3: web * trmEmeralds.toInt(),
          ),
        ],
      ),
    );
  }

  Widget commission() {
    return CatapultaScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('Tarifas generales', style: _styleTitle),
            ),
            CommissionLabel(
              controller: t1Controller,
              label: '\$100 a \$1.000 COP',
              rate: rates.rateA.toString() ?? "...",
              onChanged: (text) {
                _canPush();
              },
            ),
            CommissionLabel(
              controller: t2Controller,
              label: '\$1.100 a \$10.000 COP',
              rate: rates.rateB.toString() ?? "...",
              onChanged: (text) {
                _canPush();
              },
            ),
            CommissionLabel(
              controller: t3Controller,
              label: '\$10.100 a \$200.000 COP',
              rate: rates.rateC.toString() ?? "...",
              onChanged: (text) {
                _canPush();
              },
            ),
            CommissionLabel(
              controller: t4Controller,
              label: '\$200.100 a \$500.000 COP',
              rate: rates.rateD.toString() ?? "...",
              onChanged: (text) {
                _canPush();
              },
            ),
            CommissionLabel(
              controller: t5Controller,
              label: '\$500.100 a \$1\'500.000 COP',
              rate: rates.rateE.toString() ?? "...",
              onChanged: (text) {
                _canPush();
              },
            ),
            CommissionLabel(
              controller: t6Controller,
              label: '>\$\'500.100 COP',
              rate: rates.rateF.toString() ?? "...",
              onChanged: (text) {
                _canPush();
              },
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 10, 5),
              child: Text('Tarifas específicas', style: _styleTitle),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => UserListScreen(),
                    ),
                  );
              },
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Palette.cumbiaDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Visitar lista de Aliados Cumbia',
                        style: TextStyle(color: Palette.bgColor, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.chevron_right,
                        size: 30,
                        color: Palette.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CatapultaSpace(),
            CumbiaButton(
              onPressed: () {
                if (canPushBool) {
                  _updateConstantRatesDoc();
                  Navigator.pop(context);
                }
              },
              title: 'Actualizar tarifas',
              canPush: canPushBool,
              isLoading: isLoading,
            )
          ],
        ),
      ),
    );
  }

  /// ::::::::::::: FUNCTIONS ::::::::::::: ///
  
  void _canPush() {
    if (t1Controller.text != rates.rateA.toString() ||
        t2Controller.text != rates.rateB.toString() ||
        t3Controller.text != rates.rateC.toString() ||
        t4Controller.text != rates.rateD.toString() ||
        t5Controller.text != rates.rateE.toString() ||
        t6Controller.text != rates.rateF.toString()) {
      setState(() {
        canPushBool = true;
      });
    } else {
      setState(() {
        canPushBool = false;
      });
    }
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  void _getConstantDoc() {
    LogMessage.get("CONSTANT DOC 1");
    References.earningConstants.get().then((constantEarnings) {
      LogMessage.getSuccess("CONSTANT DOC 1");
      setState(() {
        if (constantEarnings.exists) {
          appStore = constantEarnings.data()['earnings']['appStore'];
          playStore = constantEarnings.data()['earnings']['playStore'];
          web = constantEarnings.data()['earnings']['web'];
        }
      });
    }).catchError((e) {
      LogMessage.getError("CONSTANT DOC 1", e);
    });
  }

  void _getConstantRatesDoc() {
    LogMessage.get("CONSTANT DOC 2");
    References.rates.get().then((constantRates) {
      LogMessage.getSuccess("CONSTANT DOC 2");
      setState(() {
        if (constantRates.exists) {
          rates = Rate(
            rateA: constantRates.data()['rates']['rateA'],
            rateB: constantRates.data()['rates']['rateB'],
            rateC: constantRates.data()['rates']['rateC'],
            rateD: constantRates.data()['rates']['rateD'],
            rateE: constantRates.data()['rates']['rateE'],
            rateF: constantRates.data()['rates']['rateF'],
          );

          setState(() {
            t1Controller.text = rates.rateA.toString();
            t2Controller.text = rates.rateB.toString();
            t3Controller.text = rates.rateC.toString();
            t4Controller.text = rates.rateD.toString();
            t5Controller.text = rates.rateE.toString();
            t6Controller.text = rates.rateF.toString();
          });
        }
      });
    }).catchError((e) {
      LogMessage.getError("CONSTANT DOC 2", e);
    });
  }

  void _updateConstantRatesDoc() {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> rateMap = {
      'rates': {
        'rateA': int.parse(t1Controller.text.trim()),
        'rateB': int.parse(t2Controller.text.trim()),
        'rateC': int.parse(t3Controller.text.trim()),
        'rateD': int.parse(t4Controller.text.trim()),
        'rateE': int.parse(t5Controller.text.trim()),
        'rateF': int.parse(t6Controller.text.trim()),
      }
    };

    LogMessage.get("CONSTANT DOC 2");
    References.rates.update(rateMap).then((constantRates) {
      LogMessage.getSuccess("CONSTANT DOC 2");
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      LogMessage.getError("CONSTANT DOC 2", e);
      setState(() {
        isLoading = false;
      });
    });
  }
}
