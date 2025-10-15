import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../controller/todo_controller.dart'; 

class DatabaseHelper {
  
  static final DatabaseHelper instance = DatabaseHelper._internal();
  factory DatabaseHelper() => instance;
  DatabaseHelper._internal();

  static Database? _database;


  static const String tableTodos = 'todos';
  static const String tableHistory = 'history';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    const String createTableSql = '''
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT,
      status TEXT,
      colorIndex INTEGER,
      startTime TEXT,
      endTime TEXT
    ''';
    
    
    await db.execute('CREATE TABLE $tableTodos($createTableSql)');
    
    
    await db.execute('CREATE TABLE $tableHistory($createTableSql)');
  }
  
  
  Future<Todo> insertTodo(Todo todo) async {
    final db = await database;
    
    final Map<String, dynamic> todoMap = todo.toMap()..remove('id'); 
    final id = await db.insert(tableTodos, todoMap);
    
    
    return Todo.fromMap(todoMap)..id = id;
  }

 
  Future<List<Todo>> getTodos() async {
    final db = await database;
    final maps = await db.query(tableTodos, orderBy: 'id DESC');
    return maps.map((map) => Todo.fromMap(map)).toList();
  }

  
  Future<int> updateTodoStatus(int id, String status, int colorIndex) async {
    final db = await database;
    return await db.update(
      tableTodos,
      {'status': status, 'colorIndex': colorIndex},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

 
  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete(
      tableTodos,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  

  
  Future<Todo> insertHistory(Todo todo) async {
    final db = await database;
    
    final Map<String, dynamic> todoMap = todo.toMap()..remove('id');
    final id = await db.insert(tableHistory, todoMap);
    
    
    return Todo.fromMap(todoMap)..id = id;
  }

 
  Future<List<Todo>> getHistory() async {
    final db = await database;
    final maps = await db.query(tableHistory, orderBy: 'id DESC');
    return maps.map((map) => Todo.fromMap(map)).toList();
  }

  Future<int> deleteHistory(int id) async {
    final db = await database;
    return await db.delete(
      tableHistory,
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<void> clearAll() async {
    final db = await database;
    await db.delete(tableTodos);
    await db.delete(tableHistory);
  }
}