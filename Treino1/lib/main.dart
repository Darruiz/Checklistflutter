import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int _selectedIndex = 0;
  String _display = '';
  double _result = 0;
  List<String> _historico = [];

  @override
  void initState() {
    super.initState();
    _loadHistorico();
  }

  void _loadHistorico() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? historico = prefs.getStringList('historico');
    setState(() {
      _historico = historico ?? [];
    });
  }

  void _saveHistorico() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('historico', _historico);
  }

  void _addToDisplay(String value) {
    setState(() {
      _display += value;
    });
  }

  void _calculateResult() {
    setState(() {
      try {
        Parser p = Parser();
        Expression exp = p.parse(_display);
        ContextModel cm = ContextModel();
        _result = exp.evaluate(EvaluationType.REAL, cm);
        _display = _result.toString();
        String calculation = '$_display = $_result';
        _historico.add(calculation);
        _saveHistorico();
      } catch (e) {
        _display = 'Erro';
      }
    });
  }

  void _clearDisplay() {
    setState(() {
      _display = '';
      _result = 0;
    });
  }

  void _onNavbarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _clearHistorico() {
    setState(() {
      _historico.clear();
      _saveHistorico();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = [
      Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _display,
                style: TextStyle(fontSize: 32.0),
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _clearDisplay,
            child: Text('Limpar'),
          ),
        ],
      ),
      ListView.builder(
        itemCount: _historico.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              _historico[index],
              style: TextStyle(fontSize: 18.0),
            ),
          );
        },
      ),
      Container(
        color: Colors.orangeAccent,
        child: Center(
          child: ElevatedButton(
            onPressed: _clearHistorico,
            child: Text('Excluir Histórico'),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
        centerTitle: true,
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculadora',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavbarItemTapped,
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () {
            if (text == '=') {
              _calculateResult();
            } else {
              _addToDisplay(text);
            }
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
