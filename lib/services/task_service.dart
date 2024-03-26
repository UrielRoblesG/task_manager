import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:task_manager/models/models.dart';
import 'package:task_manager/utils/autorization_header.dart';
import 'package:task_manager/utils/env.dart';

// Clase para realizar las peticiones crud al server
class TaskService {
  String token = '';

  // Obtener todos los registros
  FutureOr<List<Task>> getAll() async {
    try {
      final url = Uri.https(Env.server, '/vdev/tasks-challenge/tasks');

      final resp =
          await http.get(url, headers: AutorizationHeader.create(token: token));

      if (resp.statusCode != 200) {
        return [];
      }

      final tasks =
          List<Task>.from(json.decode(resp.body).map((x) => Task.fromJson(x)))
              .toList();

      return tasks;
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  //Obtener un registro especifico en base al id
  Future<Task?> getById(int id) async {
    try {
      final url = Uri.https(Env.server, '/vdev/tasks-challenge/tasks/${id}',
          {'task_id': id}.map((key, value) => MapEntry(key, value.toString())));
      final resp =
          await http.get(url, headers: AutorizationHeader.create(token: token));

      if (resp.statusCode != 200) {
        return null;
      }
      final decodedData = json.decode(resp.body);
      final task = Task.fromJson(decodedData[0]);

      return task;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Crear una nueva tarea
  FutureOr<Task?> create(Task task) async {
    try {
      final url = Uri.https(Env.server, '/vdev/tasks-challenge/tasks');
      final resp = await http.post(url,
          headers: AutorizationHeader.create(token: token),
          body: taskToJson(task));

      if (resp.statusCode != 201) {
        return null;
      }

      final decodedData = json.decode(resp.body);

      final newTask = Task.fromJson(decodedData['task']);

      return newTask;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Actualizar una tarea
  FutureOr<bool> update(Task task) async {
    try {
      final url = Uri.https(
          Env.server,
          '/vdev/tasks-challenge/tasks/${task.id}',
          {'task_id': task.id}
              .map((key, value) => MapEntry(key, value.toString())));
      final encodedForm = task.encodeFormData();
      final resp = await http.put(url,
          headers: AutorizationHeader.create(
              token: token, contentType: 'application/x-www-form-urlencoded'),
          body: encodedForm);

      if (resp.statusCode != 201) {
        return false;
      }

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  FutureOr<bool> delete(int id) async {
    try {
      final url = Uri.https(Env.server, '/vdev/tasks-challenge/tasks/$id',
          {'task_id': id}.map((key, value) => MapEntry(key, value.toString())));
      final resp = await http.delete(url,
          headers: AutorizationHeader.create(token: token));
      if (resp.statusCode != 201) {
        return false;
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
