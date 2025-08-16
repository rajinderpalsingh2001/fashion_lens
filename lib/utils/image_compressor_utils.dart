// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import '../utils/utils.dart';
//
// class ImageCompressorUtils {
//   /// Compresses the [imageFile] so that its size does not exceed [maxSizeMB].
//   /// Returns the compressed file or null if compression failed.
//   static Future<XFile?> compressImage({
//     required XFile imageFile,
//     required double maxSizeMB,
//   }) async {
//     final maxSizeBytes = maxSizeMB * 1024 * 1024;
//     final originalSizeBytes = await imageFile.length();
//     log("Original image size: ${(originalSizeBytes / (1024 * 1024)).toStringAsFixed(2)} MB");
//
//     if (originalSizeBytes <= maxSizeBytes) {
//       log("Image is already under max size, skipping compression.");
//       return imageFile;
//     }
//
//     Uint8List imageBytes = await imageFile.readAsBytes();
//     img.Image? decodedImage = img.decodeImage(imageBytes);
//     if (decodedImage == null) {
//       log("Failed to decode image.");
//       return null;
//     }
//
//     int quality = 90;
//     Uint8List? compressedBytes;
//
//     // Reduce quality
//     while (quality > 10) {
//       compressedBytes = Uint8List.fromList(
//         img.encodeJpg(decodedImage, quality: quality),
//       );
//       double compressedSizeMB = compressedBytes.lengthInBytes / (1024 * 1024);
//       log("Trying quality $quality → Compressed size: ${compressedSizeMB.toStringAsFixed(2)} MB");
//
//       if (compressedBytes.lengthInBytes <= maxSizeBytes) {
//         break;
//       }
//
//       quality -= 10;
//     }
//
//     // Still too big? Resize it iteratively
//     while (compressedBytes!.lengthInBytes > maxSizeBytes) {
//       int newWidth = (decodedImage!.width * 0.9).toInt();
//       decodedImage = img.copyResize(decodedImage, width: newWidth);
//       compressedBytes = Uint8List.fromList(
//         img.encodeJpg(decodedImage, quality: quality),
//       );
//       double compressedSizeMB = compressedBytes.lengthInBytes / (1024 * 1024);
//       log("Resized to width $newWidth → New size: ${compressedSizeMB.toStringAsFixed(2)} MB");
//     }
//
//     final tempDir = await getTemporaryDirectory();
//     final compressedPath = '${tempDir.path}/compressed_${Utils.uniqueTimestamp()}.jpg';
//     final compressedFile = await File(compressedPath).writeAsBytes(compressedBytes);
//
//     log("Final compressed image size: ${(compressedFile.lengthSync() / (1024 * 1024)).toStringAsFixed(2)} MB");
//
//     return XFile(compressedFile.path);
//   }
//
//   static Future<String> imageSize(XFile file) async {
//     return "${(await (file.length()) / (1024 * 1024)).toStringAsFixed(2)} MB";
//   }
// }
