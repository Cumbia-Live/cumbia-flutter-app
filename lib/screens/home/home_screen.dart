import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/model/live/live_model.dart';
import 'package:cumbialive/screens/live/merchant_live/live_stream/audience_onlive_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../screens.dart';
import 'package:cumbialive/screens/store_profile/profile_store.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoadingMerchants = false;
  final notification = LoadUsers();

  /// Lista de en vivos activos dentro del qpp
  List<Live> liveList = [];
  List<Merchant> lstTiendas = [];

  /// Listas provisionales para las búsquedas
  List<Live> liveBackUp = [];
  List<User> shopsBackUp = [];
  List<Merchant> lstTiendasCategoria = [];

  /// Categoría que se muestra en el label del aún no
  String categoria = 'Turismo';

  /// Key que se utiliza en el swipe to refresh
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool isFiltered = false;
  String selectedCategoryId;

  @override
  void initState() {
    onInit();
    super.initState();
  }

  Future<void> onInit() async {
    await _getMerchant();
    await _getCategories();
    await _getLive();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Palette.bgColor,
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _reload,
            color: Palette.cumbiaDark,
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  fiterByCategoryBar(),
                  !_isFilteredByCategory()
                      ? liveList.isEmpty && lstTiendas.isEmpty
                          ? withoutResultsPage(false, true)
                          : sizedBoxShrink()
                      : sizedBoxShrink(),
                  _isFilteredByCategory()
                      ? liveBackUp.isEmpty && lstTiendasCategoria.isEmpty
                          ? withoutResultsPage(false, false)
                          : liveBackUp.isNotEmpty && lstTiendasCategoria.isEmpty
                              ? horizontalLiveListWithoutShops()
                              : shopsGridWithFilter()
                      : sizedBoxShrink()
                ],
              ),
            )),
      ),
    );
  }

  /// ::::::::::::: FRONT ::::::::::::: ///

  // TODO: WIDGETS QUE POPULAN SLIVERGRID O SLIVERLIST
  Widget fiterByCategoryBar() => SliverToBoxAdapter(
        child: Container(
          height: 64,
          width: MediaQuery.of(context).size.width,
          color: Palette.bgColor,
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, position) {
                    return CumbiaCategoryFilter(
                      title: categories[position].name,
                      isSelected: categories[position].isSelected,
                      onPressed: () {
                        setState(() {
                          categoria = categories[position].name;
                          categories.forEach((categoria) {
                            if (categories[position] == categoria) {
                              categoria.isSelected = true;
                              selectedCategoryId = categoria.id;
                            } else {
                              categoria.isSelected = false;
                            }
                          });
                          liveBackUp.clear();
                          _filterLiveByCategory();
                          lstTiendasCategoria.clear();
                          _filterShopsByCategory();
                        });
                      },
                    );
                  },
                  itemCount: categories.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    child: Icon(
                      Icons.search,
                      color: Palette.black.withOpacity(0.4),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget withoutResultsPage(bool isShop, bool withoutFilter) =>
      SliverToBoxAdapter(
        child: Container(
            color: Palette.bgColor,
            height: !isShop
                ? MediaQuery.of(context).size.height * 0.75
                : MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  withoutFilter
                      ? "Aún no hay en vivos para mostrar"
                      : "Aún no hay tiendas\nautorizadas en $categoria",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CumbiaButton(
                  backgroundColor: Palette.cumbiaLight,
                  onPressed: () {},
                  title: "Abrir mi tienda",
                  width: 150,
                  canPush: true,
                )
              ],
            )),
      );

  Widget horizontalLiveListWithoutShops() => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, position) {
                    return setupListLayout(position);
                  },
                  itemCount: liveBackUp.length,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Tiendas',
                    style: Styles.txtTextLbl(weight: FontWeight.w600),
                  ),
                ],
              ),
              Container(
                  color: Palette.bgColor,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Aún no hay tiendas\nautorizadas en $categoria",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      CumbiaButton(
                        backgroundColor: Palette.cumbiaLight,
                        onPressed: () {},
                        title: "Abrir mi tienda",
                        width: 150,
                        canPush: true,
                      )
                    ],
                  )),
            ],
          ),
        ),
      );

  Widget sizedBoxShrink() => SliverToBoxAdapter(
        child: const SizedBox.shrink(),
      );

  Widget shopsLabel() => SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
        sliver: SliverToBoxAdapter(
          child: Text(
            'Tiendas',
            style: Styles.txtTextLbl(weight: FontWeight.w600),
          ),
        ),
      );

  Widget shopsGridWithFilter() => SliverToBoxAdapter(
        child: Column(
          children: [
            _isLive()
                ? Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {
                        return setupListLayout(position);
                      },
                      itemCount: liveBackUp.length,
                    ),
                  )
                : Container(
                    height: 10,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    'Tiendas',
                    style: Styles.txtTextLbl(weight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Container(
              child: lstTiendasCategoria.isNotEmpty
                  ? Container(
                      height: ((MediaQuery.of(context).size.width * 0.5) *
                              this.tamanoGrid(lstTiendasCategoria)) +
                          20,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: lstTiendasCategoria.length,
                        itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                            onTap: () {
                              notification
                                  .sendNotificationProductIsCreatedTopic();
                              // Navigator.push(
                              //   context,
                              //   CupertinoPageRoute(
                              //     builder: (context) => ProfileStoreScreen(
                              //       tienda: lstTiendasCategoria[index],
                              //     ),
                              //   ),
                              // );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: (MediaQuery.of(context).size.width *
                                          0.3) -
                                      30,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        lstTiendasCategoria[index]
                                            .user
                                            .profilePictureURL,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 200,
                                      ),
                                      child: Text(
                                        lstTiendasCategoria[index].razonSocial,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Palette.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                // isLiveMerchant(lstTiendasCategoria[index])
                                //     ? Row(
                                //         children: [
                                //           Container(
                                //             height: 5,
                                //             width: 5,
                                //             decoration: BoxDecoration(
                                //                 color: Palette.red,
                                //                 shape: BoxShape.circle),
                                //           ),
                                //           Text(" En vivo",
                                //               style: Styles.labelAdmin)
                                //         ],
                                //       )
                                //     : const SizedBox.shrink(),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "        Aún no hay Tiendas\nautorizadas",
                          style: Styles.ulTransmision,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      );

  /// TODO: WIDGETS QUE POPULAN SLIVERGRID O SLIVERLIST

  // Lista de todas las tiendas cuando no hay ningún flitro
  Widget setupGridLayout(int index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          height: MediaQuery.of(context).size.width * 0.3,
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            color: Palette.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Palette.grey),
          ),
          child: Stack(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ProfileStoreScreen(
                        tienda: lstTiendas[index],
                      ),
                    ),
                  );
                  onJoin(liveList[index]?.streamer?.email, liveList[index]);
                },
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.28,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(liveList[index]?.imageUrl != "" ||
                                  liveList[index]?.imageUrl != null
                              ? liveList[index].imageUrl
                              : "https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2FliveImage.png?alt=media&token=d9c84a2f-92e8-4f4f-9f79-17b82c992016"),
                          fit: BoxFit.contain)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text("${liveList[index].streamer.username}",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.liveBasicLbl),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  // Grid de tiendas cuando hay un filtro
  Widget setupGridShopsLayout(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
                color: Palette.white,
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: ExactAssetImage(
                    lstTiendasCategoria[index].user.profilePictureURL ??
                        'images/liveImage.png',
                  ),
                  fit: BoxFit.cover,
                )),
          ),
          const SizedBox(height: 8),
          Text("${lstTiendasCategoria[index].razonSocial}"),
          const SizedBox(height: 5),
          isLiveMerchant(lstTiendasCategoria[index])
              ? Row(
                  children: [
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          color: Palette.red, shape: BoxShape.circle),
                    ),
                    Text("En vivo", style: Styles.labelAdmin)
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  // lista horizobtal de en vivos cuando hay un filtro
  Widget setupListLayout(int position) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Column(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  onJoin(liveBackUp[position]?.streamer?.email,
                      liveBackUp[position]);
                },
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.45,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Palette.skeleton,
                    image: DecorationImage(
                      image: NetworkImage(liveBackUp[position]?.imageUrl !=
                                  "" ||
                              liveBackUp[position]?.imageUrl != null
                          ? liveBackUp[position].imageUrl
                          : "https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2FliveImage.png?alt=media&token=d9c84a2f-92e8-4f4f-9f79-17b82c992016"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Palette.red,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text("EN VIVO", style: Styles.liveLbl),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Palette.black.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            "${liveBackUp[position]?.audience ?? 0} ${liveBackUp[position]?.audience == 1 ? "espectador" : "espectadores"}",
                            style: Styles.audienceLiveLbl,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CumbiaDisclaimer(
                name: "${liveBackUp[position].streamer.username}",
                label: "${liveBackUp[position].labelLive}",
              )
            ],
          ),
        ),
      );

  /// FUNCIONES DE BÚSQUEDA

  bool _isFilteredByCategory() {
    isFiltered = false;
    categories.forEach((category) {
      if (category.isSelected ?? false) {
        setState(() {
          isFiltered = true;
        });
      }
    });
    return isFiltered;
  }

  bool _isLive() {
    for (var i = 0; i < liveBackUp.length; i++) {
      for (var j = 0; j < categories.length; j++) {
        if (liveBackUp[i].categoryLive.name == categories[j].name &&
            categories[j].isSelected) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> _filterLiveByCategory() async {
    setState(() {
      categories.forEach((category) {
        liveList.forEach((live) {
          if (live.categoryLive.name == category.name && category.isSelected) {
            liveBackUp.add(live);
          }
        });
      });
    });
  }

  Future<void> _filterShopsByCategory() async {
    lstTiendas.forEach((shop) {
      categories.forEach((category) {
        if (shop.category1 == category.name && category.isSelected) {
          lstTiendasCategoria.add(shop);
        }
      });
    });
  }

  /// FUNCIONES PARA EL EN VIVO

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
  }

  Future<void> onJoin(String channel, Live live) async {
    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AudiencePage(
          channelName: channel,
          role: ClientRole.Audience,
          live: live,
        ),
      ),
    );
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  // Descarga las categorías
  Future<void> _getCategories() {
    LogMessage.get("CATEGORÍAS");
    References.categorias.get().then((querySnapshot) {
      categories.clear();
      LogMessage.getSuccess("CATEGORÍAS");
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          if (selectedCategoryId == null) {
            categories.add(
              LiveCategory(
                  isSelected: doc.data()["isSelected"] ?? false,
                  id: doc.id,
                  name: doc.data()["name"],
                  votes: doc.data()["votes"]),
            );
          } else {
            categories.add(
              LiveCategory(
                  isSelected: selectedCategoryId == doc.id,
                  id: doc.id,
                  name: doc.data()["name"],
                  votes: doc.data()["votes"]),
            );
          }
        });
      }
      setState(() {
        // isLoadingCategoriesLayout = false;
      });
    }).catchError((e) {
      LogMessage.getError("CATEGORÍAS", e);
      setState(() {
        // isLoadingCategoriesLayout = false;
      });
    });
  }

  // Descarga los en vivos
  Future<void> _getLive() async {
    setState(() {
      LogMessage.get("EN VIVOS");
      References.lives
          .where("onLive", isEqualTo: true)
          .snapshots()
          .listen((querySnapshot) {
        liveList.clear();
        LogMessage.getSuccess("EN VIVOS");
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((liveStream) {
            LogMessage.get("USERS");
            References.users.firestore.doc(liveStream.data()["broadcasterId"]).get()
                .then((userDoc) {
              LogMessage.getSuccess("USERS");
              if (userDoc.data().isNotEmpty) {
                liveList.add(
                  Live(
                    id: liveStream.id,
                    streamer: User(
                      id: liveStream.data()["broadcasterId"],
                      name: userDoc.data()["name"],
                      email: userDoc.data()["email"],
                      username: userDoc.data()["username"],
                    ),
                    imageUrl: liveStream.data()["thumbnailURL"],
                    onLive: liveStream.data()["onLive"],
                    categoryLive: LiveCategory(
                      name: liveStream.data()["category"]["name"],
                    ),
                    labelLive: liveStream.data()["title"],
                    startDate: liveStream.data()["dates"]["startDate"],
                  ),
                );
                _filterLiveByCategory();
              }
            }).catchError((e) {
              LogMessage.getError("USERS", e);
            });
          });
        }
      }).onError((e) {
        LogMessage.getError("EN VIVOS", e);
      });
    });
  }

  Future<void> _getMerchant() async {
    setState(() {
      isLoadingMerchants = true;
    });
    LogMessage.get("MERCHANT");
    References.merchant
        .where("isApproved", isEqualTo: true)
        .where("isRejected", isEqualTo: false)
        //.orderBy("onLive")
        .snapshots()
        .listen((querySnapshot) {
      lstTiendas.clear();
      LogMessage.getSuccess("MERCHANT");
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          isLoadingMerchants = false;
        });

        querySnapshot.docs.forEach((merchantStream) {
          LogMessage.get("USERS");
          References.users.firestore
              .doc(merchantStream.data()["userId"]).get()
              .then((userDoc) {
            LogMessage.getSuccess("USERS");
            setState(() {
              isLoadingMerchants = false;
            });

            if (userDoc.data().isNotEmpty) {
              lstTiendas.add(
                Merchant(
                  id: merchantStream.id,
                  user: User(
                    id: merchantStream.data()["userId"],
                    name: userDoc.data()["name"],
                    username: userDoc.data()["username"],
                    email: userDoc.data()["email"],
                    onLive: userDoc.data()["onLive"] ?? false,
                    profilePictureURL: userDoc.data()["profilePictureURL"] ??
                        "https://i.pinimg.com/736x/89/10/8e/89108e533640fd9d0731e0623699c57c.jpg",
                  ),
                  category1: merchantStream.data()["principalCategory"],
                  category2: merchantStream.data()["secondaryCategory"],
                  instagram: merchantStream.data()["instagram"],
                  colombianProducts: merchantStream.data()["colombianProducts"],
                  webPage: merchantStream.data()["webPage"],
                  phoneNumber: merchantStream.data()["phoneNumber"],
                  email: merchantStream.data()["email"],
                  nit: merchantStream.data()["nit"],
                  razonSocial: merchantStream.data()["razonSocial"],
                  shopName: merchantStream.data()["username"],
                ),
              );
              lstTiendasCategoria.clear();
              _filterShopsByCategory();
              setState(() {
                isLoadingMerchants = false;
              });
            }
          }).catchError((e) {
            setState(() {
              isLoadingMerchants = false;
            });

            LogMessage.getError("USERS", e);
          });
        });
      }
      _getLive();
    }).onError((e) {
      setState(() {
        isLoadingMerchants = false;
      });

      LogMessage.getError("MERCHANT", e);
    });
    setState(() {
      isLoadingMerchants = false;
    });
  }

  bool isLiveMerchant(Merchant merchant) {
    if (liveList.isNotEmpty) {
      for (var i = 0; i < liveList.length; i++) {
        if (liveList[i].streamer.name == merchant.user.name) {
          return true;
        }
      }
    }
    return false;
  }

  // Funciones _getLive() y getMerchants() para el swipe to refres
  Future<void> _reload() async {
    await _getLive();
    await _getCategories();
    await _getMerchant();
  }

  double tamanoGrid(List<Merchant> merchant) {
    double cont = 0;
    for (var i = 0; i < merchant.length; i++) {
      if (i % 2 == 0) {
        cont++;
      }
    }
    return cont;
  }
}
