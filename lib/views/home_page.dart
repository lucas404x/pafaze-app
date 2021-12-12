import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pafaze/services/storage_service.dart';
import 'package:pafaze/viewmodels/home_viewmodel.dart';
import 'package:pafaze/views/add_task_page.dart';
import 'package:pafaze/views/edit_task_page.dart';
import 'package:pafaze/widgets/background_text.dart';
import 'package:pafaze/widgets/task_card.dart';
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
                                  image: 'assets/images/default_avatar.png'),
                              _returnPopupMenu(viewModel),
                            ],
                          ),
                          Expanded(
                              child: viewModel.tasks.isEmpty
                                  ? const Align(
                                      alignment: Alignment.center,
                                      child: BackgroundText(
                                          text:
                                              'Você não possuí nenhuma tarefa cadastrada.'),
                                    )
                                  : _returnListViewWithTasks(viewModel))
                        ],
                      ))),
              floatingActionButton: FloatingActionButton(
                  onPressed: () => viewModel.openPageAndUpdateTasksWhenComeBack(
                      context, AddTaskPage.route, null),
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.add)),
            ));
  }
}

_returnPopupMenu(HomeViewModel viewModel) {
  return PopupMenuButton<TaskSortMode>(
      onSelected: viewModel.sortTasks,
      itemBuilder: (context) => <PopupMenuEntry<TaskSortMode>>[
            const PopupMenuItem<TaskSortMode>(
              value: TaskSortMode.dateCreated,
              child: Text('Data de criação'),
            ),
            const PopupMenuItem<TaskSortMode>(
              value: TaskSortMode.dateToDelivery,
              child: Text('Data de entrega'),
            ),
            const PopupMenuItem<TaskSortMode>(
              value: TaskSortMode.ascendingTitle,
              child: Text('A-Z'),
            ),
            const PopupMenuItem<TaskSortMode>(
              value: TaskSortMode.descendingTitle,
              child: Text('Z-A'),
            )
          ]);
}

_returnListViewWithTasks(HomeViewModel viewModel) {
  return ListView.builder(
      itemCount: viewModel.tasks.length,
      itemBuilder: (context, index) {
        String taskId = viewModel.tasks[index].task.id;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onLongPress: () {
              viewModel.openPageAndUpdateTasksWhenComeBack(
                  context, EditTaskPage.route, taskId);
            },
            onTap: () => viewModel.switchExpandState(index),
            child: TaskCard(
              listTask: viewModel.tasks[index],
              onTaskDone: viewModel.onTaskDone,
              onTaskRemove: viewModel.onTaskRemove,
            ),
          ),
        );
      });
}
