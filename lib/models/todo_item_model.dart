import 'package:hive_flutter/hive_flutter.dart';
part 'todo_item_model.g.dart';

@HiveType(typeId: 1)
class TodoItemModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  bool isDone;

  TodoItemModel({required this.name, required this.date, this.isDone = false});
}
