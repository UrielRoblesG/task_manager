import 'package:flutter/material.dart';
import 'package:task_manager/models/models.dart';

// Provider para manejar la seleccion de un filtro
class FiltersProvider extends ChangeNotifier {
  int _selected = 0;

  set selected(int value) {
    _selected = value;
    notifyListeners();
  }

  int get selected => _selected;
}
