class Product {
  String imagePath;
  String description;
  double price;
  String category;

  // Constructor
  Product({
    required this.imagePath,
    required this.description,
    required this.price,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      imagePath: map['imagePath'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
      category: map['category'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Product{imagePath: $imagePath, description: $description, price: $price, category: $category}';
  }
}
