// Este es el modelo base de todos los usuarios.

import 'package:cumbialive/model/models.dart';

class User {
  String id; // Id del usuario
  String name; // Nombre del usuario
  String email; // Email del usuario
  String username; // Username del usuario
  PhoneNumberCumbia phoneNumber; // Celular del usuario
  String profilePictureURL; // Foto de screens.perfil del usuario
  String pushToken; // Token para notificaciones push
  UserRoles roles; // Determina si tiene permisos de Admin o Merchant
  int emeralds; // Número de esmeraldas del usuario
  int puntosCumbia; // Puntos cumbia del vendedor
  List<dynamic> addresses; // Direcciones del usuario
  bool onLive; // Si el usuario está haciendo un en vivo
  LiveCategory category;

  User({
    this.id,
    this.name,
    this.email,
    this.username,
    this.profilePictureURL,
    this.phoneNumber,
    this.pushToken,
    this.roles,
    this.addresses,
    this.emeralds,
    this.puntosCumbia,
    this.onLive,
    this.category,
  });
}

// Esta clase nos ayudará a gestionar el número del celular del usuario
// incluyendo su dialingCode y basePhoneNumber. Y contiene la función
// completePhoneNumber() que retorna el número completo con su indicativo.
// EJEMPLO:
//   PhoneNumber phoneNumber = PhoneNumber("+57", "3234975584");
//   print(phoneNumber.dialingCode);            -> +57
//   print(phoneNumber.basePhoneNumber);        -> 3211234567
//   print(phoneNumber.completePhoneNumber());  -> +573211234567
class PhoneNumberCumbia {
  String dialingCode; // Indicativo/Prefijo de acuerdo al país
  String basePhoneNumber; // Número base del celular
  String completePhoneNumber() => "$dialingCode$basePhoneNumber";

  PhoneNumberCumbia({
    this.dialingCode,
    this.basePhoneNumber,
  });
}

// Esta clase determina si un usuario tiene permisos de Admin o Merchant
class UserRoles {
  bool isMerchant;
  bool isAdmin;

  UserRoles({
    this.isAdmin,
    this.isMerchant,
  });
}
