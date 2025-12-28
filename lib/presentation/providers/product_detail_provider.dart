import 'package:flutter/material.dart';
import '../../domain/entities/product_detail.dart';
import '../../domain/repositories/product_repository.dart';

class ProductDetailProvider extends ChangeNotifier {
  final ProductRepository repo;
  final String handle;

  ProductDetail? product;
  bool isLoading = true;
  String? error;

  ProductDetailProvider(this.repo, this.handle) {
    _fetch();
  }

  Future<void> _fetch() async {
    try {
      isLoading = true;
      notifyListeners();

      product = await repo.getDetail(handle);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
