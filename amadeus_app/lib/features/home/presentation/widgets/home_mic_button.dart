import 'package:amadeus_app/core/constants/interaction_mode.dart';
import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:amadeus_app/features/avatar/presentation/conversation_bloc/conversation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget homeMicButton(BuildContext context, InteractionMode isInteractionMode) {
  return BlocBuilder<ConversationBloc, ConversationState>(
    builder: (context, conversationState) {
      final isListening = conversationState is ConversationListening;

      return GestureDetector(
        onTap: () {
          context.read<ConversationBloc>().add(
            ToggleListeningEvent(!isListening),
          );
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E).withOpacity(0.95),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.4),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
              if (isListening)
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 0),
                ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Icon(
            isInteractionMode == InteractionMode.voice
                ? Icons.mic
                : Icons.mic_off,
            color: AppColors.primary,
            size: 28,
          ),
        ),
      );
    },
  );
}
