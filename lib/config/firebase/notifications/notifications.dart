import 'dart:async';
import 'dart:convert';
import 'package:cumbialive/config/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

//Token
//cIMdZEx_QK2VNPiNzPElCF:APA91bH_1pSXnIy7AdFtwR32BPBQ025D0aMhsNVI2AAmkDRiRvHSVY1WL7LEhFPW_Qm3tsalf1aFBfOvdoVEzhXWkQsU26Sxv3Wc5UpIq7g4_dut6JpNpCYoDBKKZLwL7UpzSgNLjQSB

class PushNotification {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _notificationsStream =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get mensaje => _notificationsStream.stream;

  initNotifications() {
    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((token) {
      if (user.pushToken != token) {
        print("ASIGNARÉ TOKEN A USER");
        assignTokenToUser(token, user.id);
      } else {
        print("✔️ TOKEN IDENTIFICADO");
      }
    }).catchError((e) {
      print("ERROR AL OBTENER TOKEN: $e");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _notificationsStream.sink.add(message.data);

    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _notificationsStream.sink.add(message.data);

    });

    /*_firebaseMessaging.configure(
      onMessage: (data) {
        print("ON MESSAGE: $data");
        _notificationsStream.sink.add(data);
      },
      onResume: (data) {
        print("ON RESUME: $data");
        _notificationsStream.sink.add({});
      },
      onLaunch: (data) {
        print("ON LAUNCH: $data");
        _notificationsStream.sink.add({});
      },
    );*/
  }

  assignTokenToUser(String token, String userId) {
    Map<String, dynamic> userMap = {
      "pushToken": token,
    };
    FirebaseFirestore.instance
        .doc("users/$userId")
        .update(userMap)
        .then((value) {
      user.pushToken = token;
      print("✔️ TOKEN ASIGNADO");
      _firebaseMessaging.subscribeToTopic("buyer").then((r) {
        print("✔️ SUSCRITO AL TOPIC BUYER");
      }).catchError((e) {
        print("ERROR AL SUSCRIBIR AL TOPIC BUYER: $e");
      });
      if (user.roles.isAdmin) {
        _firebaseMessaging.subscribeToTopic("admin").then((r) {
          print("✔️ SUSCRITO AL TOPIC ADMIN");
        }).catchError((e) {
          print("ERROR AL SUSCRIBIR AL TOPIC ADMIN: $e");
        });
      }
      if (user.roles.isMerchant) {
        _firebaseMessaging.subscribeToTopic("merchant").then((r) {
          print("✔️ SUSCRITO AL TOPIC MERCHANT");
        }).catchError((e) {
          print("ERROR AL SUSCRIBIR AL TOPIC MERCHANT: $e");
        });
      }
    }).catchError((e) {
      print("ERROR AL ASIGNAR TOKEN: $e");
    });
  }

  dispose() {
    _notificationsStream?.close();
  }

  Future<Map<String, dynamic>> sendNotificationToTopic(
      String topic, String title, String body) async {
    final String serverToken =
        "AAAAFuarAE4:APA91bErU0VtRxUYm-E4gOEb_-J__CH7NW8JVvK3LAfTHFOTDbH4YAHMWyhQZTu3btesenG4an2BRSnCoIne1fZc4NjCT-tq4z2XxYyDTn8S8mU2p6tqjOOs7Fo4KiGT7GlJT3CuQE5C";
    //"AAAAqtXYwsY:APA91bG-M9q1X7E5C5m0Ad2aX8ksVrgtk4LvHBhZDR2iVTpQ3SfoMmu7a162SjbDGSkFZUM2qxQreh_ORu4z2I4M30ZnDF4elA2UXG0bW6Y6W45AbwJ23O-rLxxIUvwbuuvOKufsSKY1";
    Uri myUri = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final response = await http
        .post(
      myUri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          "to": "/topics/$topic",
          "notification": <String, dynamic>{
            "title": "$title",
            "body": "$body",
            "sound": "default",
            "badge": 1,
          },
          "priority": "high",
          "data": <String, dynamic>{
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "status": "done",
          },
        },
      ),
    )
        .catchError((e) {
      print("ERROR AL POST NOTIF: $e");
    });

    print("RESPONSE: ${response.body}");
  }

  Future<Map<String, dynamic>> sendNotificationToToken(
      String token, String title, String body) async {
    final String serverToken =
        "AAAAFuarAE4:APA91bErU0VtRxUYm-E4gOEb_-J__CH7NW8JVvK3LAfTHFOTDbH4YAHMWyhQZTu3btesenG4an2BRSnCoIne1fZc4NjCT-tq4z2XxYyDTn8S8mU2p6tqjOOs7Fo4KiGT7GlJT3CuQE5C";
    //"AAAAqtXYwsY:APA91bG-M9q1X7E5C5m0Ad2aX8ksVrgtk4LvHBhZDR2iVTpQ3SfoMmu7a162SjbDGSkFZUM2qxQreh_ORu4z2I4M30ZnDF4elA2UXG0bW6Y6W45AbwJ23O-rLxxIUvwbuuvOKufsSKY1";

    Uri myUri = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final response = await http
        .post(
      myUri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          "to": "$token",
          "notification": <String, dynamic>{
            "title": "$title",
            "body": "$body",
            "sound": "default",
            "badge": 1,
          },
          "priority": "high",
          "data": <String, dynamic>{
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "status": "done",
          },
        },
      ),
    )
        .catchError((e) {
      print("ERROR AL POST NOTIF: $e");
    });

    print("RESPONSE: ${response.body}");
  }

  Future<Map<String, dynamic>> sendNotificationToTokens(
      List<String> tokens, String title, String body) async {
    final String serverToken =
        "AAAAFuarAE4:APA91bErU0VtRxUYm-E4gOEb_-J__CH7NW8JVvK3LAfTHFOTDbH4YAHMWyhQZTu3btesenG4an2BRSnCoIne1fZc4NjCT-tq4z2XxYyDTn8S8mU2p6tqjOOs7Fo4KiGT7GlJT3CuQE5C";
    //"AAAAqtXYwsY:APA91bG-M9q1X7E5C5m0Ad2aX8ksVrgtk4LvHBhZDR2iVTpQ3SfoMmu7a162SjbDGSkFZUM2qxQreh_ORu4z2I4M30ZnDF4elA2UXG0bW6Y6W45AbwJ23O-rLxxIUvwbuuvOKufsSKY1";
    Uri myUri = Uri.parse('https://fcm.googleapis.com/fcm/send');


    final response = await http
        .post(
      myUri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          "registration_ids": tokens,
          "notification": <String, dynamic>{
            "title": "$title",
            "body": "$body",
            "sound": "default",
            "badge": 1,
          },
          "priority": "high",
          "data": <String, dynamic>{
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "status": "done",
          },
        },
      ),
    )
        .catchError((e) {
      print("ERROR AL POST NOTIF: $e");
    });

    print("RESPONSE: ${response.body}");
  }
}
