import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sephora/data/repositories/product_repository_impl.dart';
import 'package:sephora/presentation/pages/product_detail_page.dart';
import 'package:sephora/presentation/providers/product_detail_provider.dart';
import 'package:sephora/presentation/widgets/custome_appbar.dart';
import '../providers/product_list_provider.dart';
import '../widgets/product_card.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ScrollController controller = ScrollController();
  bool showScrollToTop = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductListProvider>().loadLatest();
    });

    controller.addListener(() {
      final provider = context.read<ProductListProvider>();

      // 🔹 Pagination
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        provider.loadMore();
      }

      // 🔹 Show / hide scroll-to-top button
      if (controller.offset > 400 && !showScrollToTop) {
        setState(() => showScrollToTop = true);
      } else if (controller.offset <= 400 && showScrollToTop) {
        setState(() => showScrollToTop = false);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void scrollToTop() {
    controller.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductListProvider>();
    final repository = context.read<ProductRepositoryImpl>();

    return Scaffold(
      appBar: const SephoraAppBar(),
      backgroundColor: Colors.white,

      body: GridView.builder(
        controller: controller,
        padding: const EdgeInsets.all(8),
        itemCount: provider.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (_, i) {
          final product = provider.products[i];

          return ProductCard(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => ProductDetailProvider(
                      repository,
                      product.handle,
                    ),
                    child: const ProductDetailPage(),
                  ),
                ),
              );
            },
          );
        },
      ),

      //  Scroll-to-top button
      floatingActionButton: AnimatedOpacity(
        opacity: showScrollToTop ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: showScrollToTop
            ? FloatingActionButton(
                onPressed: scrollToTop,
                backgroundColor: Colors.white,
                
                child: const Icon(Icons.arrow_upward),
              )
            : null,
      ),
    );
  }
}
