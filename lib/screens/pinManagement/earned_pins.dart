import 'package:flutter/material.dart';

class EarnedPinsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> earnedPins;

  const EarnedPinsScreen({super.key, required this.earnedPins});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earned Pins'),
      ),
      body: earnedPins.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.workspace_premium_outlined, 
                      size: 48, 
                      color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    'No pins earned yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemCount: earnedPins.length,
              itemBuilder: (context, index) {
                final pin = earnedPins[index];
                return _buildEarnedPinCard(context, pin);
              },
            ),
    );
  }

  Widget _buildEarnedPinCard(BuildContext context, Map<String, dynamic> pin) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showPinDetails(context, pin),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pin Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(pin['image']),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Pin Title
              Text(
                pin['title'],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Earned Date
              Text(
                'Earned: ${pin['dateEarned']}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Points
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPinColor(pin['category']).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${pin['points']} pts',
                  style: TextStyle(
                    color: _getPinColor(pin['category']),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
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

  void _showPinDetails(BuildContext context, Map<String, dynamic> pin) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Pin Image
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(pin['image']),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Pin Title
                Text(
                  pin['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Earned Date
                Text(
                  'Earned on ${pin['dateEarned']}',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Points and Rarity
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getPinColor(pin['category']).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${pin['points']} pts',
                        style: TextStyle(
                          color: _getPinColor(pin['category']),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getRarityColor(pin['rarity']).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        pin['rarity'],
                        style: TextStyle(
                          color: _getRarityColor(pin['rarity']),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Close Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEBA050),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case 'Common':
        return Colors.blue;
      case 'Uncommon':
        return Colors.green;
      case 'Rare':
        return Colors.purple;
      case 'Epic':
        return Colors.orange;
      case 'Legendary':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}