import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmer extends StatelessWidget {
  final double height;
  final double borderRadius;

  const ImageShimmer({
    super.key,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}