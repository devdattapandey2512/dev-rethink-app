import 'package:flutter/material.dart';
import 'package:rider_adda/utils/constants.dart';
import 'package:rider_adda/screens/chat_detail_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<Map<String, dynamic>> _chats = [
    {
      'id': 1,
      'name': 'Rohan Das',
      'avatar': 'https://i.pravatar.cc/150?u=rohan',
      'message': 'See you at 6 AM!',
      'time': '10:30 AM',
    },
    {
      'id': 2,
      'name': 'Karan Malhotra',
      'avatar': 'https://i.pravatar.cc/150?u=karan',
      'message': 'Did you fix the carburetor issue?',
      'time': 'Yesterday',
    },
    {
      'id': 3,
      'name': 'Anjali Verma',
      'avatar': 'https://i.pravatar.cc/150?u=anjali',
      'message': 'Thanks for the recommendation!',
      'time': '2 days ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat['avatar']),
              onBackgroundImageError: (exception, stackTrace) => {},
              child: const Icon(Icons.person),
            ),
            title: Text(chat['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(chat['message'], style: const TextStyle(color: Colors.grey)),
            trailing: Text(chat['time'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(user: chat),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
