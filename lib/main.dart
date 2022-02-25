import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/provider/current_video.dart';
import 'package:youtube_clone/provider/miniplayer_provider.dart';
import 'package:youtube_clone/screen/nav_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentVideo(),
        ),
        ChangeNotifierProvider(
          create: (context) => MiniplayerProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter YouTube UI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: Colors.white),
        ),
        home: const NavScreen(),
      ),
    );
  }
}
