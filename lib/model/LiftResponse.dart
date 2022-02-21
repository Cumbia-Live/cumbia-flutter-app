class LiftResponse {
  Order order;

  LiftResponse({this.order});

  LiftResponse.fromJson(Map<String, dynamic> json) {
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
  Customer customer;
  int id;
  List<Items> items;
  String orderNumber;
  String trackingNumber;
  bool valid;

  Order(
      {this.customer,
        this.id,
        this.items,
        this.orderNumber,
        this.trackingNumber,
        this.valid});

  Order.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    id = json['id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    orderNumber = json['order_number'];
    trackingNumber = json['tracking_number'];
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['order_number'] = this.orderNumber;
    data['tracking_number'] = this.trackingNumber;
    data['valid'] = this.valid;
    return data;
  }
}

class Customer {
  int id;
  String internalId;
  int orderId;

  Customer({this.id, this.internalId, this.orderId});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    internalId = json['internal_id'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['internal_id'] = this.internalId;
    data['order_id'] = this.orderId;
    return data;
  }
}

class Items {
  int id;
  int orderId;
  String sku;

  Items({this.id, this.orderId, this.sku});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    sku = json['sku'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['sku'] = this.sku;
    return data;
  }
}
