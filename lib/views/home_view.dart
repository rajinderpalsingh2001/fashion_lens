import 'package:fashion_lens/controllers/ai_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AiController aiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Home")));
  }
}
