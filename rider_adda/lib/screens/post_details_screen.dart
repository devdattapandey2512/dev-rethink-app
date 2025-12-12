import 'package:flutter/material.dart';
import 'package:rider_adda/utils/constants.dart';

class PostDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetailsScreen({super.key, required this.post});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, String>> _comments = [
    {'name': 'Arjun', 'comment': 'Awesome ride! Stay safe.'},
    {'name': 'Vikram', 'comment': 'Is that the new exhaust?'},
    {'name': 'Sneha', 'comment': 'Great click!'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Post Content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.post['avatar']),
                            onBackgroundImageError: (exception, stackTrace) => {},
                            child: const Icon(Icons.person),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.post['name'],
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                              Text(widget.post['time'],
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(widget.post['text'], style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.post['image'],
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(height: 200, color: Colors.grey[800], child: const Icon(Icons.broken_image)),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text('Comments', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.accent)),
                ),
                // Comments List
                ..._comments.map((comment) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[800],
                        child: Text(comment['name']![0], style: const TextStyle(color: Colors.white)),
                      ),
                      title: Text(comment['name']!, style: const TextStyle(color: Colors.white)),
                      subtitle: Text(comment['comment']!, style: const TextStyle(color: Colors.grey)),
                    )),
              ],
            ),
          ),
          // Comment Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Write a comment...',
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.accent),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      setState(() {
                        _comments.add({
                          'name': 'Me',
                          'comment': _commentController.text,
                        });
                        _commentController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
