class Book {
  int id;
  String title;
  String? data; // Nullable
  String? image; // Nullable
  int? marketPrice; // Nullable
  int? sellingPrice; // Nullable
  String? description; // Nullable
  Category? category; // Nullable
  bool favorite;

  Book({
    required this.id,
    required this.title,
    this.data,
    this.image,
    this.marketPrice,
    this.sellingPrice,
    this.description,
    this.category,
    this.favorite = false, // Default value
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0, // Default to 0 if null
      title: json['title'] ?? "Untitled", // Default if null
      data: json['data'],
      image: json['image'],
      marketPrice: json['market_price'],
      sellingPrice: json['selling_price'],
      description: json['description'],
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null, // Handle null category
      favorite: json['favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'data': data,
      'image': image,
      'market_price': marketPrice,
      'selling_price': sellingPrice,
      'description': description,
      'category': category?.toJson(),
      'favorite': favorite,
    };
  }
}

class Category {
  int id;
  String title;
  String? date; // Nullable

  Category({
    required this.id,
    required this.title,
    this.date,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0, // Default to 0 if null
      title: json['title'] ?? "No Title", // Default if null
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
    };
  }
}
