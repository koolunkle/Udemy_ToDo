import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/data/datasources/mapper/todo_collection_mapper.dart';
import 'package:todo/data/datasources/mapper/todo_entry_mapper.dart';
import 'package:todo/data/datasources/todo_remote_datasource_interface.dart';
import 'package:todo/data/exceptions/exceptions.dart';
import 'package:todo/domain/entities/todo_collection.dart';
import 'package:todo/domain/entities/todo_entry.dart';
import 'package:todo/domain/entities/unique_id.dart';
import 'package:todo/domain/failures/failures.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

class ToDoRepositoryRemote
    with ToDoCollectionMapper, ToDoEntryMapper
    implements ToDoRepository {
  final ToDoRemoteDataSourceInterface remoteSource;

  ToDoRepositoryRemote({required this.remoteSource});

  String get userId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'some-user-id-123';

  @override
  Future<Either<Failure, bool>> createToDoCollection(
    ToDoCollection collection,
  ) async {
    try {
      final result = await remoteSource.createToDoCollection(
        userId: userId,
        collection: toDoCollectionToModel(collection),
      );
      return Right(result);
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry(
    CollectionId collectionId,
    ToDoEntry entry,
  ) async {
    try {
      final result = await remoteSource.createToDoEntry(
        userId: userId,
        collectionId: collectionId.value,
        entry: toDoEntryToModel(entry),
      );
      return Right(result);
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() async {
    try {
      final collectionIds = await remoteSource.getToDoCollectionIds(
        userId: userId,
      );
      final List<ToDoCollection> collections = [];
      for (String collectionId in collectionIds) {
        final collection = await remoteSource.getToDoCollection(
          userId: userId,
          collectionId: collectionId,
        );
        collections.add(toDoCollectionModelToEntity(collection));
      }
      return Right(collections);
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
    CollectionId collectionId,
    EntryId entryId,
  ) async {
    try {
      final result = await remoteSource.getToDoEntry(
        userId: userId,
        collectionId: collectionId.value,
        entryId: entryId.value,
      );
      return Right(toDoEntryModelToEntity(result));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
    CollectionId collectionId,
  ) async {
    try {
      final entries = await remoteSource.getToDoEntryIds(
        userId: userId,
        collectionId: collectionId.value,
      );
      return Right(entries.map((id) => EntryId.fromUniqueString(id)).toList());
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
   Future<Either<Failure, ToDoEntry>> updateToDoEntry({
    required CollectionId collectionId,
    required ToDoEntry entry,
  }) async {
    try {
      final updateEntry = await remoteSource.updateToDoEntry(
        userId: userId,
        collectionId: collectionId.value,
        entry: toDoEntryToModel(entry),
      );
      return Right(toDoEntryModelToEntity(updateEntry));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}
