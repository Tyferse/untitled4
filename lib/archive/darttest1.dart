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
            home: const MyHomePage(title: 'Flutter laba 1'),
        );
        // return Text('kek', style: TextStyle(color: Colors.lightGreenAccent));
    }
    // Center()
    // Column()
    // Row()
}

class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key, required this.title});
    final String title;

    @override
    State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    int _counter = 0;

    void _increment_counter() {
        setState(() {
            _counter += 1;
        });
    }

    void _decrement_counter() {
        setState(() {
            _counter -= 1;
        });
    }

    @override
    Widget build(BuildContext context) {
        // This method is rerun every time setState is called, for instance as done
        // by the _incrementCounter method above.
        //
        // The Flutter framework has been optimized to make rerunning build methods
        // fast, so that you can just rebuild anything that needs updating rather
        // than having to individually change instances of widgets.
        return Scaffold(
            appBar: AppBar(
                // TRY THIS: Try changing the color here to a specific color (to
                // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
                // change color while the other colors stay the same.
                backgroundColor: Colors.deepOrange, //.colorScheme.inversePrimary,
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Center(child: Text(widget.title)),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        const Text("Sample text over the ButtOn", style: TextStyle(
                            fontSize: 30)),
                        Text('$_counter', style: const TextStyle(fontSize: 30)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Padding(padding: const EdgeInsets.only(right: 80),
                                    child: FloatingActionButton(
                                        onPressed: _increment_counter,
                                        child: const Icon(Icons.plus_one, size: 40)
                                    // label: Text(
                                    //     "+", style: TextStyle(fontSize: 45)
                                    // )
                                )),
                                FloatingActionButton(
                                    onPressed: _decrement_counter,
                                    child: const Icon(Icons.exposure_minus_1, size: 40)
                                    // label: Text(
                                    //     "+", style: TextStyle(fontSize: 45)
                                    // )
                                ),
                            ]
                        )
                    ]),
            ),
            // floatingActionButton: FloatingActionButton(
            //     onPressed: _increment_counter,
            //     child: const Icon(Icons.plus_one, size: 40)
            // ),
        );
    }
}
