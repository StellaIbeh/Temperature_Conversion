import 'package:flutter/material.dart';

void main() => runApp(TempConverterApp());

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.blueGrey.shade50,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Background color
            foregroundColor: Colors.white, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
            ),
          ),
        ),
      ),
      home: TempConverterHomePage(),
    );
  }
}

class TempConverterHomePage extends StatefulWidget {
  @override
  _TempConverterHomePageState createState() => _TempConverterHomePageState();
}

class _TempConverterHomePageState extends State<TempConverterHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedConversion = 'F to C';
  String _result = '';
  List<String> _history = [];

  void _convertTemperature() {
    double inputTemp = double.tryParse(_controller.text) ?? 0.0;
    double convertedTemp;
    String unit;

    if (_selectedConversion == 'F to C') {
      convertedTemp = (inputTemp - 32) * 5 / 9;
      unit = '°C';
    } else {
      convertedTemp = (inputTemp * 9 / 5) + 32;
      unit = '°F';
    }

    setState(() {
      _result = '${convertedTemp.toStringAsFixed(2)} $unit';
      _history.add('$_selectedConversion: ${inputTemp.toStringAsFixed(1)} => $_result');
    });
  }

  void _showHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Conversion History'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_history[index]),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Temperature',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio<String>(
                      value: 'F to C',
                      groupValue: _selectedConversion,
                      onChanged: (value) {
                        setState(() {
                          _selectedConversion = value!;
                        });
                      },
                    ),
                    Text('F to C'),
                    Radio<String>(
                      value: 'C to F',
                      groupValue: _selectedConversion,
                      onChanged: (value) {
                        setState(() {
                          _selectedConversion = value!;
                        });
                      },
                    ),
                    Text('C to F'),
                  ],
                ),
                ElevatedButton(
                  onPressed: _convertTemperature,
                  child: Text('Convert'),
                ),
                SizedBox(height: 20),
                Text(
                  'Result: $_result',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _showHistory,
                  child: Text('Show History'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}