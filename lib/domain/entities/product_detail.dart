import 'product_tab.dart';

class ProductDetail {
  final String title;
  final String description;
  final String id;

  final String brandName;
  final String metaTitle;
  final String metaDescription;

  final List<String> images;

  final double price;
  final double originalPrice;


  final Map<String, ProductTab> tabsByTitle;

  ProductDetail({
    required this.title,
    required this.description,
    required this.id,
    required this.brandName,
    required this.metaTitle,
    required this.metaDescription,
    required this.images,
    required this.price,
    required this.originalPrice,
    required this.tabsByTitle,
  });


  ProductTab? get ingredients => tabsByTitle['Ingredients'];
  ProductTab? get howToUse => tabsByTitle['How To Use'];
  ProductTab? get summary => tabsByTitle['Summary'];
}
