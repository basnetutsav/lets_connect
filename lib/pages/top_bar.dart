import 'package:flutter/material.dart';
import 'job_search.dart';
import 'inbox_chat.dart'; // DMPage & InboxPage
import 'settings.dart'; // Your separate settings page

class TopBar extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  const TopBar({super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _darkMode = widget.isDarkMode;
    _tabController = TabController(length: 2, vsync: this); // Only Home & Chat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lets Connect'),
        backgroundColor: const Color(0xFF6C88BF),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage( // Navigate to SettingsPage from settings.dart
                    toggleTheme: widget.toggleTheme,
                    isDarkMode: _darkMode,
                  ),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.chat), text: 'Chat'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const JobSearch(), // Home
          const InboxPage(), // Chat (DM inbox)
        ],
      ),
    );
  }
}

