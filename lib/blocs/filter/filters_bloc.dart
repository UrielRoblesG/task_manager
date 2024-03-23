import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/models/filter.dart';

part 'filters_event.dart';

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
    on<OnSelectionChanged>(_onSelectionChanged);
  }

  FutureOr<void> _onSelectionChanged(
      OnSelectionChanged event, Emitter<int> emit) {
    emit(event.choice);
  }
}
