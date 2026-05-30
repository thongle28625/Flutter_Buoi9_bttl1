import 'package:flutter9_bthd/utils/database_helper.dart';
import 'package:flutter9_bthd/models/task.dart';
class TaskController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
// Insert a new task into the database
  Future<void> insertTask(Task task) async {
    final db = await _dbHelper.database;
    await db.insert('tasks', task.toMap());
  }
// Update an existing task in the database
  Future<void> updateTask(Task task) async {
    final db = await _dbHelper.database;
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs:
    [task.id]);
  }
// Delete a task from the database
  Future<void> deleteTask(int id) async {
    final db = await _dbHelper.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
//check task is exist in the database by title
  Future<bool> isTaskExist(String title) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks', where:
    'title = ?', whereArgs: [title]);
    return maps.isNotEmpty;
  }
//search task by title or description
  Future<List<Task>> searchTasks(String query) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return maps.map((obj) => Task.fromMap(obj)).toList();
  }
// Fetch all tasks from the database
  Future<List<Task>> fetchTasks() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return maps.map((obj) => Task.fromMap(obj)).toList();
  }
}
