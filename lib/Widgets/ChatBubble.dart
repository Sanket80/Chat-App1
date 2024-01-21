import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.alignment, required this.message});

  final Alignment alignment;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: alignment,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              ),
              const SizedBox(height: 14),
              Image.network('https://img.freepik.com/premium-vector/chat-app-logo-sms-messenger-label-design-mobile-app-online-conversation-with-texting-message-ui-design-concept-vector-illustration_172533-1513.jpg', height: 150),
            ],
          ),
          margin: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Colors.grey[600],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
        ),
      );
  }
}
