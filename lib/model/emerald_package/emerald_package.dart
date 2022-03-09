import 'package:in_app_purchase/in_app_purchase.dart';

class EmeraldPackage {
  EmeraldPackage({
    this.id,
    this.precioCOP,
    this.cantidad,
    this.productDetails,
  });

  final String id; // ID en AppStore, PlayStore y Firestore
  final int precioCOP; // Precio final que ve y paga el usuario
  final int cantidad; // Esmeraldas que recibirá el usuario por la compra
  ProductDetails productDetails;
}
