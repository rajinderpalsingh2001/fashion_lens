import 'package:fashion_lens/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shimmer/shimmer.dart';

class OutfitSuggestionsShimmer extends StatelessWidget {
  const OutfitSuggestionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16.0),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppTheme.nagarroDarkBlue,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  shimmerText(width: 200, height: 6),
                  const SizedBox(height: 4.0,),
                  shimmerText(width: 200, height: 6),
                ],
              )
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(HugeIcons.strokeRoundedStar, color: AppTheme.milkyWhite),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    shimmerText(width: 12, height: 6),
                    Text(
                      "/10",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppTheme.milkyWhite,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 18.0),
      ListTile(
        title: Text("Outfit Feedback", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            shimmerText(width: double.infinity, height: 16),
            const SizedBox(height: 6.0),
            shimmerText(width: double.infinity, height: 16),
            const SizedBox(height: 6.0),
            shimmerText(width: double.infinity, height: 16),
            const SizedBox(height: 6.0),
            shimmerText(width: double.infinity, height: 16),
          ],
        ),
      ),
      const SizedBox(height: 12.0),
      Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text("Suggested Improvements", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: shimmerText(width: double.infinity, height: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 18.0),
    ],
  );
  }

  Widget shimmerContainer({
    double height = 16.0,
    double width = double.infinity,
    BorderRadius? borderRadius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget shimmerText({double width = 150, double height = 16}) {
    return shimmerContainer(height: height, width: width);
  }

  Widget shimmerCircle({double size = 24}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }

}