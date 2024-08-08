import 'package:flutter/material.dart';
import 'package:solid_chat/ui/screen/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactsScreen(),
    );
  }
}
