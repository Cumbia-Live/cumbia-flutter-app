import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/config/constants/campaign_constant.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/model/campaign/campaign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/get_button.dart';

class LaunchCampaign extends StatefulWidget {
  LaunchCampaign({Key key}) : super(key: key);

  @override
  _LaunchCampaignState createState() => _LaunchCampaignState();
}

class _LaunchCampaignState extends State<LaunchCampaign> {
  final TextEditingController unitsController = TextEditingController();
  bool state = false;
  bool isLoading = false;
  @override
  void initState() {
    print(campaign.amount);
    print(campaign.isActive);
    setState(() {
      unitsController.text = campaign.amount.toString();
      state = campaign.isActive;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.white,
        backgroundColor: Palette.cumbiaDark,
        middle: Text(
          'Campaña de lanzamiento',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 48),
        child: CatapultaScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Esmeraldas de regalo',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      'Estado de campaña',
                      style: TextStyle(
                        color: Palette.b5Grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      children: [
                        Expanded(
                          child: GetButton(
                            title: 'Activa',
                            canPush: !state ? true : false,
                            onPressed: () {
                              setState(() {
                                state = true;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: GetButton(
                            title: 'Inactiva',
                            canPush: state ? true : false,
                            onPressed: () {
                              setState(() {
                                state = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Regalo a nuevo usuario',
                          style: TextStyle(
                            color: Palette.b5Grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CumbiaTextField(
                          controller: unitsController,
                          placeholder: 'Ej: 100',
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: unitsController.text,
                          onChanged: (text) {},
                          validator: (value) {
                            if (value == '0') {
                              return 'No puede ser 0';
                            } else if (value.isEmpty) {
                              return 'Campo obligatorio';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Image.asset('images/emerald.png', height: 30),
                  )
                ],
              ),
              CatapultaSpace(),
              CumbiaButton(
                onPressed: () {
                  _updateEmeraldsUser();
                },
                canPush: true,
                title: 'Actualizar',
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateEmeraldsUser() {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> campaignMap = {
      'campaign': {
        'amount': int.parse(unitsController.text.trim()),
        'state': state
      }
    };
    print("⏳ ACTUALIZARÉ CAMPAIGN");
    References.constants.update(campaignMap).then((r) async {
      print("✔ CAMPAIGN ACTUALIZADO");
      setState(() {
        isLoading = false;
        campaign = Campaign(
          isActive: state,
          amount: int.parse(unitsController.text.trim()),
        );
      });
      Navigator.pop(context);
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      showBasicAlert(
        context,
        "Hubo un error.",
        "Por favor, intenta más tarde.",
      );
      print("💩️ ERROR AL ACTUALIZAR CAMPAIGN: $e");
    });
  }
}
