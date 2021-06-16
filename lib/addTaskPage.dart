import 'package:flutter/material.dart';
import 'package:flutter_todoapp/main.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  Task newTask = Task("", null);
  DateTime? deadLineDate;
  TimeOfDay? deadLineTime;
  DateTime? deadLineDateTime;

  DateTime setDeadLine(d, t) {
    return DateTime(d.year, d.month, d.day, t.hour, t.minute);
  }

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
                  newTask.content = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(deadLineDateTime.toString()),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  final DateTime? _pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 5));

                  setState(() {
                    deadLineDate = _pickedDate;
                    deadLineDateTime = _pickedDate;
                  });
                },
                child: Text("Set Date")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? _pickedTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (deadLineDate != null) {
                    setState(() {
                      deadLineTime = _pickedTime;
                      deadLineDateTime =
                          setDeadLine(deadLineDate, deadLineTime);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Set date of deadline before setting time"),
                      action: SnackBarAction(
                        label: "Close",
                        onPressed: () {},
                      ),
                    ));
                  }
                },
                child: Text("Set Time")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  newTask.deadLine = deadLineDateTime;
                  Navigator.of(context).pop(newTask);
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
