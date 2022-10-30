import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_tests/datasource/todo_datasource.dart';
import 'package:todo_tests/repository/todo_repository.dart';

import 'todo_datasource_test.dart';

class DatasourceMock extends Mock implements TodoDatasource {}

void main() {
  late DatasourceMock datasource;
  late TodoRepository repository;

  setUp(() {
    datasource = DatasourceMock();
    repository = TodoRepository(datasource);
  });

  test('Should return list lenght == 2', () async {
    when(() => datasource.getAllTodo()).thenAnswer((_) async => listDatasource);
    final list = await repository.getAll();

    expect(list.length, 2);
  });
}

const List<dynamic> listDatasource = [
  {"userId": 1, "id": 1, "title": "delectus aut autem", "completed": false},
  {
    "userId": 1,
    "id": 2,
    "title": "quis ut nam facilis et officia qui",
    "completed": false
  },
];
