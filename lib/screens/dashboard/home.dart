// // New file: dashboard_home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:desuungapp/config/theme.dart';
// import 'package:desuungapp/screens/attendance/attendance_index.dart';
// import 'package:desuungapp/screens/events/events_index.dart';

// class DashboardHomeScreen extends StatelessWidget {
//   final Function(int) onNavigate;
//   final Function(Widget, String, ActiveMenu) onNavigateToScreen;

//   const DashboardHomeScreen({
//     super.key,
//     required this.onNavigate,
//     required this.onNavigateToScreen,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;
//     final colorScheme = theme.colorScheme;

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Welcome Card
//           _buildWelcomeCard(context),
//           const SizedBox(height: 24),

//           // Quick Stats Row
//           _buildQuickStats(context),
//           const SizedBox(height: 24),

//           // Quick Actions
//           Text(
//             'Quick Actions',
//             style: theme.textTheme.titleLarge?.copyWith(
//               fontWeight: FontWeight.w600,
//               color: isDarkMode ? colorScheme.onSurface : colorScheme.primary,
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildActionGrid(context),
//           const SizedBox(height: 24),

//           // Recent Activities
//           Text(
//             'Recent Activities',
//             style: theme.textTheme.titleLarge?.copyWith(
//               fontWeight: FontWeight.w600,
//               color: isDarkMode ? colorScheme.onSurface : colorScheme.primary,
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildRecentActivities(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildWelcomeCard(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;
//     final colorScheme = theme.colorScheme;

//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(
//           color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
//           width: 1,
//         ),
//       ),
//       color: isDarkMode ? colorScheme.surface : colorScheme.background,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             Container(
//               width: 60,
//               height: 60,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   colors: [
//                     colorScheme.primary.withOpacity(0.1),
//                     colorScheme.primary.withOpacity(0.2),
//                   ],
//                 ),
//               ),
//               child: Icon(
//                 Icons.person,
//                 size: 30,
//                 color: colorScheme.primary,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Welcome back,',
//                     style: theme.textTheme.bodyLarge?.copyWith(
//                       color: isDarkMode 
//                           ? colorScheme.onSurface.withOpacity(0.8)
//                           : colorScheme.onBackground.withOpacity(0.6),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'De-suung Member',
//                     style: theme.textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: isDarkMode 
//                           ? colorScheme.onSurface 
//                           : colorScheme.onBackground,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickStats(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;

//     return SizedBox(
//       height: 100,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           _buildStatItem(
//             context,
//             value: '24',
//             label: 'Present Days',
//             icon: Icons.check_circle,
//             color: Colors.green,
//           ),
//           const SizedBox(width: 12),
//           _buildStatItem(
//             context,
//             value: '2',
//             label: 'Absent Days',
//             icon: Icons.cancel,
//             color: Colors.red,
//           ),
//           const SizedBox(width: 12),
//           _buildStatItem(
//             context,
//             value: '92%',
//             label: 'Attendance',
//             icon: Icons.bar_chart,
//             color: Colors.blue,
//           ),
//           const SizedBox(width: 12),
//           _buildStatItem(
//             context,
//             value: '5',
//             label: 'Events',
//             icon: Icons.event,
//             color: Colors.orange,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatItem(
//     BuildContext context, {
//     required String value,
//     required String label,
//     required IconData icon,
//     required Color color,
//   }) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;

//     return Container(
//       width: 120,
//       decoration: BoxDecoration(
//         color: isDarkMode ? Colors.grey[800] : Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           if (!isDarkMode)
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               blurRadius: 6,
//               spreadRadius: 1,
//               offset: const Offset(0, 2),
//             ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               children: [
//                 Icon(icon, size: 16, color: color),
//                 const SizedBox(width: 4),
//                 Text(
//                   value,
//                   style: theme.textTheme.titleLarge?.copyWith(
//                     fontWeight: FontWeight.w700,
//                     color: color,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               style: theme.textTheme.bodySmall?.copyWith(
//                 color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActionGrid(BuildContext context) {
//     return GridView.count(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       crossAxisSpacing: 12,
//       mainAxisSpacing: 12,
//       childAspectRatio: 1.2,
//       children: [
//         _buildActionButton(
//           context,
//           icon: Icons.calendar_today,
//           label: 'Attendance',
//           color: Colors.blue,
//           onTap: () => onNavigateToScreen(
//             const AttendanceIndexScreen(),
//             'Attendance',
//             ActiveMenu.attendance,
//           ),
//         ),
//         _buildActionButton(
//           context,
//           icon: Icons.event,
//           label: 'Events',
//           color: Colors.green,
//           onTap: () => onNavigateToScreen(
//             const EventsIndex(),
//             'Events',
//             ActiveMenu.events,
//           ),
//         ),
//         _buildActionButton(
//           context,
//           icon: Icons.school,
//           label: 'Training',
//           color: Colors.orange,
//           onTap: () => onNavigateToScreen(
//             const AttendanceScreen(),
//             'Skilling Program',
//             ActiveMenu.skillingProgram,
//           ),
//         ),
//         _buildActionButton(
//           context,
//           icon: Icons.announcement,
//           label: 'Announcements',
//           color: Colors.purple,
//           onTap: () => onNavigate(1),
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButton(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;

//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       color: isDarkMode ? Colors.grey[800] : Colors.white,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(icon, color: color),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 label,
//                 style: theme.textTheme.titleSmall?.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRecentActivities(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;

//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       color: isDarkMode ? Colors.grey[800] : Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildActivityItem(
//               icon: Icons.event_available,
//               title: 'Attended Cleanup Program',
//               subtitle: 'Yesterday, 10:00 AM',
//               color: Colors.green,
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 8),
//               child: Divider(height: 1),
//             ),
//             _buildActivityItem(
//               icon: Icons.notifications,
//               title: 'New Announcement',
//               subtitle: '2 days ago',
//               color: Colors.blue,
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 8),
//               child: Divider(height: 1),
//             ),
//             _buildActivityItem(
//               icon: Icons.school,
//               title: 'Completed Training',
//               subtitle: '1 week ago',
//               color: Colors.orange,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActivityItem({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//   }) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           shape: BoxShape.circle,
//         ),
//         child: Icon(icon, size: 20, color: color),
//       ),
//       title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
//       subtitle: Text(subtitle),
//     );
//   }
// }