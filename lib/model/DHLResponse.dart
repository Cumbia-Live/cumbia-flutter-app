class DHLResponse {
  ResDCTResponse resDCTResponse;

  DHLResponse({this.resDCTResponse});

  DHLResponse.fromJson(Map<String, dynamic> json) {
    resDCTResponse = json['res\$DCTResponse'] != null ? new ResDCTResponse.fromJson(json['res\$DCTResponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resDCTResponse != null) {
      data['res\$DCTResponse'] = this.resDCTResponse.toJson();
    }
    return data;
  }
}

class ResDCTResponse {
  String xsiSchemaLocation;
  List<Xmlns> xmlns;
  String xmlnsRes;
  String xmlnsXsi;
  GetQuoteResponse getQuoteResponse;

  ResDCTResponse({this.xsiSchemaLocation, this.xmlns, this.xmlnsRes, this.xmlnsXsi, this.getQuoteResponse});

  ResDCTResponse.fromJson(Map<String, dynamic> json) {
    xsiSchemaLocation = json['xsi:schemaLocation'];
    if (json['xmlns'] != null) {
      xmlns = new List<Xmlns>();
      json['xmlns'].forEach((v) { xmlns.add(new Xmlns.fromJson(v)); });
    }
    xmlnsRes = json['xmlns\$res'];
    xmlnsXsi = json['xmlns\$xsi'];
    getQuoteResponse = json['GetQuoteResponse'] != null ? new GetQuoteResponse.fromJson(json['GetQuoteResponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xsi:schemaLocation'] = this.xsiSchemaLocation;
    if (this.xmlns != null) {
      data['xmlns'] = this.xmlns.map((v) => v.toJson()).toList();
    }
    data['xmlns\$res'] = this.xmlnsRes;
    data['xmlns\$xsi'] = this.xmlnsXsi;
    if (this.getQuoteResponse != null) {
      data['GetQuoteResponse'] = this.getQuoteResponse.toJson();
    }
    return data;
  }
}

class Xmlns {


  Xmlns();

Xmlns.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}

class GetQuoteResponse {
  Response response;
  BkgDetails bkgDetails;
  Srvs srvs;
  Note note;

  GetQuoteResponse({this.response, this.bkgDetails, this.srvs, this.note});

  GetQuoteResponse.fromJson(Map<String, dynamic> json) {
    response = json['Response'] != null ? new Response.fromJson(json['Response']) : null;
    bkgDetails = json['BkgDetails'] != null ? new BkgDetails.fromJson(json['BkgDetails']) : null;
    srvs = json['Srvs'] != null ? new Srvs.fromJson(json['Srvs']) : null;
    note = json['Note'] != null ? new Note.fromJson(json['Note']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['Response'] = this.response.toJson();
    }
    if (this.bkgDetails != null) {
      data['BkgDetails'] = this.bkgDetails.toJson();
    }
    if (this.srvs != null) {
      data['Srvs'] = this.srvs.toJson();
    }
    if (this.note != null) {
      data['Note'] = this.note.toJson();
    }
    return data;
  }
}

class Response {
  ServiceHeader serviceHeader;

  Response({this.serviceHeader});

  Response.fromJson(Map<String, dynamic> json) {
    serviceHeader = json['ServiceHeader'] != null ? new ServiceHeader.fromJson(json['ServiceHeader']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceHeader != null) {
      data['ServiceHeader'] = this.serviceHeader.toJson();
    }
    return data;
  }
}

class ServiceHeader {
  MessageTime messageTime;
  MessageTime messageReference;
  MessageTime siteID;

  ServiceHeader({this.messageTime, this.messageReference, this.siteID});

  ServiceHeader.fromJson(Map<String, dynamic> json) {
    messageTime = json['MessageTime'] != null ? new MessageTime.fromJson(json['MessageTime']) : null;
    messageReference = json['MessageReference'] != null ? new MessageTime.fromJson(json['MessageReference']) : null;
    siteID = json['SiteID'] != null ? new MessageTime.fromJson(json['SiteID']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messageTime != null) {
      data['MessageTime'] = this.messageTime.toJson();
    }
    if (this.messageReference != null) {
      data['MessageReference'] = this.messageReference.toJson();
    }
    if (this.siteID != null) {
      data['SiteID'] = this.siteID.toJson();
    }
    return data;
  }
}

class MessageTime {
  String t;

  MessageTime({this.t});

  MessageTime.fromJson(Map<String, dynamic> json) {
    t = json['\$t'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$t'] = this.t;
    return data;
  }
}

class BkgDetails {
  QtdShp qtdShp;

  BkgDetails({this.qtdShp});

  BkgDetails.fromJson(Map<String, dynamic> json) {
    qtdShp = json['QtdShp'] != null ? new QtdShp.fromJson(json['QtdShp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.qtdShp != null) {
      data['QtdShp'] = this.qtdShp.toJson();
    }
    return data;
  }
}

class QtdShp {
  OriginServiceArea originServiceArea;
  OriginServiceArea destinationServiceArea;
  MessageTime globalProductCode;
  MessageTime localProductCode;
  MessageTime productShortName;
  MessageTime localProductName;
  MessageTime networkTypeCode;
  MessageTime pOfferedCustAgreement;
  MessageTime transInd;
  MessageTime pickupDate;
  MessageTime pickupCutoffTime;
  MessageTime bookingTime;
  MessageTime currencyCode;
  MessageTime exchangeRate;
  MessageTime weightCharge;
  MessageTime weightChargeTax;
  MessageTime totalTransitDays;
  MessageTime pickupPostalLocAddDays;
  MessageTime deliveryPostalLocAddDays;
  Xmlns pickupNonDHLCourierCode;
  Xmlns deliveryNonDHLCourierCode;
  DeliveryDate deliveryDate;
  MessageTime deliveryTime;
  MessageTime dimensionalWeight;
  MessageTime weightUnit;
  MessageTime pickupDayOfWeekNum;
  DestinationDayOfWeekNum destinationDayOfWeekNum;
  DestinationDayOfWeekNum quotedWeight;
  DestinationDayOfWeekNum quotedWeightUOM;
  List<QtdShpExChrg> qtdShpExChrg;
  MessageTime pricingDate;
  MessageTime shippingCharge;
  MessageTime totalTaxAmount;
  List<QtdSInAdCur> qtdSInAdCur;
  MessageTime pickupWindowEarliestTime;
  MessageTime pickupWindowLatestTime;
  MessageTime bookingCutoffOffset;

  QtdShp({this.originServiceArea, this.destinationServiceArea, this.globalProductCode, this.localProductCode, this.productShortName, this.localProductName, this.networkTypeCode, this.pOfferedCustAgreement, this.transInd, this.pickupDate, this.pickupCutoffTime, this.bookingTime, this.currencyCode, this.exchangeRate, this.weightCharge, this.weightChargeTax, this.totalTransitDays, this.pickupPostalLocAddDays, this.deliveryPostalLocAddDays, this.pickupNonDHLCourierCode, this.deliveryNonDHLCourierCode, this.deliveryDate, this.deliveryTime, this.dimensionalWeight, this.weightUnit, this.pickupDayOfWeekNum, this.destinationDayOfWeekNum, this.quotedWeight, this.quotedWeightUOM, this.qtdShpExChrg, this.pricingDate, this.shippingCharge, this.totalTaxAmount, this.qtdSInAdCur, this.pickupWindowEarliestTime, this.pickupWindowLatestTime, this.bookingCutoffOffset});

  QtdShp.fromJson(Map<String, dynamic> json) {
    originServiceArea = json['OriginServiceArea'] != null ? new OriginServiceArea.fromJson(json['OriginServiceArea']) : null;
    destinationServiceArea = json['DestinationServiceArea'] != null ? new OriginServiceArea.fromJson(json['DestinationServiceArea']) : null;
    globalProductCode = json['GlobalProductCode'] != null ? new MessageTime.fromJson(json['GlobalProductCode']) : null;
    localProductCode = json['LocalProductCode'] != null ? new MessageTime.fromJson(json['LocalProductCode']) : null;
    productShortName = json['ProductShortName'] != null ? new MessageTime.fromJson(json['ProductShortName']) : null;
    localProductName = json['LocalProductName'] != null ? new MessageTime.fromJson(json['LocalProductName']) : null;
    networkTypeCode = json['NetworkTypeCode'] != null ? new MessageTime.fromJson(json['NetworkTypeCode']) : null;
    pOfferedCustAgreement = json['POfferedCustAgreement'] != null ? new MessageTime.fromJson(json['POfferedCustAgreement']) : null;
    transInd = json['TransInd'] != null ? new MessageTime.fromJson(json['TransInd']) : null;
    pickupDate = json['PickupDate'] != null ? new MessageTime.fromJson(json['PickupDate']) : null;
    pickupCutoffTime = json['PickupCutoffTime'] != null ? new MessageTime.fromJson(json['PickupCutoffTime']) : null;
    bookingTime = json['BookingTime'] != null ? new MessageTime.fromJson(json['BookingTime']) : null;
    currencyCode = json['CurrencyCode'] != null ? new MessageTime.fromJson(json['CurrencyCode']) : null;
    exchangeRate = json['ExchangeRate'] != null ? new MessageTime.fromJson(json['ExchangeRate']) : null;
    weightCharge = json['WeightCharge'] != null ? new MessageTime.fromJson(json['WeightCharge']) : null;
    weightChargeTax = json['WeightChargeTax'] != null ? new MessageTime.fromJson(json['WeightChargeTax']) : null;
    totalTransitDays = json['TotalTransitDays'] != null ? new MessageTime.fromJson(json['TotalTransitDays']) : null;
    pickupPostalLocAddDays = json['PickupPostalLocAddDays'] != null ? new MessageTime.fromJson(json['PickupPostalLocAddDays']) : null;
    deliveryPostalLocAddDays = json['DeliveryPostalLocAddDays'] != null ? new MessageTime.fromJson(json['DeliveryPostalLocAddDays']) : null;
    pickupNonDHLCourierCode = json['PickupNonDHLCourierCode'] != null ? new Xmlns.fromJson(json['PickupNonDHLCourierCode']) : null;
    deliveryNonDHLCourierCode = json['DeliveryNonDHLCourierCode'] != null ? new Xmlns.fromJson(json['DeliveryNonDHLCourierCode']) : null;
    deliveryDate = json['DeliveryDate'] != null ? new DeliveryDate.fromJson(json['DeliveryDate']) : null;
    deliveryTime = json['DeliveryTime'] != null ? new MessageTime.fromJson(json['DeliveryTime']) : null;
    dimensionalWeight = json['DimensionalWeight'] != null ? new MessageTime.fromJson(json['DimensionalWeight']) : null;
    weightUnit = json['WeightUnit'] != null ? new MessageTime.fromJson(json['WeightUnit']) : null;
    pickupDayOfWeekNum = json['PickupDayOfWeekNum'] != null ? new MessageTime.fromJson(json['PickupDayOfWeekNum']) : null;
    destinationDayOfWeekNum = json['DestinationDayOfWeekNum '] != null ? new DestinationDayOfWeekNum.fromJson(json['DestinationDayOfWeekNum ']) : null;
    quotedWeight = json['QuotedWeight '] != null ? new DestinationDayOfWeekNum.fromJson(json['QuotedWeight ']) : null;
    quotedWeightUOM = json['QuotedWeightUOM '] != null ? new DestinationDayOfWeekNum.fromJson(json['QuotedWeightUOM ']) : null;
    if (json['QtdShpExChrg '] != null) {
      qtdShpExChrg = new List<QtdShpExChrg>();
      json['QtdShpExChrg '].forEach((v) { qtdShpExChrg.add(new QtdShpExChrg.fromJson(v)); });
    }
    pricingDate = json['PricingDate'] != null ? new MessageTime.fromJson(json['PricingDate']) : null;
    shippingCharge = json['ShippingCharge'] != null ? new MessageTime.fromJson(json['ShippingCharge']) : null;
    totalTaxAmount = json['TotalTaxAmount'] != null ? new MessageTime.fromJson(json['TotalTaxAmount']) : null;
    if (json['QtdSInAdCur'] != null) {
      qtdSInAdCur = new List<QtdSInAdCur>();
      json['QtdSInAdCur'].forEach((v) { qtdSInAdCur.add(new QtdSInAdCur.fromJson(v)); });
    }
    pickupWindowEarliestTime = json['PickupWindowEarliestTime'] != null ? new MessageTime.fromJson(json['PickupWindowEarliestTime']) : null;
    pickupWindowLatestTime = json['PickupWindowLatestTime'] != null ? new MessageTime.fromJson(json['PickupWindowLatestTime']) : null;
    bookingCutoffOffset = json['BookingCutoffOffset'] != null ? new MessageTime.fromJson(json['BookingCutoffOffset']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.originServiceArea != null) {
      data['OriginServiceArea'] = this.originServiceArea.toJson();
    }
    if (this.destinationServiceArea != null) {
      data['DestinationServiceArea'] = this.destinationServiceArea.toJson();
    }
    if (this.globalProductCode != null) {
      data['GlobalProductCode'] = this.globalProductCode.toJson();
    }
    if (this.localProductCode != null) {
      data['LocalProductCode'] = this.localProductCode.toJson();
    }
    if (this.productShortName != null) {
      data['ProductShortName'] = this.productShortName.toJson();
    }
    if (this.localProductName != null) {
      data['LocalProductName'] = this.localProductName.toJson();
    }
    if (this.networkTypeCode != null) {
      data['NetworkTypeCode'] = this.networkTypeCode.toJson();
    }
    if (this.pOfferedCustAgreement != null) {
      data['POfferedCustAgreement'] = this.pOfferedCustAgreement.toJson();
    }
    if (this.transInd != null) {
      data['TransInd'] = this.transInd.toJson();
    }
    if (this.pickupDate != null) {
      data['PickupDate'] = this.pickupDate.toJson();
    }
    if (this.pickupCutoffTime != null) {
      data['PickupCutoffTime'] = this.pickupCutoffTime.toJson();
    }
    if (this.bookingTime != null) {
      data['BookingTime'] = this.bookingTime.toJson();
    }
    if (this.currencyCode != null) {
      data['CurrencyCode'] = this.currencyCode.toJson();
    }
    if (this.exchangeRate != null) {
      data['ExchangeRate'] = this.exchangeRate.toJson();
    }
    if (this.weightCharge != null) {
      data['WeightCharge'] = this.weightCharge.toJson();
    }
    if (this.weightChargeTax != null) {
      data['WeightChargeTax'] = this.weightChargeTax.toJson();
    }
    if (this.totalTransitDays != null) {
      data['TotalTransitDays'] = this.totalTransitDays.toJson();
    }
    if (this.pickupPostalLocAddDays != null) {
      data['PickupPostalLocAddDays'] = this.pickupPostalLocAddDays.toJson();
    }
    if (this.deliveryPostalLocAddDays != null) {
      data['DeliveryPostalLocAddDays'] = this.deliveryPostalLocAddDays.toJson();
    }
    if (this.pickupNonDHLCourierCode != null) {
      data['PickupNonDHLCourierCode'] = this.pickupNonDHLCourierCode.toJson();
    }
    if (this.deliveryNonDHLCourierCode != null) {
      data['DeliveryNonDHLCourierCode'] = this.deliveryNonDHLCourierCode.toJson();
    }
    if (this.deliveryDate != null) {
      data['DeliveryDate'] = this.deliveryDate.toJson();
    }
    if (this.deliveryTime != null) {
      data['DeliveryTime'] = this.deliveryTime.toJson();
    }
    if (this.dimensionalWeight != null) {
      data['DimensionalWeight'] = this.dimensionalWeight.toJson();
    }
    if (this.weightUnit != null) {
      data['WeightUnit'] = this.weightUnit.toJson();
    }
    if (this.pickupDayOfWeekNum != null) {
      data['PickupDayOfWeekNum'] = this.pickupDayOfWeekNum.toJson();
    }
    if (this.destinationDayOfWeekNum != null) {
      data['DestinationDayOfWeekNum '] = this.destinationDayOfWeekNum.toJson();
    }
    if (this.quotedWeight != null) {
      data['QuotedWeight '] = this.quotedWeight.toJson();
    }
    if (this.quotedWeightUOM != null) {
      data['QuotedWeightUOM '] = this.quotedWeightUOM.toJson();
    }
    if (this.qtdShpExChrg != null) {
      data['QtdShpExChrg '] = this.qtdShpExChrg.map((v) => v.toJson()).toList();
    }
    if (this.pricingDate != null) {
      data['PricingDate'] = this.pricingDate.toJson();
    }
    if (this.shippingCharge != null) {
      data['ShippingCharge'] = this.shippingCharge.toJson();
    }
    if (this.totalTaxAmount != null) {
      data['TotalTaxAmount'] = this.totalTaxAmount.toJson();
    }
    if (this.qtdSInAdCur != null) {
      data['QtdSInAdCur'] = this.qtdSInAdCur.map((v) => v.toJson()).toList();
    }
    if (this.pickupWindowEarliestTime != null) {
      data['PickupWindowEarliestTime'] = this.pickupWindowEarliestTime.toJson();
    }
    if (this.pickupWindowLatestTime != null) {
      data['PickupWindowLatestTime'] = this.pickupWindowLatestTime.toJson();
    }
    if (this.bookingCutoffOffset != null) {
      data['BookingCutoffOffset'] = this.bookingCutoffOffset.toJson();
    }
    return data;
  }
}

class OriginServiceArea {
  MessageTime facilityCode;
  MessageTime serviceAreaCode;

  OriginServiceArea({this.facilityCode, this.serviceAreaCode});

  OriginServiceArea.fromJson(Map<String, dynamic> json) {
    facilityCode = json['FacilityCode'] != null ? new MessageTime.fromJson(json['FacilityCode']) : null;
    serviceAreaCode = json['ServiceAreaCode'] != null ? new MessageTime.fromJson(json['ServiceAreaCode']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.facilityCode != null) {
      data['FacilityCode'] = this.facilityCode.toJson();
    }
    if (this.serviceAreaCode != null) {
      data['ServiceAreaCode'] = this.serviceAreaCode.toJson();
    }
    return data;
  }
}

class DeliveryDate {
  MessageTime deliveryType;
  MessageTime dlvyDateTime;
  MessageTime deliveryDateTimeOffset;

  DeliveryDate({this.deliveryType, this.dlvyDateTime, this.deliveryDateTimeOffset});

  DeliveryDate.fromJson(Map<String, dynamic> json) {
    deliveryType = json['DeliveryType'] != null ? new MessageTime.fromJson(json['DeliveryType']) : null;
    dlvyDateTime = json['DlvyDateTime'] != null ? new MessageTime.fromJson(json['DlvyDateTime']) : null;
    deliveryDateTimeOffset = json['DeliveryDateTimeOffset'] != null ? new MessageTime.fromJson(json['DeliveryDateTimeOffset']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deliveryType != null) {
      data['DeliveryType'] = this.deliveryType.toJson();
    }
    if (this.dlvyDateTime != null) {
      data['DlvyDateTime'] = this.dlvyDateTime.toJson();
    }
    if (this.deliveryDateTimeOffset != null) {
      data['DeliveryDateTimeOffset'] = this.deliveryDateTimeOffset.toJson();
    }
    return data;
  }
}

class DestinationDayOfWeekNum {
  String t;

  DestinationDayOfWeekNum({this.t});

  DestinationDayOfWeekNum.fromJson(Map<String, dynamic> json) {
    t = json['\$t '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$t '] = this.t;
    return data;
  }
}

class QtdShpExChrg {
  MessageTime specialServiceType;
  MessageTime localServiceType;
  MessageTime globalServiceName;
  MessageTime localServiceTypeName;
  MessageTime sOfferedCustAgreement;
  MessageTime chargeCodeType;
  MessageTime currencyCode;
  MessageTime chargeValue;
  List<QtdSExtrChrgInAdCur> qtdSExtrChrgInAdCur;

  QtdShpExChrg({this.specialServiceType, this.localServiceType, this.globalServiceName, this.localServiceTypeName, this.sOfferedCustAgreement, this.chargeCodeType, this.currencyCode, this.chargeValue, this.qtdSExtrChrgInAdCur,
    });

  QtdShpExChrg.fromJson(Map<String, dynamic> json) {
    specialServiceType = json['SpecialServiceType '] != null ? new MessageTime.fromJson(json['SpecialServiceType ']) : null;
    localServiceType = json['LocalServiceType '] != null ? new MessageTime.fromJson(json['LocalServiceType ']) : null;
    globalServiceName = json['GlobalServiceName '] != null ? new MessageTime.fromJson(json['GlobalServiceName ']) : null;
    localServiceTypeName = json['LocalServiceTypeName '] != null ? new MessageTime.fromJson(json['LocalServiceTypeName ']) : null;
    sOfferedCustAgreement = json['SOfferedCustAgreement '] != null ? new MessageTime.fromJson(json['SOfferedCustAgreement ']) : null;
    chargeCodeType = json['ChargeCodeType '] != null ? new MessageTime.fromJson(json['ChargeCodeType ']) : null;
    currencyCode = json['CurrencyCode '] != null ? new MessageTime.fromJson(json['CurrencyCode ']) : null;
    chargeValue = json['ChargeValue '] != null ? new MessageTime.fromJson(json['ChargeValue ']) : null;
    if (json['QtdSExtrChrgInAdCur '] != null) {
      qtdSExtrChrgInAdCur = new List<QtdSExtrChrgInAdCur>();
      json['QtdSExtrChrgInAdCur '].forEach((v) { qtdSExtrChrgInAdCur.add(new QtdSExtrChrgInAdCur.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.specialServiceType != null) {
      data['SpecialServiceType '] = this.specialServiceType.toJson();
    }
    if (this.localServiceType != null) {
      data['LocalServiceType '] = this.localServiceType.toJson();
    }
    if (this.globalServiceName != null) {
      data['GlobalServiceName '] = this.globalServiceName.toJson();
    }
    if (this.localServiceTypeName != null) {
      data['LocalServiceTypeName '] = this.localServiceTypeName.toJson();
    }
    if (this.sOfferedCustAgreement != null) {
      data['SOfferedCustAgreement '] = this.sOfferedCustAgreement.toJson();
    }
    if (this.chargeCodeType != null) {
      data['ChargeCodeType '] = this.chargeCodeType.toJson();
    }
    if (this.currencyCode != null) {
      data['CurrencyCode '] = this.currencyCode.toJson();
    }
    if (this.chargeValue != null) {
      data['ChargeValue '] = this.chargeValue.toJson();
    }
    if (this.qtdSExtrChrgInAdCur != null) {
      data['QtdSExtrChrgInAdCur '] = this.qtdSExtrChrgInAdCur.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class QtdSExtrChrgInAdCur {
  MessageTime chargeValue;
  MessageTime currencyCode;
  MessageTime currencyRoleTypeCode;
  MessageTime chargeTaxRate;

  QtdSExtrChrgInAdCur({this.chargeValue, this.currencyCode, this.currencyRoleTypeCode, this.chargeTaxRate});

  QtdSExtrChrgInAdCur.fromJson(Map<String, dynamic> json) {
    chargeValue = json['ChargeValue '] != null ? new MessageTime.fromJson(json['ChargeValue ']) : null;
    currencyCode = json['CurrencyCode '] != null ? new MessageTime.fromJson(json['CurrencyCode ']) : null;
    currencyRoleTypeCode = json['CurrencyRoleTypeCode '] != null ? new MessageTime.fromJson(json['CurrencyRoleTypeCode ']) : null;
    chargeTaxRate = json['ChargeTaxRate '] != null ? new MessageTime.fromJson(json['ChargeTaxRate ']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chargeValue != null) {
      data['ChargeValue '] = this.chargeValue.toJson();
    }
    if (this.currencyCode != null) {
      data['CurrencyCode '] = this.currencyCode.toJson();
    }
    if (this.currencyRoleTypeCode != null) {
      data['CurrencyRoleTypeCode '] = this.currencyRoleTypeCode.toJson();
    }
    if (this.chargeTaxRate != null) {
      data['ChargeTaxRate '] = this.chargeTaxRate.toJson();
    }
    return data;
  }
}


class QtdSInAdCur {
  MessageTime currencyCode;
  MessageTime currencyRoleTypeCode;
  MessageTime weightCharge;
  MessageTime totalAmount;
  MessageTime totalTaxAmount;
  MessageTime weightChargeTax;
  MessageTime exchangeRate;

  QtdSInAdCur({this.currencyCode, this.currencyRoleTypeCode, this.weightCharge, this.totalAmount, this.totalTaxAmount, this.weightChargeTax, this.exchangeRate});

  QtdSInAdCur.fromJson(Map<String, dynamic> json) {
    currencyCode = json['CurrencyCode'] != null ? new MessageTime.fromJson(json['CurrencyCode']) : null;
    currencyRoleTypeCode = json['CurrencyRoleTypeCode'] != null ? new MessageTime.fromJson(json['CurrencyRoleTypeCode']) : null;
    weightCharge = json['WeightCharge'] != null ? new MessageTime.fromJson(json['WeightCharge']) : null;
    totalAmount = json['TotalAmount'] != null ? new MessageTime.fromJson(json['TotalAmount']) : null;
    totalTaxAmount = json['TotalTaxAmount'] != null ? new MessageTime.fromJson(json['TotalTaxAmount']) : null;
    weightChargeTax = json['WeightChargeTax'] != null ? new MessageTime.fromJson(json['WeightChargeTax']) : null;
    exchangeRate = json['ExchangeRate'] != null ? new MessageTime.fromJson(json['ExchangeRate']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currencyCode != null) {
      data['CurrencyCode'] = this.currencyCode.toJson();
    }
    if (this.currencyRoleTypeCode != null) {
      data['CurrencyRoleTypeCode'] = this.currencyRoleTypeCode.toJson();
    }
    if (this.weightCharge != null) {
      data['WeightCharge'] = this.weightCharge.toJson();
    }
    if (this.totalAmount != null) {
      data['TotalAmount'] = this.totalAmount.toJson();
    }
    if (this.totalTaxAmount != null) {
      data['TotalTaxAmount'] = this.totalTaxAmount.toJson();
    }
    if (this.weightChargeTax != null) {
      data['WeightChargeTax'] = this.weightChargeTax.toJson();
    }
    if (this.exchangeRate != null) {
      data['ExchangeRate'] = this.exchangeRate.toJson();
    }
    return data;
  }
}

class Srvs {
  Srv srv;

  Srvs({this.srv});

  Srvs.fromJson(Map<String, dynamic> json) {
    srv = json['Srv'] != null ? new Srv.fromJson(json['Srv']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.srv != null) {
      data['Srv'] = this.srv.toJson();
    }
    return data;
  }
}

class Srv {
  MessageTime globalProductCode;
  List<MrkSrv> mrkSrv;

  Srv({this.globalProductCode, this.mrkSrv});

  Srv.fromJson(Map<String, dynamic> json) {
    globalProductCode = json['GlobalProductCode'] != null ? new MessageTime.fromJson(json['GlobalProductCode']) : null;
    if (json['MrkSrv'] != null) {
      mrkSrv = new List<MrkSrv>();
      json['MrkSrv'].forEach((v) { mrkSrv.add(new MrkSrv.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.globalProductCode != null) {
      data['GlobalProductCode'] = this.globalProductCode.toJson();
    }
    if (this.mrkSrv != null) {
      data['MrkSrv'] = this.mrkSrv.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MrkSrv {
  MessageTime localProductCode;
  MessageTime productShortName;
  MessageTime localProductName;
  MessageTime productDesc;
  MessageTime networkTypeCode;
  MessageTime pOfferedCustAgreement;
  MessageTime transInd;
  MessageTime localProductCtryCd;
  MessageTime globalServiceType;
  MessageTime localServiceName;
  MessageTime localServiceType;
  MessageTime globalServiceName;
  MessageTime localServiceTypeName;
  MessageTime sOfferedCustAgreement;
  MessageTime chargeCodeType;
  MessageTime mrkSrvInd;

  MrkSrv({this.localProductCode, this.productShortName, this.localProductName, this.productDesc, this.networkTypeCode, this.pOfferedCustAgreement, this.transInd, this.localProductCtryCd, this.globalServiceType, this.localServiceName, this.localServiceType, this.globalServiceName, this.localServiceTypeName, this.sOfferedCustAgreement, this.chargeCodeType, this.mrkSrvInd});

  MrkSrv.fromJson(Map<String, dynamic> json) {
    localProductCode = json['LocalProductCode'] != null ? new MessageTime.fromJson(json['LocalProductCode']) : null;
    productShortName = json['ProductShortName'] != null ? new MessageTime.fromJson(json['ProductShortName']) : null;
    localProductName = json['LocalProductName'] != null ? new MessageTime.fromJson(json['LocalProductName']) : null;
    productDesc = json['ProductDesc'] != null ? new MessageTime.fromJson(json['ProductDesc']) : null;
    networkTypeCode = json['NetworkTypeCode'] != null ? new MessageTime.fromJson(json['NetworkTypeCode']) : null;
    pOfferedCustAgreement = json['POfferedCustAgreement'] != null ? new MessageTime.fromJson(json['POfferedCustAgreement']) : null;
    transInd = json['TransInd'] != null ? new MessageTime.fromJson(json['TransInd']) : null;
    localProductCtryCd = json['LocalProductCtryCd'] != null ? new MessageTime.fromJson(json['LocalProductCtryCd']) : null;
    globalServiceType = json['GlobalServiceType'] != null ? new MessageTime.fromJson(json['GlobalServiceType']) : null;
    localServiceName = json['LocalServiceName'] != null ? new MessageTime.fromJson(json['LocalServiceName']) : null;
    localServiceType = json['LocalServiceType'] != null ? new MessageTime.fromJson(json['LocalServiceType']) : null;
    globalServiceName = json['GlobalServiceName'] != null ? new MessageTime.fromJson(json['GlobalServiceName']) : null;
    localServiceTypeName = json['LocalServiceTypeName'] != null ? new MessageTime.fromJson(json['LocalServiceTypeName']) : null;
    sOfferedCustAgreement = json['SOfferedCustAgreement'] != null ? new MessageTime.fromJson(json['SOfferedCustAgreement']) : null;
    chargeCodeType = json['ChargeCodeType'] != null ? new MessageTime.fromJson(json['ChargeCodeType']) : null;
    mrkSrvInd = json['MrkSrvInd'] != null ? new MessageTime.fromJson(json['MrkSrvInd']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.localProductCode != null) {
      data['LocalProductCode'] = this.localProductCode.toJson();
    }
    if (this.productShortName != null) {
      data['ProductShortName'] = this.productShortName.toJson();
    }
    if (this.localProductName != null) {
      data['LocalProductName'] = this.localProductName.toJson();
    }
    if (this.productDesc != null) {
      data['ProductDesc'] = this.productDesc.toJson();
    }
    if (this.networkTypeCode != null) {
      data['NetworkTypeCode'] = this.networkTypeCode.toJson();
    }
    if (this.pOfferedCustAgreement != null) {
      data['POfferedCustAgreement'] = this.pOfferedCustAgreement.toJson();
    }
    if (this.transInd != null) {
      data['TransInd'] = this.transInd.toJson();
    }
    if (this.localProductCtryCd != null) {
      data['LocalProductCtryCd'] = this.localProductCtryCd.toJson();
    }
    if (this.globalServiceType != null) {
      data['GlobalServiceType'] = this.globalServiceType.toJson();
    }
    if (this.localServiceName != null) {
      data['LocalServiceName'] = this.localServiceName.toJson();
    }
    if (this.localServiceType != null) {
      data['LocalServiceType'] = this.localServiceType.toJson();
    }
    if (this.globalServiceName != null) {
      data['GlobalServiceName'] = this.globalServiceName.toJson();
    }
    if (this.localServiceTypeName != null) {
      data['LocalServiceTypeName'] = this.localServiceTypeName.toJson();
    }
    if (this.sOfferedCustAgreement != null) {
      data['SOfferedCustAgreement'] = this.sOfferedCustAgreement.toJson();
    }
    if (this.chargeCodeType != null) {
      data['ChargeCodeType'] = this.chargeCodeType.toJson();
    }
    if (this.mrkSrvInd != null) {
      data['MrkSrvInd'] = this.mrkSrvInd.toJson();
    }
    return data;
  }
}

class Note {
  MessageTime actionStatus;

  Note({this.actionStatus});

  Note.fromJson(Map<String, dynamic> json) {
    actionStatus = json['ActionStatus'] != null ? new MessageTime.fromJson(json['ActionStatus']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.actionStatus != null) {
      data['ActionStatus'] = this.actionStatus.toJson();
    }
    return data;
  }
}


