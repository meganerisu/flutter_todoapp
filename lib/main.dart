import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple To Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListPage(title: 'Simple To Do List'),
    );
  }
}

class Task {
  String content = "";
  DateTime? deadLine;

  Task(this.content, this.deadLine);
}

class ToDoListPage extends StatefulWidget {
  ToDoListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  var todoList = [
    Task("右を見る", DateTime(2021, 5, 1, 12, 00)),
    Task("右を見る", DateTime(2021, 5, 2, 12, 00)),
    Task("左を見る", DateTime(2021, 5, 1, 18, 00)),
    Task("道を渡る", null)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (BuildContext context, int index) {
                todoList.sort((a, b) {
                  if (a.deadLine != null && b.deadLine != null) {
                    return a.deadLine!.compareTo(b.deadLine!);
                  } else {
                    return 0;
                  }
                });
                return Container(
                    child: Card(
                  child: ListTile(
                      title: Text(todoList[index].content),
                      subtitle: Text(
                        todoList[index].deadLine.toString(),
                      )),
                ));
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ToDoAddPage();
            }),
          );
          if (newListText != null) {
            setState(() {
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ToDoAddPage extends StatefulWidget {
  @override
  _ToDoAddPageState createState() => _ToDoAddPageState();
}

class _ToDoAddPageState extends State<ToDoAddPage> {
  String _taskText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "What do I have to do?"),
              onChanged: (String value) {
                setState(() {
                  _taskText = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_taskText);
                },
                child: Text("Add Task")),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"))
          ],
        ),
      ),
    );
  }
}
