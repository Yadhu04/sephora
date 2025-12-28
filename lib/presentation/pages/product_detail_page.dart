import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sephora/data/repositories/product_repository_impl.dart';
import 'package:sephora/presentation/pages/image_gallary_page.dart';
import 'package:sephora/presentation/widgets/custome_appbar.dart';

import '../providers/product_detail_provider.dart';
import '../providers/similar_product_provider.dart';
import '../widgets/expandable_html.dart';
import '../widgets/expationtile.dart';
import '../widgets/similar_product_card.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final detailProvider = context.watch<ProductDetailProvider>();

    if (detailProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final product = detailProvider.product!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<SimilarProductProvider>()
          .loadSimilar(product.id);
    });

    return Scaffold(appBar: SephoraAppBar(),
    backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text( product.brandName,
              style:  TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),),
               const SizedBox(height: 5),
              Text( product.metaTitle,
              style:  TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),),
              
               const SizedBox(height: 22),
            /// IMAGE CAROUSEL
AspectRatio(
  aspectRatio: 1.1,
  child: PageView.builder(
    itemCount: product.images.length,
    itemBuilder: (_, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ImageGalleryPage(
                images: product.images,
                initialIndex: index,
              ),
            ),
          );
        },
        child:Container(color: Colors.amber,child: Center(child: Text("No.Of images : ${product.images.length.toString()}\n\nclick on the text\n\nslidable",textAlign: TextAlign.center,style: const TextStyle(color: Colors.black,fontSize: 14,),)),)
        //  Image.network(
        //   product.images[index],
        //   fit: BoxFit.cover,
        // ),
      );
    },
  ),
),


            const SizedBox(height: 16),

            /// PRICE
            Text(
              "₹${product.price}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "₹${product.originalPrice}",
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
              ),
            ),

            const SizedBox(height: 16),

            /// ABOUT
            const Text(
              "About the Product",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            ExpandableHtml(
              html: product.summary?.content ?? '',
            ),

            const SizedBox(height: 16),

            /// INGREDIENTS
            SimpleExpansionTile(
              title: 'Ingredients',
              content:
                  product.ingredients?.content ?? 'No information available.',
            ),

            const SizedBox(height: 16),

            /// HOW TO USE
            SimpleExpansionTile(
              title: 'How to Use',
              content:
                  product.howToUse?.content ?? 'No information available.',
            ),

            const SizedBox(height: 24),

            /// 🔥 SIMILAR PRODUCTS
            Consumer<SimilarProductProvider>(
              builder: (_, similarProvider, __) {
                if (similarProvider.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (similarProvider.products.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Similar Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                       height: 350.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: similarProvider.products.length,
                        itemBuilder: (_, index) {
                          final item =
                              similarProvider.products[index];
final repository = context.read<ProductRepositoryImpl>();

                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              width: 150,
                              child: SimilarProductCard(
                                product: item,
                                  onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ProductDetailProvider(
              repository,
              item.handle,
            ),
            child: ProductDetailPage(),
          ),
        ),
      );
    },

                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
