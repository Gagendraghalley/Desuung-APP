import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedEvent = 'National Day Duty';
  bool _isLoading = false;

  final List<String> _events = [
    'National Day Duty',
    'December 17th'
    
  ];
  
  final List<Student> _allStudents = [
    Student(id: '1', name: 'Desuung one', events: ['National Day Duty'], rollNumber: 'ST001'),
    Student(id: '2', name: 'Desuung two', events: ['National Day Duty'], rollNumber: 'ST002'),
    Student(id: '3', name: 'Desuung three', events: ['December 17th'], rollNumber: 'ST003'),
    Student(id: '4', name: 'Desuung four', events: ['National Day Duty'], rollNumber: 'ST004'),
    Student(id: '5', name: 'Desuung five', events: ['National Day Duty'], rollNumber: 'ST005'),
    Student(id: '6', name: 'Desuung six', events: ['National Day Duty'], rollNumber: 'ST006'),
    Student(id: '7', name: 'Desuung seven', events: ['December 17th'], rollNumber: 'ST007'),
    Student(id: '8', name: 'Desuung eight', events: ['National Day Duty'], rollNumber: 'ST008'),
  ];

  List<Student> get _filteredStudents {
    return _allStudents.where((student) => student.events.contains(_selectedEvent)).toList();
  }

  final List<AttendanceRecord> _attendanceRecords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Attendance'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildHeaderSection(),
          const Divider(height: 1),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredStudents.isEmpty
                    ? _buildEmptyState()
                    : _buildAttendanceList(),
          ),
        ],
      ),
      floatingActionButton: _buildSaveButton(),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventDropdown(),
          const SizedBox(height: 16),
          _buildDatePickerButton(),
          const SizedBox(height: 16),
          _buildSummaryCard(),
        ],
      ),
    );
  }

  Widget _buildEventDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Event', style: TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedEvent,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 2,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedEvent = newValue;
                  });
                }
              },
              items: _events.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerButton() {
    return InkWell(
      onTap: () => _selectDate(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 20, color: Colors.blue),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  DateFormat('MMM dd, yyyy').format(_selectedDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    final presentCount = _filteredStudents.where((student) {
      try {
        return _attendanceRecords.firstWhere(
          (record) => record.studentId == student.id && 
                    _isSameDay(record.date, _selectedDate),
        ).status == 'Present';
      } catch (e) {
        return true; // Default is present
      }
    }).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem('Total', _filteredStudents.length.toString(), Icons.people_alt, Colors.blue),
              _buildSummaryItem('Present', presentCount.toString(), Icons.check_circle, Colors.green),
              _buildSummaryItem('Absent', (_filteredStudents.length - presentCount).toString(), 
                Icons.cancel, Colors.red),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _filteredStudents.isEmpty ? 0 : presentCount / _filteredStudents.length,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: [
              Text(
                'Participants (${_filteredStudents.length})',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.search, size: 20),
                onPressed: _showSearchDialog,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: _filteredStudents.length,
            separatorBuilder: (context, index) => const Divider(height: 1, indent: 72),
            itemBuilder: (context, index) {
              return _buildStudentAttendanceCard(_filteredStudents[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStudentAttendanceCard(Student student) {
    String currentStatus = _getAttendanceStatus(student.id);
    Color statusColor = _getStatusColor(currentStatus);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey.shade200,
          child: student.profileImage != null
              ? ClipOval(child: Image.network(student.profileImage!))
              : Text(
                  student.name[0],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
        ),
      ),
      title: Text(
        student.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        'ID: ${student.rollNumber}',
        style: TextStyle(color: Colors.grey.shade600),
      ),
      trailing: _buildStatusDropdown(student, currentStatus, statusColor),
    );
  }

  Widget _buildStatusDropdown(Student student, String currentStatus, Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: DropdownButton<String>(
        value: currentStatus,
        underline: Container(),
        icon: Icon(Icons.arrow_drop_down, color: statusColor),
        style: TextStyle(
          fontSize: 14,
          color: statusColor,
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: Colors.white,
        items: const [
          DropdownMenuItem(
            value: 'Present',
            child: Text('Present'),
          ),
          DropdownMenuItem(
            value: 'Absent',
            child: Text('Absent'),
          ),
        ],
        onChanged: (String? newValue) {
          if (newValue != null) {
            _updateAttendance(student.id, newValue);
          }
        },
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _saveAttendance,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blue.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.save, size: 20, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'SAVE ATTENDANCE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_available, size: 60, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'No participants for this event',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try selecting a different event or date',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showSearchDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search Participant'),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Enter name or ID',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              // Implement search functionality
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement search
                Navigator.pop(context);
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(), // Only allow current or future dates
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _getAttendanceStatus(String studentId) {
    try {
      return _attendanceRecords.firstWhere(
        (record) => record.studentId == studentId && 
                  _isSameDay(record.date, _selectedDate),
      ).status;
    } catch (e) {
      return 'Present'; // Default status
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Present':
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  void _updateAttendance(String studentId, String newStatus) {
    setState(() {
      _attendanceRecords.removeWhere(
        (record) => record.studentId == studentId && 
                  _isSameDay(record.date, _selectedDate),
      );

      _attendanceRecords.add(AttendanceRecord(
        date: _selectedDate,
        studentId: studentId,
        status: newStatus,
      ));
    });
  }

  Future<void> _saveAttendance() async {
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() => _isLoading = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Attendance saved for $_selectedEvent',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to attendance report
          },
        ),
      ),
    );
  }
}

class Student {
  final String id;
  final String name;
  final List<String> events;
  final String? profileImage;
  final String rollNumber;

  Student({
    required this.id,
    required this.name,
    required this.events,
    this.profileImage,
    required this.rollNumber,
  });
}

class AttendanceRecord {
  final DateTime date;
  final String studentId;
  final String status;

  AttendanceRecord({
    required this.date,
    required this.studentId,
    required this.status,
  });
}