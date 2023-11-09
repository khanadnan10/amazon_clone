import 'package:amazon_clone/feature/auth/screens/auth_screens.dart';
import 'package:amazon_clone/route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      title: 'Amazon clone',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}
