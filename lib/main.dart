import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'config/config.dart';
import 'config/constants/campaign_constant.dart';
import 'config/constants/emerald_constants.dart';
import 'model/models.dart';
import 'screens/screens.dart';
import 'functions/functions.dart';
import 'model/users/user_model.dart' as localUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("I am here");


        FirebaseAuth auth = FirebaseAuth.instance; // Instancia a FBAuth
        FirebaseFirestore firestore = FirebaseFirestore.instance; // Instancia a Firestore

        print("I am here");
        getDispositivoType(); // Identifica tipo de dispositivo
        // Descarga las categorías
        LogMessage.get("CATEGORÍAS");
        References.categorias.get().then((querySnapshot) {
          LogMessage.getSuccess("CATEGORÍAS");
          if (querySnapshot.docs.isNotEmpty) {
            print(querySnapshot.docs);
            querySnapshot.docs.forEach((doc) {
              categories.add(
                LiveCategory(
                  isSelected: doc.data()["isSelected"] ?? false,
                  id: doc.id,
                  name: doc.data()["name"],
                  votes: doc.data()["votes"],
                ),
              );
            });
          }
        }).catchError((e) {
          LogMessage.getError("CATEGORÍAS", e);
        });
        LogMessage.get("CONSTANTES");
        References.constants.get().then((constantsDoc) async {
          print(constantsDoc);
          if (constantsDoc.exists) {
            LogMessage.getSuccess("CONSTANTES");
            // Keys de RevenueCat
            rcApiKey = constantsDoc.data()["revenueCat"]["apiKey"];
            // AppId de Agora
            appID = constantsDoc.data()["agora"]["appID"];
            // Determina si debe usar referencias iOS o Android
            Map<String, dynamic> versioning = constantsDoc.data()["versioning"]
            ["${getDispositivoType() == Dispositivo.ios ? "ios" : "android"}"];
            vBack = versioning["version"];
            requiresUpdate = versioning["requiresUpdate"];
            if (vLocal < vBack) {
              updateURL = versioning["storeURL"];
              isUpdated = false;
            }
            if (!isUpdated && requiresUpdate) {
              print("ES NECESARIO ACTUALIZAR A $vBack.0");
              // Es necesario actualizar
              runApp(
                MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: ActAppScreen(),
                ),
              );
            } else {
              print("VERSIÓN COMPATIBLE: $vLocal.0");

              /// Datos de contacto a soporte
              support = Support(
                voiceNumber: constantsDoc["support"]["voiceNumber"],
                wappNumber: constantsDoc["support"]["wappNumber"],
              );

              /// Datos de campaña de lanzamiento
              campaign = Campaign(
                amount: constantsDoc["campaign"]["amount"],
                isActive: constantsDoc["campaign"]["isActive"],
              );

              /// TRM
              trmEmeralds = (constantsDoc["trmEmeralds"] ?? 0).toDouble();

              var firebaseUser =  auth.currentUser;
              if (firebaseUser != null) {
                print("USUARIO LOGGEADO");
                // Usuario loggeado
                LogMessage.get("USER");
                firestore
                    .doc("users/${firebaseUser.uid}")
                    .get()
                    .then((userDoc) async {
                  LogMessage.getSuccess("USER");
                  if (userDoc.exists) {
                    // Usuario existe en Firestore. Asigna datos del doc descargado.
                    user = localUser.User(
                      id: userDoc.id,
                      name: userDoc["name"] ?? "@usuario9823",
                      email: userDoc["email"],
                      username: userDoc.data()['username'],
                      profilePictureURL: userDoc["profilePictureURL"],
                      pushToken: userDoc["pushToken"],
                      emeralds: userDoc["esmeraldas"] ?? 0,
                      puntosCumbia: userDoc["puntosCumbia"],
                      addresses: userDoc.data()["addresses"]
                          .map(
                            (addressMap) => Address(
                          address: addressMap['address'],
                          city: addressMap['city'],
                          country: addressMap['country'],
                          isPrincipal: addressMap['isPrincipal'],
                        ),
                      )
                          .toList(),
                      phoneNumber: PhoneNumberCumbia(
                        dialingCode: userDoc["phoneNumber"]["dialingCode"] ?? "57",
                        basePhoneNumber: userDoc["phoneNumber"]["basePhoneNumber"]
                            .toString()
                            .trim(),
                      ),
                      roles: userDoc["roles"] != null
                          ? UserRoles(
                        isAdmin: userDoc["roles"]["isAdmin"] ?? false,
                        isMerchant: userDoc["roles"]["isMerchant"] ?? false,
                      )
                          : UserRoles(
                        isAdmin: false,
                        isMerchant: false,
                      ),
                      /*
                merchant: userDoc["merchant"] != null
                    ? Merchant(
                        documentsPending:
                            userDoc["merchant"]["documentsPending"] ?? true,
                        dni: userDoc["merchant"]["dni"] != null
                            ? Dni(
                                type: userDoc["merchant"]["dni"]["type"],
                                number: userDoc["merchant"]["dni"]["number"],
                              )
                            : Dni(),
                        bank: userDoc["merchant"]["bank"] != null
                            ? Bank(
                                type: userDoc["merchant"]["bank"]["type"],
                                name: userDoc["merchant"]["bank"]["name"],
                                number: userDoc["merchant"]["bank"]["number"],
                              )
                            : Bank(),
                      )
                    : Merchant(
                        documentsPending: true,
                        dni: Dni(),
                        bank: Bank(),
                      ),
                promoter: userDoc["promoter"] != null
                    ? Promoter(
                        documentsPending:
                            userDoc["promoter"]["documentsPending"] ?? true,
                        dni: userDoc["promoter"]["dni"] != null
                            ? Dni(
                                type: userDoc["promoter"]["dni"]["type"],
                                number: userDoc["promoter"]["dni"]["number"],
                              )
                            : Dni(),
                        bank: userDoc["promoter"]["bank"] != null
                            ? Bank(
                                type: userDoc["promoter"]["bank"]["type"],
                                name: userDoc["merchant"]["bank"]["name"],
                                number: userDoc["merchant"]["bank"]["number"],
                              )
                            : Bank(),
                      )
                    : Promoter(
                        documentsPending: true,
                        dni: Dni(),
                        bank: Bank(),
                      ),
                 */
                    );

                    if (userDoc["isBanned"] == true) {
                      // El usuario está inhabilitado
                      runApp(
                        MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: BannedScreen(),
                        ),
                      );
                    } else {
                      // El usuario activo puede acceder a la plataforma
                      runApp(
                        MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: NavScreen(index: 0),
                        ),
                      );
                    }
                  } else {
                    print("USUARIO NO EXISTE");
                    runApp(
                      MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: LoginScreen(),
                      ),
                    );
                  }
                }).catchError((e) {
                  LogMessage.getError("USER", e);
                  // Usuario no descargado, va a iniciar sesión
                  runApp(
                    MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: LoginScreen(),
                    ),
                  );
                });
              } else {
                print("SIN SESIÓN ACTIVA");
                // Usuario no loggeado, va a iniciar sesión
                runApp(
                  MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: Welcome(),
                  ),
                );
              }
            }
          }
        }).catchError((e) {
          LogMessage.getError("CONSTANTES", e);
        });

}


