import 'package:todo/domain/entities/todo_color.dart';
import 'package:todo/domain/entities/unique_id.dart';

class ToDoCollection {
  final CollectionId id;
  final String title;
  final TodoColor color;

  ToDoCollection({required this.id, required this.title, required this.color});

  factory ToDoCollection.empty() {
    return ToDoCollection(
      id: CollectionId(),
      title: '',
      color: TodoColor(colorIndex: 0),
    );
  }
}
