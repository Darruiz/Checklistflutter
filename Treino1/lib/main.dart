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
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.purple,
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
            child: Text(
              '0',
              style: TextStyle(fontSize: 48.0, color: Colors.white),
            ),
          ),
          Expanded(
            child: SimpleCalculator(
              theme: const CalculatorThemeData(
                displayColor: Colors.black,
                displayStyle:
                    const TextStyle(fontSize: 48.0, color: Colors.white),
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
