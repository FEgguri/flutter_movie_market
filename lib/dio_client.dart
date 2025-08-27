import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//통신
class DioClient {
// await dotenv.load(fileName: ".env");
  static Dio get client => _client;

  static Dio _client = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/movie/',
      validateStatus: (status) => true,
    ),
  )..interceptors.add(interceptor); //하이잭킹 -> 헤더
  static AuthInterceptor interceptor = AuthInterceptor();
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    //
    options.headers.addAll(
      {
        'Authorization': 'Bearer ${dotenv.env['TMDB_TOKEN']}',
        'accept': 'application/json',
      },
    );
    super.onRequest(options, handler);
  }
}
