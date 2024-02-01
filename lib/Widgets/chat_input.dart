import 'package:chat_app/Widgets/picker_body.dart';
import 'package:chat_app/models/chat_message_entity.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  ChatInput({super.key, required this.onSubmit});

  final Function(ChatMessageEntity) onSubmit;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final chatMessageController = TextEditingController();

  String _selectedImageUrl = "";

  void onSendButtonPressed() {
    print(chatMessageController.text);

    final newChatMessage = ChatMessageEntity(
      text: chatMessageController.text,
      id: "234",
      createdAt: DateTime.now().millisecondsSinceEpoch,
      author: Author(userName: "Sanket80"),
    );

    if(_selectedImageUrl.isNotEmpty){
      newChatMessage.imageUrl = _selectedImageUrl;
    }

    widget.onSubmit(newChatMessage);
    chatMessageController.clear();
    _selectedImageUrl = "";
    setState(() {});
  }

  void onImagePicked(String newImageUrl) {
    setState(() {
      _selectedImageUrl = newImageUrl;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return NetworkImagePickerBody(
                      onImageSelected: onImagePicked,
                    );
                  });
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  controller: chatMessageController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                if (_selectedImageUrl.isNotEmpty)
                  Image.network(
                    _selectedImageUrl,
                    height: 70,
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              onSendButtonPressed();
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
