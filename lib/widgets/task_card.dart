import 'package:flutter/material.dart';

import '../data/models/task_model.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final _task = widget.task;
    return Container();
  }
}
