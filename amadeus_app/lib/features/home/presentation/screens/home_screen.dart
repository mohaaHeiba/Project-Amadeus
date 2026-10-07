import 'package:amadeus_app/core/utils/custom_snackbar.dart';
import 'package:amadeus_app/core/widgets/custom_background/custom_background.dart';
import 'package:amadeus_app/core/widgets/custom_background/widgets/glitch_painter.dart';
import 'package:amadeus_app/features/avatar/presentation/conversation_bloc/conversation_bloc.dart';
import 'package:amadeus_app/features/avatar/presentation/screens/avatar_screen.dart';
import 'package:amadeus_app/features/home/presentation/widgets/home_speech_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool error = false;
    final size = MediaQuery.sizeOf(context);

    return BlocListener<ConversationBloc, ConversationState>(
      listener: (context, state) {
        if (state is ConversationError) {
          error = true;
          CustomSnackbar.show(
            isError: true,
            context: context,
            message: state.message,
          );
        }
        if (state is ConversationSpeaking) {}
      },
      child: Scaffold(
        body: Stack(
          children: [
            customBackground(context),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Expanded(child: AvatarScreen()),
                  BlocBuilder<ConversationBloc, ConversationState>(
                    builder: (context, state) {
                      return HomeSpeechBubble(isInteractionMode: state.mode);
                    },
                  ),
                ],
              ),
            ),
            // animtain for error
            if (error == true)
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: size,
                    painter: GlitchPaint(
                      progress: controller.value,
                      seed: (controller.value * 60).toInt(),
                      sizeGlitch: 15,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
