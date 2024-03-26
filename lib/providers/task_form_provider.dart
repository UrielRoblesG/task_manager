import 'package:flutter/material.dart';
import 'package:task_manager/models/models.dart';

class TaskFormProvider extends ChangeNotifier {
  Task _task = Task();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  set setTitle(String value) {
    _task.title = value;
    notifyListeners();
  }

  set setDescription(String value) {
    _task.description = value;
    notifyListeners();
  }

  set setDueDate(DateTime value) {
    _task.dueDate = value;
    notifyListeners();
  }

  set setComentarios(String value) {
    _task.comments = value;
    notifyListeners();
  }

  set setTags(String value) {
    _task.tags = value;
    notifyListeners();
  }

  set setStatus(bool value) {
    _task.isCompleted = (value) ? 1 : 0;
    notifyListeners();
  }

  set task(Task task) {
    _task = task;
    // notifyListeners();
  }

  bool get getStatus => (_task.isCompleted == 1) ? true : false;

  String? get getFormatedDate => (_task.dueDate != null)
      ? '${task.dueDate?.year.toString().padLeft(4, '0')}-${task.dueDate?.month.toString().padLeft(2, '0')}-${task.dueDate?.day.toString().padLeft(2, '0')}'
      : null;
  Task get task => _task;

  bool isValidForm() => formKey.currentState?.validate() ?? false;
}
