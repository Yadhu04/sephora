import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sephora/presentation/widgets/rating_stars.dart';
import '../../domain/entities/similar_product.dart';

class SimilarProductCard extends StatelessWidget {
  final SimilarProduct product;
  final VoidCallback onTap;

  const SimilarProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          AspectRatio(
            aspectRatio: 1,
            child:Container(color: Colors.amber,
                )
            //  Image.network(
            //   product.image,
            //   fit: BoxFit.contain,
            // ),
          ),

          SizedBox(height: 8.h),

          /// BRAND
          Text(
            product.brand,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 4.h),

          /// TITLE (fixed height)
          SizedBox(
            height: 25.h,
            child: Text(
              product.variantTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                height: 1.4,
              ),
            ),
          ),

          SizedBox(height: 5.h),

          /// BUTTON
          Center(
            child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(minimumSize: Size(0, 0),
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 6.h),
              ),
              child: Text(
                'See Details',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          SizedBox(height: 10.h),

          /// PRICE
          Text(
            '₹${product.price.toInt()}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 6.h),

          /// RATING
          Row(
            children: [
              RatingStars(rating: product.rating),
              const SizedBox(width: 4),
              Text(
                "${product.reviewCount}",
                style: const TextStyle(fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
