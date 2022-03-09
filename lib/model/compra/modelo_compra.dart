import '../models.dart';

class Purchase {
  final String id;
  final String uuidStreamer;
  final String uuidBuyer;
  final String details;
  final int datePurchase;
  int dateReceived;
  final int daysToReceive;
  final Address address;
  final List<Product> products = [];
  bool isSend;
  bool received;
  final bool rated;
  final bool failed;
  final int rate;
  final int emeralds;
  final String purchaseType;

  String buyerName = "";
  String streamName = "";

  Purchase({
    this.isSend,
    this.id,
    this.uuidStreamer,
    this.uuidBuyer,
    this.details,
    this.datePurchase,
    this.failed,
    this.dateReceived,
    this.daysToReceive,
    this.address,
    this.received,
    this.rated,
    this.rate,
    this.emeralds,
    this.purchaseType,
  });
}
