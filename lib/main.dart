import 'package:fansphere/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'screens/demo_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
  // runApp(const BerryMusicApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // class BerryMusicApp extends StatefulWidget {
  //   const BerryMusicApp({super.key});
  //
  //   @override
  //   State<BerryMusicApp> createState() => _BerryMusicAppState();
  // }
  //
  // class _BerryMusicAppState extends State<BerryMusicApp> {
  //   @override
  //   void initState() {
  //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //     super.initState();
  //   }

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
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: 'Pretendard',
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
      // return MaterialApp(
      //   title: 'Berry Music Hub',
      //   theme: AppTheme.lightTheme,
      //   darkTheme: AppTheme.darkTheme,
      //   themeMode: ThemeMode.dark,
      //   home: const DemoScreen(),
      //   debugShowCheckedModeBanner: false,
    );
  }
}
