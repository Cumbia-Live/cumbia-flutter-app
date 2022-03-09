import 'dart:io';

import '../models.dart';

class Live {
  String id; // Id del live
  User streamer; // Usuario que inicia al en vivo
  String labelLive; // Breve descripción del en vivo
  LiveCategory categoryLive; // Categoría del en vivo
  bool onLive; // Si está en vivo o no
  int startDate;
  int endDate;
  String imageUrl;
  int audience;
  File auxImage;


  Live({
    this.id,
    this.categoryLive,
    this.audience,
    this.onLive,
    this.streamer,
    this.labelLive,
    this.endDate,
    this.startDate,
    this.imageUrl,
    this.auxImage
  });
}
