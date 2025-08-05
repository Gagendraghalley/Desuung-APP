import 'package:flutter/material.dart';

class PinProgressScreen extends StatelessWidget {
  final Map<String, dynamic> pin;

  const PinProgressScreen({super.key, required this.pin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pin['title']} Progress'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Summary
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Your Progress',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    CircularProgressIndicator(
                      value: pin['progress'] / 100,
                      backgroundColor: Colors.grey[200],
                      color: _getPinColor(pin['category']),
                      strokeWidth: 10,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${pin['progress']}% Completed',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Requirements List
            const Text(
              'Requirements to earn this pin:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 16),
            
            ...pin['requirements'].map<Widget>((req) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        req['completed'] ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: req['completed'] ? Colors.green : Colors.grey,
                        size: 30,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              req['description'],
                              style: TextStyle(
                                fontSize: 16,
                                decoration: req['completed'] 
                                    ? TextDecoration.lineThrough 
                                    : null,
                              ),
                            ),
                            if (!req['completed']) const SizedBox(height: 8),
                            if (!req['completed'])
                              ElevatedButton(
                                onPressed: () {
                                  _showRequirementDetails(context, req['description']);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFFEBA050),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: const Color(0xFFEBA050),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                ),
                                child: const Text('Complete Now'),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            
            const SizedBox(height: 24),
            
            // Notification if all requirements are completed
            if (pin['progress'] == 100)
              Card(
                color: Colors.green[50],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(Icons.notifications_active, size: 40, color: Colors.green),
                      const SizedBox(height: 16),
                      const Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'You have completed all requirements for this pin.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pin claimed successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Claim Pin Now'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getPinColor(String category) {
    switch (category) {
      case 'Service':
        return const Color(0xFF4285F4);
      case 'Training':
        return const Color(0xFFFBBC05);
      case 'Leadership':
        return const Color(0xFF34A853);
      case 'Emergency':
        return const Color(0xFFEA4335);
      default:
        return const Color(0xFF6E6E6E);
    }
  }

  void _showRequirementDetails(BuildContext context, String requirement) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Complete Requirement'),
          content: Text('Details about how to complete: $requirement'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Requirement marked as completed!'),
                  ),
                );
              },
              child: const Text('Mark Complete'),
            ),
          ],
        );
      },
    );
  }
}