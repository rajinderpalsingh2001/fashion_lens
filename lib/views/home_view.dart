import 'package:fashion_lens/constants/app_constants.dart';
import 'package:fashion_lens/controllers/ai_controller.dart';
import 'package:fashion_lens/themes/app_theme.dart';
import 'package:fashion_lens/utils/image_picker_utils.dart';
import 'package:fashion_lens/utils/utils.dart';
import 'package:fashion_lens/validators/input_validators.dart';
import 'package:fashion_lens/widgets/primary_button.dart';
import 'package:fashion_lens/widgets/primary_image.dart';
import 'package:fashion_lens/widgets/primary_input_field.dart';
import 'package:fashion_lens/widgets/primary_safe_area.dart';
import 'package:fashion_lens/widgets/shimmers/outfit_suggestions_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AiController aiController = Get.find();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isGeneratingAiImage = false;

  @override
  Widget build(BuildContext context) {
    return PrimarySafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: AppTheme.milkyWhite,
          title: Text(
            AppConstants.appName,
            style: TextStyle(color: AppTheme.nagarroDarkBlue),
          ),
          centerTitle: true,
        ),
        body: bodyContainer(),
      ),
    );
  }

  Widget bodyContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Expanded(
            child: (aiController.userImage == null)
                    ? _selectImageContainer()
                    : (aiController.userImage != null &&
                        !isLoading &&
                        aiController.outfitSuggestions == null)
                    ? _userSelectedImageContainer()
                    : _userAndGeneratedImageContainer(),
          ),
          _bottomCardContainer(),
        ],
      ),
    );
  }

  Widget _userAndGeneratedImageContainer() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PrimaryImage(
                  heroTag: "user-image",
                  isLoading: false,
                  xFile: aiController.userImage,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: isGeneratingAiImage == false && aiController.aiGeneratedUserImage!=null && aiController.aiGeneratedUserImage?.imageBytes == null ? 
                GestureDetector(
                  onTap: () async {
                    if (aiController.outfitSuggestions != null) {
                      await _generateOutfit();
                    }
                  },
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: Colors.grey.shade300
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Some Error Occured"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Regenerate"),
                            const SizedBox(width: 6.0,),
                            Icon(HugeIcons.strokeRoundedRefresh, size: 16.0,)
                          ],
                        )
                      ],
                    ),
                  ),
                ) : PrimaryImage(
                  heroTag: "ai-image",
                  xFile: (aiController.aiGeneratedUserImage == null || aiController.aiGeneratedUserImage?.imageBytes == null) ? null : XFile.fromData(aiController.aiGeneratedUserImage!.imageBytes!),
                  isLoading: isGeneratingAiImage
                ),
              ),
            ],
          ),
          if (aiController.outfitSuggestions == null && isLoading)
            OutfitSuggestionsShimmer()
          else
            _outfitSuggestionsContainer(),
        ],
      ),
    );
  }

  Widget _bottomCardContainer() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 6,
      color: AppTheme.nagarroDarkBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (aiController.outfitSuggestions == null)
                PrimaryInputField(
                  controller: aiController.whereAreYouGoingController,
                  icon: null,
                  labelText: "Where are you going?",
                  showLabel: false,
                  hintText: "Where are you going?",
                  validator: InputValidators.required,
                ),

              if (aiController.outfitSuggestions == null)
                const SizedBox(height: 18.0),

              PrimaryButton(
                isLoading: isLoading,
                isFullWidth: true,
                onPressed: () async {
                  Utils.hideKeyboard(context);
                  if (aiController.outfitSuggestions == null) {
                    if (_formKey.currentState!.validate()) {
                      await _getSuggestions();
                      if (aiController.outfitSuggestions != null) {
                        await _generateOutfit();
                      }
                    }
                  } else {
                    aiController.clearFields();
                  }
                },
                text:
                    aiController.outfitSuggestions == null
                        ? "Analyse"
                        : "Reset",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userSelectedImageContainer() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Stack(
        children: [
          Expanded(
            child: PrimaryImage(
              heroTag: "user-image",
              height: double.maxFinite,
              borderRadius: 30.0,
              xFile: aiController.userImage!,
            ),
          ),
          Positioned(
            right: 0,
            bottom: -4,
            child: TextButton.icon(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(30.0),
                    ),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(AppTheme.milkyWhite),
              ),
              onPressed: _pickImage,
              icon: Icon(
                HugeIcons.strokeRoundedImageAdd02,
                color: AppTheme.nagarroDarkBlue,
              ),
              label: Text(
                "Change",
                style: TextStyle(color: AppTheme.nagarroDarkBlue),
              ),
            ),
          ),
      
          Positioned(
            right: 4,
            top: 6,
            child: IconButton.filled(
              padding: EdgeInsets.all(12.0),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppTheme.milkyWhite),
              ),
              onPressed: () {
                setState(() {
                  aiController.userImage = null;
                });
              },
              icon: Icon(
                HugeIcons.strokeRoundedCancel01,
                color: AppTheme.nagarroDarkBlue,
                size: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectImageContainer() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        color: AppTheme.milkyWhite,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(HugeIcons.strokeRoundedImageAdd02, size: 40.0),
            const SizedBox(height: 8.0),
            Text(
              "Select Image",
              style: TextStyle(fontSize: 18.0, color: AppTheme.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _outfitSuggestionsContainer() {
    final suggestions = aiController.outfitSuggestions!;

    if (!suggestions.imageContainsOutfit) {
      return Column(
        children: [
          Text(
            "Image does not contain any outfit",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          PrimaryButton(onPressed: _pickImage, text: "Change Image"),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppTheme.nagarroDarkBlue,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  suggestions.isAppropriate
                      ? "This outfit looks well."
                      : "This outfit may not be suitable.",
                  style: TextStyle(fontSize: 18.0, color: AppTheme.milkyWhite),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(HugeIcons.strokeRoundedStar, color: AppTheme.milkyWhite),
                  const SizedBox(height: 4.0),
                  Text(
                    "${suggestions.rating}/10",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: AppTheme.milkyWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18.0),
        ListTile(
          title: Text(
            "Outfit Feedback",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          subtitle: _getSubtitleTextWidget(
            suggestions.styleFeedBack.toString(),
          ),
        ),
        const SizedBox(height: 12.0),
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: true,
            iconColor: AppTheme.nagarroDarkBlue,
            title: Text(
              "Suggested Improvements",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            children:
                suggestions.suggestedImprovements.isEmpty
                    ? [
                      _getSubtitleTextWidget("Seems all good, no improvements"),
                    ]
                    : suggestions.suggestedImprovements
                        .map((e) => ListTile(title: _getSubtitleTextWidget(e)))
                        .toList(),
          ),
        ),
        const SizedBox(height: 18.0),
      ],
    );
  }

  Widget _getSubtitleTextWidget(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 16.0),
    );
  }

  Future<void> _pickImage() async {
    ImagePickerUtils.pickImageFromGallery(
      context,
      onImagePicked: (XFile img) {
        setState(() {
          aiController.userImage = img;
        });
      },
    );
  }

  Future<void> _getSuggestions() async {
    setState(() => isLoading = true);
    await aiController.getOutfitSuggestions();
    setState(() => isLoading = false);
  }

  Future<void> _generateOutfit() async {
    setState(() => isGeneratingAiImage = true);
    await aiController.generateOutfitOnImage();
    setState(() => isGeneratingAiImage = false);
  }
}
