// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:cumbialive/config/config.dart';
// import 'package:cumbialive/config/constants/wompi_constants.dart';
// import 'package:cumbialive/model/models.dart';

// /// Registra tarjeta en Wompi
// Future<dynamic> registerCreditCard(
//   String number,
//   String cvv,
//   String expMonth,
//   String expYear,
//   String cardHolder,
// ) async {
//   var url = "https://production.wompi.co/v1/tokens/cards";
//   var body = {
//     "number": "$number",
//     "cvc": "$cvv",
//     "exp_month": "$expMonth",
//     "exp_year": "$expYear",
//     "card_holder": "$cardHolder",
//   };
//   var headers = {"authorization": "Bearer $pubKey"};
//   var response = await http
//       .post(Uri.parse(url), headers: headers, body: json.encode(body))
//       .catchError((e) {
//     print("💩 ERROR EN REQUEST 1: $e");
//   });
//   String status = json.decode(response.body)["status"];
//   if (status == "CREATED") {
//     String cardToken = json.decode(response.body)["data"]["id"];
//     String acceptanceToken = await getAcceptanceToken();
//     var url2 = "https://production.wompi.co/v1/payment_sources";
//     var body2 = {
//       "type": "CARD",
//       "token": "$cardToken",
//       "customer_email": "${user.email}",
//       "acceptance_token": "$acceptanceToken",
//     };
//     var headers2 = {"authorization": "Bearer $prvKey"};
//     var response2 = await http
//         .post(Uri.parse(url2), headers: headers2, body: json.encode(body2))
//         .catchError((e) {
//       print("💩 ERROR EN REQUEST 2: $e");
//     });
//     String status = json.decode(response2.body)["data"]["status"];
//     if (status == "AVAILABLE") {
//       int paymentSourceId = json.decode(response2.body)["data"]["id"];
//       return paymentSourceId;
//     } else {
//       print(
//           "💩 ERROR AL REGISTRAR TARJETA R2: ${response2.statusCode} · ${json.decode(response2.body)}");
//       return null;
//     }
//   } else {
//     print(
//         "💩 ERROR AL REGISTRAR TARJETA R1: ${response.statusCode} · ${json.decode(response.body)}");
//     if (json.decode(response.body)["error"].containsKey("number")) {
//       return "El número de la tarjeta es inválido.";
//     } else {
//       return null;
//     }
//   }
// }

// /// Obtener acceptanceToken para pagos
// Future<String> getAcceptanceToken() async {
//   var url = "https://production.wompi.co/v1/merchants";
//   var response = await http.get(Uri.parse("$url/$pubKey")).catchError((e) {
//     print("ERROR: $e");
//   });

//   String acceptanceToken = json.decode(response.body)["data"]
//       ["presigned_acceptance"]["acceptance_token"];
//   return acceptanceToken;
// }

// // Generar un pago
// Future<void> pay({int transacValue = 1500, int cuotas = 12}) async {
//   String referenceCode =
//       "${user.id}xxxx${DateTime.now().millisecondsSinceEpoch}";

//   CreditCard selectedCreditCard =
//       user.creditCardList.firstWhere((creditCard) => creditCard.isSelected);
//   // print(selectedCreditCard.paymentSourceId)
//   var url = "https://production.wompi.co/v1/transactions";
//   var body = {
//     "amount_in_cents": transacValue * 100, // Monto en centavos
//     "currency": currency ?? "COP", // Moneda
//     "customer_email":
//         "${user.email ?? "liz.project.db@gmail.com"}", // Email del usuario
//     "payment_method": {
//       "installments": cuotas ??
//           12 // Número de cuotas si la fuente de pago representa una tarjeta de lo contrario el campo payment_method puede ser ignorado.
//     },
//     "reference": "$referenceCode", // Referencia única de pago
//     "payment_source_id":
//         "${selectedCreditCard.paymentSourceId}" // ID de la fuente de pago
//   };

//   var headers = {"authorization": "Bearer $prvKey"};
//   var response = await http
//       .post(Uri.parse(url), headers: headers, body: json.encode(body))
//       .catchError((e) {
//     print("💩️ ERROR EN RESPONSE DE WOMPI: $e");
//     paymentStatus = PaymentStatus.ERROR;
//     return null;
//   });
//   print("STATUS CODE: ${response.statusCode}");
//   if (response.statusCode == 201) {
//     String transactionId = json.decode(response.body)["data"]["id"];

//     /// Response del POST exitoso
//     while (paymentStatus == PaymentStatus.PENDING) {
//       await Future.delayed(Duration(seconds: 3), () async {
//         var confirmationResponse =
//             await http.get(Uri.parse("$url/$transactionId")).catchError((e) {
//           print("ERROR: $e");
//         });
//         if (confirmationResponse.statusCode == 200) {
//           /// Request exitoso
//           String paymentStatusString =
//               json.decode(confirmationResponse.body)["data"]["status"];
//           print("PAYMENT STATUS AFUERA: $paymentStatus");
//           if (paymentStatusString == "APPROVED") {
//             paymentStatus = PaymentStatus.APPROVED;
//             print("PAYMENT STATUS DE APPROVED: $paymentStatus");
//             return;
//           } else if (paymentStatusString == "DECLINED") {
//             print("PAYMENT STATUS DE DECLINED: $paymentStatus");
//             paymentStatus = PaymentStatus.DECLINED;
//             return;
//           } else {
//             paymentStatus = PaymentStatus.PENDING;
//             print("PAYMENT STATUS SIGUE PENDING: $paymentStatus");
//           }
//         } else {
//           /// Request ha fallado, pero no sabemos si debe repetir el pago
//           print(
//               "ERROR 2do RESPONSE: ${json.decode(confirmationResponse.body)}");
//           paymentStatus = PaymentStatus.PENDING;
//         }
//       });
//     }
//   } else {
//     /// Error al procesar el pago
//     print("ERROR 1er RESPONSE: ${json.decode(response.body)}");
//     paymentStatus = PaymentStatus.ERROR;
//     return;
//   }
// }

// enum PaymentStatus {
//   PENDING,
//   APPROVED,
//   DECLINED,
//   ERROR,
// }

// PaymentStatus paymentStatus = PaymentStatus.PENDING;
