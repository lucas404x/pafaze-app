import 'package:flutter/material.dart';

import '../data/models/list_task_model.dart';
import '../data/models/task_model.dart';
import '../utils/DateTimeUtils.dart';

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
    var _task = listTask.task;
    var _dateFormatted =
        DateTimeUtils.formatDateToShort(_task.dateCreated.toLocal());
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
          _renderTexts(_task),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _dateFormatted,
                style:
                    const TextStyle(fontWeight: FontWeight.w200, fontSize: 10),
              )
            ],
          ),
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

_renderTexts(TaskModel task) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        task.title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        task.description.isNotEmpty ? task.description : 'Sem descrição',
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: task.description.isEmpty
            ? const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 10,
                fontWeight: FontWeight.w100)
            : null,
      ),
    ],
  );
}

_renderButtons(BuildContext context, ListTaskModel listTask,
    Function(ListTaskModel) onTaskDone, Function(ListTaskModel) onTaskRemove) {
  return !listTask.task.isDone
      ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () => onTaskRemove(listTask),
                icon: Icon(
                  Icons.highlight_remove_outlined,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () => onTaskDone(listTask),
                icon: Icon(
                  Icons.done_rounded,
                  color: Theme.of(context).primaryColor,
                ))
          ],
        )
      : Icon(Icons.done_outline_rounded, color: Theme.of(context).primaryColor);
}
