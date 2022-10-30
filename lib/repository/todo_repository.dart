import 'package:dio/dio.dart';
import 'package:todo_tests/datasource/todo_datasource.dart';
import 'package:todo_tests/models/todo_model.dart';

class TodoRepository {
  final dio = Dio();
  final TodoDatasource datasource;

  TodoRepository(this.datasource);

  Future<List<TodoModel>> getAll() async {
    List<TodoModel> todos = [];
    final list = await datasource.getAllTodo();
    todos = list.map((todo) => TodoModel.fromJson(todo)).toList();
    return todos;
  }
}
