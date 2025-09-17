import 'package:flutter/material.dart';
import 'package:vpn/dashborad.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VPN App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1C1C1E),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00C896), // teal/green accent
        ),
      ),
      home: const Dashboard(), // 👈 yahan Dashboard ko home screen bana do
    );
  }
}
