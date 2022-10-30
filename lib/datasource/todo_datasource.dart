import 'package:dio/dio.dart';
import 'package:todo_tests/exceptions/datasource_exception.dart';

class TodoDatasource {
  final Dio dio;

  TodoDatasource(this.dio);

  Future<List<dynamic>> getAllTodo() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/todos');
      final list = response.data as List;
      return list;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        throw DatasourceException('Lista não encontrada');
      } else if (e.response?.data == null) {
        throw DatasourceException('Lista vazia');
      }

      rethrow;
    }
  }
}
