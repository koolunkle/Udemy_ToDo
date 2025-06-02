import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/usecase.dart';
import 'package:todo/domain/entities/todo_entry.dart';
import 'package:todo/domain/entities/unique_id.dart';
import 'package:todo/domain/usecases/load_todo_entry.dart';
import 'package:todo/domain/usecases/update_todo_entry.dart';

part 'todo_entry_item_cubit_state.dart';

class ToDoEntryItemCubit extends Cubit<ToDoEntryItemCubitState> {
  ToDoEntryItemCubit({
    required this.entryId,
    required this.collectionId,
    required this.loadToDoEntry,
    required this.uploadToDoEntry,
  }) : super(TodoEntryItemLoadingState());

  final EntryId entryId;
  final CollectionId collectionId;
  final LoadToDoEntry loadToDoEntry;
  final UpdateToDoEntry uploadToDoEntry;

  Future<void> fetch() async {
    emit(TodoEntryItemLoadingState());
    try {
      final entry = await loadToDoEntry.call(
        ToDoEntryIdsParam(collectionId: collectionId, entryId: entryId),
      );
      return entry.fold(
        (left) => emit(TodoEntryItemErrorState()),
        (right) => emit(TodoEntryItemLoadedState(toDoEntry: right)),
      );
    } on Exception {
      emit(TodoEntryItemErrorState());
    }
  }

  Future<void> update() async {
    try {
      final updatedEntry = await uploadToDoEntry.call(
        ToDoEntryIdsParam(collectionId: collectionId, entryId: entryId),
      );
      return updatedEntry.fold(
        (left) => emit(TodoEntryItemErrorState()),
        (right) => emit(TodoEntryItemLoadedState(toDoEntry: right)),
      );
    } catch (e) {
      emit(TodoEntryItemErrorState());
    }
  }
}
