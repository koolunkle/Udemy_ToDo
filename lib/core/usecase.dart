import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/domain/entities/unique_id.dart';
import 'package:todo/domain/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

class ToDoEntryIdsParam extends Params {
  ToDoEntryIdsParam({required this.collectionId, required this.entryId})
    : super();

  final CollectionId collectionId;
  final EntryId entryId;

  @override
  List<Object?> get props => [collectionId, entryId];
}

class CollectionIdParam extends Params {
  CollectionIdParam({required this.collectionId}) : super();

  final CollectionId collectionId;

  @override
  List<Object?> get props => [collectionId];
}
