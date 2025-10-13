import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/database_halper.dart'; // Sesuaikan path jika perlu

class Todo {
  int? id;
  String title;
  String description;
  String status;
  int colorIndex;
  String? startTime;
  String? endTime;

  Todo({
    this.id,
    required this.title,
    this.description = "",
    this.status = "Upcoming",
    this.colorIndex = 0,
    this.startTime,
    this.endTime,
  });

  @override
  String toString() {
    return "Todo(id: $id, title: $title, desc: $description, status: $status, "
        "colorIndex: $colorIndex, start: $startTime, end: $endTime)";
  }

  // Helper untuk konversi ke Map (untuk insert/update ke DB)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'colorIndex': colorIndex,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  // Helper untuk konversi dari Map ke Todo (dari DB)
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      // PERBAIKAN 1: Menggunakan 'as int?' untuk mengatasi Type Error (Null) pada id.
      id: map['id'] as int?, 
      
      title: map['title'] as String,
      description: map['description'] as String? ?? "",
      // PERBAIKAN 2: Mengambil status LANGSUNG dari DB tanpa default "Upcoming" 
      // untuk memastikan tugas History tetap "Done".
      status: map['status'] as String, 
      colorIndex: map['colorIndex'] as int? ?? 0,
      startTime: map['startTime'] as String?,
      endTime: map['endTime'] as String?,
    );
  }
}

class TodoController extends GetxController {
  final todos = <Todo>[].obs;
  final history = <Todo>[].obs;

  var isMobile = true.obs;

  final dbHelper = DatabaseHelper.instance;

  @override
  void onInit() {
    super.onInit();
    loadTodosFromDB();
  }

  void updateLayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }

  /// Load semua data dari DB saat aplikasi dimulai
  void loadTodosFromDB() async {
    final dbTodos = await dbHelper.getTodos();
    todos.assignAll(dbTodos);

    final dbHistory = await dbHelper.getHistory();
    history.assignAll(dbHistory);
  }

  void addTodo(String title, String description, int colorIndex) async {
    if (title.trim().isEmpty) return;

    final newTodo = Todo(
      title: title.trim(),
      description: description.trim(),
      colorIndex: colorIndex,
    );

    final insertedTodo = await dbHelper.insertTodo(newTodo);
    todos.add(insertedTodo);
  }

  void saveTodo({
    required TextEditingController titleCtrl,
    required TextEditingController startTimeCtrl,
    required TextEditingController endTimeCtrl,
  }) async {
    if (titleCtrl.text.trim().isEmpty) return;

    final newTodo = Todo(
      title: titleCtrl.text.trim(),
      startTime: startTimeCtrl.text.trim().isNotEmpty ? startTimeCtrl.text.trim() : null,
      endTime: endTimeCtrl.text.trim().isNotEmpty ? endTimeCtrl.text.trim() : null,
    );

    final insertedTodo = await dbHelper.insertTodo(newTodo);
    todos.add(insertedTodo);

    titleCtrl.clear();
    startTimeCtrl.clear();
    endTimeCtrl.clear();
  }

  /// Update status todo dan pindahkan ke history jika "Done"
  void updateStatus(int index, String newStatus) async {
    if (index < 0 || index >= todos.length) return;

    final todo = todos[index];
    todo.status = newStatus;

    // Set colorIndex
    switch (newStatus) {
      case "Upcoming":
        todo.colorIndex = 0;
        break;
      case "In Progress":
        todo.colorIndex = 1;
        break;
      case "Done":
        todo.colorIndex = 2;
        break;
    }

    if (newStatus == "Done") {
      // 1. Hapus dari list utama di UI
      todos.removeAt(index);
      
      // 2. Hapus dari tabel 'todos' di DB (menggunakan ID lama)
      if (todo.id != null) {
        await dbHelper.deleteTodo(todo.id!);
      }
      
      // 3. Masukkan ke tabel 'history' di DB
      // Membuat salinan Map lalu mengonversi ke Todo dengan ID null untuk INSERT baru
      final todoForHistory = Todo.fromMap(todo.toMap())..id = null; 
      
      // Sisipkan dan dapatkan kembali objek dengan ID BARU dari tabel history
      final insertedHistory = await dbHelper.insertHistory(todoForHistory);

      // 4. Tambahkan ke list history di UI
      history.add(insertedHistory);

    } else {
      // Update status di tabel 'todos'
      if (todo.id != null) {
        await dbHelper.updateTodoStatus(todo.id!, newStatus, todo.colorIndex);
        
        // Perbarui objek di dalam list untuk trigger re-render
        todos[index] = todo;
      }
    }
  }

  /// Hapus todo dari list utama (todos)
  void deleteTodo(int index) async {
    if (index < 0 || index >= todos.length) return;
    final todo = todos[index];
    
    if (todo.id != null) {
      await dbHelper.deleteTodo(todo.id!);
    }
    todos.removeAt(index);
  }

  /// Hapus dari history
  void deleteFromHistory(int index) async {
    if (index < 0 || index >= history.length) return;
    final todo = history[index];
    
    if (todo.id != null) {
      await dbHelper.deleteHistory(todo.id!);
    }
    history.removeAt(index);
  }
}