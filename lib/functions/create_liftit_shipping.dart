/// TODO EL CONTENIDO ESTÁ AQUÍ COMENTADO ABAJO
/*
import 'package:http/http.dart' as http;
import 'dart:convert';

/// LIFTIT CREACIÓN DE PEDIDOS


POST /dgff/transportation/shipment-booking HTTP/1.1
Accept: application/json
Content-Type: application/problem+json
Authorization: Bearer REPLACE_BEARER_TOKEN
Host: 
Content-Length: 3652



  var url ="https://api.stg.liftit-sandbox.com/v1/delivery_bags";
  
  var body = {
  "housebillNumber": "SGLA00344",
  "modeOfTransport": "AIR",
  "originLocationCode": "SGSIN",
  "originLocationName": "Singapore",
  "originCountryCode": "SG",
  "destinationLocationCode": "USMIA",
  "destinationLocationName": "Miami FL",
  "destinationCountryCode": "US",
  "portOfLoadingLocationCode": "",
  "portOfLoadingLocationName": "",
  "portOfLoadingCountryCode": "",
  "portOfUnloadingLocationCode": "",
  "portOfUnloadingLocationName": "",
  "portOfUnloadingCountryCode": "",
  "requestedPickupDate": "2019-09-02T19:00:00+01:00",
  "requestedShippingDate": "2019-09-03T19:00:00+01:00",
  "requestedDeliveryDate": "2019-09-05T10:00:00+01:00",
  "shipmentType": "LSE",
  "assembly": false,
  "deliveryMode": "DOOR/DOOR",
  "serviceLevel": "STD",
  "serviceCode": "AA1",
  "_DGFInsure": false,
  "requestedCarrier": "",
  "incoterms": "FCA",
  "incotermsLocation": "Miami",
  "releaseType": "",
  "valueOfGoods": 20000,
  "valueOfGoodsCurrencyCode": "USD",
  "insuranceValue": 20000,
  "insuranceValueCurrencyCode": "USD",
  "customer": {
    "accountNumber": "USGEE030",
    "name": "ACME INT'L INC",
    "address": {
      "addressLine1": "7600 CORPORATE CENTER DR",
      "addressLine2": "SUITE 601",
      "postalCode": "33126",
      "city": "MIAMI",
      "stateProvince": "FL",
      "countryCode": "US"
    },
    "contact": {
      "name": "Mr J. Doe",
      "phone": "+1 99 999 9999",
      "email": "j.doe@acme.com"
    }
  },
  "shipper": {
    "accountNumber": "SGSIN6661",
    "name": "JJ Electronics",
    "address": {
      "addressLine1": "20 JOO KOON CIRCLE",
      "addressLine2": "",
      "postalCode": "629057",
      "city": "Singapore",
      "stateProvince": "",
      "countryCode": "SG"
    },
    "contact": {
      "name": "M Jane",
      "phone": "+65 88 888 8888",
      "email": "jane.m@jj.com"
    }
  },
  "consignee": {
    "accountNumber": "USGEE036",
    "name": "ACME INT'L INC",
    "address": {
      "addressLine1": "7699 CORPORATE CENTER DR",
      "addressLine2": "",
      "postalCode": "33126",
      "city": "MIAMI",
      "stateProvince": "FL",
      "countryCode": "US"
    },
    "contact": {
      "name": "",
      "phone": "",
      "email": ""
    }
  },
  "notify": {
    "accountNumber": "USBOC996",
    "name": "X-COMMERCIAL AIRPLANE",
    "address": {
      "addressLine1": "",
      "addressLine2": "",
      "postalCode": "",
      "city": "",
      "stateProvince": "",
      "countryCode": ""
    },
    "contact": {
      "name": "Mr. Xavier",
      "phone": "",
      "email": "xavier@x-plane.com"
    }
  },
  "goodsLines": [
    {
      "packageCount": 10,
      "packageType": "PLT",
      "packageID": "PalletNo12346",
      "grossWeight": 500,
      "grossWeightUom": "KGM",
      "volume": 10.5,
      "volumeUom": "MTQ",
      "innerPackageCount": 10,
      "loadingMeters": 8.5,
      "marksAndNumbers": "",
      "goodsDescription": "Solid metal",
      "commodityCode": "GEN",
      "harmonizedCode": "12.345.678",
      "transportUnitID": "HASU1179387",
      "transportUnitType": "42T0",
      "dimensions": {
        "dimensionsUom": "MTR",
        "length": 20.1,
        "width": 8,
        "height": 8.5
      },
      "temperatures": {
        "requiresTemperatureControl": false,
        "requiredMinimum": 8,
        "requiredMaximum": 10,
        "uom": "CEL"
      },
      "hazardousMaterial": [
        {
          "_UNDGNumber": "1266a",
          "_IMOClassCode": 3,
          "flashpointTemperature": {
            "uom": "CEL",
            "text": 20
          },
          "properShippingname": "",
          "technicalName": "",
          "marinePollutant": "Y",
          "packageCount": 10,
          "packageType": "PLT",
          "grossWeight": 500,
          "grossWeightUom": "KGM",
          "volume": 10.5,
          "volumeUom": "MTQ",
          "contact": {
            "name": "John Doe",
            "phone": "+1 99 999 9999",
            "email": "j.doe@acme.com"
          }
        }
      ]
    }
  ],
  "references": [
    {
      "type": "CRN",
      "number": "ZZ555555"
    }
  ],
  "notes": [
    {
      "type": "CIN",
      "text": "Customs Instructions will folllow"
    }
  ],
  "service": [
    {
      "type": "DKI",
      "requestedDate": "2019-09-01T08:00:00+01:00"
    }
  ],
  "pickup": {
    "_DGFPickup": true,
    "accountNumber": "SGSIN661",
    "name": "James Chang",
    "address": {
      "addressLine1": "21 JOO KOON CIRCLE",
      "addressLine2": "",
      "postalCode": "629057",
      "city": "Singapore",
      "stateProvince": "",
      "countryCode": "SG"
    },
    "contact": {
      "name": "",
      "phone": "",
      "email": ""
    }
  },
  "delivery": {
    "_DGFDeliver": false,
    "accountNumber": "",
    "name": "",
    "address": {
      "addressLine1": "",
      "addressLine2": "",
      "postalCode": "",
      "city": "",
      "stateProvince": "",
      "countryCode": ""
    },
    "contact": {
      "name": "",
      "phone": "",
      "email": ""
    }
  },
  "parties": [
    {
      "partyType": "DeliveryAgent",
      "accountNumber": "SFO"
    }
  ]
};

    var headers = {"authorization": "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJwSmNaSTNBY19zNkp3TG5BV05CNmpDZmQ2WXRtS3dyYUYycTA4VXpXRGZNIn0.eyJleHAiOjE2ODcwOTUzNjEsImlhdCI6MTYyNDAyMzM2MSwianRpIjoiMWY1NWQ2ODMtZGQ3Yi00NTJjLWFhMTMtNzVhNGI2MGZlOTlhIiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay5zdGcubGlmdGl0LXNhbmRib3guY29tL2F1dGgvcmVhbG1zL0xNUyIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiIwNTBiYTUwZS1kMGJlLTRmZTktYWVjYy0yMzVhM2Y2YjkyNGUiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJhcGktdXNlcnMiLCJzZXNzaW9uX3N0YXRlIjoiOTg2N2FhMzQtNzY3My00ZGRiLTgzMTktYTJkYzNkZDY0YjhlIiwiYWNyIjoiMSIsInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImFwcCI6eyJiYWNrb2ZmaWNlIjp7ImlkIjoxODgwMiwiZW1haWwiOiJjdW1iaWFsaXZlQGxpZnRpdC1pbnRlcm5hbC5jb20ifSwidG1zIjp7Im9yZ2FuaXphdGlvbl9pZCI6MjkyMiwicm9sZXMiOlsiYWRtaW4iXSwic2Vzc2lvbl9pZCI6NjUxMTkyLCJ1c2VyX2lkIjoxODgwMiwidXNlcl90eXBlIjoiYXBpIn19LCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwicHJlZmVycmVkX3VzZXJuYW1lIjoiY3VtYmlhbGl2ZUBsaWZ0aXQtaW50ZXJuYWwuY29tIiwiZW1haWwiOiJjdW1iaWFsaXZlQGxpZnRpdC1pbnRlcm5hbC5jb20ifQ.wEywQPqqLfnR-Zz034BxnKahMDy5jcZkzlxgty8p8_M3fXFJ4-nHfQO8HNTkqK8moN4T6ydr7QbQ0dDJKoceUZ4AKMD6AE8Chks547LlFtTE2jtsgMkm0RUYM4YNsVsmkhVgE3Y2XjCAxqNdHyWAf48CX2i63Wz9yYKp4F_ZntXuwT05rVRHmlWLKTiz3ZN2ZgpeHcHVWS6QgO3tuqxHgZ889yPl3_BGGVFQKCf3LhjXjRsABo7ZKGlk2c8bJaylMZBam3swV9NwX4EreMXWlsslLf8vTqDaAXE9jcqjuhWPxsN6aEpll-GFAWEJ1LRdB7oyH5O3zNYuMkLmG_DBvg"};
    var response = await http.post(url, headers: headers, body: json.encode(body)).catchError((e) {
      print("💩 ERROR EN RESPONSE DE WOMPI: $e");
      paymentStatus = PaymentStatus.ERROR;
      return;
    });
    print("STATUS CODE: ${response.statusCode}");
    if (response.statusCode == 201) {}



*/
