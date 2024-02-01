import 'dart:convert';

import 'package:chat_app/Widgets/ChatBubble.dart';
import 'package:chat_app/Widgets/chat_input.dart';
import 'package:chat_app/models/image_model.dart';
import 'package:chat_app/repo/image_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'models/chat_message_entity.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key /* required this.username */});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // final String username;

  // initiate state of messages
  List<ChatMessageEntity> _messages = [];

  _loadInitialMessages() async {
    final response = await rootBundle.loadString('assets/mock_messages.json');

    final List<dynamic> decodedList = jsonDecode(response) as List;
    final List<ChatMessageEntity> _chatMessages = decodedList
        .map((listItem) => ChatMessageEntity.fromJson(listItem))
        .toList();

    print(_chatMessages.length);

    // final state of messages
    setState(() {
      _messages = _chatMessages;
    });
  }

  onMessageSend(ChatMessageEntity entity) {
    _messages.add(entity);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

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
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  alignment: _messages[index].author.userName == 'Sanket80'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  entity: _messages[index],
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
          const SizedBox(height: 8),
          ChatInput(
            onSubmit: onMessageSend,
          ),
        ],
      ),
    );
  }
}
