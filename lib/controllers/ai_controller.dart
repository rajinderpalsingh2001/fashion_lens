import 'package:get/get.dart';

class AiController extends GetxController {
  String getOutfitImageGenerationPrompt(List<String> outfitSuggestions) {
    return '''
    Can you please generate an outfit on my uploaded picture with the suggestions provided

    $outfitSuggestions
    ''';
  }

  String getOutfitSuggestionPrompt({required String whereAreYouGoing}) {
    return '''
      You are a fashion consultant AI. A user has uploaded an image of their outfit. They are attending the following event:

      Event Type: $whereAreYouGoing

      Analyze the outfit shown in the uploaded image. Based on the event context, return the result in the following JSON format:

      {
        "is_appropriate": true | false,
        "rating_out_of_10": number, // overall fashion fit for the event
        "style_feedback": "string", // constructive feedback on the outfit
        "suggested_improvements": []
      }
    ''';
  }
}
