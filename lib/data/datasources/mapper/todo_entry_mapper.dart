import 'package:todo/data/models/todo_entry_model.dart';
import 'package:todo/domain/entities/todo_entry.dart';
import 'package:todo/domain/entities/unique_id.dart';

mixin ToDoEntryMapper {
  ToDoEntry toDoEntryModelToEntity(ToDoEntryModel model) {
    final entity = ToDoEntry(
      id: EntryId.fromUniqueString(model.id),
      description: model.description,
      isDone: model.isDone,
    );
    return entity;
  }

  ToDoEntryModel toDoEntryToModel(ToDoEntry entry) {
    final model = ToDoEntryModel(
      id: entry.id.value,
      description: entry.description,
      isDone: entry.isDone,
    );
    return model;
  }
}
