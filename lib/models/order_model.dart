class OrderModel {
  int id;
  String email;
  String phone;
  String address;
  Cart cart;

  OrderModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.address,
    required this.cart,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        phone = json['phone'],
        address = json['address'],
        cart = Cart.fromJson(json['cart'] ?? {});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'address': address,
      'cart': cart.toJson(),
    };
  }
}

class Cart {
  int id;
  int total;
  bool isComplit;
  String date;
  int user;

  Cart({
    required this.id,
    required this.total,
    required this.isComplit,
    required this.date,
    required this.user,
  });

  Cart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        total = json['total'],
        isComplit = json['isComplit'],
        date = json['date'],
        user = json['user'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'isComplit': isComplit,
      'date': date,
      'user': user,
    };
  }
}
