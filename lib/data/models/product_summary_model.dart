import '../../domain/entities/product_summary.dart';

class ProductSummaryModel extends ProductSummary {
  ProductSummaryModel({
    required super.id,
    required super.brand,
    required super.title,
    required super.handle,
    required super.imageUrl,
    required super.rating,
    required super.reviewCount,
    required super.originalPrice,
    required super.salePrice,
    required super.variantCount,
  });

  factory ProductSummaryModel.fromJson(Map<String, dynamic> json) {
    final List variants = json['variants'] ?? [];
    final Map<String, dynamic> firstVariant =
        variants.isNotEmpty ? variants.first : {};

    return ProductSummaryModel(
      id: json['id'] ?? '',
      brand: json['brand']?['title'] ?? '',
      title: json['title'] ?? '',
      handle: json['handle'] ?? '',
      imageUrl: json['thumbnail'] ?? '',
      rating: (json['averageRating'] ?? 0).toDouble(),
      reviewCount: json['reviewsCount'] ?? 0,
      originalPrice:
          (firstVariant['originalPrice'] ?? 0).toDouble(),
      salePrice:
          (firstVariant['currentPrice'] ?? 0).toDouble(),
      variantCount: variants.length,
    );
  }
}
