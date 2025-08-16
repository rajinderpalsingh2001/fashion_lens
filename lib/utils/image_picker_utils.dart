import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../enum/crop_type_enum.dart';

class ImagePickerUtils {
  static Future<void> pickImageFromGallery(
    BuildContext context, {
    required Function(XFile) onImagePicked,
    CropTypeEnum cropTypeEnum = CropTypeEnum.free,
    double compressImageSizeMB = 2,
  }) async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (img != null) {
      // XFile processedImage = await _processImage(
      //   context: context,
      //   originalImg: img,
      //   cropTypeEnum: cropTypeEnum,
      // );
      XFile processedImage = img;
      await onImagePicked(processedImage);
    }
  }

  static Future<void> pickImageFromCamera(
    BuildContext context, {
    required Function(XFile) onImagePicked,
    CropTypeEnum cropTypeEnum = CropTypeEnum.free,
    double compressImageSizeMB = 2,
  }) async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front,
    );
    if (img != null) {
      // XFile processedImage = await _processImage(
      //   context: context,
      //   originalImg: img,
      //   cropTypeEnum: cropTypeEnum,
      // );
      XFile processedImage = img;
      await onImagePicked(processedImage);
    }
  }

  static Future<void> pickMultipleImages(
    BuildContext context, {
    required Function(List<XFile>) onImagesPicked,
    double compressImageSizeMB = 2,
    required CropTypeEnum cropTypeEnum,
  }) async {
    final imgs = await ImagePicker().pickMultiImage(imageQuality: 50);
    List<XFile> pickedImages = [];

    for (XFile img in imgs) {
      // XFile processedImage = await _processImage(context: context, originalImg: img, cropTypeEnum: cropTypeEnum);
      XFile processedImage = img;
      pickedImages.add(processedImage);
    }

    await onImagesPicked(pickedImages);
  }

  // static Future<XFile> _processImage(
  //     {required BuildContext context,
  //     required XFile originalImg,
  //     required CropTypeEnum cropTypeEnum}) async {
  // XFile jpgImage = await _convertToJpg(originalImg);
  // XFile compressed = await _compressImage(jpgImage);
  // XFile cropped = await _cropImage(context, compressed, cropTypeEnum);
  // return cropped;
  // return originalImg;
  // }

  // static Future<XFile> _cropImage(
  //     BuildContext context, XFile file, CropTypeEnum cropTypeEnum) async {
  // try {
  //   return await CropUtils.cropToShape(context, file, cropTypeEnum: cropTypeEnum) ?? file;
  // } catch (e) {
  //   return file;
  // }
  //   return file;
  // }

  // static Future<XFile> _convertToJpg(XFile file) async {
  // String ext = file.name.split(".").last;
  // try {
  //   log("ImagePickerUtils :: _convertToJpg() :: File type: $ext");
  //
  //   if (ext == "heic" || ext == "heif") {
  //     return await ImageConverterUtils.convertFromHeicToJpg(file) ?? file;
  //   }
  //   File jpgFile = await ImageConverterUtils.convertToJpg(File(file.path));
  //   return XFile(jpgFile.path);
  // } catch (e) {
  //   return file;
  // }
  //   return file;
  // }

  // static Future<XFile> _compressImage(XFile file) async {
  // try {
  //   return await ImageCompressorUtils.compressImage(
  //           imageFile: file, maxSizeMB: 2) ??
  //       file;
  // } catch (e) {
  //   return file;
  // }
  //   return file;
  // }
}
