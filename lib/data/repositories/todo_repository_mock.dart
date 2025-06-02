import 'package:either_dart/either.dart';
import 'package:todo/domain/entities/todo_collection.dart';
import 'package:todo/domain/entities/todo_color.dart';
import 'package:todo/domain/entities/unique_id.dart';
import 'package:todo/domain/failures/failures.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements TodoRepository {
  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollection() {
    final list = List<ToDoCollection>.generate(
      10,
      (index) => ToDoCollection(
        id: CollectionId.fromUniqueString(index.toString()),
        title: 'title $index',
        color: TodoColor(colorIndex: index % TodoColor.predefinedColors.length),
      ),
    );
    return Future.delayed(Duration(milliseconds: 200), () => Right(list));
  }
}
