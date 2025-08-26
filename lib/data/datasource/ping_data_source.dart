import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/dio_client.dart';

class PingDataSource {
  final Dio _dio;
  PingDataSource(this._dio);

  /// now_playing 호출로 인증·네트워크 점검
  Future<int> nowPlayingCount() async {
    final res = await _dio.get(
      'movie/now_playing',
      queryParameters: {'language': 'ko-KR', 'page': 1},
    );
    final list = (res.data['results'] as List?) ?? const [];
    return list.length;
  }
}

final pingDSProvider = Provider<PingDataSource>((ref) {
  return PingDataSource(ref.read(dioProvider));
});
