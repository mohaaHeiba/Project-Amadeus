import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:amadeus_app/features/ai/data/model/chat_message.dart';
import 'package:amadeus_app/features/avatar/presentation/conversation_bloc/conversation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTextInputArea extends StatefulWidget {
  const HomeTextInputArea({super.key});

  @override
  State<HomeTextInputArea> createState() => HomeTextInputAreaState();
}

class HomeTextInputAreaState extends State<HomeTextInputArea> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final userMessage = ChatMessage(role: 'user', content: text);
      final List<ChatMessage> messages = [userMessage];
      context.read<ConversationBloc>().add(SendUserMessageEvent(messages));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white, fontFamily: 'Courier'),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              hintText: "Type a message...",
              hintStyle: TextStyle(
                color: Colors.grey.withValues(alpha: 0.6),
                fontFamily: 'Courier',
              ),
              filled: true,
              fillColor: Colors.black.withValues(alpha: 0.3),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
            ),
            onSubmitted: (_) => _sendMessage(),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: _sendMessage,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
            ),
            child: const Icon(Icons.send, color: AppColors.primary, size: 20),
          ),
        ),
      ],
    );
  }
}
