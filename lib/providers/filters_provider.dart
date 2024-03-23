import 'package:flutter/material.dart';
import 'package:task_manager/models/models.dart';

class FiltersProvider extends ChangeNotifier {
  final List<Filter> filters = [
    Filter(id: 0, name: 'Todos'),
    Filter(id: 1, name: 'Completados'),
    Filter(id: 2, name: 'Pendientes'),
  ];

  int _selected = 0;

  set selected(int value) {
    _selected = value;
    notifyListeners();
  }

  int get selected => _selected;
}
