import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/config/config.dart';

class LoadUsers {
  final pushNotification = PushNotification();

  void sendNotificationCreateLiveTopic() {
    pushNotification.sendNotificationToToken('buyer', "Ingresa a livestream",
        "Una tienda acaba de iniciar un stream, Ve y hecha un vistazo.");
  }

  void sendNotificationUserIsCreatedTopic() {
    pushNotification.sendNotificationToToken(
        'admin',
        "Solicitud de registro de usuario",
        "Se ha recibido una solicitud de registro para un nuevo usuario, Ve y hecha un vistazo.");
  }

  void sendNotificationProductIsCreatedTopic() {
    pushNotification.sendNotificationToToken(
        'admin',
        "Solicitud de registro de usuario",
        "Se ha recibido una solicitud de registro para un nuevo producto, Ve y hecha un vistazo.");
  }

  void sendNotificationApprovedSellerToken(User seller) {
    pushNotification.sendNotificationToToken(
        seller.pushToken,
        "Solicitud Aprovada",
        "${seller.name} Has sido aceptado como vendedor, Felicitaciones!!!");
  }

  void sendNotificationBuyProductToken(User seller) {
    pushNotification.sendNotificationToToken(seller.pushToken,
        "Producto Vendido", "Has realizado una venta, Felicitaciones!!!");
  }

  void prueba(User seller) {
    pushNotification.sendNotificationToToken(seller.pushToken,
        "Producto Vendido", "Has realizado una venta, Felicitaciones!!!");
  }
}
