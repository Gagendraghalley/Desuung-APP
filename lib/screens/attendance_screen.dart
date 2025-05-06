import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/theme.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class DailyAttendance {
  final DateTime date;
  final String status;

  DailyAttendance({required this.date, required this.status});
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<DailyAttendance> _dailyAttendances = [
    DailyAttendance(date: DateTime(2023, 12, 20), status: "Present"),
    DailyAttendance(date: DateTime(2023, 12, 21), status: "Absent"),
    DailyAttendance(date: DateTime(2023, 12, 22), status: "Present"),
    DailyAttendance(date: DateTime(2023, 12, 23), status: "Present"),
    DailyAttendance(date: DateTime(2023, 12, 24), status: "Absent"),
    DailyAttendance(date: DateTime(2023, 12, 25), status: "Present"),
    DailyAttendance(date: DateTime(2023, 12, 26), status: "Present"),
    DailyAttendance(date: DateTime(2023, 12, 27), status: "Absent"),
    DailyAttendance(date: DateTime(2023, 12, 28), status: "Present"),
    DailyAttendance(date: DateTime(2023, 12, 29), status: "Present"),
    DailyAttendance(date: DateTime(2023, 12, 30), status: "Absent"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Attendance"),
      ),
      body: ListView.builder(
        itemCount: _dailyAttendances.length,
        itemBuilder: (context, index) {
          return _buildAttendanceCard(_dailyAttendances[index]);
        },
      ),
    );
  }

  Widget _buildAttendanceCard(DailyAttendance attendance) {
    final formattedDate = DateFormat('dd MMMM yyyy').format(attendance.date);
    Color statusColor = attendance.status == "Present"
        ? Colors.green
        : attendance.status == "Absent"
            ? Colors.red
            : Colors.grey;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkTextColor),
              ),
              Text(attendance.status,
                  style: TextStyle(fontSize: 16, color: statusColor)),
            ],
          ),
        ),
      ),
    );
  }
}