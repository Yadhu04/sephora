import 'package:flutter/material.dart';
import '../../domain/entities/similar_product.dart';
import '../../domain/repositories/product_repository.dart';

class SimilarProductProvider extends ChangeNotifier {
  final ProductRepository repo;

  SimilarProductProvider(this.repo);

  List<SimilarProduct> products = [];
  bool isLoading = false;

  Future<void> loadSimilar(String productId) async {
    isLoading = true;
    notifyListeners();

    try {
      products = await repo.fetchSimilar(productId);
    } catch (_) {
      products = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
