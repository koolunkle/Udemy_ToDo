import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/local/memory_local_datasource.dart';
import 'package:todo/data/repositories/todo_repository_local.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:todo/presentation/app/app.dart';

void main() {
  runApp(
    RepositoryProvider<ToDoRepository>(
      create:
          (context) =>
              ToDoRepositoryLocal(localDataSource: MemoryLocalDataSource()),
      child: const App(),
    ),
  );
}
