import '../../domain/entities/similar_product.dart';

class SimilarProductModel extends SimilarProduct {
  SimilarProductModel({
    required super.id,
    required super.handle,
    required super.image,
    required super.brand,
    required super.title,
    required super.variantTitle,
    required super.price,
    required super.rating,
    required super.reviewCount,
  });

  factory SimilarProductModel.fromJson(Map<String, dynamic> json) {
    final variants = json['variants'] as List;
    final firstVariant = variants.first;

    return SimilarProductModel(
      id: json['id'],
      handle: json['handle'],
      image: json['thumbnail'],
      brand: json['brand']['title'],
      title: json['title'],
      variantTitle: firstVariant['title'] ?? json['title'],
      price: (firstVariant['currentPrice'] as num).toDouble(),
      rating: (json['averageRating'] ?? 0).toDouble(),
      reviewCount: json['reviewsCount'] ?? 0,
    );
  }
}
