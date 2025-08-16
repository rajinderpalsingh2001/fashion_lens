import 'package:fashion_lens/themes/app_theme.dart';
import 'package:fashion_lens/widgets/shimmers/image_shimmer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PrimaryImage extends StatelessWidget {
  final XFile? xFile;
  final double height;
  final double borderRadius;
  final bool isLoading;
  final String heroTag;
  final Function()? onRegenerate;

  const PrimaryImage({
    super.key,
    required this.xFile,
    required this.heroTag,
    this.height = 300,
    this.borderRadius = 22.0,
    this.isLoading = false,
    this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: FutureBuilder(
        future: xFile?.readAsBytes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || isLoading) {
            return ImageShimmer(height: height, borderRadius: borderRadius);
          }

          return Hero(
            tag: heroTag,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => FullScreenImage(
                          imageBytes: snapshot.data!,
                          heroTag: heroTag,
                        ),
                  ),
                );
              },
              child: Image.memory(
                snapshot.data!,
                height: height,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String heroTag;
  final Uint8List imageBytes;

  const FullScreenImage({
    super.key,
    required this.imageBytes,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color: AppTheme.nagarroDarkBlue)),
      body: Hero(
        tag: heroTag,
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity != null &&
                details.primaryVelocity! > 0) {
              // User swiped down
              Navigator.pop(context);
            }
          },
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 0.5,
            maxScale: 4.0,
            child: Center(child: Image.memory(imageBytes)),
          ),
        ),
      ),
    );
  }
}
