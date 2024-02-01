import 'package:flutter/material.dart';


void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: ThemeData(
                primaryColorLight: Colors.deepOrangeAccent,
                primaryColorDark: Colors.deepOrange
            ),
            home: Scaffold(
                appBar: AppBar(
                    title: const Text('This ebatory has been lunched',
                        style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'Impact'
                        )
                    ),
                    centerTitle: true,
                ),
                body: const Center(
                    child: Text('RUN, HE IS NEAR!!!',
                        style: TextStyle(
                            fontSize: 36,
                            fontFamily: "DeutschGothic",
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold
                        )
                    )
                ),
                floatingActionButton: FloatingActionButton(
                    onPressed: () {print('SUSCHTSCH');},
                    backgroundColor: Colors.amber,
                    child: const Text('НЕТ'),
                ),
            )
        );
    }
}
