import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/storage_hive_service.dart';
import 'services/storage_service.dart';
import 'data/models/task_model.dart';
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

  // setup repositories
  var taskBox = await Hive.openBox<TaskModel>("task");
  var repoTask = RepositoryTask(taskBox);

  // setup services
  var storageHiveService = StorageHiveService(repoTask);
  getIt.registerSingleton<StorageService>(StorageService(storageHiveService));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pafaze',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.grey,
          textTheme: TextTheme(
            headline1: GoogleFonts.openSans(
                fontSize: 81, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            headline2: GoogleFonts.openSans(
                fontSize: 50, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            headline3:
                GoogleFonts.openSans(fontSize: 40, fontWeight: FontWeight.w400),
            headline4: GoogleFonts.openSans(
                fontSize: 29, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headline5:
                GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.w400),
            headline6: GoogleFonts.openSans(
                fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 0.15),
            subtitle1: GoogleFonts.openSans(
                fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            subtitle2: GoogleFonts.openSans(
                fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.openSans(
                fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyText2: GoogleFonts.openSans(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            button: GoogleFonts.openSans(
                fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            caption: GoogleFonts.openSans(
                fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 0.4),
            overline: GoogleFonts.openSans(
                fontSize: 8, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          ).apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              decorationColor: Colors.white)),
      home: const HomePage(),
    );
  }
}
