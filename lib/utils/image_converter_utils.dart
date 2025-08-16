// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:heic_to_png_jpg/heic_to_png_jpg.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import '../utils/utils.dart';
//
// class ImageConverterUtils {
//   static Future<File> convertToJpg(File inputFile) async {
//     // Read image bytes
//     final bytes = await inputFile.readAsBytes();
//
//     // Decode to image package's image format
//     final image = img.decodeImage(bytes);
//     if (image == null) {
//       throw Exception("Failed to decode image.");
//     }
//
//     // Encode to JPG
//     final jpgBytes = img.encodeJpg(image, quality: 90);
//
//     // Get app temp directory
//     final dir = await getTemporaryDirectory();
//
//     // Create a new JPG file
//     final jpgFile = File(
//         path.join(dir.path, '${Utils.uniqueTimestamp()}.jpg'));
//     await jpgFile.writeAsBytes(jpgBytes);
//
//     return jpgFile;
//   }
//
//   static Future<XFile?> convertFromHeicToJpg(XFile file) async {
//     try {
//       Uint8List jpgData = await HeicConverter.convertToJPG(
//         heicData: await file.readAsBytes(),
//         quality: 80,
//       );
//       return XFile.fromData(jpgData);
//     } catch (e) {
//       log("Image Converter :: convertFromHeicToJpg() :: Error: $e");
//       return null;
//     }
//   }
// }
