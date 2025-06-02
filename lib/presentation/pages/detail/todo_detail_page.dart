import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/unique_id.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:todo/domain/usecases/load_todo_entry_ids_for_collection.dart';
import 'package:todo/presentation/core/page_config.dart';
import 'package:todo/presentation/pages/detail/bloc/todo_detail_cubit.dart';

class ToDoDetailPageProvider extends StatelessWidget {
  const ToDoDetailPageProvider({super.key, required this.collectionId});

  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoDetailCubit>(
      create:
          (context) => ToDoDetailCubit(
            collectionId: collectionId,
            loadToDoEntryIdsForCollection: LoadToDoEntryIdsForCollection(
              toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
            ),
          ),
      child: ToDoDetailPage(collectionId: collectionId),
    );
  }
}

class ToDoDetailPage extends StatelessWidget {
  const ToDoDetailPage({super.key, required this.collectionId});

  final CollectionId collectionId;

  static const pageConfig = PageConfig(
    icon: Icons.details_rounded,
    name: 'detail',
    child: Placeholder(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoDetailCubit, ToDoDetailCubitState>(
      builder: (context, state) {
        return Placeholder();
      },
    );
  }
}
