import 'package:flutter/material.dart';
import 'package:rider_adda/utils/constants.dart';
import 'package:rider_adda/screens/post_details_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<Map<String, dynamic>> _posts = [
    {
      'id': 1,
      'name': 'Rahul Sharma',
      'avatar': 'https://i.pravatar.cc/150?u=rahul',
      'time': '2 hrs ago',
      'text': 'Just got back from a ride to Lonavala. The weather was perfect!',
      'image': 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?q=80&w=2070&auto=format&fit=crop',
    },
    {
      'id': 2,
      'name': 'Priya Singh',
      'avatar': 'https://i.pravatar.cc/150?u=priya',
      'time': '5 hrs ago',
      'text': 'My new beast! Royal Enfield Interceptor 650.',
      'image': 'https://images.unsplash.com/photo-1625043484555-47841a754320?q=80&w=2071&auto=format&fit=crop',
    },
    {
      'id': 3,
      'name': 'Amit Patel',
      'avatar': 'https://i.pravatar.cc/150?u=amit',
      'time': '1 day ago',
      'text': 'Looking for riding buddies for a Ladakh trip next month. DM me!',
      'image': 'https://images.unsplash.com/photo-1591635566278-10dca0ca76ee?q=80&w=2070&auto=format&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Floating Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search posts, bikes, riders...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            // Posts List
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailsScreen(post: post),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      color: AppColors.surface,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(post['avatar']),
                              onBackgroundImageError: (exception, stackTrace) => {},
                              child: const Icon(Icons.person),
                            ),
                            title: Text(post['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            subtitle: Text(post['time'], style: const TextStyle(color: Colors.grey)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(post['text'], style: const TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 12),
                          Image.network(
                            post['image'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(height: 200, color: Colors.grey[800], child: const Icon(Icons.broken_image)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                const Icon(Icons.favorite_border, color: Colors.white),
                                const SizedBox(width: 24),
                                const Icon(Icons.comment, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add post action
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
