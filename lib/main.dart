import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sephora/presentation/pages/product_list_page.dart';

import 'package:sephora/presentation/providers/similar_product_provider.dart';

import 'core/utils/screen_util_init.dart';
import 'data/sources/product_remote_source.dart';
import 'data/repositories/product_repository_impl.dart';
import 'presentation/providers/product_list_provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = ProductRepositoryImpl(
    ProductRemoteSource(),
  );

  runApp(
    screenUtilInit(
      child: MultiProvider(
        providers: [
           Provider<ProductRepositoryImpl>(
            create: (_) => repository,
          ),

          ChangeNotifierProvider(
            create: (_) => ProductListProvider(repository),
          ),
           ChangeNotifierProvider(
      create: (_) => SimilarProductProvider(repository),
    ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListPage(),
    );
  }
}
