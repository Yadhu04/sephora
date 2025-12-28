import 'package:sephora/domain/entities/similar_product.dart';

import '../entities/product_summary.dart';
import '../entities/product_detail.dart';

abstract class ProductRepository {
  Future<List<ProductSummary>> fetchLatest(int page);
  Future<List<ProductSummary>> search(
    String query,
    int page, {
    int minRating,
  });

  Future<ProductDetail> getDetail(String handle);
 Future<List<SimilarProduct>> fetchSimilar(String productId);

}
