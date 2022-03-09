class LiftRequest {
  Order order;

  LiftRequest({this.order});

  LiftRequest.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    return data;
  }
}

class Order {
  int hubId;
  String zone;
  String initialDeliveryTime;
  String finishDeliveryTime;
  String startTime;
  String endTime;
  double latitude;
  double longitude;
  String neighborhood;
  String city;
  String state;
  String orderNumber;
  String promise;
  String observations;
  Customer customer;
  List<Items> items;

  Order(
      {this.hubId,
        this.zone,
        this.initialDeliveryTime,
        this.finishDeliveryTime,
        this.startTime,
        this.endTime,
        this.latitude,
        this.longitude,
        this.neighborhood,
        this.city,
        this.state,
        this.orderNumber,
        this.promise,
        this.observations,
        this.customer,
        this.items});

  Order.fromJson(Map<String, dynamic> json) {
    hubId = json['hub_id'];
    zone = json['zone'];
    initialDeliveryTime = json['initial_delivery_time'];
    finishDeliveryTime = json['finish_delivery_time'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    state = json['state'];
    orderNumber = json['order_number'];
    promise = json['promise'];
    observations = json['observations'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hub_id'] = this.hubId;
    data['zone'] = this.zone;
    data['initial_delivery_time'] = this.initialDeliveryTime;
    data['finish_delivery_time'] = this.finishDeliveryTime;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['neighborhood'] = this.neighborhood;
    data['city'] = this.city;
    data['state'] = this.state;
    data['order_number'] = this.orderNumber;
    data['promise'] = this.promise;
    data['observations'] = this.observations;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  String name;
  String identificationNumber;
  String contact;
  String phone;
  String email;
  String address;
  String extraAddress;
  String internalId;

  Customer(
      {this.name,
        this.identificationNumber,
        this.contact,
        this.phone,
        this.email,
        this.address,
        this.extraAddress,
        this.internalId});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    identificationNumber = json['identification_number'];
    contact = json['contact'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    extraAddress = json['extra_address'];
    internalId = json['internal_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['identification_number'] = this.identificationNumber;
    data['contact'] = this.contact;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['extra_address'] = this.extraAddress;
    data['internal_id'] = this.internalId;
    return data;
  }
}

class Items {
  String sku;
  String barcode;
  String description;
  int unitWeight;
  int unitVolume;
  int quantity;
  int unitPrice;
  int totalPrice;
  int totalCollect;

  Items(
      {this.sku,
        this.barcode,
        this.description,
        this.unitWeight,
        this.unitVolume,
        this.quantity,
        this.unitPrice,
        this.totalPrice,
        this.totalCollect});

  Items.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    barcode = json['barcode'];
    description = json['description'];
    unitWeight = json['unit_weight'];
    unitVolume = json['unit_volume'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    totalPrice = json['total_price'];
    totalCollect = json['total_collect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['barcode'] = this.barcode;
    data['description'] = this.description;
    data['unit_weight'] = this.unitWeight;
    data['unit_volume'] = this.unitVolume;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['total_price'] = this.totalPrice;
    data['total_collect'] = this.totalCollect;
    return data;
  }
}
