/// TODO EL CONTENIDO ESTÁ AQUÍ COMENTADO ABAJO
/*


import 'package:http/http.dart' as http;
import 'dart:convert';

/// DHL CREACIÓN DE PEDIDOS



POST /dgff/transportation/shipment-booking HTTP/1.1
Accept: application/json
Content-Type: application/problem+json
Authorization: Bearer REPLACE_BEARER_TOKEN
Host: 
Content-Length: 3652



  var url ="api-sandbox.dhl.com";
  
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

    var headers = {"authorization": "Bearer $prvKey"};
    var response = await http.post(url, headers: headers, body: json.encode(body)).catchError((e) {
      print("💩 ERROR EN RESPONSE DE WOMPI: $e");
      paymentStatus = PaymentStatus.ERROR;
      return;
    });
    print("STATUS CODE: ${response.statusCode}");
    if (response.statusCode == 201) {}



 */
