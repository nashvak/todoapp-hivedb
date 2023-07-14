import 'package:flutter/material.dart';
import 'package:hive_crud/Screens/addTodo.dart';

import 'package:hive_crud/Models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box todoBox = Hive.box<NotesModel>('notes');

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive todo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTodo()));
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
          valueListenable: todoBox.listenable(),
          builder: (context, Box box, widget) {
            if (box.isEmpty) {
              return const Center(
                child: Text("No todo"),
              );
            } else {
              return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: box.length,
                itemBuilder: (context, index) {
                  NotesModel notes = box.getAt(index);
                  return ListTile(
                    title: Text(
                      notes.title.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: notes.isCompleted ? Colors.red : Colors.black,
                          decoration: notes.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    leading: Checkbox(
                      value: notes.isCompleted,
                      onChanged: (value) {
                        NotesModel newTodo =
                            NotesModel(title: notes.title, isCompleted: value!);
                        box.putAt(index, newTodo);
                      },
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          box.deleteAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("To do deleted succesfully")));
                        },
                        icon: const Icon(Icons.delete)),
                  );
                },
              );
            }
          }),
    );
  }
}
