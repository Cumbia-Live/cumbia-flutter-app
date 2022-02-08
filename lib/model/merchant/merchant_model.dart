import '../models.dart';

class Merchant {
  String id;
  String shopName;
  String pickUpPoint;
  User user;
  String userId;
  String phoneNumber;
  String email;
  String instagram;
  String webPage;
  String category1;
  String category2;
  String nit;
  String razonSocial;
  bool colombianProducts;
  bool isOpen;
  Rate rate;

  String storeAddress;
  String storeLat;
  String storeLng;

  Merchant({
    this.id,
    this.shopName,
    this.pickUpPoint,
    this.user,
    this.userId,
    this.phoneNumber,
    this.email,
    this.instagram,
    this.webPage,
    this.category1,
    this.category2,
    this.nit,
    this.razonSocial,
    this.colombianProducts,
    this.isOpen,
    this.rate,
  });
}

class Rate {
  int rateA;
  int rateB;
  int rateC;
  int rateD;
  int rateE;
  int rateF;

  Rate({
    this.rateA,
    this.rateB,
    this.rateC,
    this.rateD,
    this.rateE,
    this.rateF,
  });
}
