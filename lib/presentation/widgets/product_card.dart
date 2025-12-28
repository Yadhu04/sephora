import 'package:flutter/material.dart';


import '../../domain/entities/product_summary.dart';


import '../widgets/rating_stars.dart';

class ProductCard extends StatelessWidget {
  final ProductSummary product;
    final VoidCallback onTap;

  const ProductCard({required this.product,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap:onTap,

      child: Card(color: Colors.white,
        elevation: 0.1,
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8 ),),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 3 / 4,
                child: 
                Container(color: Colors.amber,
                )
                // Image.network(product.imageUrl, fit: BoxFit.cover),
              ),
              const SizedBox(height: 8),
              Text(product.brand.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              Text(product.title,
                  maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Row(
                children: [
                  RatingStars(rating: product.rating),
                  const SizedBox(width: 4),
                  Text("${product.reviewCount}", style: const TextStyle(fontSize: 11)),
                ],
              ),
              const SizedBox(height: 4),
              Text("${product.variantCount} Colors",
                  style: const TextStyle(fontSize: 11)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text("₹${product.originalPrice}",
                      style:  TextStyle(
                          decoration: TextDecoration.lineThrough,color: Colors.red.shade200)),
                  const SizedBox(width: 6),
                  Text("₹${product.salePrice}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
