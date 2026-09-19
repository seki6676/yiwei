import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const YiguaApp());
}

class YiguaApp extends StatelessWidget {
  const YiguaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '易卦排盘',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFFF4F0E6), // 经典古风宣纸底色
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}