import 'package:cached_network_image/cached_network_image.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens.dart';

//Token
//cIMdZEx_QK2VNPiNzPElCF:APA91bH_1pSXnIy7AdFtwR32BPBQ025D0aMhsNVI2AAmkDRiRvHSVY1WL7LEhFPW_Qm3tsalf1aFBfOvdoVEzhXWkQsU26Sxv3Wc5UpIq7g4_dut6JpNpCYoDBKKZLwL7UpzSgNLjQSB

class NavScreen extends StatefulWidget {
  NavScreen({this.index = 0});

  int index;

  @override
  _NavScreenState createState() => _NavScreenState();
}

enum MainScreen {
  home,
  live,
  profile,
}

class _NavScreenState extends State<NavScreen> {
  MainScreen mainScreen = MainScreen.home;
  List<User> users = [];
  List<User> merchants = [];
  List<User> audience = [];
  List<User> admin = [];

  @override
  void initState() {
    super.initState();
    shoppingCart.list.clear();
    final pushNotification = PushNotification();
    pushNotification.initNotifications();
    pushNotification.mensaje.listen((data) {
      String titlulo = data['notification']['title'] ?? 'no-data';
      String cuerpo = data['notification']['body'] ?? 'no-data';
      showNotification(titlulo, cuerpo);
      setState(() {
        print("NOTIFICACIÓN RECIBIDA");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainScreen == MainScreen.home
          ? HomeScreen()
          : mainScreen == MainScreen.live
              ? LiveScreen()
              : ProfileScreen(),
      bottomNavigationBar: CustomTabBar(
        tabItems: [
          CustomTabBarItem(
            isActive: mainScreen == MainScreen.home,
            isDark: false,
            title: "Home",
            symbol: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Icon(
                Icons.home_rounded,
                size: 34,
                color: mainScreen == MainScreen.home
                    ? Palette.cumbiaDark
                    : Palette.darkGrey,
              ),
            ),
            onPressed: () {
              setState(() {
                mainScreen = MainScreen.home;
              });
            },
          ),
          CustomTabBarItem(
            isActive: mainScreen == MainScreen.live,
            isDark: false,
            symbol: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Image.asset(
                "images/icono.png",
                height: 34,
              ),
            ),
            title: "Go Live",
            onPressed: () {
              setState(() {
                mainScreen = MainScreen.live;
              });
            },
          ),
          CustomTabBarItem(
            isActive: mainScreen == MainScreen.profile,
            isDark: false,
            title: "Perfil",
            symbol: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: user.profilePictureURL == null
                  ? CircleAvatar(
                      radius: 14,
                      backgroundColor: mainScreen == MainScreen.profile
                          ? Palette.cumbiaDark
                          : Palette.darkGrey,
                      child: Text(
                        user.name.characters.first,
                        style: Styles.btn,
                      ),
                    )
                  : CircleAvatar(
                      radius: 14,
                      backgroundImage:
                          CachedNetworkImageProvider(user.profilePictureURL),
                    ),
            ),
            onPressed: () {
              setState(() {
                mainScreen = MainScreen.profile;
              });
            },
          ),
        ],
      ),
    );
  }

  Future<Widget> showNotification(String titulo, String cuerpo) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15),
              Text(
                "$titulo",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text("$cuerpo"),
              SizedBox(height: 20),
              Divider(
                height: 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Palette.cumbiaDark,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => NavScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      "Aceptar",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Palette.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// ------------------------------------------------- ///
/*class NavScreen extends StatefulWidget {
  NavScreen({this.index = 0});

  int index;

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {

  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        home: CupertinoTabScaffold(
           tabBar: CupertinoTabBar(
             backgroundColor: Palette.bgColor,
            items: [
              BottomNavigationBarItem(
                icon: CumbiaProfileIcon(
                  imageSource: "images/icono.png",
                  withoutIcon: false,
                ),
                title: Text(
                    'Home'),
              ),
              BottomNavigationBarItem(
                icon: CumbiaProfileIcon(
                  imageSource: "images/icono.png",
                  withoutIcon: false,
                ),
                title: Text('Go live'),
              ),
              BottomNavigationBarItem(
                icon: CumbiaProfileIcon(
                  withoutIcon: _withoutIcon(),
                ),
                title: Text('Perfil'),
              ),
            ],
          ),
          tabBuilder: (context, index) {
            if (index == 0) {
              return CupertinoTabView(
                navigatorKey: firstTabNavKey,
                builder: (BuildContext context) => HomeScreen(),
              );
            } else if (index == 1) {
              return CupertinoTabView(
                navigatorKey: secondTabNavKey,
                builder: (BuildContext context) => LiveScreen(),
              );
            } else {
              return CupertinoTabView(
                navigatorKey: thirdTabNavKey,
                builder: (BuildContext context) => ProfileScreen(),
              );
            }
          },
        ),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ]
    );
  }

  bool _withoutIcon() {
    if (user.profilePictureURL == null || user.profilePictureURL == "") {
      return true;
    } else {
      return false;
    }
  }
}*/
