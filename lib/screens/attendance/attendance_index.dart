import 'package:desuungapp/screens/attendance/attendance_missing_inquiry.dart';
import 'package:desuungapp/screens/attendance/attendance_missing_screen.dart';
import 'package:flutter/material.dart';
import 'package:desuungapp/screens/attendance/attendance_screen.dart';
import 'package:desuungapp/screens/attendance/attendance_view.dart';

class AttendanceIndexScreen extends StatelessWidget {
  const AttendanceIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLargeScreen = MediaQuery.of(context).size.width > 600;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 32.0 : 20.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage attendance with ease',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 32),

              // Hearts Status Section
              _buildHeartsStatus(context),
              const SizedBox(height: 32),

              // Quick Actions Title
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Action Cards
              _buildActionCard(
                context,
                icon: Icons.edit_calendar_rounded,
                title: 'Take Attendance',
                subtitle: 'Record new attendance entries',
                color: const Color(0xFF6A11CB),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AttendanceScreen()),
                ),
              ),
              const SizedBox(height: 16),
              _buildActionCard(
                context,
                icon: Icons.history_rounded,
                title: 'View Records',
                subtitle: 'Check past attendance logs',
                color: const Color(0xFF2575FC),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AttendanceViewScreen()),
                ),
              ),
              const SizedBox(height: 16),
              _buildActionCard(
                context,
                icon: Icons.report_problem_rounded,
                title: 'Submit Inquiry',
                subtitle: 'Report attendance issues before bay ends',
                color: const Color(0xFFFF6B6B),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AttendanceMissingInquiryScreen()),
                ),
              ),
              const SizedBox(height: 16),
              _buildActionCard(
                context,
                icon: Icons.mark_email_unread_rounded,
                title: 'Missed Attendance Inquiries',
                subtitle: 'View and respond to attendance inquiries',
                color: const Color(0xFF4CAF50),
                  onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AttendanceMissingScreen()),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeartsStatus(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hearts Status',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeartStatusItem(
                icon: Icons.favorite,
                color: Colors.red,
                value: '85',
                label: 'Your Hearts',
              ),
              _buildHeartStatusItem(
                icon: Icons.people,
                color: Colors.blue,
                value: '92',
                label: 'Unit Average',
              ),
              _buildHeartStatusItem(
                icon: Icons.emoji_events,
                color: Colors.amber,
                value: '1st',
                label: 'Rank',
              ),
            ],
          ),
          SizedBox(height: 12),
          LinearProgressIndicator(
            value: 0.85,
            backgroundColor: Colors.grey[200],
            color: Colors.red[400],
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Heart Points Progress',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '85/100',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeartStatusItem({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 28,
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey[500],
              ),
            ],
          ),
        ),
      ),
    );
  }
}