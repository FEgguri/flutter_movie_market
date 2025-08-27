import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test('Dio GET now_playing mocked 200', () async {
    final dio =
        Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3/movie/'));
    final adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;

    final body = {
      "page": 1,
      "results": [
        {"id": 1, "title": "Mock A"}
      ],
      "total_pages": 1,
      "total_results": 1
    };

    adapter.onGet(
      'movie/now_playing',
      (server) => server.reply(200, body),
      queryParameters: {'language': 'ko-KR', 'page': 1},
    );

    final res = await dio.get(
      'movie/now_playing',
      queryParameters: {'language': 'ko-KR', 'page': 1},
    );

    //expect(res.statusCode, 200);
    expect((res.data['results'] as List).length, 1);
  });
}
