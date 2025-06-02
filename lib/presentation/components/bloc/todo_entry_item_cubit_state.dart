part of 'todo_entry_item_cubit.dart';

abstract class ToDoEntryItemCubitState extends Equatable {
  const ToDoEntryItemCubitState();

  @override
  List<Object?> get props => [];
}

class TodoEntryItemLoadingState extends ToDoEntryItemCubitState {}

class TodoEntryItemErrorState extends ToDoEntryItemCubitState {}

class TodoEntryItemLoadedState extends ToDoEntryItemCubitState {
  const TodoEntryItemLoadedState({required this.toDoEntry});

  final ToDoEntry toDoEntry;

  @override
  List<Object?> get props => [toDoEntry];
}
