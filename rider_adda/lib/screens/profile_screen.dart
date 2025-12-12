import 'package:flutter/material.dart';
import 'package:rider_adda/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: const NetworkImage('https://i.pravatar.cc/300?u=user'),
                  onBackgroundImageError: (exception, stackTrace) => {},
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: AppColors.accent,
                      radius: 18,
                      child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Siddharth Gupta',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Riding since 2015',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat(context, 'Posts', '42'),
                  _buildStat(context, 'Rides', '15'),
                  _buildStat(context, 'Bikes', '2'),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.accent),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.accent),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.history, color: Colors.white),
                title: const Text('Ride History', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.group, color: Colors.white),
                title: const Text('My Groups', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.bookmark, color: Colors.white),
                title: const Text('Saved Posts', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
