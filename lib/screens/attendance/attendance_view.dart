import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceRecord {
  final DateTime date;
  final String studentId;
  final String status;
  final String event;

  AttendanceRecord({
    required this.date,
    required this.studentId,
    required this.status,
    required this.event,
  });
}

class Student {
  final String id;
  final String name;
  final List<String> events;
  final String rollNumber;
  final String? profileImage;

  Student({
    required this.id,
    required this.name,
    required this.events,
    required this.rollNumber,
    this.profileImage,
  });
}

class AttendanceViewScreen extends StatefulWidget {
  const AttendanceViewScreen({super.key});

  @override
  State<AttendanceViewScreen> createState() => _AttendanceViewScreenState();
}

class _AttendanceViewScreenState extends State<AttendanceViewScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedEvent = 'National Day Duty';
  bool _isLoading = false;

  final List<String> _events = [
    'National Day Duty',
    'December 17th'
  ];
  
  // This would normally come from your database/API
  final List<AttendanceRecord> _attendanceRecords = [
    AttendanceRecord(
      date: DateTime.now(),
      studentId: '1',
      status: 'Present',
      event: 'National Day Duty',
    ),
    AttendanceRecord(
      date: DateTime.now(),
      studentId: '2',
      status: 'Present',
      event: 'National Day Duty',
    ),
    // Add more sample records as needed
  ];

  final List<Student> _allStudents = [
    Student(id: '1', name: 'Desuung one', events: ['National Day Duty'], rollNumber: 'ST001'),
    Student(id: '2', name: 'Desuung two', events: ['National Day Duty'], rollNumber: 'ST002'),
    // Include all your students
  ];

  List<Student> get _filteredStudents {
    return _allStudents.where((student) => student.events.contains(_selectedEvent)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Attendance'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, size: 24),
            onPressed: () => _selectDate(context),
            tooltip: 'Select Date',
          ),
        ],
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
    final presentCount = _attendanceRecords.where((record) =>
      record.status == 'Present' &&
      record.event == _selectedEvent &&
      _isSameDay(record.date, _selectedDate)
    ).length;

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
              _buildSummaryItem('Total', _filteredStudents.length.toString(), 
                Icons.people_alt, Colors.blue),
              _buildSummaryItem('Present', presentCount.toString(), 
                Icons.check_circle, Colors.green),
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
                'Attendance Records (${_filteredStudents.length})',
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
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: _filteredStudents.length,
            separatorBuilder: (context, index) => const Divider(height: 1, indent: 72),
            itemBuilder: (context, index) {
              final student = _filteredStudents[index];
              final record = _attendanceRecords.firstWhere(
                (r) => r.studentId == student.id && 
                      r.event == _selectedEvent &&
                      _isSameDay(r.date, _selectedDate),
                orElse: () => AttendanceRecord(
                  date: _selectedDate,
                  studentId: student.id,
                  status: 'Absent',
                  event: _selectedEvent,
                ),
              );
              return _buildStudentRecordCard(student, record);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStudentRecordCard(Student student, AttendanceRecord record) {
    Color statusColor = _getStatusColor(record.status);

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
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: statusColor.withOpacity(0.3)),
        ),
        child: Text(
          record.status,
          style: TextStyle(
            color: statusColor,
            fontWeight: FontWeight.bold,
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
          Icon(Icons.event_busy, size: 60, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'No attendance records found',
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
          title: const Text('Search Records'),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Enter name or ID',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
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
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Color _getStatusColor(String status) {
    return status == 'Present' ? Colors.green : Colors.red;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }
}