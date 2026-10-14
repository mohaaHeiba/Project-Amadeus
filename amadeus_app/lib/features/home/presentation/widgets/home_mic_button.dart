import 'package:amadeus_app/core/constants/interaction_mode.dart';
import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:amadeus_app/features/home/presentation/conversation_bloc/conversation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMicButton extends StatelessWidget {
  const HomeMicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        final isListening = state is ConversationListening;

        return GestureDetector(
          onTap: () {
            // Pressing mic button switches to text/chat mode
            context
                .read<ConversationBloc>()
                .add(ChangeInteractionModeEvent(InteractionMode.text));
          },
          child: Container(
            height: 60,
            width: 60,
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
                if (isListening)
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                  ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Icon(
              isListening ? Icons.mic : Icons.mic_none,
              color: AppColors.primary,
              size: 28,
            ),
          ),
        );
      },
    );
  }
}
