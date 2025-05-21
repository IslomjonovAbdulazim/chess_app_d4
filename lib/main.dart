import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class TodoModel {
  late String title;
  late DateTime createdAt;
  late DateTime? finishedAt;
  late bool isFinished;

  TodoModel({
    required this.title,
    required this.createdAt,
    required this.finishedAt,
    required this.isFinished,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> todos = [];
  final controller = TextEditingController();
  int completedTodos = 0;
  int notFinishedTodos = 0;
  final key = GlobalKey<FormState>();

  void createTodo() {
    final input = controller.text.trim();
    final now = DateTime.now();
    final model = TodoModel(
      title: input,
      createdAt: now,
      finishedAt: null,
      isFinished: false,
    );
    todos.add(model);
    todos.sort((a, b) => a.title.compareTo(b.title));
    notFinishedTodos++;
    setState(() {});
  }

  void finishTodo(TodoModel todo) {
    if (todo.isFinished) {
      todo.isFinished = false;
      todo.finishedAt = null;
      completedTodos--;
      notFinishedTodos++;
    } else {
      todo.isFinished = true;
      todo.finishedAt = DateTime.now();
      completedTodos++;
      notFinishedTodos--;
    }
    todos.removeWhere((model) => model.createdAt == todo.createdAt);
    todos.add(todo);
    todos.sort((a, b) => a.title.compareTo(b.title));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: key,
            child: Column(
              children: [
                // Length Of All Todos
                // 1. Completed, 2. Not Finished (Count)

                Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final model = todos[index];
                      return ListTile(
                        // created at AND finished at
                        title: Text(model.title),
                        subtitle: Text(
                          DateFormat.Hms().format(model.createdAt),
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        ),
                        trailing: Column(
                          children: [
                            SizedBox(
                              height: 30,
                              child: Checkbox(
                                value: model.isFinished,
                                onChanged: (value) {
                                  finishTodo(model);
                                },
                              ),
                            ),
                            model.finishedAt == null
                                ? SizedBox()
                                : Text(DateFormat.Hms().format(model.finishedAt!)),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "Todo...",
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: createTodo,
                      child: Text("Save"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
