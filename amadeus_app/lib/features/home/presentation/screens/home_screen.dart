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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController controller;
  late final AnimationController pulseController;
  Color condition = Colors.transparent;
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

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  Color _parseHexColor(String? hexString) {
    if (hexString == null) return const Color(0x00000000);
    try {
      final cleanHex = hexString
          .replaceAll('0x', '')
          .replaceAll('0X', '')
          .replaceAll('#', '');
      return Color(
        int.parse(cleanHex.length == 6 ? 'FF$cleanHex' : cleanHex, radix: 16),
      );
    } catch (_) {
      return const Color(0x00000000);
    }
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
          setState(() => condition = _parseHexColor(state.color));
          context.read<AvatarBloc>().add(UpdateEmotionEvent(state.emotion));
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            customBackground(context),

            Positioned(
              top: size.height * 0.16,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedBuilder(
                  animation: pulseController,
                  builder: (context, child) {
                    final pulseValue = Curves.easeInOutSine.transform(
                      pulseController.value,
                    );

                    final dynamicBlur = 80.0 + (pulseValue * 40.0);
                    final dynamicSpread = 25.0 + (pulseValue * 25.0);
                    final dynamicAlpha = 0.4 + (pulseValue * 0.25);
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 280,
                      height: 280,
                      curve: Curves.easeInOutCubic,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: condition.withValues(alpha: dynamicAlpha),
                            blurRadius: dynamicBlur,
                            spreadRadius: dynamicSpread,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

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
