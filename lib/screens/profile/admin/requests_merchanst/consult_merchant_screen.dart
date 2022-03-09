import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../screens.dart';

class ConsultMerchantScreen extends StatefulWidget {
  @override
  _ConsultMerchantScreenState createState() => _ConsultMerchantScreenState();
}

class _ConsultMerchantScreenState extends State<ConsultMerchantScreen> {
  List<Merchant> merchants = [];

  bool isLoadingMerchants = false;

  @override
  void initState() {
    super.initState();

    _getMerchant();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Palette.white,
            title: Text(
              "Solicitudes",
              style: Styles.navTitleLbl,
            ),
            leading: CupertinoNavigationBarBackButton(
              color: Palette.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            actions: [],
          ),
          isLoadingMerchants
              ? _loadingLayout()
              : merchants.isNotEmpty
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, position) {
                          return CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => DetailMerchantScreen(
                                    merchant: merchants[position],
                                  ),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  merchants.removeWhere(
                                      (merchant) => merchant.id == result);
                                  isLoadingMerchants = false;
                                });
                              } else {
                                _getMerchant();
                              }
                            },
                            child: setupMerchantListLayout(position),
                          );
                        },
                        childCount: merchants.length,
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        color: Palette.white,
                        child: Center(
                          child: Text(
                            "No hay solicitudes\npendientes a revisar",
                            textAlign: TextAlign.center,
                            style: Styles.shortMessageLbl(),
                          ),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }

  Widget setupMerchantListLayout(int position) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
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
                image: NetworkImage(merchants[position]
                                ?.user
                                ?.profilePictureURL !=
                            "" &&
                        merchants[position]?.user?.profilePictureURL != null
                    ? merchants[position]?.user?.profilePictureURL
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
              Text(
                "${merchants[position].user.username}  ",
                textAlign: TextAlign.start,
                style: Styles.titleLive,
              ),
              const SizedBox(height: 5),
              Text("${merchants[position].category1}",
                  style: Styles.labelAdmin),
              const SizedBox(height: 5),
              Text("${merchants[position].category2}", style: Styles.labelAdmin)
            ],
          )
        ],
      ),
    );
  }

  Widget _loadingLayout() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, position) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Palette.black.withOpacity(0.5),
                highlightColor: Palette.black.withOpacity(0.2),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Palette.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ///Nombre y comprador
                  Container(
                      height: 10,
                      width: MediaQuery.of(context).size.width - 130,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Shimmer.fromColors(
                              baseColor: Palette.black.withOpacity(0.5),
                              highlightColor: Palette.black.withOpacity(0.2),
                              child: Container(
                                height: 15,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: Palette.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                        height: 10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 17),
                              child: Row(
                                children: <Widget>[
                                  Shimmer.fromColors(
                                    baseColor: Palette.black.withOpacity(0.5),
                                    highlightColor:
                                        Palette.black.withOpacity(0.2),
                                    child: Container(
                                      height: 15,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: BoxDecoration(
                                        color: Palette.black.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      childCount: 5,
    ));
  }

  Future<void> _getMerchant() async {
    setState(() {
      isLoadingMerchants = true;
    });
    LogMessage.get("MERCHANT");
    References.merchant
        .where("isApproved", isEqualTo: false)
        .where("isRejected", isEqualTo: false)
        .snapshots()
        .listen((querySnapshot) {
      merchants.clear();
      LogMessage.getSuccess("MERCHANT");
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          isLoadingMerchants = false;
        });

        querySnapshot.docs.forEach((merchantStream) {
          LogMessage.get("USERS");
          References.users
              .doc(merchantStream.data()["userId"])
              .get()
              .then((userDoc) {
            LogMessage.getSuccess("USERS");
            setState(() {
              isLoadingMerchants = false;
            });

            if (userDoc.data().isNotEmpty) {
              merchants.add(
                Merchant(
                  id: merchantStream.id,
                  user: User(
                    id: merchantStream.data()["userId"],
                    name: userDoc.data()["name"],
                    username: userDoc.data()["username"],
                    email: userDoc.data()["email"],
                    onLive: userDoc.data()["onLive"],
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
                ),
              );
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
}
