import 'package:flutter/material.dart';
import '../../domain/entities/product_summary.dart';
import '../../domain/repositories/product_repository.dart';

enum ProductListMode { latest, search }

class ProductListProvider extends ChangeNotifier {
  final ProductRepository repo;

  ProductListProvider(this.repo);

  List<ProductSummary> products = [];
  ProductListMode mode = ProductListMode.latest;

  String query = "";
  int minRating = 0;
  int page = 1;

  bool isLoading = false;
  bool hasMore = true;

  /// Load latest products
  Future<void> loadLatest({bool reset = true}) async {
    mode = ProductListMode.latest;
    if (reset) _reset();
    await _fetch();
  }

  /// Search products
  Future<void> searchProducts(
    String q, {
    int minRating = 0,
  }) async {
    mode = ProductListMode.search;
    query = q;
    this.minRating = minRating;
    _reset();
    await _fetch();
  }

  /// Pagination
  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;
    page++;
    await _fetch();
  }

  ///CALLED WHEN LEAVING SEARCH
  void restoreLatestIfNeeded() {
    if (mode == ProductListMode.search) {
      loadLatest();
    }
  }

  void _reset() {
    page = 1;
    hasMore = true;
    products.clear();
    notifyListeners();
  }

  Future<void> _fetch() async {
    isLoading = true;
    notifyListeners();

    final result = mode == ProductListMode.latest
        ? await repo.fetchLatest(page)
        : await repo.search(query, page, minRating: minRating);

    if (result.isEmpty) hasMore = false;
    products.addAll(result);

    isLoading = false;
    notifyListeners();
  }
}
