import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import '../const/colors.dart';
import '../services/task_service.dart';
import '../utils/DateTimeUtils.dart';
import '../viewmodels/edit_task_viewmodel.dart';
import '../widgets/background_text.dart';
import '../widgets/label_button.dart';

class EditTaskPage extends StatelessWidget {
  const EditTaskPage({Key? key}) : super(key: key);

  static const String route = 'edit-task';

  @override
  Widget build(BuildContext context) {
    String taskId = ModalRoute.of(context)!.settings.arguments as String;
    return ViewModelBuilder<EditTaskViewModel>.reactive(
        viewModelBuilder: () =>
            EditTaskViewModel(taskId, GetIt.I.get<TaskService>()),
        onModelReady: (model) => model.setup(),
        builder: (context, viewModel, child) => Scaffold(
              body: viewModel.hasError
                  ? Center(
                      child: BackgroundText(text: viewModel.errorMessage ?? ''),
                    )
                  : SafeArea(
                      child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Form(
                            key: viewModel.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                viewModel.canEditTask
                                    ? Container()
                                    : LabelButton(
                                        onTap: () {},
                                        backgroudColor:
                                            ColorsApp.disableTaskDoneBgColor,
                                        textColor:
                                            ColorsApp.disableTaskDoneTxtColor,
                                        text:
                                            'Atenção! Está tarefa está apenas em modo de visualização'),
                                TextFormField(
                                  enabled: viewModel.canEditTask,
                                  validator: viewModel.titleValidator,
                                  controller: viewModel.titleController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  maxLength: 40,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Sem título',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24)),
                                ),
                                TextFormField(
                                    enabled: viewModel.canEditTask,
                                    controller: viewModel.descriptionController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    cursorColor: Theme.of(context).primaryColor,
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        labelText: 'Descrição (opcional)',
                                        labelStyle: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor))),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Definir data de entrega'),
                                    Switch(
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        value: viewModel.isToDeliveryTask,
                                        onChanged: viewModel.canEditTask
                                            ? viewModel.switchDeliveryState
                                            : null)
                                  ],
                                ),
                                viewModel.isToDeliveryTask
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Data'),
                                          TextButton(
                                              onPressed: viewModel.canEditTask
                                                  ? () => DatePicker
                                                          .showDateTimePicker(
                                                        context,
                                                        locale: LocaleType.pt,
                                                        minTime: DateTime.now()
                                                            .add(const Duration(
                                                                minutes: 10)),
                                                        onConfirm: viewModel
                                                            .updateDeliveryDate,
                                                      )
                                                  : null,
                                              child: Text(
                                                viewModel.deliveryDate == null
                                                    ? 'Selecione a data'
                                                    : DateTimeUtils.formatDate(
                                                        viewModel.deliveryDate),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ))
                                        ],
                                      )
                                    : Container(),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Theme.of(context).primaryColor),
                                    onPressed: viewModel.canEditTask
                                        ? () async {
                                            String? result = await viewModel
                                                .validateAndUpdateTask();
                                            if (result == null) {
                                              Navigator.of(context).pop(true);
                                              return;
                                            }

                                            var snackBar =
                                                SnackBar(content: Text(result));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        : null,
                                    child: const Text(
                                      'Confirmar alterações',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            )),
                      ),
                    )),
            ));
  }
}
