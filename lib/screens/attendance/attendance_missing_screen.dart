import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceMissingScreen extends StatefulWidget {
  const AttendanceMissingScreen({super.key});

  @override
  _AttendanceMissingScreenState createState() => _AttendanceMissingScreenState();
}

class _AttendanceMissingScreenState extends State<AttendanceMissingScreen> {
  // Sample data for missing attendance records
  final List<MissingAttendanceRecord> _records = [
    MissingAttendanceRecord(
      date: DateTime.now().subtract(const Duration(days: 2)),
      studentName: 'Dorji Wangchuk',
      studentId: 'DES2023001',
      reason: 'Medical leave',
      status: 'Pending',
    ),
    MissingAttendanceRecord(
      date: DateTime.now().subtract(const Duration(days: 1)),
      studentName: 'Pema Choden',
      studentId: 'DES2023002',
      reason: 'Family emergency',
      status: 'Approved',
    ),
    MissingAttendanceRecord(
      date: DateTime.now().subtract(const Duration(days: 1)),
      studentName: 'Karma Dorji',
      studentId: 'DES2023003',
      reason: 'Transportation issue',
      status: 'Rejected',
    ),
    MissingAttendanceRecord(
      date: DateTime.now(),
      studentName: 'Sonam Yangden',
      studentId: 'DES2023004',
      reason: 'Official duty',
      status: 'Pending',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Missing Attendance Records'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _records.length,
        itemBuilder: (context, index) {
          final record = _records[index];
          final isLastItem = index == _records.length - 1;
          
          // Group by date
          final showDateHeader = index == 0 || 
              !DateUtils.isSameDay(_records[index].date, _records[index - 1].date);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showDateHeader) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 12),
                  child: Text(
                    DateFormat('MMMM d, y').format(record.date),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
              _buildMissingAttendanceCard(record),
              if (!isLastItem && 
                  DateUtils.isSameDay(record.date, _records[index + 1].date))
                const SizedBox(height: 8),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterDialog,
        child: const Icon(Icons.filter_list),
      ),
    );
  }

  Widget _buildMissingAttendanceCard(MissingAttendanceRecord record) {
    Color statusColor;
    switch (record.status.toLowerCase()) {
      case 'approved':
        statusColor = Colors.green;
        break;
      case 'rejected':
        statusColor = Colors.red;
        break;
      case 'pending':
      default:
        statusColor = Colors.orange;
    }

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  record.studentName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    record.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'ID: ${record.studentId}',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Reason:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              record.reason,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            if (record.status == 'Pending')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _updateStatus(record, 'Rejected'),
                    child: const Text(
                      'Reject',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _updateStatus(record, 'Approved'),
                    child: const Text('Approve'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _updateStatus(MissingAttendanceRecord record, String newStatus) {
    setState(() {
      record.status = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Status updated to $newStatus'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String selectedFilter = 'All';
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Filter Records'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    title: const Text('All Records'),
                    value: 'All',
                    groupValue: selectedFilter,
                    onChanged: (value) {
                      setState(() => selectedFilter = value.toString());
                    },
                  ),
                  RadioListTile(
                    title: const Text('Pending Only'),
                    value: 'Pending',
                    groupValue: selectedFilter,
                    onChanged: (value) {
                      setState(() => selectedFilter = value.toString());
                    },
                  ),
                  RadioListTile(
                    title: const Text('Approved Only'),
                    value: 'Approved',
                    groupValue: selectedFilter,
                    onChanged: (value) {
                      setState(() => selectedFilter = value.toString());
                    },
                  ),
                  RadioListTile(
                    title: const Text('Rejected Only'),
                    value: 'Rejected',
                    groupValue: selectedFilter,
                    onChanged: (value) {
                      setState(() => selectedFilter = value.toString());
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement filtering logic here
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Filtering by: $selectedFilter'),
                      ),
                    );
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class MissingAttendanceRecord {
  final DateTime date;
  final String studentName;
  final String studentId;
  final String reason;
  String status;

  MissingAttendanceRecord({
    required this.date,
    required this.studentName,
    required this.studentId,
    required this.reason,
    required this.status,
  });
}