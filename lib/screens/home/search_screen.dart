import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/shop/shop_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/text_field.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  /// Lista de en vivos activos dentro del qpp
  List<Live> liveList = [];

  /// Lista de tiendas
  List<Merchant> merchantList = [];

  /// Listas provisionales para la búsqueda
  List<Live> liveListBackUp = [];

  List<Merchant> merchantListBackUp = [];

  String search = "";

  bool isSearching = false;

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _getLive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Palette.bgColor,
          leading: CupertinoNavigationBarBackButton(
            color: Palette.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Buscar",
            style: Styles.navTitleLbl,
          ),
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
              child: CustomTextField(
                autofocus: true,
                initialValue: searchText,
                suffixWidget: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.search,
                    color: Palette.black.withOpacity(0.25),
                  ),
                ),
                placeholder: "Buscar por tienda o categoría",
                onChanged: (text) {
                  searchText = text;
                  setState(() {
                    search = text;
                  });
                  _filterByLive(text);
                  _filterByShop(text);
                  if (text == "") {
                    liveListBackUp.clear();
                    merchantListBackUp.clear();
                  }
                },
              ),
            ),
          ),
          bottom: TabBar(
            unselectedLabelColor: Palette.black.withOpacity(0.3),
            labelColor: Palette.cumbiaLight,
            tabs: [
              Tab(
                child: Text(
                  'Livestreams',
                ),
              ),
              Tab(
                child: Text(
                  'Tiendas',
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
          liveListBackUp.isEmpty && search != ""
              ? Expanded(
                  child: Container(
                    color: Palette.bgColor,
                    child: Center(
                      child: Text(
                        "No hay resultados que\ncoincidan con tu búsqueda",
                        textAlign: TextAlign.center,
                        style: Styles.shortMessageLbl(),
                      ),
                    ),
                  ),
                )
              : Container(
                  color: Palette.bgColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                    child: Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, position) {
                          return setupLiveListLayout(position);
                        },
                        itemCount: liveListBackUp.length,
                      ),
                    ),
                  ),
                ),
          merchantListBackUp.isEmpty && search != ""
              ? Expanded(
                  child: Container(
                    color: Palette.bgColor,
                    child: Center(
                      child: Text(
                        "No hay resultados que\ncoincidan con tu búsqueda",
                        textAlign: TextAlign.center,
                        style: Styles.shortMessageLbl(),
                      ),
                    ),
                  ),
                )
              : Container(
                  color: Palette.bgColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                    child: Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, position) {
                          return setupMerchantListLayout(position);
                        },
                        itemCount: merchantListBackUp.length,
                      ),
                    ),
                  ),
                ),
        ],
        controller: _tabController,
      ),
    );
  }

  /// FRONT
  Widget setupLiveListLayout(int position) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: 80,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Palette.skeleton,
                  image: DecorationImage(
                    image: NetworkImage(liveListBackUp[position]?.imageUrl !=
                                "" ||
                            liveListBackUp[position]?.imageUrl != null
                        ? liveListBackUp[position].imageUrl
                        : "https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2FliveImage.png?alt=media&token=d9c84a2f-92e8-4f4f-9f79-17b82c992016"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Container(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      "${liveListBackUp[position].streamer.username}  ",
                      textAlign: TextAlign.start,
                      style: Styles.titleLive,
                    ),
                    const SizedBox(height: 5),
                    Text("${liveListBackUp[position].categoryLive.name}",
                        style: Styles.labelAdmin),
                    Expanded(
                      child: Container(),
                    )
                  ],
                ),
              ),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.chevron_right,
                  color: Palette.black.withOpacity(0.3),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(5),
            height: 80,
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Palette.red,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text("EN VIVO", style: Styles.liveLbl),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget setupMerchantListLayout(int position) {
    return GestureDetector(
      onTap: () async {
        List<Product> p = [];
        await References.products
            .where('uid', isEqualTo: user.id)
            .get()
            .then((QuerySnapshot value) => {
                  for (var i = 0; i < value.docs.length; i++)
                    {
                      p.add(new Product(
                          imageUrl: value.docs
                              .elementAt(i)['productInfo']['imageUrl'],
                          productName: value.docs
                              .elementAt(i)['productInfo']['productName'],
                          description: value.docs
                              .elementAt(i)['productInfo']['description'],
                          avaliableUnits: value.docs
                              .elementAt(i)['avaliableUnits'],
                          id: value.docs.elementAt(i).id,
                          price:
                              value.docs.elementAt(i)['emeralds'])),
                    }
                })
            .then((value) => {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      settings: RouteSettings(name: "/ShopPage"),
                      builder: (context) =>
                          ShopScreen(merchantListBackUp[position], p),
                    ),
                  )
                });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Palette.skeleton,
                image: DecorationImage(
                  image: NetworkImage(merchantListBackUp[position]
                                  ?.user
                                  ?.profilePictureURL !=
                              "" &&
                          merchantListBackUp[position]
                                  ?.user
                                  ?.profilePictureURL !=
                              null
                      ? merchantListBackUp[position]?.user?.profilePictureURL
                      : "https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2FliveImage.png?alt=media&token=d9c84a2f-92e8-4f4f-9f79-17b82c992016"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${merchantListBackUp[position].shopName}  ",
                      textAlign: TextAlign.start,
                      style: Styles.titleLive,
                    ),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          color: Palette.red, shape: BoxShape.circle),
                    ),
                    Text(" En vivo", style: Styles.labelAdmin)
                  ],
                ),
                const SizedBox(height: 5),
                Text("${merchantListBackUp[position].category1}",
                    style: Styles.labelAdmin),
                const SizedBox(height: 5),
                Text("${merchantListBackUp[position].category2}",
                    style: Styles.labelAdmin)
              ],
            )
          ],
        ),
      ),
    );
  }

  void _filterByLive(String text) {
    setState(() {
      liveListBackUp = liveList
          .where((live) =>
              live.streamer.name
                  .toLowerCase()
                  .replaceAll(" ", "")
                  .replaceAll("á", "a")
                  .replaceAll("é", "e")
                  .replaceAll("í", "i")
                  .replaceAll("ó", "o")
                  .replaceAll("ú", "u")
                  .contains(text
                      .toLowerCase()
                      .replaceAll(" ", "")
                      .replaceAll("á", "a")
                      .replaceAll("é", "e")
                      .replaceAll("í", "i")
                      .replaceAll("ó", "o")
                      .replaceAll("ú", "u")) ||
              live.categoryLive.name
                  .toLowerCase()
                  .replaceAll(" ", "")
                  .replaceAll("á", "a")
                  .replaceAll("é", "e")
                  .replaceAll("í", "i")
                  .replaceAll("ó", "o")
                  .replaceAll("ú", "u")
                  .contains(text
                      .toLowerCase()
                      .replaceAll(" ", "")
                      .replaceAll("á", "a")
                      .replaceAll("é", "e")
                      .replaceAll("í", "i")
                      .replaceAll("ó", "o")
                      .replaceAll("ú", "u")))
          .toList();
    });
  }

  void _filterByShop(String text) {
    setState(() {
      merchantListBackUp = merchantList
          .where((merchant) =>
              merchant.shopName
                  .toLowerCase()
                  .replaceAll(" ", "")
                  .replaceAll("á", "a")
                  .replaceAll("é", "e")
                  .replaceAll("í", "i")
                  .replaceAll("ó", "o")
                  .replaceAll("ú", "u")
                  .contains(text
                      .toLowerCase()
                      .replaceAll(" ", "")
                      .replaceAll("á", "a")
                      .replaceAll("é", "e")
                      .replaceAll("í", "i")
                      .replaceAll("ó", "o")
                      .replaceAll("ú", "u")) ||
              merchant.category1
                  .toLowerCase()
                  .replaceAll(" ", "")
                  .replaceAll("á", "a")
                  .replaceAll("é", "e")
                  .replaceAll("í", "i")
                  .replaceAll("ó", "o")
                  .replaceAll("ú", "u")
                  .contains(text
                      .toLowerCase()
                      .replaceAll(" ", "")
                      .replaceAll("á", "a")
                      .replaceAll("é", "e")
                      .replaceAll("í", "i")
                      .replaceAll("ó", "o")
                      .replaceAll("ú", "u")) ||
              merchant.category2
                  .toLowerCase()
                  .replaceAll(" ", "")
                  .replaceAll("á", "a")
                  .replaceAll("é", "e")
                  .replaceAll("í", "i")
                  .replaceAll("ó", "o")
                  .replaceAll("ú", "u")
                  .contains(text
                      .toLowerCase()
                      .replaceAll(" ", "")
                      .replaceAll("á", "a")
                      .replaceAll("é", "e")
                      .replaceAll("í", "i")
                      .replaceAll("ó", "o")
                      .replaceAll("ú", "u")))
          .toList();
    });
  }

  Future<void> _getLive() async {
    LogMessage.get("EN VIVOS");
    References.lives
        .where("onLive", isEqualTo: false)
        .snapshots()
        .listen((querySnapshot) {
      liveList.clear();
      LogMessage.getSuccess("EN VIVOS");
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((liveStream) {
          LogMessage.get("USERS");
          References.users
              .doc(liveStream.data()["broadcasterId"])
              .get()
              .then((userDoc) {
            LogMessage.getSuccess("USERS");
            if (userDoc.data().isNotEmpty) {
              liveList.add(
                Live(
                    id: liveStream.id,
                    streamer: User(
                      id: liveStream.data()["broadcasterId"],
                      name: userDoc.data()["name"],
                      username: userDoc.data()["username"],
                      email: userDoc.data()["email"],
                    ),
                    imageUrl: liveStream.data()["thumbnailURL"],
                    onLive: liveStream.data()["onLive"],
                    categoryLive:
                        LiveCategory(name: liveStream.data()["category"]["name"]),
                    labelLive: liveStream.data()["title"],
                    startDate: liveStream.data()["dates"]["startDate"]),
              );
            }
          }).catchError((e) {
            LogMessage.getError("USERS", e);
          });
        });
      }
      _getMerchant();
    }).onError((e) {
      LogMessage.getError("EN VIVOS", e);
      setState(() {
        // isLoadingCategoriesLayout = false;
      });
    });
  }

  Future<void> _getMerchant() async {
    LogMessage.get("MERCHANT");
    References.merchant
        .where("isApproved", isEqualTo: true)
        .snapshots()
        .listen((querySnapshot) {
      merchantList.clear();
      LogMessage.getSuccess("MERCHANT");
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((merchantStream) {
          LogMessage.get("USERS");
          References.users
              .doc(merchantStream.data()["userId"])
              .get()
              .then((userDoc) {
            LogMessage.getSuccess("USERS");
            if (userDoc.data().isNotEmpty) {
              merchantList.add(
                Merchant(
                    id: merchantStream.id,
                    user: User(
                        id: merchantStream.data()["userId"],
                        name: userDoc.data()["name"],
                        username: userDoc.data()["username"],
                        email: userDoc.data()["email"],
                        onLive: userDoc.data()["onLive"]),
                    shopName: merchantStream.data()["shopName"],
                    category1: merchantStream.data()["principalCategory"],
                    category2: merchantStream.data()["secondaryCategory"],
                  storeLocation: Address(
                    address: merchantStream.data()['storeLocation'] != null ? merchantStream.data()['storeLocation']['address'] :"",
                    city: merchantStream.data()['storeLocation'] != null ?merchantStream.data()['storeLocation']['city']:"",
                    country:merchantStream.data()['storeLocation'] != null ?merchantStream.data()['storeLocation']['country']:"",
                    state: merchantStream.data()['storeLocation'] != null ?merchantStream.data()['storeLocation']['state']:"",
                  ),),
              );
            }
          }).catchError((e) {
            LogMessage.getError("USERS", e);
          });
        });
      }
    }).onError((e) {
      LogMessage.getError("MERCHANT", e);
    });
  }
}
