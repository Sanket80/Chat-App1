import 'package:chat_app/chat_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

void main(){
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      home: LoginPage(),
      // named routes
      routes: {
        '/login': (context) => LoginPage(),
        '/chat': (context) => ChatPage(),
      }
    );
  }
}



