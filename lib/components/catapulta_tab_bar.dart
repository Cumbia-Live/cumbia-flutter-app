import 'package:cached_network_image/cached_network_image.dart';
import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class CatapultaTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CatapultaTabBar({
    Key key,
    @required this.selectedIndex,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: BoxDecoration(border: Border.all(color: Palette.transparent)),
      labelColor: Palette.cumbiaDark,
      unselectedLabelColor: Palette.black.withOpacity(0.25),
      tabs: [
        Tab(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/home.png",
                height: 24,
              ),
              const SizedBox(height: 2),
              Text("Home"),
            ],
          ),
        ),
        Tab(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/icono.png", height: 28),
              Text("Go Live"),
            ],
          ),
        ),
        Tab(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              user.profilePictureURL == null
                  ? CircleAvatar(
                      radius: 12,
                      backgroundColor: Palette.cumbiaDark,
                      child: Text(
                        "${user.name.characters.first}",
                        style: TextStyle(color: Palette.white),
                      ),
                    )
                  : CircleAvatar(
                      radius: 12,
                      backgroundColor: Palette.black.withOpacity(0.1),
                      backgroundImage: CachedNetworkImageProvider(
                        user.profilePictureURL,
                      ),
                    ),
              const SizedBox(height: 2),
              Text("Perfil"),
            ],
          ),
        ),
      ],
      onTap: onTap,
    );
  }
}
