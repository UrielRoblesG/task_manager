import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:task_manager/models/models.dart';
import 'package:task_manager/utils/autorization_header.dart';
import 'package:task_manager/utils/env.dart';

class TaskService {
  String token = '';

  FutureOr<List<Task>> getAll() async {
    try {
      final url = Uri.https(Env.server, '/vdev/tasks-challenge/tasks');

      final resp =
          await http.get(url, headers: AutorizationHeader.create(token));

      if (resp.statusCode != 200) {
        return [];
      }

      final tasks =
          List<Task>.from(json.decode(resp.body).map((x) => Task.fromJson(x)))
              .toList();

      log('Completado');
      return tasks;
    } catch (e) {
      log(e.toString());
    }
    return [];
  }
}
