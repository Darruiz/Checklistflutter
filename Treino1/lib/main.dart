import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:math_expressions/math_expressions.dart';

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

  void adicionarOperacao(String operacao) {
    setState(() {
      historico.insert(0, operacao);
    });
  }

  void calcularExpressao() {
    String expressao = _displayController.text;
    Parser p = Parser();
    Expression exp = p.parse(expressao);
    ContextModel cm = ContextModel();
    double resultado = exp.evaluate(EvaluationType.REAL, cm);

    String operacaoComResultado = "$expressao = $resultado";
    adicionarOperacao(operacaoComResultado);
  }

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
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: historico
                      .map(
                        (expression) => Text(
                          expression,
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      )
                      .toList(),
                ),
              ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: calcularExpressao,
                child: Text('='),
              ),
              SimpleCalculator(
                controller: _displayController,
                theme: const CalculatorThemeData(
                  displayColor: Colors.white,
                  displayStyle: TextStyle(fontSize: 48.0, color: Colors.black),
                  expressionColor: Colors.white,
                  expressionStyle:
                      TextStyle(fontSize: 20.0, color: Colors.white),
                  operatorColor: Colors.purple,
                  operatorStyle: TextStyle(fontSize: 24.0, color: Colors.white),
                  commandColor: Colors.orange,
                  commandStyle: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
