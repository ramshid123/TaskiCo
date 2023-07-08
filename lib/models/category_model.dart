import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/todo_item_model.dart';
part 'category_model.g.dart';

@HiveType(typeId: 0)
class CategoryModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String iconName;

  @HiveField(2)
  int totalTasks;

  @HiveField(3)
  int completedTasks;

  @HiveField(4)
  String id;

  @HiveField(5)
  List<TodoItemModel> todoList;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconName,
    required this.totalTasks,
    required this.completedTasks,
    required this.todoList,
  });

  Future<bool> addCategory() async {
    try {
      final item = CategoryModel(
        id: id,
        name: name,
        iconName: iconName,
        totalTasks: totalTasks,
        completedTasks: completedTasks,
        todoList: [],
      );
      final box = await Hive.openBox<CategoryModel>('categories');
      await box.put(id, item);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future getData() async {
    try {
      final box = await Hive.openBox<CategoryModel>('categories');
      List<CategoryModel> data = [];
      for (int i = 0; i < box.length; i++) data.add(box.getAt(i)!);
      return data;
    } catch (e) {
      print(e);
    }
  }

  static getSingleData({required String id}) async {
    try {
      final box = await Hive.openBox<CategoryModel>('categories');
      return box.get(id);
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> addTodoItem(
      {required String name,
      required DateTime date,
      required String id}) async {
    try {
      final box = await Hive.openBox<CategoryModel>('categories');
      final category = box.get(id);
      final todoList = category!.todoList;
      todoList.add(TodoItemModel(name: name, date: date));
      box.put(
          id,
          CategoryModel(
              id: category.id,
              name: category.name,
              iconName: category.iconName,
              totalTasks: category.totalTasks + 1,
              completedTasks: category.completedTasks,
              todoList: todoList));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future deleteCategory({required String id}) async {
    try {
      final box = await Hive.openBox<CategoryModel>('categories');
      await box.delete(id);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future updateCategory({required CategoryModel categoryModel}) async {
    final box = await Hive.openBox<CategoryModel>('categories');
    await box.put(categoryModel.id, categoryModel);
  }

  static Future updateAllCategories({required List<CategoryModel> list}) async {
    final box = await Hive.openBox<CategoryModel>('categories');
    await box.clear();
    for (var item in list) await box.put(item.id, item);
  }
}
