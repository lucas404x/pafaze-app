import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pafaze/views/home_page.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

setup() async {
  // setup hive
  await Hive.initFlutter();
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
