import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'shop_tab.dart';
import 'orders_tab.dart';
import 'pins_tab.dart';

class InventoryIndex extends StatefulWidget {
  const InventoryIndex({super.key});

  @override
  State<InventoryIndex> createState() => _InventoryIndexState();
}

class _InventoryIndexState extends State<InventoryIndex> {
  int _currentTabIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => _showNotifications(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildTabButton(0, 'Shop'),
                _buildTabButton(1, 'My Orders'),
                _buildTabButton(2, 'My Pins'),
              ],
            ),
          ),
          
          // Main Content
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentTabIndex = index);
              },
              children: const [
                ShopTab(),
                OrdersTab(),
                PinsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String title) {
    final isSelected = _currentTabIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? const Color(0xFFEBA050) : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? const Color(0xFFEBA050) : Colors.grey.shade600,
            ),
            child: Text(title, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ..._buildNotificationItems(),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildNotificationItems() {
    return [
      _buildNotificationTile(
        title: 'Order Approved',
        message: 'Your order #12345 has been approved',
        icon: Icons.check_circle,
        color: Colors.green,
        time: '2h ago',
      ),
      _buildNotificationTile(
        title: 'New Pin Earned',
        message: 'You earned a service pin for volunteering',
        icon: Icons.star,
        color: Colors.amber,
        time: '5h ago',
      ),
      _buildNotificationTile(
        title: 'Payment Received',
        message: 'Payment for order #12346 has been received',
        icon: Icons.payment,
        color: Colors.blue,
        time: '1d ago',
      ),
    ];
  }

  Widget _buildNotificationTile({
    required String title,
    required String message,
    required IconData icon,
    required Color color,
    required String time,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message, style: TextStyle(color: Colors.grey.shade600)),
      trailing: Text(time, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
    );
  }
}