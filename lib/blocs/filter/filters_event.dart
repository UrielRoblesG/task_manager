part of 'filters_bloc.dart';

sealed class FiltersEvent extends Equatable {
  const FiltersEvent();
}

// Evento para cambiar el filtro de seleccion
class OnSelectionChanged extends FiltersEvent {
  final int choice;

  OnSelectionChanged({required this.choice});

  @override
  List<Object> get props => [choice];
}
