import 'package:flutter/material.dart';
import 'package:hive_crud/Models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final titleController = TextEditingController();
  Box todoBox = Hive.box<NotesModel>('notes');
  void addTodos() {
    if (titleController.text != '') {
      NotesModel notes =
          NotesModel(title: titleController.text, isCompleted: false);
      todoBox.add(notes);
    }
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("To do added succesfully")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListBody(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    addTodos();
                  },
                  child: const Text("Add"))
            ],
          ),
        ),
      ),
    );
  }
}
