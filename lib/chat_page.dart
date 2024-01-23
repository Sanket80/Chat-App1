import 'package:chat_app/Widgets/ChatBubble.dart';
import 'package:chat_app/Widgets/chat_input.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key /* required this.username */});

  // final String username;

  @override
  Widget build(BuildContext context) {

    final username = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hi $username!'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ChatBubble(
                  alignment: index % 2 == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  message: 'Hey Sanket, how are you?',
                );
              },
            ),
            // child: ListView(
            //   children: [
            //     ChatBubble(
            //       alignment: Alignment.centerLeft,
            //       message: 'Hey Sanket, how are you?',
            //     ),
            //     ChatBubble(
            //       alignment: Alignment.centerRight,
            //       message: 'I am good, how are you?',
            //     ),
            //     ChatBubble(
            //       alignment: Alignment.centerLeft,
            //       message: 'I am good too, thanks for asking!',
            //     ),
            //   ],
            // ),
          ),
          const SizedBox(height: 14),
          ChatInput(),
        ],
      ),
    );
  }
}
