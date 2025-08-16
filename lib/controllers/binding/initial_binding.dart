import 'package:fashion_lens/controllers/ai_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {    
    Get.put<AiController>(AiController());
  }
}
