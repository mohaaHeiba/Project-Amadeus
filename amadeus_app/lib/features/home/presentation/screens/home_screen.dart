import 'package:amadeus_app/core/utils/custom_snackbar.dart';
import 'package:amadeus_app/core/widgets/custom_background/custom_background.dart';
import 'package:amadeus_app/core/widgets/custom_background/widgets/glitch_painter.dart';
import 'package:amadeus_app/features/avatar/presentation/avatar_bloc/avatar_bloc.dart';
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

  bool hasError = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    controller.addStatusListener((s) {
      if (s == AnimationStatus.completed && mounted) {
        setState(() => hasError = false);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocListener<ConversationBloc, ConversationState>(
      listener: (context, state) {
        if (state is ConversationError) {
          setState(() => hasError = true);
          controller.forward(from: 0);

          CustomSnackbar.show(
            isError: true,
            context: context,
            message: state.message,
          );
        }

        if (state is ConversationSpeaking) {
          context.read<AvatarBloc>().add(UpdateEmotionEvent(state.emotion));
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            customBackground(context),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const Expanded(child: AvatarScreen()),
                  BlocBuilder<ConversationBloc, ConversationState>(
                    builder: (context, state) {
                      return HomeSpeechBubble(isInteractionMode: state.mode);
                    },
                  ),
                ],
              ),
            ),
            if (hasError)
              IgnorePointer(
                child: AnimatedBuilder(
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
              ),
          ],
        ),
      ),
    );
  }
}
