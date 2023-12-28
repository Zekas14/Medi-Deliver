
class Product {
  late String name;
  late String imagePath;
  late String description;
  late String category;
  late int price;
  static Product? product;
  String? id;

  Product({
    required this.name,
    required this.imagePath,
    required this.description,
    required this.category,
    required this.price,
    this.id,
  });
<<<<<<< HEAD

  // Factory method to create a Product instance from a Map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json["name"],
      imagePath: json["image"],
      description: json["description"],
      category: json["category"],
      price: json["price"],
      id: json["id"],
    );
  }

  // Method to convert a Product instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': imagePath,
      'description': description,
      'category': category,
      'price': price,
      'id': id,
    };
  }

  // Override == operator for equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.imagePath == imagePath &&
        other.description == description &&
        other.category == category &&
        other.price == price;
  }

  // Override hashCode for consistency with == operator
  @override
  int get hashCode {
    return name.hashCode ^
        imagePath.hashCode ^
        description.hashCode ^
        category.hashCode ^
        price.hashCode;
  }
=======
>>>>>>> e8c57787743054bebfd58882b9012ed4d8d77225
}
