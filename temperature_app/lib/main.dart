import 'package:flutter/material.dart';

void main() => runApp(TempConverterApp());

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convert Temperature',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TempConverterHome(),
    );
  }
}

class TempConverterHome extends StatefulWidget {
  @override
  _TempConverterHomeState createState() => _TempConverterHomeState();
}

class _TempConverterHomeState extends State<TempConverterHome> {
  final TextEditingController _controller = TextEditingController();
  bool _isCelsiusToFahrenheit = true;
  String _result = '';
  List<String> _history = [];

  void _convert() {
    double inputTemp = double.tryParse(_controller.text) ?? 0.0;
    double convertedTemp;

    if (_isCelsiusToFahrenheit) {
      convertedTemp = inputTemp * 9 / 5 + 32;
    } else {
      convertedTemp = (inputTemp - 32) * 5 / 9;
    }

    setState(() {
      _result = convertedTemp.toStringAsFixed(2);
      _history.add('${_controller.text}° ${_isCelsiusToFahrenheit ? 'C' : 'F'} = $_result° ${_isCelsiusToFahrenheit ? 'F' : 'C'}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Convert Temperature')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Celsius to Fahrenheit'),
                Switch(
                  value: !_isCelsiusToFahrenheit,
                  onChanged: (value) {
                    setState(() {
                      _isCelsiusToFahrenheit = !value;
                    });
                  },
                ),
                Text('Fahrenheit to Celsius'),
              ],
            ),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _result.isEmpty ? '' : 'Converted Temperature: $_result',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}