import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';

class ProductRemoteSource {
  Future<List<dynamic>> fetchLatest(int page) async {
    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiConstants.productList}"
      "?sort=createdAt:desc&page=$page",
    );

    final res = await http.get(uri);
    return jsonDecode(res.body)['data'];
  }

Future<List<dynamic>> search(
  String query,
  int page, {
  int minRating = 0,
}) async {
  final uri = Uri.parse(
    'https://api.virgincodes.com/store/product-search'
    '?q=$query&minRating=$minRating',
  );

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Search failed');
  }

  final Map<String, dynamic> body =
      jsonDecode(response.body);

  /// ✅ THIS IS THE ONLY CORRECT PATH
  final List<dynamic> products =
      body['data']?['products'] ?? [];

  return products;
}




  Future<Map<String, dynamic>> fetchByHandle(String handle) async {
    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiConstants.productByHandle}/$handle",
    );

    final res = await http.get(uri);
    return jsonDecode(res.body)['data'];
  }

    Future<List<dynamic>> fetchSimilar(String productId) async {
    final res = await http.get(
      Uri.parse(
        'https://api.virgincodes.com/store/product/$productId/similar?limit=5',
      ),
    );

    final body = jsonDecode(res.body);
    return body['data'] as List;
  }


}
