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

class ToDoListPage extends StatefulWidget {
  ToDoListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  var todoArray = ["右を見る", "左を見る", "右を見る", "道を渡る"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: todoArray.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Card(
                  child: ListTile(
                    title: Text(todoArray[index]),
                  ),
                ));
              })),
    );
  }
}
