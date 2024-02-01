import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB();
      return _database!;
    }
  }

  Future<Database> _initDB() async {
    // var databasesPath = await getDatabasesPath();
    // var path = join(databasesPath, "lib/pages/todo.sqlite");
    //
    // // Удаляем старую базу данных
    // await deleteDatabase(path);

    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, "lib/pages/todo.sqlite");
    // await deleteDatabase(path);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // print(await db.query('todo'));
    // print('how to do that');

    // await db.execute("DROP TABLE IF EXISTS todo");
    await db.execute("CREATE TABLE IF NOT EXISTS todo("
        "id INTEGER PRIMARY KEY, "
        "desc TEXT, "
        "done INTEGER)");
  }

  Future<int> insertTodo(String desc) async {
    Database db = await getDatabase();
    return await db.insert('todo', {'desc': desc, 'done': 0});
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    Database db = await getDatabase();
    // print(await db.query('todo'));
    return await db.query('todo');
  }

  // Future<List<String>> getTodos() async {
  //   Database db = await getDatabase();
  //   List<Map<String, dynamic>> todos = await db.query('todo');
  //   return todos.map((todo) => todo['desc'] as String).toList();
  // }

  Future<int> updateTodo(int newID, String newDesc, int newDone) async {
    Database db = await getDatabase();
    return await db.update(
      'todo',
      {'desc': newDesc, 'done': newDone},
      where: 'id = ?',
      whereArgs: [newID],
    );
  }

  Future<int> deleteTodo(int id) async {
    Database db = await getDatabase();
    return await db.delete('todo', where: 'id = ?', whereArgs: [id]);
  }
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  List<Map<String, dynamic>> todoList = [];

  @override
  void initState() {
    super.initState();
    DBHelper.instance.getTodos().then((todos) {
      setState(() {
        todoList.addAll(todos);
      });
      // print(todoList);
    });

    // todoList.addAll(["Сущ", "Сущ", "Сущ", "Сущ", "Есть одна СУЩественная проблема"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text('ТУДУ ЛИСТ'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 3.0),
              child: CheckboxListTile(
              title: Text(
                todoList[index]['desc'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  decoration: todoList[index]['done'] != 0
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              tileColor: todoList[index]['done'] == 0 ? Colors.blue[100] : Colors.blueGrey[100],
              shape: RoundedRectangleBorder( // установите желаемую форму границ
                borderRadius: BorderRadius.circular(17.5),
                side: BorderSide(color: Colors.blueAccent.shade100, width: 2.5), // установите желаемую толщину и цвет границы
              ),
              value: todoList[index]['done'] != 0,
              onChanged: (bool? value) async {
                int doneValue = value! ? 1 : 0;
                await DBHelper.instance.updateTodo(
                    todoList[index]['id'], todoList[index]['desc'], doneValue
                ); // Вызываем метод для обновления записи в базе данных

                List<Map<String, dynamic>> refreshedTodos = await DBHelper.instance.getTodos();
                setState(() {
                  todoList = refreshedTodos;
                });
              },
              secondary: IconButton(
                icon: const Icon(Icons.delete_forever),
                color: Colors.red,
                onPressed: () async {
                  // DBHelper.instance.deleteTodo(todoList[index]['desc']);
                  // setState(() {
                  //   DBHelper.instance.deleteTodo(todoList[index]['desc']);
                  //   todoList.removeAt(index);
                  // });
                  await DBHelper.instance.deleteTodo(todoList[index]['id']);
                  List<Map<String, dynamic>> refreshedTodos = await DBHelper.instance.getTodos();
                  setState(() {
                    todoList = refreshedTodos;
                  });
                },
              ),
            ));
            // return Dismissible(
            //     key: Key(todoList[index]),
            //     child: Card(
            //       child: ListTile(
            //           title: Text(
            //             todoList[index],
            //             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            //           ),
            //         trailing: IconButton(
            //           icon: const Icon(Icons.delete_forever),
            //           color: Colors.red,
            //           onPressed: () {
            //             DBHelper.instance.deleteTodo(todoList[index]);
            //
            //             setState(() {
            //               todoList.removeAt(index);
            //             });
            //           },
            //         ),
            //       )
            //     ),
            //   onDismissed: (dir) {
            //       if (dir == DismissDirection.startToEnd) {
            //         DBHelper.instance.deleteTodo(todoList[index]);
            //
            //         setState(() {
            //           todoList.removeAt(index);
            //         });
            //       }
            //   },
            // );
          },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String _user_entry = ''; // Объявляем _user_entry здесь
              bool _show_error = false; // Добавляем состояние _show_error для AlertDialog
              return AlertDialog(
                    title: const Text('Добавить заметку в список'),
                    content: TextField(
                      controller: TextEditingController(),
                      onChanged: (String value) {
                        setState(() {
                          _user_entry = value;
                          _show_error = _user_entry.isEmpty; // Обновляем состояние ошибки в соответствии с вводом
                        });
                      },
                      keyboardType: TextInputType.multiline, // установите многострочный ввод
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Введите заметку',
                        errorText: _show_error ? 'Запрещено добавлять пустые заметки' : null,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_user_entry.isNotEmpty) {
                            await DBHelper.instance.insertTodo(_user_entry);
                            List<Map<String, dynamic>> refreshedTodos = await DBHelper.instance.getTodos();
                            setState(() {
                              todoList = refreshedTodos;
                              _user_entry = '';
                              _show_error = true;
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Добавить'),
                      ),
                    ],
                  );
                },
          );
        },
        backgroundColor: Colors.deepOrange[400],
        child: Icon(Icons.add, size: 48, weight: 900, color: Colors.green[100]),
      ),
    );
  }
}
