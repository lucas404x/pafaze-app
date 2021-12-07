import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/models/task_model.dart';
import 'data/repositories/repository_interface.dart';
import 'data/repositories/repository_task.dart';

import 'views/home_page.dart';

final getIt = GetIt.instance;

void main() async {
  await setup();
  runApp(const MyApp());
}

setup() async {
  // setup hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());

  // setup get_it
  var taskBox = await Hive.openBox<TaskModel>("task");
  getIt.registerSingleton<IRepository>(RepositoryTask(taskBox));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pafaze',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
