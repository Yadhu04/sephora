import '../../domain/entities/product_detail.dart';
import '../../domain/entities/product_tab.dart';

class ProductDetailModel extends ProductDetail {
  ProductDetailModel({
    required super.title,
      required super.id,
    required super.description,
    required super.brandName,
    required super.metaTitle,
    required super.metaDescription,
    required super.images,
    required super.price,
    required super.originalPrice,
    required super.tabsByTitle,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    final variants = json['variants'] as List;
    final firstVariant = variants.first;

    /// Images
    final images = (json['productImages'] as List)
        .map((e) => e['image'].toString())
        .toList();

    /// Tabs → Map by title
    final Map<String, ProductTab> tabsMap = {};

    final tabs = json['tabs'] as List?;
    if (tabs != null) {
      for (final tab in tabs) {
        final title = tab['title'];
        final content = tab['content'];

        if (title != null && content != null) {
          tabsMap[title] = ProductTab(
            title: title,
            content: content,
          );
        }
      }
    }

    return ProductDetailModel(
      title: json['title'],
       id: json['id'] ?? '',
      description: json['description'],
      brandName: json['brand']?['title'] ?? '',
      metaTitle: json['metaTitle'] ?? '',
      metaDescription: json['metaDescription'] ?? '',
      images: images,
      price: (firstVariant['currentPrice'] as num).toDouble(),
      originalPrice: (firstVariant['originalPrice'] as num).toDouble(),
      tabsByTitle: tabsMap,
    );
  }
}
