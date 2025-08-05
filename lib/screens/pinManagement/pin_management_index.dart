import 'package:desuungapp/screens/pinManagement/earned_pins.dart';
import 'package:desuungapp/screens/pinManagement/pin_progress.dart';
import 'package:flutter/material.dart';

class PinManagementIndex extends StatefulWidget {
  const PinManagementIndex({super.key});

  @override
  State<PinManagementIndex> createState() => _PinManagementIndexState();
}

class _PinManagementIndexState extends State<PinManagementIndex> {
  final List<Map<String, dynamic>> allPins = [
    {
      'id': '1',
      'title': 'Community Service Pin',
      'description': 'Awarded for completing 100 hours of community service',
      'image': 'assets/pins/service.png',
      'category': 'Service',
      'status': 'Earned', // Can be 'Earned', 'In Progress', 'Locked'
      'progress': 100, // 0-100
      'dateEarned': 'June 15, 2025',
      'requirements': [
        {'description': 'Complete 100 hours of service', 'completed': true},
        {'description': 'Participate in 5 community events', 'completed': true},
        {'description': 'Get positive feedback from 3 organizers', 'completed': true},
      ],
      'rarity': 'Common',
      'points': 50,
    },
    {
      'id': '2',
      'title': 'Training Excellence Pin',
      'description': 'Awarded for completing advanced training programs',
      'image': 'assets/pins/training.png',
      'category': 'Training',
      'status': 'In Progress',
      'progress': 65,
      'dateEarned': null,
      'requirements': [
        {'description': 'Complete Basic Training', 'completed': true},
        {'description': 'Complete 3 advanced courses', 'completed': false},
        {'description': 'Score above 90% in final assessment', 'completed': true},
      ],
      'rarity': 'Rare',
      'points': 100,
    },
    {
      'id': '3',
      'title': 'Leadership Pin',
      'description': 'Awarded for demonstrating exceptional leadership',
      'image': 'assets/pins/leadership.png',
      'category': 'Leadership',
      'status': 'Locked',
      'progress': 20,
      'dateEarned': null,
      'requirements': [
        {'description': 'Lead 5 community projects', 'completed': false},
        {'description': 'Mentor 3 new Desuups', 'completed': true},
        {'description': 'Receive leadership certification', 'completed': false},
      ],
      'rarity': 'Epic',
      'points': 200,
    },
    {
      'id': '4',
      'title': 'Emergency Response Pin',
      'description': 'Awarded for participation in emergency response activities',
      'image': 'assets/pins/emergency.png',
      'category': 'Emergency',
      'status': 'Earned',
      'progress': 100,
      'dateEarned': 'May 10, 2025',
      'requirements': [
        {'description': 'Complete emergency training', 'completed': true},
        {'description': 'Participate in 2 drills', 'completed': true},
        {'description': 'Assist in 1 real emergency', 'completed': true},
      ],
      'rarity': 'Uncommon',
      'points': 75,
    },
  ];

  String _selectedFilter = 'All'; // 'All', 'Earned', 'In Progress', 'Locked'
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> get filteredPins {
    return allPins.where((pin) {
      final matchesFilter = _selectedFilter == 'All' || 
          pin['status'] == _selectedFilter;
      final matchesSearch = pin['title'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) || 
          pin['description'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLargeScreen = MediaQuery.of(context).size.width > 600;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Pin Management',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFFEBA050),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 24.0 : 16.0,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPointsSummary(),
              
              const SizedBox(height: 16),
              
              _buildSearchAndFilterSection(),
              
              const SizedBox(height: 16),
              
              _buildPinsCount(),
              
              const SizedBox(height: 8),
              
              Expanded(
                child: filteredPins.isEmpty
                    ? _buildEmptyState()
                    : _buildPinsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPointsSummary() {
  final totalPoints = allPins
      .where((pin) => pin['status'] == 'Earned')
      .fold(0, (sum, pin) => sum + (pin['points'] as int));

  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: const Color(0xFFEBA050).withOpacity(0.1),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.workspace_premium, size: 40, color: Color(0xFFEBA050)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$totalPoints Points',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFEBA050),
                ),
              ),
              const Text(
                'Total earned points',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EarnedPinsScreen(
                    earnedPins: allPins
                        .where((pin) => pin['status'] == 'Earned')
                        .toList(),
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFEBA050),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('View All'),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildSearchAndFilterSection() {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search pins...',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _searchController.clear();
                setState(() {});
              },
            ),
          ),
          onChanged: (value) => setState(() {}),
        ),
        
        const SizedBox(height: 12),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip('All'),
              _buildFilterChip('Earned'),
              _buildFilterChip('In Progress'),
              _buildFilterChip('Locked'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? label : 'All';
          });
        },
        selectedColor: const Color(0xFFEBA050),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildPinsCount() {
    return Text(
      '${filteredPins.length} ${filteredPins.length == 1 ? 'pin' : 'pins'} found',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.workspace_premium_outlined, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No pins found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedFilter = 'All';
                _searchController.clear();
              });
            },
            child: const Text('Reset filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildPinsList() {
    return ListView.separated(
      itemCount: filteredPins.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final pin = filteredPins[index];
        return _buildPinCard(pin);
      },
    );
  }

  Widget _buildPinCard(Map<String, dynamic> pin) {
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
          child: Row(
            children: [
              // Pin Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: pin['status'] == 'Locked' 
                      ? Colors.grey[200]
                      : _getPinColor(pin['category']).withOpacity(0.1),
                  image: pin['status'] != 'Locked'
                      ? DecorationImage(
                          image: AssetImage(pin['image']),
                          fit: BoxFit.contain,
                        )
                      : null,
                ),
                child: pin['status'] == 'Locked'
                    ? const Icon(Icons.lock_outline, size: 30, color: Colors.grey)
                    : null,
              ),
              
              const SizedBox(width: 16),
              
              // Pin Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pin['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pin['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Progress or Earned status
                    if (pin['status'] == 'Earned')
                      Row(
                        children: [
                          const Icon(Icons.check_circle, size: 16, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            'Earned on ${pin['dateEarned']}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${pin['progress']}% completed',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: pin['progress'] / 100,
                            backgroundColor: Colors.grey[200],
                            color: _getPinColor(pin['category']),
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Points or View button
              if (pin['status'] == 'Earned')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                )
              else
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PinProgressScreen(pin: pin),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFEBA050),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text('View'),
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Draggable Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Pin Image
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: pin['status'] == 'Locked' 
                        ? Colors.grey[200]
                        : _getPinColor(pin['category']).withOpacity(0.1),
                    image: pin['status'] != 'Locked'
                        ? DecorationImage(
                            image: AssetImage(pin['image']),
                            fit: BoxFit.contain,
                          )
                        : null,
                  ),
                  child: pin['status'] == 'Locked'
                      ? const Icon(Icons.lock_outline, size: 50, color: Colors.grey)
                      : null,
                ),
                
                const SizedBox(height: 16),
                
                // Pin Title
                Text(
                  pin['title'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Rarity and Points
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${pin['points']} points',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    pin['description'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Status Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        pin['status'] == 'Earned'
                            ? 'You earned this pin on ${pin['dateEarned']}'
                            : pin['status'] == 'In Progress'
                                ? 'Your progress towards this pin'
                                : 'Requirements to unlock this pin',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      if (pin['status'] == 'Earned')
                        const Icon(Icons.check_circle, size: 48, color: Colors.green)
                      else if (pin['status'] == 'In Progress')
                        Column(
                          children: [
                            CircularProgressIndicator(
                              value: pin['progress'] / 100,
                              backgroundColor: Colors.grey[200],
                              color: _getPinColor(pin['category']),
                              strokeWidth: 8,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${pin['progress']}% completed',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      else
                        const Icon(Icons.lock, size: 48, color: Colors.grey),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Requirements List
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Requirements:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                ...pin['requirements'].map<Widget>((req) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          req['completed'] ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: req['completed'] ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            req['description'],
                            style: TextStyle(
                              color: req['completed'] ? Colors.green : Colors.black87,
                              decoration: req['completed'] 
                                  ? TextDecoration.lineThrough 
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                
                const SizedBox(height: 32),
                
                // Action Button
                if (pin['status'] == 'In Progress')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PinProgressScreen(pin: pin),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEBA050),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('View Progress Details'),
                      ),
                    ),
                  ),
                
                const SizedBox(height: 16),
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