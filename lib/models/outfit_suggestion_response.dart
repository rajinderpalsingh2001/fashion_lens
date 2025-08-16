import 'package:fashion_lens/models/model_constants/outfit_sugestion_response_constants.dart';

class OutfitSuggestionResponse {
  bool imageContainsOutfit;
  bool isAppropriate;
  int rating;
  String styleFeedBack;
  List<String> suggestedImprovements;

  OutfitSuggestionResponse({
    required this.imageContainsOutfit,
    required this.isAppropriate,
    required this.rating,
    required this.styleFeedBack,
    required this.suggestedImprovements,
  });

  factory OutfitSuggestionResponse.fromJson(Map<String, dynamic> json) {
    
    return OutfitSuggestionResponse(
      imageContainsOutfit: json[OutfitSugestionResponseConstants.imageContainsOutfit],
      isAppropriate: json[OutfitSugestionResponseConstants.isAppropriate],
      rating: json[OutfitSugestionResponseConstants.rating],
      styleFeedBack: json[OutfitSugestionResponseConstants.styleFeedBack],
      suggestedImprovements: List<String>.from(json[OutfitSugestionResponseConstants.suggestedImprovements])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      OutfitSugestionResponseConstants.imageContainsOutfit: imageContainsOutfit,
      OutfitSugestionResponseConstants.isAppropriate: isAppropriate,
      OutfitSugestionResponseConstants.rating: rating,
      OutfitSugestionResponseConstants.styleFeedBack: styleFeedBack,
      OutfitSugestionResponseConstants.suggestedImprovements: suggestedImprovements,
    };
  }
}
