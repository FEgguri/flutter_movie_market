import 'package:dio/dio.dart';
import 'package:flutter_movie_market/env/env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dio를 앱 전역에서 재사용하기 위한 팩토리.
/// 이유: 연결 재사용, 인터셉터 일관, 헤더 누락 방지.
class DioClient {
  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/',
        headers: {
          'Authorization': 'Bearer ${Env.tmdbToken}', // v4 토큰. 코드 하드코딩 금지.
          'accept': 'application/json',
        },
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // 초기 디버깅에 필요한 최소 로그. 본문은 무거우므로 비활성.
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: false,
      responseHeader: false,
      responseBody: false,
    ));
  }

  late final Dio dio;

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
}

/// DI 용 Provider. 어디서든 ref.read(dioProvider)로 동일 Dio를 받는다.
final dioProvider = Provider<Dio>((ref) => DioClient().dio);
