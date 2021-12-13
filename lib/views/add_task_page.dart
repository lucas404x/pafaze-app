import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import '../services/task_service.dart';
import '../utils/DateTimeUtils.dart';
import '../viewmodels/add_task_viewmodel.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  static const String route = '/add-task';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTaskViewModel>.reactive(
        viewModelBuilder: () => AddTaskViewModel(GetIt.I.get<TaskService>()),
        builder: (context, viewModel, child) => Scaffold(
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            validator: viewModel.titleValidator,
                            controller: viewModel.titleController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            maxLength: 40,
                            cursorColor: Theme.of(context).primaryColor,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Sem título',
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24)),
                          ),
                          TextFormField(
                              controller: viewModel.descriptionController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  labelText: 'Descrição (opcional)',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Definir data de entrega'),
                              Switch(
                                  activeColor: Theme.of(context).primaryColor,
                                  value: viewModel.isToDeliveryTask,
                                  onChanged: viewModel.switchDeliveryState)
                            ],
                          ),
                          viewModel.isToDeliveryTask
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Data'),
                                    TextButton(
                                        onPressed: () =>
                                            DatePicker.showDateTimePicker(
                                              context,
                                              locale: LocaleType.pt,
                                              minTime: DateTime.now().add(
                                                  const Duration(seconds: 10)),
                                              onConfirm:
                                                  viewModel.updateDeliveryDate,
                                            ),
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
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor)),
                              onPressed: () async {
                                String? result =
                                    await viewModel.validateAndUploadTask();
                                if (result == null) {
                                  Navigator.of(context).pop(true);
                                  return;
                                }

                                var snackBar = SnackBar(content: Text(result));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: const Text(
                                'Criar tarefa',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )),
                ),
              )),
            ));
  }
}
