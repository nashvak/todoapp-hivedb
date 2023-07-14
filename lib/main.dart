import 'dart:io'; //for Directory

import 'package:flutter/material.dart';
import 'package:hive_crud/Screens/homescreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'Models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  //registering adapter
  Hive.registerAdapter(NotesModelAdapter());

  await Hive.openBox<NotesModel>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      title: 'Notes using hive',
      home: const HomeScreen(),
    );
  }
}
