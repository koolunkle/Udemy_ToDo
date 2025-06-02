import 'package:either_dart/either.dart';
import 'package:todo/core/usecase.dart';
import 'package:todo/domain/entities/todo_entry.dart';
import 'package:todo/domain/failures/failures.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

class UpdateToDoEntry implements UseCase<ToDoEntry, ToDoEntryIdsParam> {
  const UpdateToDoEntry({required this.toDoRepository});

  final ToDoRepository toDoRepository;

  @override
  Future<Either<Failure, ToDoEntry>> call(ToDoEntryIdsParam params) async {
    try {
      final loadedEntry = await toDoRepository.updateToDoEntry(
        collectionId: params.collectionId,
        entryId: params.entryId,
      );
      return loadedEntry.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
