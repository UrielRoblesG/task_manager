import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/models/filter.dart';

part 'filters_event.dart';

// Gestor de estados para seleccionar visualizar las tareas en base al estatus
// de cada una
class FiltersBloc extends Bloc<FiltersEvent, int> {
  final List<Filter> filters = [
    Filter(id: 0, name: 'Todos'),
    Filter(id: 1, name: 'Completados'),
    Filter(id: 2, name: 'Pendientes'),
  ];
  FiltersBloc() : super(0) {
    on<FiltersEvent>((event, emit) {
      // TODO: implement event handler
    });
    // Handlers de los eventos
    on<OnSelectionChanged>(_onSelectionChanged);
  }

  // Emite un nuevo evento
  FutureOr<void> _onSelectionChanged(
      OnSelectionChanged event, Emitter<int> emit) {
    emit(event.choice);
  }
}
