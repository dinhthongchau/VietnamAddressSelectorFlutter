// lib/main.dart
import 'package:flutter/material.dart';
import 'address_dropdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Vietnam Address Selector')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: AddressDropdown(),
        ),
      ),
    );
  }
}