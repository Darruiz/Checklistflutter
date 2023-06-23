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

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final TextEditingController _displayController = TextEditingController();
  List<String> historico = [];

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
            child: ListView.builder(
              reverse: true,
              itemCount: historico.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    historico[index],
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                );
              },
            ),
          ),
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
            flex: 2,
            child: SimpleCalculator(
              onExpressionChanged: (expression) {
                // Atualizar o histórico de operações
                setState(() {
                  historico.insert(0, expression);
                });
              },
              theme: const CalculatorThemeData(
                displayColor: Colors.white,
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
