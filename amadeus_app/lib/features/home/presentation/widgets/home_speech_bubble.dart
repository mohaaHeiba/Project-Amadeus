import 'package:amadeus_app/core/constants/interaction_mode.dart';
import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:amadeus_app/features/avatar/presentation/conversation_bloc/conversation_bloc.dart';
import 'package:amadeus_app/features/home/presentation/widgets/home_mic_button.dart';
import 'package:amadeus_app/features/home/presentation/widgets/home_text_input_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSpeechBubble extends StatefulWidget {
  final InteractionMode isInteractionMode;
  const HomeSpeechBubble({super.key, required this.isInteractionMode});

  @override
  State<HomeSpeechBubble> createState() => _HomeSpeechBubbleState();
}

class _HomeSpeechBubbleState extends State<HomeSpeechBubble> {
  String _lastDisplayedText =
      "Good evening. Have the worldline divergence parameters shifted again?";

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConversationBloc, ConversationState>(
      listener: (context, state) {
        if (state is ConversationSpeaking) {
          setState(() {
            _lastDisplayedText = state.replyText;
          });
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 26),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E).withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "■ AMADEUS // KURISU",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),

                    BlocBuilder<ConversationBloc, ConversationState>(
                      builder: (context, state) {
                        String displayText = _lastDisplayedText;
                        Color textColor = Colors.white;

                        if (state is ConversationListening) {
                          displayText = "[Listening to user input...]";
                          textColor = Colors.orangeAccent;
                        } else if (state is ConversationThinking) {
                          displayText =
                              "[Connecting to Amadeus Server... Processing...]";
                          textColor = Colors.grey;
                        } else if (state is ConversationSpeaking) {
                          displayText = state.replyText;
                        } else if (state is ConversationError) {
                          displayText = "ERR: ${state.message}";
                          textColor = Colors.redAccent;
                        }

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            displayText,
                            key: ValueKey<String>(displayText),
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontFamily: 'Courier',
                              height: 1.5,
                            ),
                          ),
                        );
                      },
                    ),

                    if (widget.isInteractionMode == InteractionMode.text) ...[
                      const SizedBox(height: 16),
                      const HomeTextInputArea(),
                    ],
                  ],
                ),
              ),

              Positioned(
                top: -45,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: homeMicButton(context, widget.isInteractionMode),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
