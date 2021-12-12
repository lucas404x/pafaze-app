import 'package:flutter/material.dart';

import '../data/models/list_task_model.dart';

class TaskCard extends StatelessWidget {
  final ListTaskModel listTask;
  final Function(ListTaskModel) onTaskDone;
  final Function(ListTaskModel) onTaskRemove;

  const TaskCard(
      {Key? key,
      required this.listTask,
      required this.onTaskDone,
      required this.onTaskRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.1),
                blurRadius: 20,
                offset: const Offset(0, 5))
          ]),
      child: Column(
        children: [
          _renderTexts(listTask),
          listTask.expand
              ? const SizedBox(
                  height: 24,
                )
              : Container(),
          listTask.expand
              ? _renderButtons(context, listTask, onTaskDone, onTaskRemove)
              : Container()
        ],
      ),
    );
  }
}

_renderTexts(ListTaskModel listTask) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        listTask.task.title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        listTask.task.description,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    ],
  );
}

_renderButtons(BuildContext context, ListTaskModel task,
    Function(ListTaskModel) onTaskDone, Function(ListTaskModel) onTaskRemove) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
          onPressed: () => onTaskRemove(task),
          icon: Icon(
            Icons.highlight_remove_outlined,
            color: Theme.of(context).primaryColor,
          )),
      IconButton(
          onPressed: () => onTaskDone(task),
          icon: Icon(
            Icons.done_rounded,
            color: Theme.of(context).primaryColor,
          ))
    ],
  );
}
