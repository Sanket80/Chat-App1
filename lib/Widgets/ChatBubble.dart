import 'package:chat_app/models/chat_message_entity.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.alignment, required this.entity});

  final Alignment alignment;
  final ChatMessageEntity entity;

  @override
  Widget build(BuildContext context) {
    bool isAuthor = entity.author.userName == "Sanket80";

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${entity.text}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            if (entity.imageUrl != null)
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(entity.imageUrl!),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
          ],
        ),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isAuthor ? Colors.blueAccent : Colors.black87,
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
