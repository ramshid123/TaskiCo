import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/category_model.dart';

void main() {
  // Initialize Hive before running the tests
  setUpAll(() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CategoryModelAdapter());
  });

  // Close Hive after running the tests
  tearDownAll(() async {
    await Hive.close();
  });

  group('CategoryModel', () {
    test('Adding a category should return true', () async {
      final category = CategoryModel(
        id: '1',
        name: 'Test Category',
        iconName: 'icon_name',
        totalTasks: 5,
        completedTasks: 2,
      );

      final result = await category.addCategory();

      expect(result, true);
    });

    test('Adding a category with invalid data should return false', () async {
      final category = CategoryModel(
        id: 'test_id', // Invalid ID
        name: 'Test Category',
        iconName: 'icon_name',
        totalTasks: 5,
        completedTasks: 2,
      );

      final result = await category.addCategory();

      expect(result, false);
    });
  });
}
