import 'package:flutter/material.dart';
import 'package:pafaze/data/models/task_model.dart';
import '../controllers/home_controller.dart';
import '../services/storage_service.dart';
import '../data/enumerators/enum_task_sort_mode.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _homeController = HomeController(getIt<StorageService>());

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 36,
                  height: 36,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        AssetImage("assets/images/default_avatar.png"),
                  ),
                ),
                PopupMenuButton<TaskSortMode>(
                    itemBuilder: (context) => <PopupMenuEntry<TaskSortMode>>[
                          const PopupMenuItem<TaskSortMode>(
                            value: TaskSortMode.date,
                            child: Text("Data"),
                          ),
                          const PopupMenuItem<TaskSortMode>(
                            value: TaskSortMode.priority,
                            child: Text("Prioridade"),
                          ),
                          const PopupMenuItem<TaskSortMode>(
                            value: TaskSortMode.ascendingTitle,
                            child: Text("A-Z"),
                          ),
                          const PopupMenuItem<TaskSortMode>(
                            value: TaskSortMode.descendingTitle,
                            child: Text("Z-A"),
                          )
                        ])
              ],
            ),
            FutureBuilder<List<TaskModel>>(
                future: _homeController.getTasks(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                          "Não conseguimos recuperar as suas tarefas! Tente novamente mais tarde."),
                    );
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                    case ConnectionState.done:
                      var tasks = snapshot.data;
                      return Expanded(child: _returnListViewWithTasks(tasks));
                    default:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                })
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

ListView _returnListViewWithTasks(List<TaskModel>? tasks) {
  return ListView.builder(
      itemCount: tasks?.length, itemBuilder: (context, index) => Container());
}
