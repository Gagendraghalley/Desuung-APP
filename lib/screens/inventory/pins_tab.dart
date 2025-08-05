import 'package:flutter/material.dart';

class PinsTab extends StatelessWidget {
  const PinsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final pins = [
      {
        'name': 'Service Pin',
        'description': 'Awarded for completing 100 hours of community service',
        'image': 'assets/pins/service.png',
        'date': '2023-06-10',
        'type': 'Achievement',
      },
      // Add more pins...
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pins.length,
      itemBuilder: (context, index) {
        final pin = pins[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Image.asset(
                      pin['image'] ?? 'assets/default.png',
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.star),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pin['name'] ?? 'Unknown Name',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pin['description'] ?? 'No description available',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getPinTypeColor(pin['type'] as String)
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              pin['type'] ?? 'Unknown',
                              style: TextStyle(
                                color: _getPinTypeColor(pin['type'] as String),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            pin['date'] ?? 'Unknown Date',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getPinTypeColor(String type) {
    switch (type) {
      case 'Achievement':
        return Colors.green;
      case 'Training':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}