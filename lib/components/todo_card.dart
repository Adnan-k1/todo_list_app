import 'package:flutter/material.dart';
import '../controller/todo_controller.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onDelete;
  final ValueChanged<String?>? onStatusChanged;
  final bool showDelete;      // ⬅️ untuk tampilkan / sembunyikan icon hapus
  final bool enableDropdown;  // ⬅️ untuk aktif / nonaktif dropdown

  const TodoCard({
    super.key,
    required this.todo,
    this.onDelete,
    this.onStatusChanged,
    this.showDelete = true,       // default tampil
    this.enableDropdown = true,   // default bisa diubah
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case "Done":
        return Colors.green;
      case "In Progress":
        return Colors.orange;
      case "Upcoming":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              todo.description,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                enableDropdown
                    ? DropdownButton<String>(
                        value: todo.status,
                        underline: const SizedBox(),
                        items: ["Upcoming", "In Progress", "Done"]
                            .map((s) => DropdownMenuItem(
                                  value: s,
                                  child: Text(s),
                                ))
                            .toList(),
                        onChanged: onStatusChanged,
                      )
                    : Text(todo.status, // kalau nonaktif tampil teks saja
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(todo.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    todo.status,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),

                if (showDelete) // hanya tampil kalau true
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
