import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/home/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../screens.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<User> viewersList = [];

  List<User> alliesList = [];

  List<User> viewerListBackUp = [];

  List<User> alliesListBackUp = [];
  List<User> usersList = [];

  String searchAlly = "";
  String searchViewer = "";

  bool isLoading = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _getUsers();
    Future.delayed(const Duration(seconds: 1), () {});

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
            'Lista de usuarios',
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
                  'Espectadores',
                ),
              ),
              Tab(
                child: Text(
                  'Aliados Cumbia',
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
          viewers(),
          ally(),
        ],
        controller: _tabController,
      ),
    );
  }

  Widget viewers() {
    return CatapultaScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: CustomTextField(
                initialValue: searchText,
                suffixWidget: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Palette.black.withOpacity(0.25),
                    )),
                placeholder: "Ej: @usuario",
                onChanged: (text) {
                  searchText = text;
                  setState(() {
                    searchViewer = text;
                  });
                  _filterByViewer(text);
                  if (text == "") {
                    viewersList = usersList
                        .where((user) => !user.roles.isMerchant)
                        .toList();
                  }
                },
              ),
            ),
            isLoading
                ? _loadingLayout()
                : viewersList.isEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        color: Palette.bgColor,
                        child: Center(
                          child: Text(
                            "No hay resultados que\ncoincidan con tu búsqueda",
                            textAlign: TextAlign.center,
                            style: Styles.shortMessageLbl(),
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        color: Palette.bgColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                          child: Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, position) {
                                return setupViewersListLayout(
                                    position, viewersList);
                              },
                              itemCount: viewersList.length,
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget ally() {
    return CatapultaScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: CustomTextField(
                initialValue: searchText,
                suffixWidget: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Palette.black.withOpacity(0.25),
                    )),
                placeholder: "Ej: @usuario",
                onChanged: (text) {
                  searchText = text;
                  setState(() {
                    searchAlly = text;
                  });
                  _filterByAllies(text);
                  if (text == "") {
                    setState(() {
                      alliesList = usersList
                          .where((user) => user.roles.isMerchant)
                          .toList();
                    });
                  }
                },
              ),
            ),
            isLoading
                ? _loadingLayout()
                : alliesList.isEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        color: Palette.bgColor,
                        child: Center(
                          child: Text(
                            "No hay resultados que\ncoincidan con tu búsqueda",
                            textAlign: TextAlign.center,
                            style: Styles.shortMessageLbl(),
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        color: Palette.bgColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                          child: Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, position) {
                                return setupViewersListLayout(
                                    position, alliesList);
                              },
                              itemCount: alliesList.length,
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _loadingLayout() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      color: Palette.bgColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Expanded(
          child: ListView.builder(
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Palette.txtBgColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Palette.black.withOpacity(0.5),
                              highlightColor: Palette.black.withOpacity(0.2),
                              child: Container(
                                height: 10,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: Palette.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Shimmer.fromColors(
                              baseColor: Palette.black.withOpacity(0.5),
                              highlightColor: Palette.black.withOpacity(0.2),
                              child: Container(
                                height: 10,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: Palette.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Shimmer.fromColors(
                          baseColor: Palette.black.withOpacity(0.5),
                          highlightColor: Palette.black.withOpacity(0.2),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Palette.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: 5,
          ),
        ),
      ),
    );
  }

  /// FRONT

  Widget setupViewersListLayout(int position, List list) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => UsersDetailScreen(
              user: list[position],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Palette.txtBgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  "@${list[position].name}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Palette.cumbiaIconGrey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  list[position].addresses.isEmpty
                      ? "Sin domicilio"
                      : '${list[position].addresses[0].city}/${list[position].addresses[0].country}',
                  style: TextStyle(
                    color: Palette.cumbiaLabelGrey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              size: 25,
              color: Palette.cumbiaLight,
            )
          ],
        ),
      ),
    );
  }

  void _filterByViewer(String text) {
    setState(() {
      viewersList = viewersList
          .where(
            (user) =>
                user.name
                    .toLowerCase()
                    .replaceAll(" ", "")
                    .replaceAll("á", "a")
                    .replaceAll("é", "e")
                    .replaceAll("í", "i")
                    .replaceAll("ó", "o")
                    .replaceAll("ú", "u")
                    .contains(
                      text
                          .toLowerCase()
                          .replaceAll(" ", "")
                          .replaceAll("á", "a")
                          .replaceAll("é", "e")
                          .replaceAll("í", "i")
                          .replaceAll("ó", "o")
                          .replaceAll("ú", "u"),
                    ) ||
                user.username
                    .toLowerCase()
                    .replaceAll(" ", "")
                    .replaceAll("á", "a")
                    .replaceAll("é", "e")
                    .replaceAll("í", "i")
                    .replaceAll("ó", "o")
                    .replaceAll("ú", "u")
                    .contains(
                      text
                          .toLowerCase()
                          .replaceAll(" ", "")
                          .replaceAll("á", "a")
                          .replaceAll("é", "e")
                          .replaceAll("í", "i")
                          .replaceAll("ó", "o")
                          .replaceAll("ú", "u"),
                    ),
          )
          .toList();
    });
  }

  void _filterByAllies(String text) {
    setState(() {
      alliesList = alliesList
          .where(
            (ally) =>
                ally.name
                    .toLowerCase()
                    .replaceAll(" ", "")
                    .replaceAll("á", "a")
                    .replaceAll("é", "e")
                    .replaceAll("í", "i")
                    .replaceAll("ó", "o")
                    .replaceAll("ú", "u")
                    .contains(
                      text
                          .toLowerCase()
                          .replaceAll(" ", "")
                          .replaceAll("á", "a")
                          .replaceAll("é", "e")
                          .replaceAll("í", "i")
                          .replaceAll("ó", "o")
                          .replaceAll("ú", "u"),
                    ) ||
                ally.username
                    .toLowerCase()
                    .replaceAll(" ", "")
                    .replaceAll("á", "a")
                    .replaceAll("é", "e")
                    .replaceAll("í", "i")
                    .replaceAll("ó", "o")
                    .replaceAll("ú", "u")
                    .contains(
                      text
                          .toLowerCase()
                          .replaceAll(" ", "")
                          .replaceAll("á", "a")
                          .replaceAll("é", "e")
                          .replaceAll("í", "i")
                          .replaceAll("ó", "o")
                          .replaceAll("ú", "u"),
                    ),
          )
          .toList();
    });
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  void _getUsers() {
    setState(() {
      isLoading = true;
    });
    LogMessage.get("USERS");
    References.users.get().then((querySnapshot) {
      LogMessage.getSuccess("USERS");
      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((userDoc) {
            usersList.add(
              User(
                id: userDoc.id,
                profilePictureURL: userDoc.data()['profilePictureURL'],
                name: userDoc.data()['name'],
                username: userDoc.data()['username'],
                email: userDoc.data()['email'],
                addresses: userDoc.data()["addresses"]
                    .map(
                      (addressMap) => Address(
                        address: addressMap['address'],
                        city: addressMap['city'],
                        country: addressMap['country'],
                        isPrincipal: addressMap['isPrincipal'],
                      ),
                    )
                    .toList(),
                emeralds: userDoc.data()["esmeraldas"],
                phoneNumber: PhoneNumberCumbia(
                  dialingCode: userDoc.data()["phoneNumber"]["dialingCode"],
                  basePhoneNumber: userDoc.data()["phoneNumber"]
                      ["basePhoneNumber"],
                ),
                roles: UserRoles(
                  isMerchant: userDoc.data()["roles"]["isMerchant"],
                ),
              ),
            );
          });
          viewersList =
              usersList.where((user) => !user.roles.isMerchant).toList();
          alliesList =
              usersList.where((user) => user.roles.isMerchant).toList();
        }
      });
    }).catchError((e) {
      LogMessage.getError("USERS", e);
    });
    setState(() {
      isLoading = false;
    });
  }
}
