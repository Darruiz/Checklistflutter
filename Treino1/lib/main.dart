import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.purple,
            onPrimary: Colors.white,
          ),
        ),
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatelessWidget {
  final TextEditingController _displayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.bottomRight,
            child: TextField(
              controller: _displayController,
              enabled: false,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 48.0, color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Expanded(
            child: SimpleCalculator(
              theme: const CalculatorThemeData(
                displayColor: Colors.white,
                displayStyle:
                    const TextStyle(fontSize: 48.0, color: Colors.black),
                expressionColor: Colors.white,
                expressionStyle:
                    const TextStyle(fontSize: 20.0, color: Colors.white),
                operatorColor: Colors.purple,
                operatorStyle:
                    const TextStyle(fontSize: 24.0, color: Colors.white),
                commandColor: Colors.orange,
                commandStyle:
                    const TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
