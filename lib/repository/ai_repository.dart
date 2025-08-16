import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:fashion_lens/constants/ai_constants.dart';
import 'package:fashion_lens/constants/gemini_models.dart';
import 'package:fashion_lens/models/outfit_image_response.dart';
import 'package:fashion_lens/models/outfit_suggestion_response.dart';
import 'package:http/http.dart' as http;

class AiRepository {
  final headers = {
    "x-goog-api-key": AiConstants.apiKey,
    "Content-Type": "application/json",
  };

  Future<OutfitSuggestionResponse?> getOutfitSuggestions({
    required Uint8List imageBytes,
    required String prompt,
  }) async {
    try {
      final url = _generateUrl(model: GeminiModels.gemini25Flash);

      final body = _generateRequestBody(prompt: prompt, imageBytes: imageBytes);

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract text output
        final output =
            data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"];
        if (output != null) {
          final cleaned = _stripJsonMarkdown(output);
          final Map<String, dynamic> responseMap = jsonDecode(cleaned);

          return OutfitSuggestionResponse.fromJson(responseMap);
        }
      } else {
        throw Exception(
          "Gemini API Error: ${response.statusCode} ${response.body}",
        );
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<OutfitImageResponse?> generateOutfitOnImage({
    required Uint8List originalImageBytes,
    required String prompt,
  }) async {
    try {
      final url = _generateUrl(
        model: GeminiModels.gemini20FlashPreviewImageGeneration,
      );

      final body = _generateRequestBody(
        prompt: prompt,
        imageBytes: originalImageBytes,
        isGenerateImage: true,
      );

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        OutfitImageResponse imageResponse = OutfitImageResponse.fromJson(data);
        if (imageResponse.imageBytes != null) {
          log("AiRepository :: generateOutfitOnImage() :: Image generated");
          return imageResponse;
        } else {
          log(
            "AiRepository :: generateOutfitOnImage() :: Image data not found in response",
          );
          return null;
        }
      } else {
        throw Exception(
          "Gemini API Error: ${response.statusCode} ${response.body}",
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Uri _generateUrl({required String model}) {
    return Uri.parse('${AiConstants.geminiBaseUrl}/$model:generateContent');
  }

  Map<String, dynamic> _generateRequestBody({
    String? prompt,
    Uint8List? imageBytes,
    bool isGenerateImage = false,
  }) {
    return {
      "contents": [
        {
          "parts": [
            if (prompt != null) {"text": prompt},

            if (imageBytes != null)
              {
                "inline_data": {
                  "mime_type": "image/jpeg",
                  "data": base64Encode(imageBytes),
                },
              },
          ],
        },
      ],
      if (isGenerateImage)
        "generationConfig": {
          "responseModalities": ["TEXT", "IMAGE"],
        },
    };
  }

  // Helper to strip ```json ... ```
  String _stripJsonMarkdown(String text) {
    const startMarker = '```json';
    const endMarker = '```';

    int startIndex = text.indexOf(startMarker);
    if (startIndex != -1) {
      startIndex += startMarker.length;
    } else {
      startIndex = 0;
    }

    int endIndex = text.lastIndexOf(endMarker);
    if (endIndex == -1) {
      endIndex = text.length;
    }

    return text.substring(startIndex, endIndex).trim();
  }
}
