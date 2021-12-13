import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pafaze/data/enumerators/enum_task_delivery_state.dart';
import 'package:pafaze/data/models/alarm_model.dart';
import 'package:pafaze/services/alarm_service.dart';
import 'package:pafaze/services/task_service.dart';

import 'data/models/task_model.dart';
import 'data/repositories/hive_repository.dart';
import 'services/storage_service.dart';
import 'views/add_task_page.dart';
import 'views/edit_task_page.dart';
import 'views/home_page.dart';

final getIt = GetIt.instance;

void main() async {
  await setup();
  runApp(const MyApp());
}

setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setup AlarmManager
  await AndroidAlarmManager.initialize();

  // setup app locale
  await initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';

  // setup hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(AlarmModelAdapter());
  Hive.registerAdapter(TaskDeliveryStateAdapter());

  // setup repositories
  var taskBox = await Hive.openBox<TaskModel>('task');
  var alarmBox = await Hive.openBox<AlarmModel>('alarm');

  // setup repositories
  var taskLocalSource = HiveRepository<TaskModel>(taskBox);
  var alarmLocalSource = HiveRepository<AlarmModel>(alarmBox);

  // setup services
  var storageService = StorageService(taskLocalSource, alarmLocalSource);
  var alarmService = AlarmManagerService();
  var taskService = TaskService(storageService, alarmService);

  // register services in get_it
  getIt.registerSingleton<TaskService>(taskService);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pafaze',
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.route,
      routes: {
        HomePage.route: (context) => const HomePage(),
        AddTaskPage.route: (context) => const AddTaskPage(),
        EditTaskPage.route: (context) => const EditTaskPage()
      },
      theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: const Color(0xFFF9F9F9),
          splashColor: Colors.blue,
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
          )),
    );
  }
}
