import 'package:flutter/widgets.dart';
import 'package:todo/domain/entities/unique_id.dart';
import 'package:todo/presentation/components/todo_entry_item.dart';

class ToDoDetailLoaded extends StatelessWidget {
  const ToDoDetailLoaded({
    super.key,
    required this.entryIds,
    required this.collectionId,
  });

  final List<EntryId> entryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: entryIds.length,
          itemBuilder:
              (context, index) => ToDoEntryItemProvider(
                entryId: entryIds[index],
                collectionId: collectionId,
              ),
        ),
      ),
    );
  }
}
