import 'package:flutter/material.dart';
import '../login.dart';

void main() {
  runApp(const RampCheckApp());
}

class RampCheckApp extends StatelessWidget {
  const RampCheckApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramp Check Prototype',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 194, 29, 17)),
        primaryColor: const Color.fromARGB(255, 194, 29, 17)
      ),
      home: const LoginPage(title: 'Login Page'),
    );
  }
}



