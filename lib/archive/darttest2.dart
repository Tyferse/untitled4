// import 'dart:html';

import 'package:flutter/material.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                brightness: Brightness.light,
                /* light theme settings */
            ),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                /* dark theme settings */
            ),
            themeMode: ThemeMode.system,
            home: const MyHomePage(title: 'Flutter laba 2'),
        );
    }
}

class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key, required this.title});
    final String title;

    @override
    State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    double _celsius = 0, _fahrenheit = 0;

    void _convert() {
        setState(() {
            _fahrenheit = _celsius * 9 / 5 + 32;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.deepOrange,
                title: Center(child: Text(widget.title)),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        const Text("Temperature converter", style: TextStyle(
                            fontSize: 30)),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                        child: TextField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter temperature in Celsius',
                            ),
                            onChanged: (value) => _celsius = double.parse(value),
                        )),
                        Text('$_fahrenheit F', style: const TextStyle(fontSize: 30)),
                        FloatingActionButton.extended(
                            onPressed: _convert,
                            label: const Text('Конвертировать', style: TextStyle(fontSize: 36))
                        )
                    ]),
            ),
        );
    }
}
