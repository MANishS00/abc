class CartModel {
  final int id;
  final int total;
  final bool isComplete;
  final String date;
  final int user;
  final List<CartBooks> cartBooks;

  CartModel({
    required this.id,
    required this.total,
    required this.isComplete,
    required this.date,
    required this.user,
    required this.cartBooks,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? 0,
      total: json['total'] ?? 0,
      isComplete: json['isComplit'] ?? false,
      date: json['date'] ?? '',
      user: json['user'] ?? 0,
      cartBooks: (json['cartbooks'] as List?)
          ?.map((v) => CartBooks.fromJson(v))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'total': total,
    'isComplit': isComplete,
    'date': date,
    'user': user,
    'cartbooks': cartBooks.map((v) => v.toJson()).toList(),
  };
}

class CartBooks {
  final int id;
  final int price;
  late final int quantity;
  final int subtotal;
  final Cart cart;
  final List<Book> books;

  CartBooks({
    required this.id,
    required this.price,
    required this.quantity,
    required this.subtotal,
    required this.cart,
    required this.books,
  });

  factory CartBooks.fromJson(Map<String, dynamic> json) {
    return CartBooks(
      id: json['id'] ?? 0,
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      subtotal: json['subtotal'] ?? 0,
      cart: Cart.fromJson(json['cart'] ?? {}),
      books: (json['book'] as List?)
          ?.map((v) => Book.fromJson(v))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'price': price,
    'quantity': quantity,
    'subtotal': subtotal,
    'cart': cart.toJson(),
    'book': books.map((v) => v.toJson()).toList(),
  };
}

class Cart {
  final int id;
  final int total;
  final bool isComplete;
  final String date;
  final int user;

  Cart({
    required this.id,
    required this.total,
    required this.isComplete,
    required this.date,
    required this.user,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] ?? 0,
      total: json['total'] ?? 0,
      isComplete: json['isComplit'] ?? false,
      date: json['date'] ?? '',
      user: json['user'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'total': total,
    'isComplit': isComplete,
    'date': date,
    'user': user,
  };
}

class Book {
  final int id;
  final String title;
  final String data;
  final String image;
  final int marketPrice;
  final int sellingPrice;
  final String description;
  final int category;

  Book({
    required this.id,
    required this.title,
    required this.data,
    required this.image,
    required this.marketPrice,
    required this.sellingPrice,
    required this.description,
    required this.category,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      data: json['data'] ?? '',
      image: json['image'] ?? '',
      marketPrice: json['marcket_price'] ?? 0,
      sellingPrice: json['selling_price'] ?? 0,
      description: json['description'] ?? '',
      category: json['category'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'data': data,
    'image': image,
    'marcket_price': marketPrice,
    'selling_price': sellingPrice,
    'description': description,
    'category': category,
  };
}
