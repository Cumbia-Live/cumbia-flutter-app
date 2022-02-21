import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cumbialive/model/DHLResponse.dart';
import 'package:cumbialive/model/LiftRequest.dart';
import 'package:cumbialive/model/LiftResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' ;
import 'package:xml2json/xml2json.dart';

Future<http.Response> getResponse(String api,
    {String body, String token}) async {
  final http.Response response = await http.get(
    Uri.parse(api),
    headers: token != null
        ? <String, String>{
      'Accept': 'application/json; charset=UTF-8',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    }
        : <String, String>{
      'Accept': 'application/json; charset=UTF-8',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}

Future<http.Response> postRequest(String api, var body, {String token}) async {
  final http.Response response = await http.post(Uri.parse(api),
      headers: token != null
          ? <String, String>{
        'Accept': 'application/json; charset=UTF-8',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      }
          : <String, String>{
        'Accept': 'application/json; charset=UTF-8',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body));

  return response;
}

Future<LiftResponse> createLiftOrder(LiftRequest request) async {
  var headers = {
    'Content-Type': 'application/json',
    'client-type': 'mobile',
    'authorization': 'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJwSmNaSTNBY19zNkp3TG5BV05CNmpDZmQ2WXRtS3dyYUYycTA4VXpXRGZNIn0.eyJleHAiOjE2ODcwOTUzNjEsImlhdCI6MTYyNDAyMzM2MSwianRpIjoiMWY1NWQ2ODMtZGQ3Yi00NTJjLWFhMTMtNzVhNGI2MGZlOTlhIiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay5zdGcubGlmdGl0LXNhbmRib3guY29tL2F1dGgvcmVhbG1zL0xNUyIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiIwNTBiYTUwZS1kMGJlLTRmZTktYWVjYy0yMzVhM2Y2YjkyNGUiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJhcGktdXNlcnMiLCJzZXNzaW9uX3N0YXRlIjoiOTg2N2FhMzQtNzY3My00ZGRiLTgzMTktYTJkYzNkZDY0YjhlIiwiYWNyIjoiMSIsInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImFwcCI6eyJiYWNrb2ZmaWNlIjp7ImlkIjoxODgwMiwiZW1haWwiOiJjdW1iaWFsaXZlQGxpZnRpdC1pbnRlcm5hbC5jb20ifSwidG1zIjp7Im9yZ2FuaXphdGlvbl9pZCI6MjkyMiwicm9sZXMiOlsiYWRtaW4iXSwic2Vzc2lvbl9pZCI6NjUxMTkyLCJ1c2VyX2lkIjoxODgwMiwidXNlcl90eXBlIjoiYXBpIn19LCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwicHJlZmVycmVkX3VzZXJuYW1lIjoiY3VtYmlhbGl2ZUBsaWZ0aXQtaW50ZXJuYWwuY29tIiwiZW1haWwiOiJjdW1iaWFsaXZlQGxpZnRpdC1pbnRlcm5hbC5jb20ifQ.wEywQPqqLfnR-Zz034BxnKahMDy5jcZkzlxgty8p8_M3fXFJ4-nHfQO8HNTkqK8moN4T6ydr7QbQ0dDJKoceUZ4AKMD6AE8Chks547LlFtTE2jtsgMkm0RUYM4YNsVsmkhVgE3Y2XjCAxqNdHyWAf48CX2i63Wz9yYKp4F_ZntXuwT05rVRHmlWLKTiz3ZN2ZgpeHcHVWS6QgO3tuqxHgZ889yPl3_BGGVFQKCf3LhjXjRsABo7ZKGlk2c8bJaylMZBam3swV9NwX4EreMXWlsslLf8vTqDaAXE9jcqjuhWPxsN6aEpll-GFAWEJ1LRdB7oyH5O3zNYuMkLmG_DBvg',
    'device-id': '123456',
    'client-type': 'mobile',
    'user-agent': 'postman'
  };
  var request = http.Request('POST', Uri.parse('https://tms.stg.liftit-sandbox.com/delivery_bags'));
  request.body = json.encode({
    "order": {
      "hub_id": 2394,
      "zone": "Norte",
      "initial_delivery_time": "2019-03-15T17:00:00.000000Z",
      "finish_delivery_time": "2019-03-15T17:00:00.000000Z",
      "start_time": "08:00",
      "end_time": "21:00",
      "latitude": 4.7002864,
      "longitude": 74.0333434,
      "neighborhood": "Suba",
      "city": "Bogota",
      "state": "Bogota",
      "order_number": "33215312",
      "promise": "7-13",
      "observations": "El edificio es de color rosa",
      "customer": {
        "name": "Daniel",
        "identification_number": "900000000",
        "contact": "Felipe",
        "phone": "54576452",
        "email": "daniikpando@gmail.com",
        "address": "calle 19 # 31",
        "extra_address": "torre 1 apto 503",
        "internal_id": "20"
      },
      "items": [
        {
          "sku": "24022",
          "barcode": "77742466666",
          "description": "TV 65",
          "unit_weight": 10,
          "unit_volume": 300,
          "quantity": 2,
          "unit_price": 1000000,
          "total_price": 2000000,
          "total_collect": 2000000
        }
      ]
    }
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var response2 = await http.Response.fromStream(response);
    final result = jsonDecode(response2.body) as Map<String, dynamic>;

    return LiftResponse.fromJson(result);
  }
  else {
    print(response.reasonPhrase);
    return null;
  }
}



String createRequest(String country, String countryCode){
  return '''<?xml version="1.0" encoding="utf-8"?> <p:DCTRequest xmlns:p="http://www.dhl.com" xmlns:p1="http://www.dhl.com/datatypes" xmlns:p2="http://www.dhl.com/DCTRequestdatatypes" schemaVersion="2.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dhl.com DCT-req.xsd "> <GetQuote> <Request> <ServiceHeader> <MessageTime>2022-08-20T11:28:56.000-08:00</MessageTime> <MessageReference>1234567890123456789012345678901</MessageReference> <SiteID>v62_DD44qtjHu2</SiteID> <Password>9pCDpOCOXv</Password> </ServiceHeader> <MetaData> <SoftwareName>3PV</SoftwareName> <SoftwareVersion>1.0</SoftwareVersion> </MetaData> </Request> <From> <CountryCode>$country</CountryCode> <Postalcode>$countryCode</Postalcode> </From> <BkgDetails> <PaymentCountryCode>CO</PaymentCountryCode> <Date>2022-03-10</Date> <ReadyTime>PT10H21M</ReadyTime> <ReadyTimeGMTOffset>+01:00</ReadyTimeGMTOffset> <DimensionUnit>CM</DimensionUnit> <WeightUnit>KG</WeightUnit> <Pieces> <Piece> <PieceID>1</PieceID> <Height>100</Height> <Depth>50</Depth> <Width>70</Width> <Weight>66.0</Weight> </Piece> </Pieces> <PaymentAccountNumber>683141085</PaymentAccountNumber> <IsDutiable>Y</IsDutiable> <NetworkTypeCode>AL</NetworkTypeCode> <QtdShp> <GlobalProductCode>P</GlobalProductCode> <LocalProductCode>P</LocalProductCode> </QtdShp> </BkgDetails> <To> <CountryCode>GR</CountryCode> <Postalcode>18535</Postalcode> </To> <Dutiable> <DeclaredCurrency>EUR</DeclaredCurrency> <DeclaredValue>1.0</DeclaredValue> </Dutiable> </GetQuote> </p:DCTRequest>''';
}

Xml2Json xml2json = Xml2Json();

Future<String> getDHLQoute() async {
  //final aresponse = await http.get(recentAlbumsURL);
  String xml = createRequest("CO","110111");
  print(xml);
  var client = IOClient();

  var request = http.Request(
    'POST',
    Uri.parse('https://xmlpi-ea.dhl.com/XMLShippingServlet'),
  );
  request.headers.addAll({
   // HttpHeaders.authorizationHeader: 'Basic $credential',
    'Accept-Charset': 'utf-8',
    'content-type': 'text/xml' // or text/xml;charset=utf-8
  });

  // either
  request.body = xml;
  // which will encode the string to bytes, and modify the content-type header, adding the encoding
  // or
  // request.bodyBytes = utf8.encode(xml);
  // which gives you complete control over the character encoding

  var streamedResponse = await client.send(request);
  print(streamedResponse.statusCode);

  var responseBody =
  await streamedResponse.stream.transform(utf8.decoder).join();
  debugPrint(responseBody);


  client.close();




/*
 final aresponse = http.Response(xml, 200);

  printWrapped(aresponse.body);
*/

  xml2json.parse(responseBody);
  var jsondata = xml2json.toGData();

  printWrapped(''' $jsondata''' );

  DHLResponse data = payloadFromJson(jsondata);

  printWrapped(data.resDCTResponse.getQuoteResponse.bkgDetails.qtdShp.qtdSInAdCur[1].totalAmount.t);
  //print(albumList.toString());

  return data.resDCTResponse.getQuoteResponse.bkgDetails.qtdShp.qtdSInAdCur[1].totalAmount.t;
}

DHLResponse payloadFromJson(var str) => DHLResponse.fromJson(json.decode(str));

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}