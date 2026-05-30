import 'package:flutter/material.dart';
import 'package:flutter9_bttl_1/task_controller.dart';
import 'package:flutter9_bttl_1/task.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final VoidCallback onUpdate; // Callback để load lại danh sách sau khi cập nhật

  const TaskDetailScreen({Key? key, required this.task, required this.onUpdate}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final TaskController _taskController = TaskController();
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.task.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(widget.task.title, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(widget.task.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("Completed", style: TextStyle(fontSize: 16)),
                Checkbox(
                  value: _isCompleted,
                  onChanged: (bool? value) async {
                    setState(() {
                      _isCompleted = value!;
                    });
                    // Cập nhật trạng thái vào database
                    widget.task.isCompleted = _isCompleted;
                    await _taskController.updateTask(widget.task);

                    // Thông báo cho màn hình danh sách tải lại dữ liệu
                    widget.onUpdate();

                    // Quay về màn hình danh sách
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}