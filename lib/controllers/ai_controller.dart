import 'dart:developer';
import 'dart:typed_data';

import 'package:fashion_lens/models/model_constants/outfit_sugestion_response_constants.dart';
import 'package:fashion_lens/models/outfit_image_response.dart';
import 'package:fashion_lens/models/outfit_suggestion_response.dart';
import 'package:fashion_lens/repository/ai_repository.dart';
import 'package:fashion_lens/utils/message_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AiController extends GetxController {
  AiRepository aiRepository = AiRepository();

  XFile? userImage;
  OutfitImageResponse? aiGeneratedUserImage;
  OutfitSuggestionResponse? outfitSuggestions;
  TextEditingController whereAreYouGoingController = TextEditingController(
    text: "I am going to corporate office for giving session",
  );

  void clearFields() {
    whereAreYouGoingController.clear();
    userImage = null;
    aiGeneratedUserImage = null;
    outfitSuggestions = null;
    Get.forceAppUpdate();
  }

  Future<void> getOutfitSuggestions() async {
    if (userImage == null) {
      log("AiController :: getOutfitSuggestions() :: Please Select image");
      MessageDisplay.fail("No Image Selected", "Please select image");
      return;
    }

    try {
      log("AiController :: getOutfitSuggestions()");
      Uint8List imageBytes = await userImage!.readAsBytes();
      String prompt = _getOutfitSuggestionPrompt(
        whereAreYouGoing: whereAreYouGoingController.text,
      );
      outfitSuggestions = await aiRepository.getOutfitSuggestions(
        imageBytes: imageBytes,
        prompt: prompt,
      );
      if (outfitSuggestions != null) {
        Get.forceAppUpdate();
      }
      log("AiController :: getOutfitSuggestions() :: Processed");
    } catch (e) {
      log("AiController :: getOutfitSuggestions() :: Error:$e");
    }
  }

  Future<void> generateOutfitOnImage() async {
    log("AiController :: generateOutfitOnImage()");
    if (userImage == null) {
      log("AiController :: generateOutfitOnImage() :: Please Select image");
      MessageDisplay.fail("No Image Selected", "Please select image");
      return;
    }
    if (outfitSuggestions == null ||
        (outfitSuggestions != null &&
            outfitSuggestions!.suggestedImprovements.isEmpty)) {
      log(
        "AiController :: generatedOutfitOnImage() :: Please get outfit suggestions",
      );
      return;
    }
    try {
      Uint8List imageBytes = await userImage!.readAsBytes();
      String prompt = _getOutfitImageGenerationPrompt(
        outfitSuggestions!.suggestedImprovements,
      );
      aiGeneratedUserImage = await aiRepository.generateOutfitOnImage(
        originalImageBytes: imageBytes,
        prompt: prompt,
      );
    } catch (e) {
      log("AiController :: generateOutfitOnImage() :: Error:$e");
    }
  }

  String _getOutfitImageGenerationPrompt(List<String> outfitSuggestions) {
    return '''
    Can you please generate an outfit on uploaded picture with the suggestions provided, and return the image

    Suggestions: $outfitSuggestions
    ''';
  }

  String _getOutfitSuggestionPrompt({required String whereAreYouGoing}) {
    return '''
      You are a fashion consultant AI. A user has uploaded an image of their outfit. They are attending the following event:

      Event Type: $whereAreYouGoing

      Analyze the outfit shown in the uploaded image. Based on the event context, return the result in the following JSON format:

      {
        "${OutfitSugestionResponseConstants.imageContainsOutfit}": true | false, // false if user uploads some random image, that does not contain any outfit
        "${OutfitSugestionResponseConstants.isAppropriate}": true | false,
        "${OutfitSugestionResponseConstants.rating}": <integer 1 to 10>, // overall fashion fit for the event
        "${OutfitSugestionResponseConstants.styleFeedBack}": <string>, // constructive feedback on the outfit
        "${OutfitSugestionResponseConstants.suggestedImprovements}": <List<string>>
      }
    ''';
  }
}
