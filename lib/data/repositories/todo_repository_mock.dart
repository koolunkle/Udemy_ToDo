import 'package:either_dart/either.dart';
import 'package:todo/domain/entities/todo_collection.dart';
import 'package:todo/domain/entities/todo_color.dart';
import 'package:todo/domain/entities/todo_entry.dart';
import 'package:todo/domain/entities/unique_id.dart';
import 'package:todo/domain/failures/failures.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

class ToDoRepositoryMock implements ToDoRepository {
  final List<ToDoEntry> toDoEntries = List.generate(
    100,
    (index) => ToDoEntry(
      description: 'description $index',
      isDone: false,
      id: EntryId.fromUniqueString(index.toString()),
    ),
  );

  final toDoCollections = List<ToDoCollection>.generate(
    10,
    (index) => ToDoCollection(
      id: CollectionId.fromUniqueString(index.toString()),
      title: 'title $index',
      color: TodoColor(colorIndex: index % TodoColor.predefinedColors.length),
    ),
  );

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollection() {
    try {
      return Future.delayed(
        const Duration(milliseconds: 200),
        () => Right(toDoCollections),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
    CollectionId collectionId,
    EntryId entryId,
  ) {
    try {
      final selectedEntryItem = toDoEntries.firstWhere(
        (element) => element.id == entryId,
      );
      return Future.delayed(
        const Duration(milliseconds: 200),
        () => Right(selectedEntryItem),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
    CollectionId collectionId,
  ) {
    try {
      final startIndex = int.parse(collectionId.value) * 10;
      final endIndex = startIndex + 10;
      final entryIds =
          toDoEntries
              .sublist(startIndex, endIndex)
              .map((entry) => entry.id)
              .toList();
      return Future.delayed(
        const Duration(microseconds: 300),
        () => Right(entryIds),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}
