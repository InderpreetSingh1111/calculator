import 'package:calculator/calculator/calculatorpage.dart';
import 'package:calculator/calculator/page1.dart';
import 'package:calculator/calculator/page2.dart';
import 'package:calculator/calculator/page3.dart';
import 'package:calculator/calculator/page4.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Page4(),
    );
  }
}
