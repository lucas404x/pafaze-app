import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pafaze/data/models/task_model.dart';
import 'package:pafaze/services/storage_service.dart';
import 'package:pafaze/viewmodels/home_viewmodel.dart';
import 'package:pafaze/views/add_task_page.dart';
import 'package:pafaze/widgets/background_text.dart';
import 'package:pafaze/widgets/user_profile.dart';
import 'package:stacked/stacked.dart';
import '../data/enumerators/enum_task_sort_mode.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(GetIt.I.get<StorageService>()),
        onModelReady: (viewModel) => viewModel.updateTasks(),
        builder: (context, viewModel, child) => Scaffold(
              body: SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const UserProfile(
                                  image: "assets/images/default_avatar.png"),
                              PopupMenuButton<TaskSortMode>(
                                  itemBuilder: (context) =>
                                      <PopupMenuEntry<TaskSortMode>>[
                                        const PopupMenuItem<TaskSortMode>(
                                          value: TaskSortMode.dateCreated,
                                          child: Text("Data de criação"),
                                        ),
                                        const PopupMenuItem<TaskSortMode>(
                                          value: TaskSortMode.dateToDelivery,
                                          child: Text("Data de entrega"),
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
                          Expanded(
                              child: viewModel.tasks.isEmpty
                                  ? const Align(
                                      alignment: Alignment.center,
                                      child: BackgroundText(
                                          text:
                                              "Você não possuí nenhuma tarefa cadastrada."),
                                    )
                                  : ListView.builder(
                                      itemCount: viewModel.tasks.length,
                                      itemBuilder: (context, index) => Center(
                                            child: Text(
                                                viewModel.tasks[index].title),
                                          )))
                        ],
                      ))),
              floatingActionButton: FloatingActionButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AddTaskPage.route, arguments: TaskModel()),
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.add)),
            ));
  }
}
