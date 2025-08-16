// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import '../enum/crop_type_enum.dart';
// import '../themes/app_theme.dart';
//
// class CropUtils {
//   static Future<XFile?> cropToShape(
//       BuildContext context,
//       XFile originalFile, {
//         CropTypeEnum cropTypeEnum = CropTypeEnum.FREE,
//       }) async {
//     final bool isFree = cropTypeEnum == CropTypeEnum.FREE;
//     final bool isCircle = cropTypeEnum == CropTypeEnum.CIRCLE;
//
//     final CropAspectRatio? customAspectRatio = isFree
//         ? null
//         : (cropTypeEnum == CropTypeEnum.SQUARE
//         ? const CropAspectRatio(ratioX: 1, ratioY: 1)
//         : cropTypeEnum == CropTypeEnum.RECTANGLE
//         ? const CropAspectRatio(ratioX: 4, ratioY: 3)
//         : null);
//
//     final CroppedFile? cropped = await ImageCropper().cropImage(
//       sourcePath: originalFile.path,
//       aspectRatio: customAspectRatio,
//       compressFormat: ImageCompressFormat.jpg,
//       uiSettings: [
//         AndroidUiSettings(
//           toolbarTitle: 'Crop Image',
//           toolbarColor: AppTheme.primaryColor,
//           toolbarWidgetColor: AppTheme.milkyWhite,
//           initAspectRatio: _getCropAspectRatioPreset(cropTypeEnum),
//           aspectRatioPresets: _getCropAspectRatioPresets(cropTypeEnum),
//           lockAspectRatio: !isFree,
//           cropStyle: isCircle ? CropStyle.circle : CropStyle.rectangle,
//         ),
//         IOSUiSettings(
//           title: 'Crop Image',
//           aspectRatioLockEnabled: !isFree,
//           cropStyle: isCircle ? CropStyle.circle : CropStyle.rectangle,
//           // Optional: You can set aspect ratio presets for iOS like Android
//           aspectRatioPresets: _getCropAspectRatioPresets(cropTypeEnum)
//         ),
//         WebUiSettings(
//           context: context,
//           size: const CropperSize(height: 300, width: 300),
//           initialAspectRatio: _getInitialAspectRatio(cropTypeEnum),
//           dragMode: WebDragMode.none,
//           movable: false,
//         ),
//       ],
//     );
//
//     return cropped != null ? XFile(cropped.path) : null;
//   }
//
//   static List<CropAspectRatioPresetData> _getCropAspectRatioPresets(CropTypeEnum cropTypeEnum){
//     if(cropTypeEnum == CropTypeEnum.SQUARE){
//       return [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.original];
//     }else if(cropTypeEnum == CropTypeEnum.RECTANGLE){
//       return [CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.square, CropAspectRatioPreset.original];
//     }else{
//       return [CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.square];
//     }
//   }
//
//   static CropAspectRatioPreset _getCropAspectRatioPreset(CropTypeEnum cropTypeEnum){
//     if(cropTypeEnum == CropTypeEnum.SQUARE){
//       return CropAspectRatioPreset.square;
//     }else if(cropTypeEnum == CropTypeEnum.RECTANGLE){
//       return CropAspectRatioPreset.ratio4x3;
//     }else{
//       return CropAspectRatioPreset.original;
//     }
//   }
//
//   static num? _getInitialAspectRatio(CropTypeEnum cropTypeEnum) {
//     switch (cropTypeEnum) {
//       case CropTypeEnum.SQUARE:
//         return 1;
//       case CropTypeEnum.RECTANGLE:
//         return 4 / 3;
//       default:
//         return null;
//     }
//   }
// }
