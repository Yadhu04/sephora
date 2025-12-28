class ProductSummary {
  final String id;
  final String brand;
  final String title;
  final String handle;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final double originalPrice;
  final double salePrice;
  final int variantCount;

  ProductSummary({
    required this.id,
    required this.brand,
    required this.title,
    required this.handle,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.originalPrice,
    required this.salePrice,
    required this.variantCount,
  });
}
