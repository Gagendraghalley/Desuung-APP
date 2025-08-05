import 'package:desuungapp/screens/events/apply_screen.dart';
import 'package:flutter/material.dart';
import 'package:desuungapp/screens/attendance/attendance_screen.dart';
import 'package:desuungapp/screens/attendance/attendance_view.dart';

class EventsIndex extends StatefulWidget {
  const EventsIndex({super.key});

  @override
  State<EventsIndex> createState() => _EventsIndexState();
}

class _EventsIndexState extends State<EventsIndex> {
  // Sample event data with categories
  final List<Map<String, dynamic>> allEvents = [
    {
      'id': '1',
      'title': 'Community Service',
      'description': 'Join us for a day of giving back to the community',
      'date': 'June 15, 2023',
      'location': 'Central Park',
      'image': 'assets/communityService.jpeg',
      'category': 'Volunteer',
      'status': 'Upcoming',
    },
    {
      'id': '2',
      'title': 'Leadership Workshop',
      'description': 'Develop your leadership skills with our experts',
      'date': 'June 20, 2023',
      'location': 'Conference Hall',
      'image': 'assets/leadership.jpeg',
      'category': 'Workshop',
      'status': 'Upcoming',
    },
    {
      'id': '3',
      'title': 'Cultural Festival',
      'description': 'Celebrate our diverse cultures with performances and food',
      'date': 'June 25, 2023',
      'location': 'Town Square',
      'image': 'assets/festival.jpeg',
      'category': 'Cultural',
      'status': 'Upcoming',
    },
    {
      'id': '4',
      'title': 'Tech Conference',
      'description': 'Learn about the latest technology trends',
      'date': 'July 5, 2023',
      'location': 'Tech Center',
      'image': 'assets/tech.jpeg',
      'category': 'Conference',
      'status': 'Upcoming',
    },
    {
      'id': '5',
      'title': 'Health Camp',
      'description': 'Free health checkups and consultations',
      'date': 'May 30, 2023',
      'location': 'Community Center',
      'image': 'assets/health.jpeg',
      'category': 'Health',
      'status': 'Past',
    },
  ];

  // Filter variables
  String _selectedCategory = 'All';
  String _selectedStatus = 'Upcoming';
  final TextEditingController _searchController = TextEditingController();

  // Get unique categories
  List<String> get categories {
    final cats = allEvents.map((e) => e['category'] as String).toSet().toList();
    cats.insert(0, 'All');
    return cats;
  }

  // Get filtered events
  List<Map<String, dynamic>> get filteredEvents {
    return allEvents.where((event) {
      final matchesCategory = _selectedCategory == 'All' || 
          event['category'] == _selectedCategory;
      final matchesStatus = event['status'] == _selectedStatus;
      final matchesSearch = event['title'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) || 
          event['description'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
      return matchesCategory && matchesStatus && matchesSearch;
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
        title: Text(
          'Upcoming Events',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Color.fromARGB(255, 235, 160, 80),
        
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            style: IconButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 11, 11, 11),
            ),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 32.0 : 16.0,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search events...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),

              // Active Filters
              Wrap(
                spacing: 8,
                children: [
                  if (_selectedCategory != 'All')
                    Chip(
                      label: Text(_selectedCategory),
                      deleteIcon: const Icon(Icons.close, size: 16),
                      onDeleted: () {
                        setState(() {
                          _selectedCategory = 'All';
                        });
                      },
                      backgroundColor: _getCategoryColor(_selectedCategory).withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: _getCategoryColor(_selectedCategory),
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: _getCategoryColor(_selectedCategory),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  if (_selectedStatus != 'Upcoming')
                    Chip(
                      label: Text(_selectedStatus),
                      deleteIcon: const Icon(Icons.close, size: 16),
                      onDeleted: () {
                        setState(() {
                          _selectedStatus = 'Upcoming';
                        });
                      },
                      backgroundColor: _selectedStatus == 'Upcoming'
                          ? Colors.green[50]
                          : Colors.grey[200],
                      labelStyle: TextStyle(
                        color: _selectedStatus == 'Upcoming'
                            ? Colors.green[800]
                            : Colors.grey[800],
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: _selectedStatus == 'Upcoming'
                              ? Colors.green
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8),

              // Events Count
              Text(
                '${filteredEvents.length} ${filteredEvents.length == 1 ? 'event' : 'events'} found',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),
              
              // Events List
              Expanded(
                child: filteredEvents.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.event_busy, size: 48, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'No events found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedCategory = 'All';
                                  _selectedStatus = 'Upcoming';
                                  _searchController.clear();
                                });
                              },
                              child: Text('Reset filters'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredEvents.length,
                        itemBuilder: (context, index) {
                          final event = filteredEvents[index];
                          return _buildEventCard(context, event);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> event) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image with Category Badge
          Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                event['image'],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey[200],
                    child: Center(
                      child: Icon(Icons.event, size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(event['category']),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  event['category'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      event['date'],
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      event['location'],
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  event['description'],
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        _showEventDetails(context, event);
                      },
                      child: Text('Details'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        _applyForEvent(context, event['id']);
                      },
                      child: Text('Apply Now'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        backgroundColor: Color.fromARGB(255, 235, 160, 80),
                        foregroundColor: const Color.fromARGB(255, 249, 247, 247),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Volunteer':
        return Colors.green;
      case 'Workshop':
        return Colors.blue;
      case 'Cultural':
        return Colors.purple;
      case 'Conference':
        return Colors.orange;
      case 'Health':
        return Colors.red;
      default:
        return Colors.teal;
    }
  }

  void _showFilterDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: SizedBox(
                    width: 40,
                    child: Divider(thickness: 3, height: 24),
                  ),
                ),
                const Text(
                  'Filter Events',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Category Filter
                const Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: categories.map((category) {
                    final isSelected = _selectedCategory == category;
                    return FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setModalState(() {
                          _selectedCategory = selected ? category : 'All';
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: _getCategoryColor(category).withOpacity(0.2),
                      checkmarkColor: _getCategoryColor(category),
                      labelStyle: TextStyle(
                        color: isSelected ? _getCategoryColor(category) : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: isSelected 
                              ? _getCategoryColor(category)
                              : Colors.grey[300]!,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 16),
                
                // Status Filter
                const Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['Upcoming', 'Past', 'All'].map((status) {
                    final isSelected = _selectedStatus == status;
                    return FilterChip(
                      label: Text(status),
                      selected: isSelected,
                      onSelected: (selected) {
                        setModalState(() {
                          _selectedStatus = selected ? status : 'Upcoming';
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: status == 'Upcoming' 
                          ? Colors.green[50]
                          : Colors.grey[200],
                      checkmarkColor: status == 'Upcoming' 
                          ? Colors.green
                          : Colors.grey,
                      labelStyle: TextStyle(
                        color: isSelected 
                            ? status == 'Upcoming'
                                ? Colors.green[800]
                                : Colors.grey[800]
                            : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: isSelected 
                              ? status == 'Upcoming'
                                  ? Colors.green
                                  : Colors.grey
                              : Colors.grey[300]!,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 24),
                
                // Apply Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEBA050),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

  void _showEventDetails(BuildContext context, Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event['title']),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(event['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                event['description'],
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('Date: ${event['date']}'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('Location: ${event['location']}'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.category, size: 16, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('Category: ${event['category']}'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.event_available, size: 16, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('Status: ${event['status']}'),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _applyForEvent(context, event['id']);
            },
            child: Text('Apply Now'),
          ),
        ],
      ),
    );
  }

  void _applyForEvent(BuildContext context, String eventId) {
  // Find the event by ID
  final event = allEvents.firstWhere((e) => e['id'] == eventId);
  
  // Navigate to the application form
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ApplicationForm(
        eventId: eventId,
        eventTitle: event['title'],
      ),
    ),
  );
}
}