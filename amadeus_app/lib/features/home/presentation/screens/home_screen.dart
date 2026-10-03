import 'package:amadeus_app/core/services/service_locator.dart';
import 'package:amadeus_app/core/widgets/custom_background/custom_background.dart';
import 'package:amadeus_app/features/ai/domain/usecases/send_message_usecase.dart';
import 'package:amadeus_app/features/avatar/presentation/screens/avatar_screen.dart';
import 'package:amadeus_app/features/home/presentation/widgets/home_speech_bubble.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final SendMessageUsecase sendMessageUsecase;

  const HomeScreen({super.key, required this.sendMessageUsecase});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final sendMessageUsecase = sl<SendMessageUsecase>();
    return Scaffold(
      body: Stack(
        children: [
          customBackground(context),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const Expanded(child: AvatarScreen()),
                HomeSpeechBubble(),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await sendMessageUsecase.post("hey");
        },
      ),
    );
  }
}
