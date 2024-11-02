import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/main_page.dart';

void main() {
  runApp(
    const MainApp(),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0XFFf2f2f2),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
