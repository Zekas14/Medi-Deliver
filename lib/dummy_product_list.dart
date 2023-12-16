import 'package:medi_deliver/component/MedicineItem.dart';
import 'package:medi_deliver/core/ExtensionFunctions.dart';
import 'package:medi_deliver/model/orderContent.dart';
import 'package:medi_deliver/model/product.dart';

 List<Product> productList=[];
 List<Map<String, String>> categoriesList = [
    {
      "name": "Health care",
      "imagePath": "asset/images/categories/category3.png"
    },
    {"name": "Skin care", "imagePath": "asset/images/categories/category2.jpg"},
    {"name": "Hair care", "imagePath": "asset/images/categories/category1.jpg"},
    {"name": "Baby care", "imagePath": "asset/images/categories/category4.jpg"},
  ];
  List<Product> categoryList = [];
  