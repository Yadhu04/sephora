import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({required this.rating});

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalf = rating - fullStars >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, size: 14, color: Colors.black);
        } else if (index == fullStars && hasHalf) {
          return const Icon(Icons.star_half, size: 14, color: Colors.black);
        } else {
          return const Icon(Icons.star_border, size: 14, color: Colors.black);
        }
      }),
    );
  }
}
