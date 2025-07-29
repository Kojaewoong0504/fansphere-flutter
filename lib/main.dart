import 'package:fansphere/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'screens/demo_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(const FanSphereApp());
}

class FanSphereApp extends StatefulWidget {
  const FanSphereApp({super.key});

  @override
  State<FanSphereApp> createState() => _FanSphereAppState();
}

class _FanSphereAppState extends State<FanSphereApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider()..initialize(),
        ),
      ],
      child: MaterialApp.router(
        title: 'FanSphere',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        routerConfig: router,
      ),
    );
  }
}
