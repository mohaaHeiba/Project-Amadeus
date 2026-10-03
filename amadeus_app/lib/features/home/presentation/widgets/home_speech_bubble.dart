import 'package:amadeus_app/features/avatar/presentation/conversation_bloc/conversation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSpeechBubble extends StatelessWidget {
  const HomeSpeechBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 26),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E).withOpacity(0.95),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orange.withOpacity(0.4),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "■ AMADEUS // KURISU",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Good evening. Have the worldline divergence parameters shifted again?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Courier',
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -45,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: _buildMicButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMicButton(BuildContext context) {
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
            border: Border.all(color: Colors.orange.withOpacity(0.4), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
              BoxShadow(
                color: Colors.orange.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Icon(
            isListening ? Icons.mic : Icons.mic_off_outlined,
            color: Colors.orange,
            size: 28,
          ),
        ),
      );
    },
  );
}
