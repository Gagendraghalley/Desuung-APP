import 'package:flutter/material.dart';
import 'package:desuungapp/screens/skillsAndProgram/apply_skilling_program.dart';

class SkillAndProgramIndex extends StatefulWidget {
  const SkillAndProgramIndex({super.key});

  @override
  State<SkillAndProgramIndex> createState() => _SkillAndProgramIndexState();
}

class _SkillAndProgramIndexState extends State<SkillAndProgramIndex> {
  final List<Map<String, dynamic>> allPrograms = [
    {
      'id': '1',
      'title': 'Basic Carpentry Training',
      'description': 'Learn fundamental carpentry skills including woodworking, joinery, and furniture making',
      'date': 'June 15 - July 15, 2025',
      'location': 'Thimphu Technical Training Institute',
      'image': 'assets/carpentry.jpeg',
      'category': 'Construction',
      'status': 'Upcoming',
      'duration': '4 weeks',
      'seats': '15',
      'instructor': 'Tashi Dorji',
      'certification': 'Vocational Training Certificate'
    },
    {
      'id': '2',
      'title': 'Basic Electrical Wiring',
      'description': 'Training on domestic electrical installation, maintenance and safety practices',
      'date': 'June 20 - July 10, 2025',
      'location': 'Phuentsholing Vocational Training Center',
      'image': 'assets/electrical.jpeg',
      'category': 'Technical',
      'status': 'Upcoming',
      'duration': '3 weeks',
      'seats': '12',
      'instructor': 'Karma Wangchuk',
      'certification': 'Vocational Training Certificate'
    },
    {
      'id': '3',
      'title': 'Tourism and Hospitality',
      'description': 'Training in hotel operations, customer service and tour guiding',
      'date': 'July 5 - August 5, 2025',
      'location': 'Paro College of Hospitality',
      'image': 'assets/tourism.jpeg',
      'category': 'Service',
      'status': 'Upcoming',
      'duration': '4 weeks',
      'seats': '20',
      'instructor': 'Pema Lhamo',
      'certification': 'Vocational Training Certificate'
    },
    {
      'id': '4',
      'title': 'Organic Farming Techniques',
      'description': 'Learn sustainable farming practices without chemical inputs',
      'date': 'May 15 - June 15, 2025',
      'location': 'Bumthang Agriculture Center',
      'image': 'assets/farming.jpeg',
      'category': 'Agriculture',
      'status': 'Past',
      'duration': '4 weeks',
      'seats': '18',
      'instructor': 'Dorji Wangyal',
      'certification': 'Vocational Training Certificate'
    },
  ];

  String _selectedCategory = 'All';
  String _selectedStatus = 'Upcoming';
  final TextEditingController _searchController = TextEditingController();

  List<String> get categories {
    final cats = allPrograms.map((e) => e['category'] as String).toSet().toList();
    cats.insert(0, 'All');
    return cats;
  }

  List<Map<String, dynamic>> get filteredPrograms {
    return allPrograms.where((program) {
      final matchesCategory = _selectedCategory == 'All' || 
          program['category'] == _selectedCategory;
      final matchesStatus = program['status'] == _selectedStatus;
      final matchesSearch = program['title'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) || 
          program['description'].toLowerCase().contains(
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
        title: const Text(
          'Skilling Programs',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 24.0 : 16.0,
            vertical: 16.0,
          ),
          child: Column(
            children: [
              // Search Bar with Filter Chips
              _buildSearchAndFilterSection(context),
              
              const SizedBox(height: 16),
              
              // Programs Count
              _buildProgramsCount(),
              
              const SizedBox(height: 8),
              
              // Programs List
              Expanded(
                child: filteredPrograms.isEmpty
                    ? _buildEmptyState()
                    : _buildProgramsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilterSection(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search skilling programs...',
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
        
        // Active Filters
        Wrap(
          spacing: 8,
          children: [
            if (_selectedCategory != 'All')
              Chip(
                label: Text(_selectedCategory),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => setState(() => _selectedCategory = 'All'),
                backgroundColor: _getCategoryColor(_selectedCategory).withOpacity(0.2),
              ),
            if (_selectedStatus != 'Upcoming')
              Chip(
                label: Text(_selectedStatus),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => setState(() => _selectedStatus = 'Upcoming'),
                backgroundColor: Colors.grey[200],
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgramsCount() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '${filteredPrograms.length} ${filteredPrograms.length == 1 ? 'program' : 'programs'} found',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school_outlined, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No skilling programs found',
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
                _selectedCategory = 'All';
                _selectedStatus = 'Upcoming';
                _searchController.clear();
              });
            },
            child: const Text('Reset filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramsList() {
    return ListView.separated(
      itemCount: filteredPrograms.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final program = filteredPrograms[index];
        return _buildProgramCard(context, program);
      },
    );
  }

  Widget _buildProgramCard(BuildContext context, Map<String, dynamic> program) {
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
        onTap: () => _showProgramDetails(context, program),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Category Tag
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    program['image'],
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 160,
                        color: Colors.grey[200],
                        child: Center(
                          child: Icon(Icons.school_outlined, size: 50, color: Colors.grey[400]),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(program['category']),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      program['category'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Program Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          program['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: program['status'] == 'Upcoming' 
                              ? Colors.green[50]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          program['status'],
                          style: TextStyle(
                            color: program['status'] == 'Upcoming'
                                ? Colors.green[800]
                                : Colors.grey[800],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Key Details
                  _buildDetailRow(Icons.calendar_today, program['date']),
                  const SizedBox(height: 6),
                  _buildDetailRow(Icons.location_on, program['location']),
                  const SizedBox(height: 6),
                  _buildDetailRow(Icons.timer_outlined, '${program['duration']} • ${program['seats']} seats'),
                  
                  const SizedBox(height: 12),
                  
                  // Description (truncated)
                  Text(
                    program['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _showProgramDetails(context, program),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: const Text('View Details'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _applyForProgram(context, program['id']),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEBA050),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('Apply Now'),
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
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Construction':
        return const Color(0xFF4285F4);
      case 'Technical':
        return const Color(0xFFFBBC05);
      case 'Service':
        return const Color(0xFF34A853);
      case 'Agriculture':
        return const Color(0xFFEA4335);
      default:
        return const Color(0xFF6E6E6E);
    }
  }

  void _showFilterBottomSheet(BuildContext context) {
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
                    'Filter Programs',
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

  void _showProgramDetails(BuildContext context, Map<String, dynamic> program) {
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
                
                // Program Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    program['image'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: Center(
                          child: Icon(Icons.school_outlined, size: 50, color: Colors.grey[400]),
                        ),
                      );
                    },
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              program['title'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: program['status'] == 'Upcoming' 
                                  ? Colors.green[50]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              program['status'],
                              style: TextStyle(
                                color: program['status'] == 'Upcoming'
                                    ? Colors.green[800]
                                    : Colors.grey[800],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Category Chip
                      Chip(
                        label: Text(program['category']),
                        backgroundColor: _getCategoryColor(program['category']).withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: _getCategoryColor(program['category']),
                          fontWeight: FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide(
                            color: _getCategoryColor(program['category']),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Key Details
                      _buildDetailCard(program),
                      
                      const SizedBox(height: 16),
                      
                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        program['description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Instructor Info
                      if (program['instructor'] != null) ...[
                        const Text(
                          'Instructor',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(
                            program['instructor'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: const Text('Certified Trainer'),
                        ),
                      ],
                      
                      const SizedBox(height: 16),
                      
                      // Certification Info
                      if (program['certification'] != null) ...[
                        const Text(
                          'Certification',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.verified, color: Colors.green),
                              const SizedBox(width: 12),
                              Text(
                                program['certification'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      
                      const SizedBox(height: 24),
                      
                      // Apply Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _applyForProgram(context, program['id']);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEBA050),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Apply Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
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

  Widget _buildDetailCard(Map<String, dynamic> program) {
    return Card(
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
            // Date and Location
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailItem(Icons.calendar_today, 'Date', program['date']),
                      const SizedBox(height: 12),
                      _buildDetailItem(Icons.location_on, 'Location', program['location']),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailItem(Icons.timer_outlined, 'Duration', program['duration']),
                      const SizedBox(height: 12),
                      _buildDetailItem(Icons.people_outline, 'Available Seats', program['seats']),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _applyForProgram(BuildContext context, String programId) {
    final program = allPrograms.firstWhere((p) => p['id'] == programId);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplySkillingProgram(
          programId: programId,
          programTitle: program['title'],
        ),
      ),
    );
  }
}