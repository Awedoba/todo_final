import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_final/model/moor_database.dart';
import 'package:todo_final/widgets/custom_button.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final taskController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    taskController.clearComposing();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              "Add new task.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: taskController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              labelText: "Enter Task",
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                buttonText: "close",
              ),
              CustomButton(
                onPressed: () {
                  print(taskController.text);
                  if (taskController.text == "") {
                    print("please enter something");
                  } else {
                    final database =
                        Provider.of<AppDatabase>(context, listen: false);
                    final task = Todo(
                      name: taskController.text,
                    );
                    database.insertTodo(task);
                    Navigator.of(context).pop();
                  }
                },
                buttonText: "Save",
                color: Theme.of(context).accentColor,
                textcolor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
