import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_tests/datasource/todo_datasource.dart';
import 'package:todo_tests/exceptions/datasource_exception.dart';

class DioMock extends Mock implements Dio {}

class RequestMock extends Mock implements RequestOptions {}

void main() {
  late TodoDatasource datasource;
  late DioMock mockDio;
  late RequestMock requestMock;

  setUp(() {
    mockDio = DioMock();
    requestMock = RequestMock();
    datasource = TodoDatasource(mockDio);
  });

  test('Should return true for the lenght of List == 2 using Mock', () async {
    when(() => mockDio.get(any())).thenAnswer((_) async =>
        Response(data: jsonDecode(jsonResponse), requestOptions: requestMock));
    final todos = await datasource.getAllTodo();
    expect(todos.length, 2);
  });

  test('Should return error when status code is 404 using Mock', () async {
    final response =
        Response(requestOptions: requestMock, data: {}, statusCode: 404);

    when(() => mockDio.get(any()))
        .thenThrow(DioError(requestOptions: requestMock, response: response));

    expect(() => datasource.getAllTodo(), throwsA(isA<DatasourceException>()));
  });

  test('Should return error when data is null using Mock', () async {
    final response = Response(requestOptions: requestMock, data: null);

    when(() => mockDio.get(any()))
        .thenThrow(DioError(requestOptions: requestMock, response: response));

    expect(() => datasource.getAllTodo(), throwsA(isA<DatasourceException>()));
  });
}

const jsonResponse =
    ''' 
[
  {
    "userId": 1, 
    "id": 1, 
    "title": "delectus aut autem", 
    "completed": false
  },
  {
    "userId": 1,
    "id": 2,
    "title": "quis ut nam facilis et officia qui",
    "completed": false
  }
]
''';
