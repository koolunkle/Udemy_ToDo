import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/domain/entities/todo_color.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:todo/domain/usecases/create_todo_collection.dart';
import 'package:todo/presentation/core/page_config.dart';
import 'package:todo/presentation/pages/create_todo_collection/bloc/create_todo_collection_page_cubit.dart';

class CreateToDoCollectionPageProvider extends StatelessWidget {
  const CreateToDoCollectionPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateToDoCollectionPageCubit>(
      create:
          (context) => CreateToDoCollectionPageCubit(
            createToDoCollection: CreateToDoCollection(
              toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
            ),
          ),
      child: const CreateToDoCollectionPage(),
    );
  }
}

class CreateToDoCollectionPage extends StatefulWidget {
  const CreateToDoCollectionPage({super.key});

  static const pageConfig = PageConfig(
    name: 'create_todo_collection',
    icon: Icons.add_task_rounded,
    child: CreateToDoCollectionPageProvider(),
  );

  @override
  State<CreateToDoCollectionPage> createState() =>
      _CreateToDoCollectionPageState();
}

class _CreateToDoCollectionPageState extends State<CreateToDoCollectionPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'collection_title_label'.tr(),
              ),
              onChanged:
                  (value) => context
                      .read<CreateToDoCollectionPageCubit>()
                      .titleChanged(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title!';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'collection_color_label'.tr(),
              ),
              onChanged:
                  (value) => context
                      .read<CreateToDoCollectionPageCubit>()
                      .colorChanged(value),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parsedColorIndex = int.tryParse(value);
                  if (parsedColorIndex == null ||
                      parsedColorIndex < 0 ||
                      parsedColorIndex > ToDoColor.predefinedColors.length) {
                    return 'collection_color_failure'.tr(
                      namedArgs: {
                        'numbers': '${ToDoColor.predefinedColors.length - 1}',
                      },
                    );
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final isValide = _formKey.currentState?.validate();
                if (isValide == true) {
                  context.read<CreateToDoCollectionPageCubit>().submit().then((
                    _,
                  ) {
                    if (context.mounted) {
                      context.pop(true);
                    }
                  });
                }
              },
              child: Text('collection_save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
