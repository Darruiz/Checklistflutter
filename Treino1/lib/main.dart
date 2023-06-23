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
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 0, 0, 0),
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: TextField(
                controller: _displayController,
                enabled: false,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 48.0, color: const Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SimpleCalculator(
              theme: const CalculatorThemeData(
                displayColor: Color.fromARGB(255, 0, 0, 0),
                displayStyle: const TextStyle(
                    fontSize: 48.0, color: Color.fromARGB(255, 255, 255, 255)),
                expressionColor: Colors.white,
                expressionStyle: const TextStyle(
                    fontSize: 20.0, color: Color.fromARGB(255, 0, 0, 0)),
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
