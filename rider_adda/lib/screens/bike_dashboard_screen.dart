import 'package:flutter/material.dart';
import 'package:rider_adda/utils/constants.dart';

class BikeDashboardScreen extends StatefulWidget {
  const BikeDashboardScreen({super.key});

  @override
  State<BikeDashboardScreen> createState() => _BikeDashboardScreenState();
}

class _BikeDashboardScreenState extends State<BikeDashboardScreen> {
  final List<Map<String, dynamic>> _maintenanceLog = [
    {'task': 'Chain Lube', 'done': false},
    {'task': 'Oil Change', 'done': false},
    {'task': 'Brake Pads', 'done': true},
    {'task': 'Air Filter Clean', 'done': false},
    {'task': 'Coolant Top-up', 'done': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bike'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bike Header Card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: AppColors.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('KTM 390 Duke', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.accent)),
                      const SizedBox(height: 8),
                      Text('MH 12 AB 1234', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?q=80&w=2070&auto=format&fit=crop',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(height: 200, color: Colors.grey[800], child: const Icon(Icons.broken_image)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(context, 'Odometer', '12,500 km', Icons.speed),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(context, 'Next Service', '15 Oct 2023', Icons.calendar_today),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Maintenance Log
              Text('Maintenance Log', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.accent)),
              const SizedBox(height: 12),
              Card(
                color: AppColors.surface,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _maintenanceLog.length,
                  itemBuilder: (context, index) {
                    final item = _maintenanceLog[index];
                    return CheckboxListTile(
                      title: Text(
                        item['task'],
                        style: TextStyle(
                          color: item['done'] ? Colors.grey : Colors.white,
                          decoration: item['done'] ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      value: item['done'],
                      activeColor: AppColors.accent,
                      checkColor: Colors.white,
                      onChanged: (bool? value) {
                        setState(() {
                          _maintenanceLog[index]['done'] = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon) {
    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: AppColors.accent, size: 32),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
            const SizedBox(height: 4),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
