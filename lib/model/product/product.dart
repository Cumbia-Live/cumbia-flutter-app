import 'dart:io';

import '../models.dart';

class Product {
  String id;
  String uid;
  String idProduct;
  String mainProductId;
  User mercahnt;
  String imageUrl;
  String productName;
  String description;
  String reference;
  double height;
  double large;
  double width;
  double weight;
  int avaliableUnits;
  int price;
  File auxImage;
  String color;
  String dimension;
  String size;
  String material;
  String style;
  bool isSelected;
  bool isCheckout;
  bool isVariant;
  int emeralds;
  double comission;
  int unitsCheckout;
  int unitsCarrito;
  bool isReceived;
  bool rated;
  int rate;
  List<Review> reviews = [];

  Product({
    this.id,
    this.uid,
    this.idProduct,
    this.mainProductId,
    this.mercahnt,
    this.imageUrl,
    this.productName,
    this.description,
    this.reference,
    this.height,
    this.large,
    this.width,
    this.weight,
    this.avaliableUnits,
    this.price,
    this.auxImage,
    this.color,
    this.dimension,
    this.size,
    this.material,
    this.style,
    this.isSelected = false,
    this.isCheckout = false,
    this.isReceived = false,
    this.isVariant,
    this.comission,
    this.emeralds,
    this.unitsCarrito = 1,
    this.unitsCheckout = 1,
    this.rated = false,
    this.rate = 0,
  });
}
