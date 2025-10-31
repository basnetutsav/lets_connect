import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lets_connect/pages/job_search.dart';
import 'pages/login_page.dart';
import 'pages/top_bar.dart';
import 'pages/inbox_chat.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ✅ Initialize Firebase here
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Lets Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C88BF),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C88BF),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: LoginPage(
        toggleTheme: _toggleTheme,
        isDarkMode: _isDarkMode,
      ),
      routes: {
        '/top_bar': (context) => TopBar(
              toggleTheme: _toggleTheme,
              isDarkMode: _isDarkMode,
            ),
        '/job_search': (context) => const JobSearch(),
        '/chat': (context) => const InboxPage(),
      },
    );
  }
}
