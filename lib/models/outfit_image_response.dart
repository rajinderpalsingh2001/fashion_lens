import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

class OutfitImageResponse {
  Uint8List? imageBytes;
  String? mimeType;

  OutfitImageResponse({required this.imageBytes, required this.mimeType});

  factory OutfitImageResponse.fromJson(Map<String, dynamic> data) {
    try {
      List<dynamic> parts = data["candidates"][0]["content"]["parts"];
      Map<String, dynamic> inlineData = {};
      for (var part in parts) {
        if (part.containsKey("inlineData")) {
          inlineData = part["inlineData"];
          break;
        }
      }
      if(inlineData == {}){
        return OutfitImageResponse(imageBytes: null, mimeType: null);
      }
      String? base64Data = inlineData["data"];
      String? mimeType = inlineData["mimeType"];

      if (base64Data != null) {
        return OutfitImageResponse(
          imageBytes: base64Decode(base64Data),
          mimeType: mimeType,
        );
      }
    } catch (e) {
      log("OutfitImageResponse.fromJson error: $e");
    }
    // Return empty/default if missing
    return OutfitImageResponse(imageBytes: null, mimeType: null);
  }
}
