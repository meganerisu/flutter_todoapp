import 'package:flutter/material.dart';
import 'addTaskPage.dart';

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
      home: TaskListPage(title: 'Simple To Do List'),
    );
  }
}

class Task {
  String content = "";
  DateTime? deadLine;

  Task(this.content, this.deadLine);
}

class TaskListPage extends StatefulWidget {
  TaskListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  var taskList = [
    Task("右を見る", DateTime(2021, 5, 1, 12, 00)),
    Task("右を見る", DateTime(2021, 5, 2, 12, 00)),
    Task("左を見る", DateTime(2021, 5, 1, 18, 00)),
    Task("道を渡る", null)
  ];

  void sortTaskList() {
    taskList.sort((a, b) {
      if (a.deadLine != null && b.deadLine != null) {
        return a.deadLine!.compareTo(b.deadLine!);
      } else if (a.deadLine == null && b.deadLine != null) {
        return 1; // aよりbが先に来る場合は正の値を返す
      } else {
        return 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
                sortTaskList();
                return Container(
                    child: Card(
                  child: ListTile(
                      title: Text(taskList[index].content),
                      subtitle: Text(
                        taskList[index].deadLine.toString(),
                      )),
                ));
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddTaskPage();
            }),
          );
          if (newTask != null) {
            setState(() {
              taskList.add(newTask);
              sortTaskList();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
