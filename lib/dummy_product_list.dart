import 'model/product_model.dart';

List<Map<String, dynamic>> productList = [
  {
    'imagePath': 'asset/images/products/hairP1.jpg',
    'description':
        'Head & Shoulders Menthol Refresh Anti-Dandruff Shampoo with Menthol 400 ml',
    'price': 153,
    'category': 'Hair_Care',
  },
  {
    'imagePath': 'asset/images/products/hairP3.jpg',
    'description': 'Sunsilk Cocreations Shine And Strength Shampoo 600 ML',
    'price': 78,
    'category': 'Hair_Care',
  },
  {
    'imagePath': 'asset/images/products/hairP2.jpg',
    'description':
        'Tresemmé Shampoo Keratin Smooth & Straight 400ML + Tresemmé Conditioner Keratin Smooth & Straight 400ML',
    'price': 228,
    'category': 'Hair_Care',
  },
  {
    'imagePath': 'asset/images/products/skincareP1.jpg',
    'description':
        'Care & more soft cream with glycerin 75 ml vanilla & cookies',
    'price': 25,
    'category': 'Skin_Care',
  },
  {
    'imagePath': 'asset/images/products/skincareP2.jpg',
    'description':
        'NIVEA Body Cream Dry Skin, Cocoa Butter Vitamin E, Jar 50ml',
    'price': 178,
    'category': 'Skin_Care',
  },
  {
    'imagePath': 'asset/images/products/skincareP3.jpg',
    'description':
        'RAW AFRICAN | Very Berry Exfoliator | 200 gm | Organic Body Scrub | Moisturizing and Exfoliating | Berry Extracts | Vegan | 100% Natural Essential Oils',
    'price': 168,
    'category': 'Skin_Care',
  },
  {
    'imagePath': 'asset/images/products/skincareP4.jpg',
    'description': 'Luxurious Blue Nila face and body scrub, 200ml',
    'price': 83,
    'category': 'Skin_Care',
  },
  {
    'imagePath': 'asset/images/products/babycareP1.jpg',
    'description':
        'Pampers Baby-Dry Diapers, Size 3, Medium, 6-10kg, 58 Count packaging may vary',
    'price': 299,
    'category': 'Baby_Care',
  },
  {
    'imagePath': 'asset/images/products/babycareP2.jpg',
    'description': 'Fine Baby Diapers, Size 5, Maxi, 11-18 kg, 76 Diaper',
    'price': 328,
    'category': 'Baby_Care',
  },
  {
    'imagePath': 'asset/images/products/babycareP3.jpg',
    'description':
        'Molfix - Baby Diapers - Jumbo Pack - New Born Size 1 - 60 Pieces - "Pack Design May Vary"',
    'price': 228,
    'category': 'Baby_Care',
  },
  {
    'imagePath': 'asset/images/products/healthcareP1.jpg',
    'description':
        'PANADOL EXTRA ( PARACETAMOL 500mg + CAFFEINE 65 mg ) 24 FILM-COATED TABLETS',
    'price': 26,
    'category': 'Health_Care',
  },
  {
    'imagePath': 'asset/images/products/healthcareP2.jpg',
    'description': 'PANADOL COLD & FLU DAY 24 TAB',
    'price': 36,
    'category': 'Health_Care',
  },
];
List<Product> products = productList.map((map) {
  return Product(
    imagePath: map['imagePath'],
    description: map['description'],
    price: map['price'].toDouble(),
    category: map['category'],
  );
}).toList();
