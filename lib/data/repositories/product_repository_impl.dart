import 'package:sephora/data/models/similar_product_model.dart';
import 'package:sephora/domain/entities/similar_product.dart';

import '../../domain/entities/product_summary.dart';
import '../../domain/entities/product_detail.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_summary_model.dart';
import '../models/product_detail_model.dart';
import '../sources/product_remote_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteSource remote;

  ProductRepositoryImpl(this.remote);

  /// Fetch latest products (pagination)
  @override
  Future<List<ProductSummary>> fetchLatest(int page) async {
    final List<dynamic> rawList = await remote.fetchLatest(page);

    return rawList
        
        .whereType<Map<String, dynamic>>()
     
        .map<ProductSummary>(
          (json) => ProductSummaryModel.fromJson(json),
        )
        .toList();
  }

  /// Search products with pagination
  @override
  Future<List<ProductSummary>> search(
    String query,
    int page, {
    int minRating = 0,
  }) async {
    final List<dynamic> rawList =
        await remote.search(query, page, minRating: minRating);

    return rawList
        .whereType<Map<String, dynamic>>()
        .map<ProductSummary>(
          (json) => ProductSummaryModel.fromJson(json),
        )
        .toList();
  }

  /// Fetch product detail by handle
  @override
  Future<ProductDetail> getDetail(String handle) async {
    final Map<String, dynamic> json =
        await remote.fetchByHandle(handle);

  
    return ProductDetailModel.fromJson(json);
  }

@override
  Future<List<SimilarProduct>> fetchSimilar(String productId) async {
    final list = await remote.fetchSimilar(productId);
    return list
        .map((e) => SimilarProductModel.fromJson(e))
        .toList();
  }


}

