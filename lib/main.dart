import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'screens/demo_screen.dart';

void main() {
  runApp(const BerryMusicApp());
}

class BerryMusicApp extends StatefulWidget {
  const BerryMusicApp({super.key});

  @override
  State<BerryMusicApp> createState() => _BerryMusicAppState();
}

class _BerryMusicAppState extends State<BerryMusicApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berry Music Hub',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const DemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
